Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32254A9BB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359612AbiBDPMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:12:23 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51124
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359596AbiBDPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:12:19 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 749093F1F0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643987538;
        bh=00B2qCrzeyDH+uH8/dw2Cjp7WLU/oGst7SCYDobRn64=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=V9vhsq5j/uQ725vhHYIVizH3SHirRNR5JHaUVW8kblnQM9YsvH8E1xdwOcXsFNLzZ
         +yu8sO2GgsIZ7GCQ6JkxLsSvZm45QrbR1fObkwMQYEHZJxOukB3uBtWUn9eMbns01h
         XNYVIH5oTsvu+o7kpcQIB84Lpa4sYG1cfpnZ2wmjlmk94/+pVI9Dfe9qkNIxEzabeL
         4oA9YTrQGCVkSO8C5w55zFe6M15gZfAjSonGFWQ0Tps6pNLr9phHc36Nvm+tgztURo
         Oo1SRYsLZj4KchUdXa4nz64b1FUxiyycooL6731/xMLBvY4FAMctP67Vlug0tpyWxj
         s15yzk1a5wu5Q==
Received: by mail-ed1-f69.google.com with SMTP id l16-20020aa7c3d0000000b004070ea10e7fso3402251edr.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00B2qCrzeyDH+uH8/dw2Cjp7WLU/oGst7SCYDobRn64=;
        b=FUWb8frMIGPvBe9Y4O20BT5GVo0NI4KTAcnGxrgwN6HQXIkkILJpkUpQjikvQ9hgrH
         /lNJ9Pf/ddV+Mpr6XW06yndmcI9bzV+5L/HNr2ehu19dvLO0HMup5xpEAGftk6nSVdml
         7Z9+QnaPLlycAdTEuZbBT+AVpOQYXsDLLZPEGo1I4FqB2DB3HhMiEhyp9KjFOstoZvAO
         vK1vHHZr3dePBGVuwNz6NngWb1xkh3sW43FpbBbv8P2q4bVMKR/n1jZeeM4zb+McpN9t
         70FMaNxykbNFSXWRFy6HjVXhyDoTKvqBeE02K7/4c4TIvv/AEmDKR81dzLGFv1P+5cSl
         VV7w==
X-Gm-Message-State: AOAM531+QZyelkwT3DFGJXzwiSfRxkhndke2BLe8nAVbOd+SfZs6p6vN
        kqYytm3yJDTpixu9jxKQIfS7gDgb000FHA06BaIW+MmqGJSiCgiJbhbVe+f2DxdVUhPqOAyAO9h
        sTznpOTbLWXbEttFgT+m0PvRVvRAyCPov7cipqydq6w==
X-Received: by 2002:a50:eb46:: with SMTP id z6mr3423797edp.229.1643987536917;
        Fri, 04 Feb 2022 07:12:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxb7QZV7uykHzljTBp1XTCcqRb+uEgrBmcfwCNo3JGwEadAja6qKSSvp1JuF6RGg5AIg+FgSQ==
X-Received: by 2002:a50:eb46:: with SMTP id z6mr3423779edp.229.1643987536749;
        Fri, 04 Feb 2022 07:12:16 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id h15sm757748ejg.144.2022.02.04.07.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 07:12:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: exynos: add charger and battery to p4note
Date:   Fri,  4 Feb 2022 16:12:12 +0100
Message-Id: <164398752918.81715.4450526381656731657.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <d7f7b0f87a18b5cc44ba97390461c15469439829.1643919230.git.martin.juecker@gmail.com>
References: <d7f7b0f87a18b5cc44ba97390461c15469439829.1643919230.git.martin.juecker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2022 21:29:47 +0100, Martin Jücker wrote:
> Add device tree entry to support the Summit SMB347 charger which is
> built into the p4note devices, as well as a simple battery node.
> 
> 

Applied, thanks!

[1/2] ARM: dts: exynos: add charger and battery to p4note
      commit: 38dfe352b5a56df9cdf3e40ec5a09bb539757352
[2/2] ARM: defconfig: add SMB347 charger driver for p4note
      commit: 300ccbb25491b4d4aa67098161a953ff7652d650

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
