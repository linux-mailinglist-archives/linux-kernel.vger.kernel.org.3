Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF0C47D467
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbhLVPxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:53:07 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59886
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343759AbhLVPxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:53:05 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E0F903F207
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640188384;
        bh=wwMXPWMLJyza5v6X1TaAk2XM/noBR4icpHiHaWLn4fY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=LvAWJn/pUyl9AuiGs16ibG+KE1xr+TRhg0Z2JNt/8JLuetw7DV8bcioPfQq6OX/Su
         t9YeJ75An9Ceu1RrOWwxKw4ZftzPd65ChJMe5omFg/jOmRQUjz3goi3FxrVQDy7yQ7
         eaQCt6voPSxeU0d7Zzt+B4iSNo129Xb3X6kuludFtU5Zl03b63t0mT9HTcqWfG2/5m
         Rcs49KmdQPJQIX/KXW9hIOOBaLErJXsKgfXPUjQikFdRzFvCW+CVPKTABuLrOaVPgX
         YqlTRqDm/pboScLzxtyr8I39ZkY8/cwhVc/ibUPfaVLiZxMcsmEzOypjtyevqWhxIG
         8OyWZUuA+84mA==
Received: by mail-lf1-f70.google.com with SMTP id o2-20020a198c02000000b00425d146a32bso1387945lfd.15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 07:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwMXPWMLJyza5v6X1TaAk2XM/noBR4icpHiHaWLn4fY=;
        b=0jwX4oYUyc+QnQM2LejkxffMjcSzaWxdEfD6EhZV/E93k823zqqGCKlLMcN/4hjtt7
         U9/e6Ye0wB3DUDygoFV7tWWezlDUB2xc9mA6I/0FeZMbCEYQLJcQTgf0ykCbTxfmJkev
         nHmL1GnsAXI8HAmnq76TkTayu3tl2uDrFkJjbEN7gBdOr+oqgvcfSDsYl64UNtPDp+mQ
         33RJa7S5nLiK2BMiz/TkKpZ7g8ZoNQJe7rDQUiOmhmE5B6M5KbWYFwrmtJSs+Ke9LrP9
         oldC51fO+IYPaO3DMf4RutsfeyXLpJ481ieXZoChcoAzCgmunod3+jOaP2MRIRSSLkqv
         K7jw==
X-Gm-Message-State: AOAM5321mTl2qljBpGyBUZU2M6sKGaUNTen6cn1VEoxmOveYBpIKatTR
        +W1V9WYA6v2zVcPcrV41uDIbEsH3fKYyykJ7OAyGgkezpOvnDA/fCrGtviM7W31nLKiKbNvbntx
        KKNZnkpFJwQGefTGVt7/Pa7ft40vrrmZ0TIv5hoK+ZA==
X-Received: by 2002:a2e:9017:: with SMTP id h23mr2465784ljg.13.1640188382653;
        Wed, 22 Dec 2021 07:53:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXN7uYxkuhPW5AvR4M49wCb95nQJIFBIueJZUYTf3lHmM6d+eH8m+7D55Ok0F5KBXbHsnuvw==
X-Received: by 2002:a2e:9017:: with SMTP id h23mr2465760ljg.13.1640188382372;
        Wed, 22 Dec 2021 07:53:02 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u4sm250738lff.17.2021.12.22.07.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 07:53:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     tony@atomide.com, miquel.raynal@bootlin.com,
        Roger Quadros <rogerq@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-mtd@lists.infradead.org, robh@kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        nm@ti.com, vigneshr@ti.com, kishon@ti.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/4] memory: omap-gpmc: Add AM64 SoC support
Date:   Wed, 22 Dec 2021 16:52:59 +0100
Message-Id: <164018828306.17046.6793512518826929956.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211221131757.2030-1-rogerq@kernel.org>
References: <20211221131757.2030-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 15:17:53 +0200, Roger Quadros wrote:
> TI's AM64 SoC contains one GPMC module. Add driver support for it.
> 
> cheers,
> -roger
> 
> Changelog:
> v4
> - move compatible match table to header file so it can be used by
> GPMC driver even when NAND driver is not enabled or as a module.
> GPMC driver is always enabled as built-in.
> - Select OMAP_GPMC driver from MTD_NAND_OMAP2 driver config as
> OMAP_GPMC is not essential for ARCH_K3 boot.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: memory-controllers: ti,gpmc: Add compatible for AM64
      commit: 4892242784786f3cbaa3b79ea03f8b0c145f6cfd
[2/4] memory: omap-gpmc: Add support for GPMC on AM64 SoC
      commit: 7e58accf4547b75070e5cc1e04f97e890d7f719a
[3/4] memory: omap-gpmc: Use a compatible match table when checking for NAND controller
      commit: f2f8115fe8b390af27d013411045bd712a812103
[4/4] mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3
      commit: 5784260892e5b808e1317843f71d4b787ad1f4b7

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
