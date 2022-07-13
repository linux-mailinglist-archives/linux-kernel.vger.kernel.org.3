Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA8573889
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiGMOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiGMOPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:15:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBA0255BB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:14:59 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bx13so13655922ljb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGcV0udwGjSruZ22N9l9PLf+/uHhdyNzh4czvTCR/yA=;
        b=zCTXM9N+lWM7M4yu4edy1tV1WT6siuoQVV6e1kZX7hZCPivLfKVDwNmZtMUzVTGTpk
         Ef/AqPA3Cez2+uOeq9HV/f45tl55LY3/Lm6rh//1MmfnE/laT91v1pxoExx7UEnUDxCn
         k+YUuX3kPsjFkja4s3YHSyZTONf48zrSpsqopdXI6QpK4QNe2dvl0s1rizEh9vWkXkxq
         lZrrKtazdbhBNmmNGYg9KXcMYXNveeSxUh+6khWPFBJhyJjhsUPhsNKbhjX+X4GDpXmE
         bKl01T2O+MbqurfsuoXEoHQI8RzhgK8jlETIuCE/jnpt5a0WPd/D2VtgyjbibRTLuymr
         MrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGcV0udwGjSruZ22N9l9PLf+/uHhdyNzh4czvTCR/yA=;
        b=uUAJouYcTq1LFC2OJ7jzLf8tTtIivFozzrSVuzeMqzprRG63vwfcaP+lMLmOHaI3ka
         jDxdRKBW/3zXKOmlXmaqXY1AvMa5gTl5b6lA/0JIuXx35AzMv1tWScJQY7XUuJjdQ8Ho
         B+++6A5Vw0y1XMyLF06cjmowWBsqxNm+b5Idra+xsZw8HLCC4X1YYc3jwF1qMlEVnuTh
         ufcwaOPYg3HP2SiJ0AD7sflqPZKpXClhaZ8J1dY542W3Y/dXPSayOWS7wrn/PNxGq96w
         JNl8DvXDIwwbMaTNeoXkLy7atOKKUsMxts8Pl0FXsZ/7zTKqv/4munO2S9ahqX6MDauS
         pUAA==
X-Gm-Message-State: AJIora+oNsqyRzOcgDWCZb2z+R6AA5SgnGBcmqHT2IU0G0aAcUcGxyxo
        dbgofTZZdYgwWh6T/rV4nogTYC6ixTeaxtFou+0wTg==
X-Google-Smtp-Source: AGRyM1tG9FwWpL3QNN3CU2va1RCPbzZzojzMQ4cZgpcwNihHlrvL0DxO6/vvEBv8w67LwDpTW1hzi0m3ohydLI4AQ8s=
X-Received: by 2002:a2e:bd11:0:b0:25d:4f94:ac79 with SMTP id
 n17-20020a2ebd11000000b0025d4f94ac79mr1943417ljq.4.1657721697308; Wed, 13 Jul
 2022 07:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com> <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
In-Reply-To: <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 13 Jul 2022 17:14:46 +0300
Message-ID: <CAPLW+4=pikbLQZLabv7aZvGhA_30xaJRYLxK+uOUUXnwu2Byow@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Hey David,

Can you please try out the [1] branch again? I've added support for
Exynos7885 there, using the info provided by Janghyuck Kim: apparently
Exynos7885 has EMU registers, but those have some other offsets than
on Exynos850:

    #define MMU_EMU_PRELOAD    0x8040
    #define MMU_EMU_SHOT       0x8044

I wonder if my changes to [1] do the trick.

[1] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu

> Best regards,
> David
