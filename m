Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A57357B95C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbiGTPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241277AbiGTPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:13:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E65D58842
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A036B81E95
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE99C3411E;
        Wed, 20 Jul 2022 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658330030;
        bh=nGt3Aby0DEsD4O/j96Wopr2DY0zyfin9FwsBSZGUq1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glBh9aEW8cXsqumGpksb4ZHfU3E6/Fpy8afP4Xz5VUGkb6jaiJx+/Qd6ipiscwBHD
         fUfNqZcKFKcOB97AMTDp1Ww2oehpD18b9TfCS/frvSbgNuq3WD633/gyUa7gBPoMw5
         WNrYaUavOhgtjRA7Q9qGIFGZiz+AigWCKz1JxaVLQCN0XCUnrfhKVLO1TpzFQvaUO0
         y1bHGjVbKC0HOaR8Dhk1Gupx+ZwSjrDshayrkWltmVOxBuOouHPomeJ7pYLk3ocyL+
         9uCOKJdXYnWdsJ4IdeZzuiSTEExd1FAn4/4xOSH2uEo0x06ib/NnSZaPHVSvMTfBk+
         tNWIvdUCQNFCQ==
Date:   Wed, 20 Jul 2022 16:13:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     =?utf-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= 
        <haibinzhang@tencent.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Martin Ma <Martin.Ma@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hewenliang4@huawei.com" <hewenliang4@huawei.com>
Subject: Re: [PATCH V2] arm64: fix oops in concurrently setting
 insn_emulation sysctls
Message-ID: <20220720151344.GA16452@willie-the-truck>
References: <9A004C03-250B-46C5-BF39-782D7551B00E@tencent.com>
 <YtfzvK0T8pJacsDm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtfzvK0T8pJacsDm@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 01:23:24PM +0100, Lee Jones wrote:
> On Sat, 02 Jul 2022, haibinzhang(张海斌) wrote:
> 
> > How to reproduce:
> >     launch two shell executions:
> >        #!/bin/bash
> >        while [ 1 ];
> >        do
> >            echo 1 > /proc/sys/abi/swp
> >        done
> > 
> > Oops info:
> >     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> >     Internal error: Oops: 96000006 [#1] SMP
> >     Call trace:
> >     update_insn_emulation_mode+0xc0/0x148
> >     emulation_proc_handler+0x64/0xb8
> >     proc_sys_call_handler+0x9c/0xf8
> >     proc_sys_write+0x18/0x20
> >     __vfs_write+0x20/0x48
> >     vfs_write+0xe4/0x1d0
> >     ksys_write+0x70/0xf8
> >     __arm64_sys_write+0x20/0x28
> >     el0_svc_common.constprop.0+0x7c/0x1c0
> >     el0_svc_handler+0x2c/0xa0
> >     el0_svc+0x8/0x200
> > 
> > emulation_proc_handler changes table->data for proc_dointvec_minmax
> > and so it isn't allowed to reenter before restoring table->data,
> > which isn't right now.
> > To fix this issue, keep the table->data as &insn->current_mode and
> > use container_of() to retrieve the insn pointer. Another mutex is
> > used to protect against the current_mode update but not for retrieving
> > insn_emulation as table->data is no longer changing.
> 
> Looks as though this lost its Fixes tag during the rework.
> 
>   Fixes: 587064b610c7 ("arm64: Add framework for legacy instruction emulation")
> 
> Will, are you able to add this retroactively?

Sadly, this is now buried under some other patches so I'd have to rebase the
branch if I were to add this and I don't think it's worth it just to add a
tag. On the plus side, the patch has a Link: tag to this thread, so the
Fixes tag is retrievable if you're determined enough.

If somebody wants this for stable, then I suppose they'll have to send
a backport to make sure it doesn't get missed.

Will
