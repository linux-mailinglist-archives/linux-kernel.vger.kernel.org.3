Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E3857DB7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiGVHtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiGVHtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:49:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2BC43E5C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:49:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E3EA2CE202B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32793C341CB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658476145;
        bh=oFiEeRGUgpyFfmlOu8G9LzLg0b440Ed+op390yZ+zAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QYwJuq2VDEmmH8n4ATz+L0cGEA3259ZXblO469UawOcH6R3UByzFKmzWfWbICt96R
         IfslQnQDdS95EwFUPuy0XRUNqiFfGtZhxledVHcOTzfiq2uJnQ/A90oVUIWCcqAGl9
         TZHp4YHsrlV3GRYOyNX9bqdVfGYYbVM95FDdgoZHCfAGM0JzP5rvgRkqrz/5OyuIPV
         Qe4p6rekirL7/K73gQmPyEBt7vNBoH3rjp6D/lQdXTOre5M4LkiFu1UPxEX0gTZXTU
         0+9znV9YRXRHax9hVyrSqAJ7LkYtDwN2Z8V+/AIXmPo5RravDZd6MMRuOwsCVBhkQ7
         AE1RgJbJ8UyTw==
Received: by mail-vs1-f51.google.com with SMTP id k129so3645541vsk.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:49:05 -0700 (PDT)
X-Gm-Message-State: AJIora9Wht6b53eUI+nVEka9QXZUW2oZv2v3s1u9Hm9AxEFgtuZ2MoVf
        e22OoSgEeqryQjp+dk198b/+2XGZ3kDu3EitTGk=
X-Google-Smtp-Source: AGRyM1ss4kDIrNV2OFFIsgZ1FVXlhJFzRJOa6dEtVcimbr95buNO4410rqCNTUzUlIz2xHMdDlVAwdEk2HmZD5Az5Vg=
X-Received: by 2002:a67:be07:0:b0:358:19f1:742c with SMTP id
 x7-20020a67be07000000b0035819f1742cmr643262vsq.70.1658476144120; Fri, 22 Jul
 2022 00:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <1658305979-2073-1-git-send-email-yangtiezhu@loongson.cn>
 <fc5a891d-e5a9-c02d-08e0-318213cde8f4@loongson.cn> <f43b5f40-9e2b-b179-390d-591a73603afa@xen0n.name>
In-Reply-To: <f43b5f40-9e2b-b179-390d-591a73603afa@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 22 Jul 2022 15:48:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4DcfChTDtE+y926Taynwcz5wkpRa9+L4JBgCTbZjJkRw@mail.gmail.com>
Message-ID: <CAAhV-H4DcfChTDtE+y926Taynwcz5wkpRa9+L4JBgCTbZjJkRw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Remove LOONGARCH_CPUCFG48 and some CSR definitions
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

On Fri, Jul 22, 2022 at 3:34 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 2022/7/22 14:58, Tiezhu Yang wrote:
> >
> >
> > On 07/20/2022 04:32 PM, Tiezhu Yang wrote:
> >> According to the configuration information accessible by the CPUCFG
> >> instruction [1] and the Overview of Control and Status Registers [2],
> >> we can not see the descriptions about LOONGARCH_CPUCFG48 (0x30),
> >> LOONGARCH_CSR_PRID (0xc0), LOONGARCH_CSR_MCSR* (0xc0 ~ 0xff) and
> >> LOONGARCH_CSR_UCAWIN* (0x100 ~ 0x109), they are not used in the
> >> current kernel code.
> >>
> >> LOONGARCH_CPUCFG48 may be used only in the firmware layer, it should
> >> not be used in the future for kernel developers, remove the related
> >> LOONGARCH_CPUCFG48 definitions.
> >>
> >> LOONGARCH_CSR_MCSR* is shadow of LOONGARCH_CPUCFG*, no need to access
> >> LOONGARCH_CSR_MCSR* and LOONGARCH_CSR_PRID through CSR instruction,
> >> use CPUCFG instruction to access LOONGARCH_CPUCFG* is enough, so also
> >> remove LOONGARCH_CSR_MCSR* and LOONGARCH_CSR_PRID definitions.
> >>
> >> LOONGARCH_CSR_UCAWIN* may be not implemented in hardware, use CSR
> >> instruction to access them is meaningless, so also remove the related
> >> LOONGARCH_CSR_UCAWIN* definitions.
> >>
> >> The intention of this patch is to keep consistent between the code and
> >> the manual.
> >>
> >> [1]
> >> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#the-configuration-information-accessible-by-the-cpucfg-instruction
> >> [2]
> >> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#table-overview-of-control-and-status-registers
> >>
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >> ---
> >>
> >> v2:
> >>   -- Remove LOONGARCH_CSR_PRID and LOONGARCH_CSR_UCAWIN*
> >>   -- Modify the patch subject and update the commit message
> >>
> >>  arch/loongarch/include/asm/loongarch.h | 229
> >> ---------------------------------
> >>  1 file changed, 229 deletions(-)
> >> Hi all,
> >
> > Are you OK with this change? Any comments will be much appreciated.
>
> Sorry for not getting to this earlier; $DAY_JOB is taking its toll on my
> Linux contributions these days.
>
> IMO, it's probably better to keep the definitions for documentation
> purposes.
>
> As a Loongson employee, you may be aware of the fact that your company's
> "official" documentation is often lacking, and this information you're
> removing is not found elsewhere. So for preserving this knowledge,
> either (1) ask your documentation people to properly record these
> information in official docs then you can go ahead removing them here,
> or (2) just keep the content here if (1) isn't doable for any reason.
> You do want 3rd-parties to freely develop on your platforms, making full
> use of the products' capabilities, don't you? ;-)
I agree with Xuerui, and I have already had an offline discussion with
Tiezhu about why we want to keep it.
There are various drivers that provide large register definitions, the
most notable one is amdgpu (their registers are obviously not "all in
use"), you can see drivers/gpu/drm/amd/amdgpu/sid.h as an example.

Regards,
Huacai

>
>
