Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958E64C71DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiB1Qof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiB1Qoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:44:32 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87D66623
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:43:53 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2EDAC3FCAC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646066631;
        bh=z46ftlWp8HVzXGwdCryYKmM/VWtrNM7xN3TT5iDqJdM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Ureyj2Q+zwI9j11xyAgRf42XkdCdeHShp2UjWyjEZVrGz0xU06ebQzsYhYqFy0usg
         G0mludPdBKtP4qCRjnzLogq8i11zItgsfKcrv6UGL1vlpLVaGw5+P/t3lk/AtffrdX
         ussT3oEs8mhn9ZWgziXiu4MaCHBTD7sRcDZEIOx2iU28GVzlh4x8mxgwBg5io2aV4U
         vIID9JWXZBz9fFgKqU/eJowVqIIbtky1is0NZOV7pABPuEqKWXyFc0o3DgroGBt1/0
         87INkXV3XNI5MFRIXYCC//UVo/ATi/cy1adH/KYcQ83Mp+tq89M32Zsn/+5+IWCTbW
         eLS8H+vANsD8A==
Received: by mail-ed1-f69.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso6203846edt.20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z46ftlWp8HVzXGwdCryYKmM/VWtrNM7xN3TT5iDqJdM=;
        b=sL3CtX9IepFjg335/wZuklmtyvxri6nn3speQ0hZDY/pxJ2HbKNJgxPtMwD7NNhB5F
         tdo5BBcWs8+c9qqh2SipJsbLkmjsDYTDLOyLF3C1nTGgUIH3RcUF7IyhMhpUYGySJ7yC
         B3Pn0v/UhC3Gp2QjjWSCTZPOIDo2VVtFHCvoZ3ebpMrmmw2BpYRrKTXfsmEdm8KGyn8L
         mXBzr4A9Zf8FPpXzBcxbwMcyF3JCtA1ZPgyISHKWwZoHrWVZIzSRx+Oc3kyA9bsBuXN2
         fNX76piVyw49Ju40dpIN7x8quhP8apfFn2Pfe1S5fHR4WnS90CSq8DeSLodM6u89hIHD
         slHA==
X-Gm-Message-State: AOAM531uxnK+YT6UnthPloao/aIcak5Hn5Mb57d7M+Kd/uvDBmMGB9qJ
        I+ykQffUTv1EjV5ZDDg6dknhALbGZBNGZheTCpK2+6u/K80sS9yKUtXNy0qnZBrFNweO3wRm0ZQ
        VgT+iNpQYMKWRWkZO0FVVKfifNS00ij6coHJHZbZw5g==
X-Received: by 2002:a17:906:b887:b0:6ce:36cb:1e18 with SMTP id hb7-20020a170906b88700b006ce36cb1e18mr16005112ejb.95.1646066630391;
        Mon, 28 Feb 2022 08:43:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyihmYLKs3hjWBogsCiEne50Bxk+AmKd7XUPOOzE57p2CEzj37GAswbJS4yucW9/3uChBQZMQ==
X-Received: by 2002:a17:906:b887:b0:6ce:36cb:1e18 with SMTP id hb7-20020a170906b88700b006ce36cb1e18mr16005100ejb.95.1646066630153;
        Mon, 28 Feb 2022 08:43:50 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090635d200b006cdeef01456sm4498443ejb.163.2022.02.28.08.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:43:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 2/3] memory: mediatek drivers for v5.18
Date:   Mon, 28 Feb 2022 17:43:12 +0100
Message-Id: <20220228164313.52931-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220228164313.52931-1-krzysztof.kozlowski@canonical.com>
References: <20220228164313.52931-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mediatek specific branch.

Best regards,
Krzysztof


The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-mediatek-5.18

for you to fetch changes up to 12fbfd665fc473800d25d0f3ca4617c82cff42dd:

  memory: mtk-smi: Enable sleep ctrl safety function for MT8195 (2022-02-08 09:29:25 +0100)

----------------------------------------------------------------
Memory controller drivers for v5.18 - Mediatek SoC

1. Several updates in the MTK SMI bindings.
2. Add support for MT8186 MTK SMI and improvements in support for MT8195.

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      memory: mtk-smi: Enable sleep ctrl safety function for MT8195

Yong Wu (7):
      dt-bindings: memory: mtk-smi: Rename clock to clocks
      dt-bindings: memory: mtk-smi: No need mediatek,larb-id for mt8167
      dt-bindings: memory: mtk-smi: Correct minItems to 2 for the gals clocks
      dt-bindings: memory: mediatek: Add mt8186 support
      memory: mtk-smi: handle positive return value for clk_bulk_prepare_enable
      memory: mtk-smi: Add sleep ctrl function
      memory: mtk-smi: mt8186: Add smi support

 .../memory-controllers/mediatek,smi-common.yaml    | 32 ++++++-------
 .../memory-controllers/mediatek,smi-larb.yaml      | 19 ++++----
 drivers/memory/mtk-smi.c                           | 54 +++++++++++++++++++++-
 3 files changed, 77 insertions(+), 28 deletions(-)
