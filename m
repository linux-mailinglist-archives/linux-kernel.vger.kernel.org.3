Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDB8551885
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbiFTMNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242284AbiFTMNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:13:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FF2186CE;
        Mon, 20 Jun 2022 05:13:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so2110890pju.1;
        Mon, 20 Jun 2022 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l21bPVpEqABT+p9DbqMiBD/g5N8ETVurA2tsuMO34hA=;
        b=E2bhiLOLaQX5Id+mOKVw35/T0Y9neY7K+kld8cSStB4XWpwiXkJm/zKzA5JRLTpSoO
         ACwJo1lh2EVAYVa/qa7YYY/U3srMBuYgBqJVS+Q0G3pdYRe9uISqdahsAY75nLKbNywt
         mbOgUEq/hzLO0m7M4FwzB0H+1OBuTnK+98d7mWYqgMeOr7VguG6ksT8NSqt/E4XVA79h
         0inUqtXrg1cUh+mV0PPu1b1/Oi1v1BmNYKIiw3x8UOYVGg3R4VRpg+j8DhqDnsYuBR/i
         1NRCv+hxaZs17yiodGO2Lq9g6L+b6NUAIEiEzaA4XYQIX7K6/H7FoI/fcnFEK9uNgIRX
         4a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l21bPVpEqABT+p9DbqMiBD/g5N8ETVurA2tsuMO34hA=;
        b=tEIIsOLcXaEu4/nH4UVTXqZ+DjtJ1cAb8HEukDqQLB3S30E7LuQ1+QDTk7y/Pt2OQA
         u5lGByszWuNyPr7k+mKUdKgjdz0mbtQYPtH3ZFFRXxoLYQtG9ab7yoBjbKZiUNMEOcD1
         brscOG8mlPdLYtF4byKSssFOrSCucxtDvS9DKTZboNyCurG7zzeyY9tj8FuWfv1w/UkW
         xjfx81Mr6ZOmatoJFnETKXa0mgR0K7X6wmUfX9F+q0z+6Xr8bUlxLoHcD7nbZB2WkHJy
         MC0Y5+lRO4ote9SNagRdXigbeSzdEYNphAM4C4cDK/OdQSVxpmtxA6NM4OmD+8i0oI7R
         W5sQ==
X-Gm-Message-State: AJIora8eHuAJ5RSqmP6XRKnyCAeiHeG2WMivyk9aTCovqN5HzQLTlSZW
        MHmvP3qxpVyeNF+E425aU+VeNcghWq4=
X-Google-Smtp-Source: AGRyM1ujMyJeWJesnMMfpgqQBJHnW1Xr43RT5QrR9fedG1YoY/0E4PA7jJloa1A527gt4UwHIcXfMg==
X-Received: by 2002:a17:902:ce87:b0:163:fc5e:398b with SMTP id f7-20020a170902ce8700b00163fc5e398bmr22960947plg.125.1655727211055;
        Mon, 20 Jun 2022 05:13:31 -0700 (PDT)
Received: from linux-server-us.. ([172.247.46.202])
        by smtp.gmail.com with ESMTPSA id a2-20020a624d02000000b0051e7b6ec81dsm8946987pfb.108.2022.06.20.05.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:13:30 -0700 (PDT)
From:   YuTong Chang <mtwget@gmail.com>
To:     bcousson@baylibre.com
Cc:     tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        YuTong Chang <mtwget@gmail.com>
Subject: [PATCH v1 0/1] ARM: dts: am33xx: Fix MMCHS0 dma properties
Date:   Mon, 20 Jun 2022 05:13:25 -0700
Message-Id: <20220620121326.5122-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
v1: Cleaned up coding style and addressed review comments

YuTong Chang (1):
  ARM: dts: am33xx: Fix MMCHS0 dma properties

 arch/arm/boot/dts/am33xx-l4.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.36.1

