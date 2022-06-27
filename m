Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9FF55E1A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiF0TBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239613AbiF0TBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE45510DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B28E615E1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 19:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901C8C341CB;
        Mon, 27 Jun 2022 19:01:17 +0000 (UTC)
Date:   Mon, 27 Jun 2022 15:01:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Message-ID: <20220627150115.066e17d1@gandalf.local.home>
In-Reply-To: <25C37F40-7D8E-41C6-961F-0774C8138CCB@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
        <20220616113400.15335d91@gandalf.local.home>
        <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
        <20220617155019.373adda7@gandalf.local.home>
        <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
        <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
        <20220624190819.59df11d3@rorschach.local.home>
        <3EB14A14-767B-4B66-9B28-97DDE7EECFD2@oracle.com>
        <20220625134552.08c1a23a@rorschach.local.home>
        <0bf1d366-348c-0f91-8f0a-fc9cc6228783@kernel.org>
        <12417afa-331b-e0f6-a3b0-19623e38590b@eaglescrag.net>
        <308F6A3B-1FB9-42CD-8239-12B0FD0F5FDB@oracle.com>
        <20220627131140.56761db9@gandalf.local.home>
        <25C37F40-7D8E-41C6-961F-0774C8138CCB@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 17:19:18 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > Would you be able to send me a trace.dat file that has this issue?  
> 
> Sending under separate cover.

I found this is the kallsyms output:

ffffffffac820000 b __brk_early_pgt_alloc
ffffffffac830000 B _end
ffffffffac830000 B __brk_limit
ffffffffc0948205 0944410 t qrtr_alloc_ctrl_packet       [qrtr]
ffffffffc0944470 t qrtr_node_enqueue    [qrtr]
ffffffffc094d100 b __key.5      [qrtr]
ffffffffc09448b0 t qrtr_reset_ports     [qrtr]
ffffffffc094c1c0 d qrtr_ports   [qrtr]
ffffffffc094d100 b __key.3      [qrtr]
ffffffffc094d100 b __key.4      [qrtr]

The line with:

  ffffffffc0948205 0944410 t qrtr_alloc_ctrl_packet       [qrtr]

Causes the parsing to stop, because it is not of a proper format. It has
that extra "0944410" in it, which will break the parsing.

Now the question is, why does that exist? And yes, that's a kernel bug.

The kallsyms code that outputs this file is:

static int s_show(struct seq_file *m, void *p)
{
	void *value;
	struct kallsym_iter *iter = m->private;

	/* Some debugging symbols have no name.  Ignore them. */
	if (!iter->name[0])
		return 0;

	value = iter->show_value ? (void *)iter->value : NULL;

	if (iter->module_name[0]) {
		char type;

		/*
		 * Label it "global" if it is exported,
		 * "local" if not exported.
		 */
		type = iter->exported ? toupper(iter->type) :
					tolower(iter->type);
		seq_printf(m, "%px %c %s\t[%s]\n", value,
			   type, iter->name, iter->module_name);
	} else
		seq_printf(m, "%px %c %s\n", value,
			   iter->type, iter->name);
	return 0;
}

So how did it get that strange output.

Hmm, I bet it is because trace-cmd reads it in BUFSIZ blocks, and that the
seq_file code got confused when parsing between two elements, I bet
something got dropped. I'll go see if there was any seq_file updates that
could have caused this.

-- Steve
