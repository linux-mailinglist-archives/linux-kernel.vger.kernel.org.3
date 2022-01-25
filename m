Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AC149B9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355598AbiAYROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:14:01 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54848
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356606AbiAYRLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:11:45 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 97CA63F07D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643130701;
        bh=w7pNveLS0GBUcaM6xZHDvqGiuHIf5TR0krpcnow2fyo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=hqugDulmFV/YpJbTPBNKQtXXj3OCUXpThQUF+/NUp8Gt2EwQZKBnhvcs41NYBKFZO
         piUu24l5/PCp0fpK6R4goyAOzWrvTrx8qWjTEx55rlvucfs6N7EcMGGnshggQTnCkl
         BoUYo3Yiq9dN0t3KS5j9LpViBIm0s79S4XXZDS8kP4oODqBcQhLTbjKKxKR5unjUrA
         oBq2JLNmGk93VohCJwDT6tC9aIdnBS80XQYxFeGUWFG4tdpqrUwWML8+ZynBI4Ndrt
         Vvcd0KlIhZKGUE4aemziVwUSPkVI8ksN1Vq8f1kwmc07U2pQJmcdi7qkR9Zr9j/MgG
         E5YS8DFfdfeWw==
Received: by mail-wr1-f70.google.com with SMTP id s25-20020adfa299000000b001d8d032255fso3322162wra.14
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7pNveLS0GBUcaM6xZHDvqGiuHIf5TR0krpcnow2fyo=;
        b=X13HA6a/tjNy06WDbNgh9r9tun1qoanCSNBe0fPK15OOJIH16uAb5IJD837ms6rVf2
         7Jlj3FmRNEmtO24+MCt115Zf735e06+FXE6VMHkc931wptFRC7dvShu8UURqddalylzj
         v26Aq1acMaYvR1VVrjo1FTomGDJZDFtmMXVVTUPCGF75HZjTQtuujalK2KyH3M5aW2OP
         h5hcDPw9P5qh0Wy3iAG8a4nqXycrXE/lppXnV98jnRqsBCS4U9eMtQavu/B6t8If1WRj
         F995yt+IWTir7BAluCyt40GMCMcnjyzazMbyxf1H5MTHBM1JposP01j5Pe55K1SjhDvc
         q/FQ==
X-Gm-Message-State: AOAM532wct3liacgY42Fvg6GqBWDoK2kKRxxXQSMPnanYAsNCDdVvsd8
        bz9F9fKhRu3R+221zTSkspxBLjKN/Td7FMtKpuVmckNli9CdAW1aGCmt25BTjReNzxnwHKd+3Le
        8HkWdGSqEx1OJ/+sparK5WM7trJ+Q/vAocV7/WH2GZg==
X-Received: by 2002:a05:600c:4282:: with SMTP id v2mr3842237wmc.78.1643130700816;
        Tue, 25 Jan 2022 09:11:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0UJNIa6CQvbeScVNkgkIbqxoZi3ySJ1nOLLm6MxdhJFLNeQKvajyCF1/0whS+dTxXoqrw0Q==
X-Received: by 2002:a05:600c:4282:: with SMTP id v2mr3842215wmc.78.1643130700627;
        Tue, 25 Jan 2022 09:11:40 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h127sm4477087wmh.2.2022.01.25.09.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:11:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        soc@kernel.org, catalin.marinas@arm.com, linux-clk@vger.kernel.org,
        arnd@arndb.de, robh+dt@kernel.org, linux-fsd@tesla.com,
        olof@lixom.net, pankaj.dubey@samsung.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        sboyd@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org
Subject: Re: (subset) [PATCH v5 11/16] dt-bindings: pinctrl: samsung: Add compatible for Tesla FSD SoC
Date:   Tue, 25 Jan 2022 18:11:03 +0100
Message-Id: <164313066043.81586.10760195237607935843.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124141644.71052-12-alim.akhtar@samsung.com>
References: <20220124141644.71052-1-alim.akhtar@samsung.com> <CGME20220124142941epcas5p4bbba53cfc2fc9862da9fd85d44de6e79@epcas5p4.samsung.com> <20220124141644.71052-12-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 19:46:39 +0530, Alim Akhtar wrote:
> Add compatible for Tesla Full Self-Driving SoC. The
> pinctrl hardware IP is similar to what found on most of the
> Exynos series of SoC, so this new compatible is added in
> Samsung pinctrl binding.
> 
> 

Applied, thanks!

[11/16] dt-bindings: pinctrl: samsung: Add compatible for Tesla FSD SoC
        commit: 98ed04b33f43a80c0d9e218023abce3b47ca3539

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
