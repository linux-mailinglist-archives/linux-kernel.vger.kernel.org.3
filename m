Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D40C585406
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiG2Q5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbiG2Q46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:56:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30B189A51
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F317B828AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 16:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB712C433D6;
        Fri, 29 Jul 2022 16:56:54 +0000 (UTC)
Date:   Fri, 29 Jul 2022 12:56:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     liqiong <liqiong@nfschina.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        yuzhe@nfschina.com, renyu@nfschina.com, jiaming@nfschina.com
Subject: Re: [PATCH] tracing: Do PTR_ERR() after IS_ERR()
Message-ID: <20220729125647.746379e5@rorschach.local.home>
In-Reply-To: <efce3a4c-4480-99f5-0229-a44009ebe9d8@nfschina.com>
References: <20220727153519.6697-1-liqiong@nfschina.com>
        <20220727122847.6b00e29d@rorschach.local.home>
        <efce3a4c-4480-99f5-0229-a44009ebe9d8@nfschina.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 08:28:08 +0800
liqiong <liqiong@nfschina.com> wrote:

> It's all right, assign  PTR_ERR()  to 'ret'  anyway.
> But this assignment is valid only at the "IS_ERR()" path.
> Maybe it is better put "PTR_ERR()" at error path, keep the code clear.

No it does not. It adds unnecessary brackets.

It is common in the kernel to have:

	ret = ERROR;
	if (some_condition())
		goto out;

	ret = ERROR1;
	if (some_other_condition())
		goto out;

	ret = ERROR2;
	if (some_new_condition())
		goto out;

	ret = 0;
out:
	return ret;

And your change breaks this.

-- Steve
