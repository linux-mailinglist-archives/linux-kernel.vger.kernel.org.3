Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166714A2E37
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiA2L3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:29:31 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53154
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235093AbiA2L31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:29:27 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DEA9F3F4B6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643455766;
        bh=mQWIhzfALzmhNvVwAVuvuNXj69s9Y0aV8nVP8i/ovfg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=NFg+xFE44e5U+WJh7VaXUwffiot4vxAky2m9/yZxJQtp7TSkUid89L5/vVIHpDMgT
         KWVVa0FLcp9yPw4RzVCdF5A6+DRPBybgsaMHnQdBL8wyEbik3wqRzUhXln5Fqn98dA
         37SK8oPG6b/B6OJulLR5FRwAjCFwPx6lL58hqjqmDeA09O495CVUNR1eS8O1L/qIIz
         wzQ8TZoA5jXTlmbVDzSj1aaG//EYvNd/4KltR+QIGynW37PgJbUOBlvPVpWJNFesj9
         EGrleRpg3taeDpu9BONvk9j0h0lewi9nLO5F74gkO9v4UhgmboRLo9RDSTQd/ijsTL
         1/t09QVSTsybw==
Received: by mail-ed1-f71.google.com with SMTP id k5-20020a508ac5000000b00408dec8390aso4342337edk.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQWIhzfALzmhNvVwAVuvuNXj69s9Y0aV8nVP8i/ovfg=;
        b=pBoJ57CLfu/yGjlNhBGIM+//da1cpndWmJDo6aTRy3GW5AJccGylha/zsXVFzqhvgL
         DcIg+ff4WiDW9ih5HXWGy0RJAKWAC08/jFPDG3cy0sbyp0lIC6AsuD2oMpRp7LJcV/Uc
         ceaVScfjmAt1C5T6h3gNGcxdAbyJPt5ZejfyEetaSZJKj2i8KiQv0M5chsXJe/EtT7dK
         Xeb64NDf37jwOkuY4n6koGcKyVgE+Zxw8nhxVbXOk97NLFbMSSj8QQPUBBEQl9LNbhGK
         S4Wksut3otRwQaED35nLG4aLkt4lH8ex/lHUHd4kRUUTTzKOQiQiH7WaQYa+/hGvoMwH
         1ghA==
X-Gm-Message-State: AOAM533K4ip3+thdPromednck0itcfn7IOY30/nqHKyXduCz8Z3eBH5q
        VwF+C/BazKB/XURowuF8O8rwEC6AdTddQRDl/eOmRjIxCiD5d2UZy3V9nvTkh30HsGCQtXsxENx
        alwS23tZ1AjQXSwrvJZnAyYQH50lBcYmdpbGGujYJVQ==
X-Received: by 2002:a17:907:3f99:: with SMTP id hr25mr10190860ejc.588.1643455765345;
        Sat, 29 Jan 2022 03:29:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUWK6qByvVxIBS+9uu2vdLsOAJFd0ApGv7Ogy0hcRemfHrZnMyIWyq6RHHSeL54zf6jeCBQw==
X-Received: by 2002:a17:907:3f99:: with SMTP id hr25mr10190835ejc.588.1643455765142;
        Sat, 29 Jan 2022 03:29:25 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id jt17sm10943147ejb.161.2022.01.29.03.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 03:29:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linus.walleij@linaro.org, Aswani Reddy <aswani.reddy@samsung.com>,
        linux-fsd@tesla.com, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        pankaj.dubey@samsung.com, devicetree@vger.kernel.org,
        andi@etezian.org, linux-samsung-soc@vger.kernel.org,
        broonie@kernel.org
Subject: Re: (subset) [PATCH v3 3/3] arm64: dts: fsd: Add SPI device nodes
Date:   Sat, 29 Jan 2022 12:29:22 +0100
Message-Id: <164345575829.11115.173136141798893555.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220125031604.76009-4-alim.akhtar@samsung.com>
References: <20220125031604.76009-1-alim.akhtar@samsung.com> <CGME20220125032828epcas5p22fbacf42ebfb1b78c1f74f48d37aa381@epcas5p2.samsung.com> <20220125031604.76009-4-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 08:46:04 +0530, Alim Akhtar wrote:
> From: Aswani Reddy <aswani.reddy@samsung.com>
> 
> Adds device tree node for SPI IPs
> 
> 

Applied, thanks!

[3/3] arm64: dts: fsd: Add SPI device nodes
      commit: bd1e3696a052b9b2bd3c1c72ef4bf800a3a1e286

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
