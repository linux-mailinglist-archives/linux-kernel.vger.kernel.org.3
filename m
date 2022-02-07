Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE8E4AC428
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384661AbiBGPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382915AbiBGPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 10:35:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1D6C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 07:35:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 895BCB815AD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BB4C004E1;
        Mon,  7 Feb 2022 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644248134;
        bh=U53gZ+l/kdaaJyvWD/b5EEP8osDkf04QBB3k8cFqnJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EMvYcc4JNP+7zcm/GA8wH76cRCamoeL9hklxByyHqVwmPvWQTVfb7Aw57sPbo6DcR
         FcaclsyfDyir6g3P2u4b+Q1gF4gOifVf6+nS2m9OPE/LgH1A3o5/iyaUkoF8oYITvb
         ccA2A8bm3BEfLCkZ3bxKBIW8PEefrWM4KY84+jDlmBbhWT38/fMutqQcTbFy2FZ9At
         3F7HpBjoxQS+gVLMv3mqKvVJDQM41ETvbyUOGEKzV0TiGUlmVP2SXAtC/sS0ChlOyg
         my/CWmpKykQe518DVWWLVUKMADOZwAw4mm/pI3gYc1kKbfxIc3gBRbxcrTo9oCVNhn
         LebOMYeGZR+5g==
Date:   Mon, 7 Feb 2022 23:27:46 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] riscv: reduce THREAD_SIZE from 16KB to 8KB for RV64
Message-ID: <YgE6co0GR93s1LTQ@xhacker>
References: <20220206174359.2986-1-jszhang@kernel.org>
 <CAK8P3a3Nnw5gfPAYx5UGdW8Om16GDcBi1-SS9Bs+CyLzssgVbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Nnw5gfPAYx5UGdW8Om16GDcBi1-SS9Bs+CyLzssgVbA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 08:35:54AM +0100, Arnd Bergmann wrote:
> On Sun, Feb 6, 2022 at 6:43 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > After irq stack is supported, it's possible to use small THREAD_SIZE.
> > In fact, I tested this patch on a Lichee RV board, looks good so far.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> I can definitely see the value in this, in particular when you get hardware with
> small RAM configurations that would run a 32-bit kernel on other architectures.
> 
> However, it's worth pointing out that all other 64-bit architectures use 16KB or
> more, so it is rather dangerous to be the first architecture to try this out in
> a long time. Some on-stack structures have a lot of pointers and 'unsigned long'
> members, so they need twice the space, while other structures are the
> same size either way.
> 
> IRQ stacks obviously help here, but I don't think the 8KB size can be made
> the default without a lot of testing of some of the more rarely used code paths.
> 
> Here are a few things that would be worth doing on the way to a smaller
> kernel stack:
> 
> - do more compile-time testing with a lower CONFIG_FRAME_WARN value.
>   Historically, this defaults to 2048 bytes on 64-bit architectures. This is
>   much higher than we really want, but it takes work to find and eliminate
>   the outliers. I previously had a series to reduce the limit to 1280 bytes on
>   arm64 and still build all 'randconfig' configurations.
> 
> - Use a much lower limit during regression testing. There is already a config
>    option to randomize the start of the thread stack, but you can also try
>    adding a configurable offset to see how far you can push it for a given
>    workload before you run into the guard page.
> 
> - With vmap stacks, using 12KB may be an option as well, giving you
>    three pages for the stack plus one guard page, instead of 4 pages
>    stack plus four guard pages.
> 
> - If you can make a convincing case for using a lower THREAD_SIZE,
>   make this a compile-time option across all 64-bit architectures that
>   support both IRQ stacks and VMAP stacks. The actual frame size
>   does depend on the ISA a bit, and we know that parisc and ia64 are
>   particularly, possibly s390 as well, but I would expect risc-v to be
>   not much different from arm64 and x86 here.
> 

Hi Arnd

Thanks so much for all the suggestions. Item3 and Item4 look more
interesting to me.

Thanks a lot
