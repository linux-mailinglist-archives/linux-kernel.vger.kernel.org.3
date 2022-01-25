Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316C949BA30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587549AbiAYRUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:20:12 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51456
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344459AbiAYRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:34 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 632EA402F3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643130717;
        bh=LvBwPzZuQYg1sk1AcEyVLVG7UxYbxMueMK9OojLw1Q4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=CY7PK8+b4bB9aoCAUW0tERxpxzO0v2nWOQ0fzR7bvxf0uuXmbre7Zc06Vd/PnuyS0
         O8uBlpcNoiSNJOquriY5l5fBTFqrJhKrDQXqd/BtaNpn7lUcg3dxRYtP6ZI62MgtNR
         CkCfJuKdyLVJwA2pEo58ykbTMKNophQQJGFncYp4vV6TOd3JShy5Il1XiCbXKMueo8
         OvhTk5ChHAZ9Hx+RkjVtBR1OFBkIodANZahKQrmEjfYTpY5+lao3+BJYmcGFAZeggB
         8YX2YBKG1WBJ+I3DFeTMIVGzLGb2Dyu3qNvnkArmMgIjA90gdO9aVDwEK2l18aaWNb
         MTmNZlV+AtUcg==
Received: by mail-wm1-f72.google.com with SMTP id l16-20020a7bcf10000000b0034ffdd81e7aso1783551wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:11:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LvBwPzZuQYg1sk1AcEyVLVG7UxYbxMueMK9OojLw1Q4=;
        b=MrOeekPimSb7BkihNE8sYp6xEClAZMPtlV2fHCggOl3082u8Ydhkya0NfgbLNyhKXG
         7Dgvmq66zJUMsJ/aKzXZQpfUN3ID7iDtIttogSLrV+m59eSuJlvuDTI+RI+s6eolDYD7
         TcJ56kwGmzzG5hdMpDRToT4oxt58rKJOuEcvu3Wuzdxf8U5RMbHtfiRNXm/B8ARcrjZR
         axhl2HFhSSN7JJ3gWpJvQ6K75nqq3OTC9TysG8Efsao4CPDg4cpFTFF2B/kYqdNrOQmQ
         j8bcTtz0SUjsnwBXQZ5P2JQUO21UU9pYcmJNfFTpfnfztp/puATuKjjEqTgGiX1Z7yKw
         +6iA==
X-Gm-Message-State: AOAM532RPkJng8ru6ik77daYOwd3NJALvzK2msB4AcmIVnqI936vDTb6
        g28s+pqAi/M2n8phEDdPq38TnrNHgpJ71UUx3CbFZ2J8dikTQjQNJLcz65AEODR0bg2upCXYD5u
        dLJoCaZ5M/iSBzIvxHGm9hUpXVB2sLwMI0RgYG6AmcQ==
X-Received: by 2002:a05:600c:4b95:: with SMTP id e21mr3819817wmp.106.1643130716928;
        Tue, 25 Jan 2022 09:11:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfP17LMlnVHGMliQrz4/SA8fpjZEApa5SVjlONjtvltbKWP+dIusViDktiO3K5mmPtxTR73g==
X-Received: by 2002:a05:600c:4b95:: with SMTP id e21mr3819792wmp.106.1643130716796;
        Tue, 25 Jan 2022 09:11:56 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f8sm1185826wmg.44.2022.01.25.09.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:11:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linus.walleij@linaro.org, linux-fsd@tesla.com,
        devicetree@vger.kernel.org, olof@lixom.net, soc@kernel.org,
        sboyd@kernel.org, linux-clk@vger.kernel.org, arnd@arndb.de,
        linux-samsung-soc@vger.kernel.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, pankaj.dubey@samsung.com,
        s.nawrocki@samsung.com
Subject: Re: (subset) [PATCH v5 16/16] arm64: defconfig: Enable Tesla FSD SoC
Date:   Tue, 25 Jan 2022 18:11:07 +0100
Message-Id: <164313065136.81319.934364321640879263.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124141644.71052-17-alim.akhtar@samsung.com>
References: <20220124141644.71052-1-alim.akhtar@samsung.com> <CGME20220124143005epcas5p103598aa358ac35fe5e1ee762faf508b0@epcas5p1.samsung.com> <20220124141644.71052-17-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 19:46:44 +0530, Alim Akhtar wrote:
> This patch enables the Tesla FSD SoC in arm64 defconfig.
> 
> 

Applied, thanks!

[16/16] arm64: defconfig: Enable Tesla FSD SoC
        commit: aeb62e360c0fffd9cf218a314647d0c7254becbe

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
