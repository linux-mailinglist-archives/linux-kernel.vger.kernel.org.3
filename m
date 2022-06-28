Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A4255F20A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiF1Xqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiF1Xqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:46:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F6D381B5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 16:46:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C9461B5F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580BAC341C8;
        Tue, 28 Jun 2022 23:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656460005;
        bh=0j9px4bXLhNpfkXYuKh1R2e7bRktJxdDLvpTAYM6cYE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GumDYMIaXFccOeThfYtDcZWnZq6fQQciVByCAIKBcUb1a5XmVBQNqQ5TfIFLJlc83
         sqEpQ2Qo6VkKbme/JjS2zf918QfK9gSdgr/lA4hYznv7Q1/JNxDVHlP1dvQL/5rzs9
         99ClkZD5RAmAiLC0RXjn2VCa+bLNnyWhxglcKxHzVcIf/eew4AV5noBFPivQFUQDzh
         bKT4OyF0y28wS454RID1XEZqO3o1Mr2C/NGUAG/E5qp3Xdsk62WCwiEv1om33pfepU
         udg7w7XJJRfI68P0AyaisB5AUhOt5XBv7Ojk/EzejlHdglZK5/Wd5A8Q/0zFi/og7W
         bN0yljkKLrCVA==
Message-ID: <2f966e28-cebd-067d-580e-ad6a1fc32c35@kernel.org>
Date:   Tue, 28 Jun 2022 16:46:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] x86/mm: declare static variable inside a function instead
 of global
Content-Language: en-US
To:     Fanjun Kong <fanjun.kong@linux.dev>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org
References: <20220618101134.3073210-1-fanjun.kong@linux.dev>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220618101134.3073210-1-fanjun.kong@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/22 03:11, Fanjun Kong wrote:
> Global variables are global capacity variables, unless they are
> shadowed, they are available to the entire program.

This is true in general, but:

> -static unsigned long memory_block_size_probed;

    ^^^^^^

So this isn't actually the case.

>   unsigned long memory_block_size_bytes(void)
>   {
> +	static unsigned long memory_block_size_probed;
> +
>   	if (!memory_block_size_probed)
>   		memory_block_size_probed = probe_memory_block_size();
>   

I'm sort of okay with the patch, but it's worth noting that, in C++, 
initialized function-scope static variables have quite surprising 
semantics, so this type of change isn't a pure win in my book.  (Yes, 
the kernel is C, not C++.  But C++ programmers may be nervous anyway.)
