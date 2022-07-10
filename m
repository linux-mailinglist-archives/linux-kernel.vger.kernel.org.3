Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31756D1DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 01:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiGJXEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 19:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJXEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 19:04:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597FBF599
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:04:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu42so6103652lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 16:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3eF7/3YZ7rIKKStNQt75RnsLq+WT1feGCVcwXzz/uI=;
        b=D9u3/PqoDWsohZRxqIhl7zMDCtr1rR6HcbqK4ie4MGbL09YbSVqbv4KNPR/b30iI2/
         yLYSbDvo+nSUOQpknGd63sOYc+XzftwHyynHqusAWPYWJHxHEGhnCgDxd8CtzT6I3Sjv
         ZSIFMjuS0Y9RJW+WKeRindRAk0/+0p+omOKH9ThPN2V75KU4BDCYIMECo7RJQea0Ie2v
         jvT8OWxgVZNm3MqRxYS781o2keDoD2SMSv5s4Z0RdwHSpDsilBZxFgzj/ii45EGMDTOS
         JYbZaSi45J1VyKhDkV5DqiB+lP51KKJLshTdDYaQtnOdp+GZgE1QKAVuAmjp8HXUeEMp
         JBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3eF7/3YZ7rIKKStNQt75RnsLq+WT1feGCVcwXzz/uI=;
        b=vx/cFahshPPPo/iqtxQmy++NNTdU+VYDP4hmppBUtJ/+9laOIBSOi5U2+dWXzC/GR5
         cSdPyJaht/5kIQ7R9ZlH2KEnm1TL/Mv3YHsmOjQqYVQDjipARkVOPcLvAMSstPEWNE+v
         uYOG3Sj4byS4WPdQYzoIlgGKXffYXKjkN5yvIWMkhDST4u0AA9xQz6onmZ/MWijvoIhM
         L2o7ErfSoCLoncBSmfduxlLfI1vc0xb2Kg7q7wPc83uiLlb7yQ/91kSJycO5SRF5wrEu
         lznGjOg1HaBi3+kjtumW53CMuS0Ox+f7TvTRGgdIvlfkA7rYQIqJzxWD0+oqPS3epVNk
         TxPw==
X-Gm-Message-State: AJIora/7N5aVOPEPnAumS71OJcRVQZKpDd8qV/tp7Xs8LiMCWKd/V1qg
        a2KfSzNlBj0x5IJSR3bp0fuqEAtM5VWhsJPHSo1DiQ==
X-Google-Smtp-Source: AGRyM1ullE+R0OOwt9+0nk05VmjzL/rnKXOzOo0zF0uLxr+6lUyQ1Vf9sRaETxu+k2ZRwmsM4OvKJj735krWmhsnWM0=
X-Received: by 2002:a05:6512:2252:b0:489:dede:1cb3 with SMTP id
 i18-20020a056512225200b00489dede1cb3mr941409lfu.503.1657494282616; Sun, 10
 Jul 2022 16:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com> <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
In-Reply-To: <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 11 Jul 2022 02:04:31 +0300
Message-ID: <CAPLW+4kU3gLfSRa4cm+374Fh4ooCag7kSk_cwhDe=M8ewMzcbw@mail.gmail.com>
Subject: Re: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
To:     David Virag <virag.david003@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2022 at 13:47, David Virag <virag.david003@gmail.com> wrote:
>
> On Sun, 2022-07-03 at 00:48 +0300, Sam Protsenko wrote:
> [...]
> > Hi Marek,
> >
> > As I understand, you have some board with SysMMU v7, which is not VM
> > capable (judging from the patches you shared earlier). Could you
> > please somehow verify if this series works fine for you? For example,
> > this testing driver [1] can be helpful.
> >
> > Thanks!
> >
> > [1]
> > https://github.com/joe-skb7/linux/commit/bbadd46fa525fe1fef2ccbdfff81f7d29caf0506
>
> Hi Sam,
>
> Not Marek here, but I wanted to try this on my jackpotlte (Exynos
> 7885). The driver reports it's DPU sysmmu as version 7.2, and manually
> reading the capabilities registers it looks like it has the 2nd
> capability register but not the VM capability.
>
> After applying your patches, adding your test driver (with SYSMMU_BASE
> corrected to 7885 value), and adding the sysmmu to dt, I tried to cat
> the test file that it creates in debugfs and I got an SError kernel
> panic.
>
> I tried tracing where the SError happens and it looks like it's this
> line:
>         /* Preload for emulation */
>         iowrite32(rw | vpn, obj->reg_base + MMU_EMU_PRELOAD);
>
> Trying to read the EMU registers using devmem results in a "Bus error".
>
> Could these emulation registers be missing from my SysMMU? Do you have
> any info on what version should have it? Or maybe some capability bit?
> I'll try testing it with DECON/DPP later and see if it works that way.
>

I don't have any manuals for v7.2, so I can only assume. Yes, it looks
to me very much like those EMU registers are missing in your SysMMU
IP-core: I remember seeing some similar SError messages while trying
to access some incorrect MMIO addresses. Good news is that once this
patch series is fixed and accepted, you can *probably* base your work
on top of it (as I only validated it with EMU registers for now). I
mean you can add some real IP-core users of that IOMMU, like graphics
(DPU), audio, camera, etc. Not sure though if it would be enough to
just add some DTS nodes, or your SoC support has to be added to some
drivers first.

> Best regards,
> David
