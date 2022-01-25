Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C249BA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiAYR0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:26:14 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55156
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345126AbiAYRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:34 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6797D3FFE2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643130715;
        bh=Eq37txspH2phodHd9XBEM6IFXJwB351PQd0cul0xPxo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=i3vxSJLw7gC9U3XSELBEQWNBokeKWgLClftdBRevLz8r0mXgslU+/m+4ExyeG8Rkp
         pgKnika4RuLZbAs6AEallBgaLIJKzkIoS/QrUiSqSrQlrBtQp5FoK/CEnvPUJOPKf7
         oolQCKJjy+WR2KyRR/iPRx6WWy3mm++THMm3xp3da4C+OQ8OBu+PNEAt4uXUlY4deH
         crUCrdC+ZMKMkarR5/3UT7UCAiJz3Q0JMKGWjZbMKFw3EfJj2DmjAvZB26BrNXiqkJ
         Q7aXOJSW0FnRkAsWi8KDuPcm7khm1x1fXBTywti8U60On7cyG2JGrXu2uJhp2wQdXM
         AZoDlniPXkc/g==
Received: by mail-wm1-f70.google.com with SMTP id j18-20020a05600c1c1200b0034aeea95dacso1430258wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eq37txspH2phodHd9XBEM6IFXJwB351PQd0cul0xPxo=;
        b=M62mRzxPUtGPQLxQK+MkRT2f3z7tMpdc0YHjAlk4vGjoAB+rJsFPITKMg/j8aVC87V
         AbQQAMKMGdb1oX4XxiCoNcDN4dLFnPTU9PDf6cuHLpIYf6vxY13qZY0ycdM7kVvlDMTU
         ggxIoHfwVDh1cBdueCjO6W/QJ0ouX5XFreoaMWuvVTeBhk0r8On8/VcGWRjgEIvknFr3
         6lg3aqEBQsyp1Rb9D3vZzm3Xiq4Iu/7/KoGeSc7akr1dQ0Ue1/u8qQ2FU4Brp2sArqkf
         fMWI4QqE2/abSYCLuFPbT/kYygLPsdEPvEVzR4se7hA2oCTbdO/q2tRUbBjmSXNutq5L
         Y2Vg==
X-Gm-Message-State: AOAM531momtgi3pOVXP8vTyoy5vRxyy04PzNUyGrPUGN186abNh5nbJb
        kFZ5pBSZ5u19Vf1gqbxRFv1lLZfVJ4pN6OqVyxj/F8F/Ub/QsmGidWd0F//SAtYN34/SPS0NnMP
        9lz+o3NfGnMKC9FJAfQNgW2jdo5OtAXEMRliPuGpglQ==
X-Received: by 2002:a7b:c3c8:: with SMTP id t8mr3770883wmj.189.1643130715145;
        Tue, 25 Jan 2022 09:11:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrbdeHL0IlLxe23svOOleIzfku/tFpG1O9rOLv6Af/becvU1F5yAgCWPKlbpU8ULSRE8Matg==
X-Received: by 2002:a7b:c3c8:: with SMTP id t8mr3770860wmj.189.1643130714957;
        Tue, 25 Jan 2022 09:11:54 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f8sm1185826wmg.44.2022.01.25.09.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:11:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        sboyd@kernel.org, olof@lixom.net, soc@kernel.org,
        linux-fsd@tesla.com, linux-clk@vger.kernel.org, arnd@arndb.de,
        linux-samsung-soc@vger.kernel.org,
        Shashank Prashar <s.prashar@samsung.com>,
        catalin.marinas@arm.com, Aswani Reddy <aswani.reddy@samsung.com>,
        robh+dt@kernel.org, pankaj.dubey@samsung.com,
        s.nawrocki@samsung.com
Subject: Re: (subset) [PATCH v5 15/16] arm64: dts: fsd: Add initial pinctrl support
Date:   Tue, 25 Jan 2022 18:11:06 +0100
Message-Id: <164313065136.81319.15871986388224953551.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124141644.71052-16-alim.akhtar@samsung.com>
References: <20220124141644.71052-1-alim.akhtar@samsung.com> <CGME20220124143001epcas5p4c0aab0902709a24bbedadaa223fe7910@epcas5p4.samsung.com> <20220124141644.71052-16-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 19:46:43 +0530, Alim Akhtar wrote:
> Add initial pin configuration nodes for FSD SoC.
> 
> 

Applied, thanks!

[15/16] arm64: dts: fsd: Add initial pinctrl support
        commit: 773d685fd406514af4b365aaa54fe493cf523602

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
