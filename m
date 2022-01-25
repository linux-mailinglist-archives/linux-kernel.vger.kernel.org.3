Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439A249B974
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381045AbiAYQ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:58:40 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:50426
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245627AbiAYQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:56:18 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 749EF40045
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643129774;
        bh=5eYae9BZCoH9A4LgUvrM4idND+AMgsOC/mtccDlQNMY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=g+ed2Wu2MHE6j33NttKTnYQAUHXYukbYhaFr+iu0TOew/PLr4caAoRfBKRo5EAszf
         GWqyBP4n4+iOvXGBfu8yYWFMv70siAVddt8icHy+FRaH4oC3kSfjZf9NPZ8UVIOdVu
         /nwZIZGlurs4uhj/ZOhgzZbmeDFkoUdXpoS00AIl5H+Zp66gpqTcMXYgTjbaUtAG2+
         77xAkuXlvUWJv92fr/zpmeIy5BzUCfMpS5n27ROd6YfzrnyMXUjO2KbfGoBH1jgT0M
         tGKKmpOz8L43MAhnEVzGlFCsofRhePz7IyW3EuK8gO+F98WGBpdV5SSuZgnFinm5u5
         augWlT724hFtA==
Received: by mail-wm1-f71.google.com with SMTP id o140-20020a1ca592000000b00350aef3949aso519312wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5eYae9BZCoH9A4LgUvrM4idND+AMgsOC/mtccDlQNMY=;
        b=PR8rrH7YHGZvFkDakhfcq58VG9gukSPaP8Qbb9NIKspQapWX1og1IMUmEga1Y2/VJ2
         4VJjmPgxJuWpDpiU8+MAFg01m1nOZWCkiqr++JU/GFcqYGteZJ4vhZWHK48BfRz0obun
         U8RE9XCXY9UvL0rwU4E2x95qg68fEj9zPvknjYENHX5CoyXEukwkANfHGw1zOa8whHTA
         1RGVILk4QYS83XzrVXXoTtBRNS5ebi6N0Au1kDIaaKTBJPQ55GWkc3YE3niJ2yA40oTs
         o+9QVCnCKLbIf8wSqWpk1U5yeVLvTrHpB9VZrgt/Haz2RfTTdWD0l5Pj5rOvxftuwzh2
         eFFg==
X-Gm-Message-State: AOAM5310a8X2VSvacfgqPAcIwve2f7G7sLpPKCw9p1KAAcePWjRE3Kcr
        IDgVWL9YPOvMVLTgGtpd2jHsCcCyiYDt9W13g4dBYJbJzTm91qH8/bPTaDDH4zawkOo45XlTlP0
        YWAWZLLA/dJWxlvioEAoROhJsf9wHpW0Nj8uBunfotg==
X-Received: by 2002:a05:6000:1447:: with SMTP id v7mr19423995wrx.492.1643129773876;
        Tue, 25 Jan 2022 08:56:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyl6s7vxqqP7feCQXJb4rhGDy+l7w2eRsOoKxYvFlhqNY7yJ2EtAmgMJCoih+WZhX4X2VwszQ==
X-Received: by 2002:a05:6000:1447:: with SMTP id v7mr19423977wrx.492.1643129773650;
        Tue, 25 Jan 2022 08:56:13 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id o15sm1058724wms.9.2022.01.25.08.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 08:56:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        anan.sun@mediatek.com, youlin.pei@mediatek.com,
        srv_heupstream@mediatek.com, Tomasz Figa <tfiga@chromium.org>,
        devicetree@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yi.kuo@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lc.kan@mediatek.com, anthony.huang@mediatek.com
Subject: Re: [PATCH v3 0/7] MT8186 SMI SUPPORT
Date:   Tue, 25 Jan 2022 17:55:38 +0100
Message-Id: <164312972455.77587.5523685649094227634.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220113111057.29918-1-yong.wu@mediatek.com>
References: <20220113111057.29918-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 19:10:50 +0800, Yong Wu wrote:
> This patchset adds mt8186 smi support.
> mainly adds a sleep control function.
> 
> Change note:
> v3: a) Add a new binding patch for renaming "clock" to "clocks".
>     b) Reword the title for the binding patches, more detailed.
>     c) Add the sleep control error path: if err, return directly.
>        also change the log from dev_warn to dev_err.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: memory: mtk-smi: Rename clock to clocks
      commit: 5bf7fa48374eafe29dbb30448a0b0c083853583f
[2/7] dt-bindings: memory: mtk-smi: No need mediatek,larb-id for mt8167
      commit: ddc3a324889686ec9b358de20fdeec0d2668c7a8
[3/7] dt-bindings: memory: mtk-smi: Correct minItems to 2 for the gals clocks
      commit: 996ebc0e332bfb3091395f9bd286d8349a57be62
[4/7] dt-bindings: memory: mediatek: Add mt8186 support
      commit: 6d86f23c35fe7b479ceef4d3f1eef925996945fd
[5/7] memory: mtk-smi: Fix the return value for clk_bulk_prepare_enable
      commit: a6945f4566d4f77a4054720f6649ff921fe1ae64
[6/7] memory: mtk-smi: Add sleep ctrl function
      commit: 8956500e5d5bf541a945299999b0bf4866dc0daf
[7/7] memory: mtk-smi: mt8186: Add smi support
      commit: 86a010bfc73983aa8cd914f1e5f73962b0406678

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
