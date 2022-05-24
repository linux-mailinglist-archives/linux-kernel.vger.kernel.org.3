Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2876A53319D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiEXTNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbiEXTNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:13:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637495DE48
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:13:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i27so37266870ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsS2AGuhnxF/8N9VLB8T2eF5RNbu94pUOvL2LTXnFJg=;
        b=HAOZoW6A4tlSRA4X6y2Fl9zXR6BbnUdHXqJK1PPa7kNEiCJPrx3Mkm9mA02+4w3mhS
         3IgN1UTNYCGQE96ZCbfxbESZ0ktW9AHIqsuNIQ7NSQfjBqvVI/GLUOXY5jzNIopN0MFS
         Lvsp/dCaenWSovY9acjyDgmGSuaouWlDOtmGMVB3V29UWsujfu56WHVhr/1kSWkjWgGe
         W7z60NolLIfgv0RaKGqxehWT5CpuD5ynhQB+4MX79DIcwUNiQaZxhlXMZXn/CvZNwcyE
         /EakcTnMFNYWor03QAZvpHLWLZ6BITYAl2wT671q3RJYKJROvWe2t1PrKZMQYxn55DHZ
         rTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsS2AGuhnxF/8N9VLB8T2eF5RNbu94pUOvL2LTXnFJg=;
        b=2Aor/k4gCOAsMXQUDeV15mW+SvZuFyU+7Gvs5XoGfg6f1hKaDniPQbO/2Cy6jVtxJb
         Ye46A6IzJAheg56YbobPN77ii8p81Fv3pH+u5TgoxKg1EDsLXlgcSLZyYiWfYq38jgfZ
         f3hTZq5XGWDZ7I2aHsxGKA8DeU4UOBh8F1oBHSDfdD6g2jEwwm7xvfh0d0R6hzr5rxmr
         13pPPtbXIPQRoatH51rX94kHn8oTu3H2ERjJY7rVTRcpY1AcLDESMWL0Xa7DAPfvbGou
         LINby2bO9ZYGOF/HUsMWY7iBxMDOcbjsLiiNvfCIFcN1J/TSC3GP65gsCxW7kMR20NTl
         BdAg==
X-Gm-Message-State: AOAM533Ztl1hA8fMZVEHW1wWocckcCa1ayyXGgEotDHqrhuootY2172A
        r3s1kv8h4DnQsZTlrvxSzM6f/5akrZtGeNf/G5M=
X-Google-Smtp-Source: ABdhPJweaG+KIiYEQRCw11koCjYEypL+sU3mG2PwGIxlwKKLPT/Lpe4gKmlZNoAShS54tEeFI9QdtEboS/aMHjzFECo=
X-Received: by 2002:a17:907:7f21:b0:6ff:10b:9cee with SMTP id
 qf33-20020a1709077f2100b006ff010b9ceemr5288487ejc.302.1653419614752; Tue, 24
 May 2022 12:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220524065729.33689-1-linmq006@gmail.com>
In-Reply-To: <20220524065729.33689-1-linmq006@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 24 May 2022 21:13:23 +0200
Message-ID: <CAFBinCA=bDdo3SJuoDgugtNz1zAMQEgxxHfZo6ZQ9Q3mRQciUw@mail.gmail.com>
Subject: Re: [PATCH] meson-mx-socinfo: Fix refcount leak in meson_mx_socinfo_init
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 8:57 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 5e68c0fc8df8 ("soc: amlogic: Add Meson6/Meson8/Meson8b/Meson8m2 SoC Information driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thank you for finding and fixing this!


Best regards,
Martin
