Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED394498428
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiAXQDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240900AbiAXQDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:03:18 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD31DC06173B;
        Mon, 24 Jan 2022 08:03:17 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b14so50899297lff.3;
        Mon, 24 Jan 2022 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVEI/04lRlpzFj8I8BWWmTX8RUNeV033mKjqJ7grZ2c=;
        b=ixdeo83yf4yjcQtce6LQghTMCa25tY67QjmF+wkz1jeDthrtlHOL3n4TKfmiZ7knvE
         m8w1+MuPumCMzVf+q81tGSkNKDPBJK3+BaSachNl7tYjv9Fjyo8XonkfytilmLIifDjt
         L9BFTLHoLCULUqGUUwfENWL/KIboJ3AjhHpZZ+8RLB3gb2e5xnKjtimm4/llK+bAW/lF
         elQ54dPPHNvqRTgqBBUYP+ZqTJ/uKjEZgitw1ZOrTKbyThL7caUvrn2wSWtVU163OuPW
         CQa+XSwWrcDY3ahqmNsZv20uxmTEsByBjtNbXjWMdH7cQMRNeKYwBPVJ2x35r6b02mW8
         y6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVEI/04lRlpzFj8I8BWWmTX8RUNeV033mKjqJ7grZ2c=;
        b=lEeJWudxTu6N4phjfDjd8W5fhwuLbTayTxHYNsIkNWCsgE7f9BmMsMVaINM/tMwUzJ
         tIqRTNDLd3eve/sblm/LDCP3L9OpmIE4ay+xJC4uzwlS3kPopkBTiurtLWmv7XOEd6+D
         UuE1ZwdbhqTGpuKH4DKvSMkaIsF78h9YgGeF04eLGxsKIHuGe5LO+eDNTjcUf8X2pj3Z
         erv/xuEr1tzOIx+h2z95ZzDdB00YKjmqOHQIUc5M+XeOu0siYNj3CzKzwAZctTDWp8kC
         hzuORFz07gW/uf40Mr5KcGFRlBqWnIYG+ve72LfQ/3j2Ni+CrQsxySJO076jNiMh/eJe
         W3iQ==
X-Gm-Message-State: AOAM531FOwXaCjR44QUoGIuiIChqVyze9ywNPYRME/TogM22A1oLZvi9
        FbtYILG31FfstM0FeymlSQ8=
X-Google-Smtp-Source: ABdhPJzNfDuL+3ZKL/I7QuCGlh29SuKJzXglj8mwsrpOdEQPSmtdPzUFte8WylH0HHhB4j3XMayh/Q==
X-Received: by 2002:a2e:a58b:: with SMTP id m11mr1671606ljp.383.1643040196104;
        Mon, 24 Jan 2022 08:03:16 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n21sm674187lji.18.2022.01.24.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:03:15 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/3] dt-bindings: nvmem: make "reg" property optional
Date:   Mon, 24 Jan 2022 17:02:58 +0100
Message-Id: <20220124160300.25131-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124160300.25131-1-zajec5@gmail.com>
References: <20220124160300.25131-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Most NVMEM providers have cells at hardcoded addresses however there are
some exceptions. Some devices store cells layout in internal structs
using custom formats.

It's important to allow NVMEM consumers to still reference such NVMEM
cells. Making "reg" optional allows defining NVMEM cells by their names
only and using them with phandles.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 43ed7e32e5ac..3bb349c634cb 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -60,9 +60,6 @@ patternProperties:
             description:
               Size in bit within the address range specified by reg.
 
-    required:
-      - reg
-
 additionalProperties: true
 
 examples:
-- 
2.31.1

