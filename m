Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E047E5AF990
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 03:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIGB6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 21:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIGB6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:58:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC458C472
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 18:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D3D3B81ADB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BA1C433D6;
        Wed,  7 Sep 2022 01:58:39 +0000 (UTC)
Date:   Tue, 6 Sep 2022 21:59:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v1] arch/x86/kernel: check the return value of
 insn_decode_kernel()
Message-ID: <20220906215918.3fe20cca@gandalf.local.home>
In-Reply-To: <20220902074706.2211252-1-floridsleeves@gmail.com>
References: <20220902074706.2211252-1-floridsleeves@gmail.com>
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

On Fri,  2 Sep 2022 00:47:06 -0700
Li Zhong <floridsleeves@gmail.com> wrote:

> @@ -20,9 +20,10 @@
>  int arch_jump_entry_size(struct jump_entry *entry)
>  {
>  	struct insn insn = {};
> +	int ret;
>  
> -	insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
> -	BUG_ON(insn.length != 2 && insn.length != 5);
> +	ret = insn_decode_kernel(&insn, (void *)jump_entry_code(entry));

It's highly unlikely that length will be 2 or 5 if ret is not zero (as it
is initialized to zero going into this function).

> +	BUG_ON(ret < 0 || insn.length != 2 && insn.length != 5);

In any case, you need parenthesis around the && condition.

-- Steve


>  
>  	return insn.length;
