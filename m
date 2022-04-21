Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4F509B56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387028AbiDUI7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiDUI72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:59:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F91AF37
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:56:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q3so5672432wrj.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8VJqr/JOTXk6D9K+KLM17m7eCfCxDzRCyqQMqD9ufoQ=;
        b=LCu6iHn0Axwbk9WWgOgbYUTUE9Mhadrn2Opz/RD0vBfDzc7PFxIN40Ps5FoSz1vdro
         5RFMZsh2mp6hOLridL297JIOQGu8Kq5Mez6FRW02D291+2MixbUuqDUxnaYT6o2x+HMf
         vKQLCqKdukIY51me16fbd3srBk6adAORkJqXkrXIAuGD6+MwJWB1BrWnZoG50Enm1VEh
         7ksyKieSfPIJ4IO7hXbeXJl4+Ze65DW4KF8/KLsc/vleFNXA2FHwMjKi5W0f2adeNMN7
         EoC4wZa/3MtvMiiQnda5LD/H/l1se/Tt++EapTd9GXqoxj+An9j207OedAj6uRuY1asL
         s8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8VJqr/JOTXk6D9K+KLM17m7eCfCxDzRCyqQMqD9ufoQ=;
        b=fd1Qquxxbw9+/vfbxqTUQfQqd4B4h99LdGPc0C8kYcJiDY4yaLjRT8lWkLJWI76SYQ
         uJPYP/rGlIm0D4WK6kzfUtJ7y1tj2QatK4jQuTl2WcKSLXETG6AwKSX4qnJe8/B8uoyo
         wqZHyTQxaiKeVFNHN+hwOPpc5aRj73ezhHvG48DgdLAV7jMW68z4C2oS8w3I7GmzGXJa
         HXIL7P10hbyGf0z3gorwfOcRSGnjc0OsK2R2KrRv1Rgs7JENqkREhVk2wbJ8UxDZ5QI9
         89Pr/GhQXqOFvOFyqdWq+gPWc+geX6Y7Z+lCfOvqBP0CkYFwe9li3X5lXcJJ3n/HC/mR
         eo+g==
X-Gm-Message-State: AOAM532JY3WvFXMcbtPl4V+zmaY4uJhRvkE6ROY+O5V+/FVvF74bX2i/
        UPU+U0oweY49gJ9Btv/kZ89MfDk2voTVmwrl9Ai3FxsCIaA=
X-Google-Smtp-Source: ABdhPJx2e3AQQ0C7FIqM/rpSO336xj2B9Rm5rTJiKVX3f9YTdTnpyUYC09uB5UyOneND8c/qYtIMU6asZnAUN3NzuAM=
X-Received: by 2002:a5d:6d05:0:b0:20a:91e4:4b7f with SMTP id
 e5-20020a5d6d05000000b0020a91e44b7fmr16175127wrq.190.1650531398196; Thu, 21
 Apr 2022 01:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1645797329.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1645797329.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Thu, 21 Apr 2022 10:56:27 +0200
Message-ID: <CAHTX3d+5vsgjbEGdR0F=8tvQ6KVdR4mUaWD8bcc4qkMwLcUAdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] microblaze: Fix issues with freestanding
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Mahesh Bodapati <mbodapat@xilinx.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p=C3=A1 25. 2. 2022 v 14:55 odes=C3=ADlatel Michal Simek <michal.simek@xili=
nx.com> napsal:
>
> Hi,
>
> with GCC 10 there is issue with simple memset implementation which is
> called recursively. There are couple of discussions about it and the firs=
t
> two patches are trying to workaround this.
> The third patch only removes simple implementations from arch code and us=
e
> generic one which is the same.
>
> Thanks,
> Michal
>
> I sent only 1 patch in v1 that's why sending v2 with all 3.
>
>
> Changes in v2:
> - missing patch in v1
> - missing patch in v1
>
> Michal Simek (3):
>   microblaze: Use simple memset implementation from lib/string.c
>   microblaze: Do loop unrolling for optimized memset implementation
>   microblaze: Use simple memmove/memcpy implementation from lib/string.c
>
>  arch/microblaze/include/asm/string.h |  2 ++
>  arch/microblaze/lib/memcpy.c         | 18 ++-------------
>  arch/microblaze/lib/memmove.c        | 29 ++----------------------
>  arch/microblaze/lib/memset.c         | 33 ++++++++++++----------------
>  4 files changed, 20 insertions(+), 62 deletions(-)
>
> --
> 2.35.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
