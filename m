Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387414EB0F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiC2PsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239037AbiC2Pr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:47:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC863AA63
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:46:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bq24so15058653lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzsX+Z/Ob1Uq1Bl1zjv6NpTlPhHDx16mmOiOaqiohic=;
        b=hW0k5QP3S+OQzUO7KyNkwKzpkeUych1UA8cIIOUlFUiS1PALQl5iYa+c5Z2OWI3Et+
         +ASK2QEkL/qYaVTDJ73mN8Iul39x/qiuK6ymqkBWXNfpRs0glgDoqWm4qUGtVJ7wxQB/
         IPrdIDps5eVBIj1pp4R0U4FUR0DckGfB2Nmlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzsX+Z/Ob1Uq1Bl1zjv6NpTlPhHDx16mmOiOaqiohic=;
        b=ztVrW1Zi+6vMyifT6J89KjMs4BVUpccLcUATk8UcmtrLjloVTlH8lviRTrYp5suO7Q
         559aWyQdyWPIcJwog/N69sfkCtkkkZKS+7GIguvSiPhF2WP3DLkHQ5cg7z4u0buMo2ZC
         vZpS4Sn21buZtRHCOKKxGXYIeGYY1I79PLcHQ2hpLfiPDZHRXWVCkEi3E4uPP+GKho0q
         GegEhKW2OQJWLbdW7TG+NO1njcxDiX0MLW3DbZjyCiaAcag3vIVtaKGEXDc4NqBUzPcl
         Sd0zKmmnllzkqXwpWzbMBNbeOvpL1Xu2nup4sXOdaQ75rYcR6nrEyR7yxdPQwqCXqQ7J
         aNIQ==
X-Gm-Message-State: AOAM532NqzaWHWy7X2HMPNcn3fFMW35ciHtNfPc2b6LXFJnKi1tSvinh
        G3MJ4ttlLLFJs/BwY1MEGSmGVZRt+5iVSI3Y
X-Google-Smtp-Source: ABdhPJwc7/qLbMS+YKkijaczHAVhLxSGmK0V2/wqQRmVhCok7XKamsDH2n70vgAQcPu6ftNonmySeQ==
X-Received: by 2002:a05:6512:32c8:b0:44a:27fd:cd06 with SMTP id f8-20020a05651232c800b0044a27fdcd06mr3351445lfg.239.1648568771638;
        Tue, 29 Mar 2022 08:46:11 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k1-20020a196f01000000b0044a518dc264sm2024123lfc.299.2022.03.29.08.46.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:46:10 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id v12so11268979ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:46:09 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr3134201lji.152.1648568769399; Tue, 29
 Mar 2022 08:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220329125631.2915388-1-geert@linux-m68k.org>
In-Reply-To: <20220329125631.2915388-1-geert@linux-m68k.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 08:45:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQGp40pKtXquewb22ZpfiAFi-iWhE220SrpCRXQHy8EA@mail.gmail.com>
Message-ID: <CAHk-=wiQGp40pKtXquewb22ZpfiAFi-iWhE220SrpCRXQHy8EA@mail.gmail.com>
Subject: Re: [PATCH] phy: PHY_FSL_LYNX_28G should depend on ARCH_LAYERSCAPE
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-phy@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 5:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Freescale Layerscape Lynx 28G SerDes PHYs are only present on
> Freescale/NXP Layerscape SoCs.
>
> Move PHY_FSL_LYNX_28G outside the block for ARCH_MXC, as the latter
> is meant for i.MX8 SoCs, which is a different family than Layerscape.
> Add a dependency on ARCH_LAYERSCAPE, to prevent asking the user about
> this driver when configuring a kernel without Layerscape SoC support.

I took this directly, since one of the bugs it fixed was mine.

Mea culpa,
             Linus
