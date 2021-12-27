Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8B447FD69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhL0NcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:32:20 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54468
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234115AbhL0NcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:32:11 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7929E3FFD2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640611930;
        bh=Ys8+KWWv6cblvYfRfABL3+M+hNb6oCdRIvi8aT4vj7M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=mtIJ3sTaN254jdZzP1c6r3i/eUATTZV93Uwkc+0omNTd+5lzyfcuJZmc/P5Rftzqf
         rCVp2e9oRgjTg2nkGnt8TT8vfDZ99RG0SJ07b1ZFzkAEZ1wWmUEpc4Zal+il5NESYT
         Bz/s4Cfxp2h22Vl/othz0MnB9lpLeHbyJe8UuTo9Yxv8AzyCT/b1i6EY+DKQKKSQyz
         QHtwl4NYktZ6JJ3t9o4vTo4ayVCsL6UtMNQfe5ZWd72wcJ5mEfGVfG/CBrPF9seazM
         snQngXXsfRLgXQze6b2h+m/UWP1BzUYiSjFi07DlTGPZhFHkN/W2qcb21LHhfquEBj
         MsUVYBQs0DGig==
Received: by mail-lj1-f199.google.com with SMTP id d12-20020a05651c088c00b0022d989d91caso4016934ljq.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ys8+KWWv6cblvYfRfABL3+M+hNb6oCdRIvi8aT4vj7M=;
        b=P8OBhIMSITuT0nDf4EfZToLyTFxjL8TpquWKPbo89niOqvhLNyTKM6tmq3drSEEF5u
         gUaLuerCfeRwRX6igPE5R7pg2rHy/V7JnfVs+yG20M+7eYT7Ajja377iQer9E+6r/Lop
         mygEJvS0pTvNQWiqkef5WvrYlj5JOHHSdlEzS8+vI2P3McP/NVhp46il/wcskoixwNqH
         z+jXDDQ5J2UiNHk9igUb/b1uFhNUOLyAdx/omzHvys0k73Z3/nru+SkSOnm05vAQNpWe
         GwSjnpfH6MaGHcI6HmFkbRTyFH0IOA19dm0yhX7JMs7wQxpb3BO28Fm5LHM3vJfSmh3e
         LXDw==
X-Gm-Message-State: AOAM531KfRSoIpJjIYcShZ9vDR0p0hvnTg+CdVw9IYTd8IkGdvpsHb7C
        bKLU239obgD/yHTbb66tA+nUx2Y1xDh5os8JapFvkdkgvqDKt0v1snKeRDWWYJigwR8dFxu3spM
        RQBUHFHKFJjE0b/4Sv/4E7BvN3DB+MX2cmX4nJ0nUVg==
X-Received: by 2002:a05:651c:1054:: with SMTP id x20mr13675244ljm.445.1640611927040;
        Mon, 27 Dec 2021 05:32:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzazX3ZCxB4v/l+C8+nXPPq3MgFAHSUlHAZU6sucg0O4uB9a/5/Rs9mH1zRhW8sZSfsXxuJnA==
X-Received: by 2002:a05:651c:1054:: with SMTP id x20mr13675234ljm.445.1640611926892;
        Mon, 27 Dec 2021 05:32:06 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d14sm1433510lfg.18.2021.12.27.05.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:32:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 04/19] dt-bindings: altera: document Arria 10 based board compatibles
Date:   Mon, 27 Dec 2021 14:31:16 +0100
Message-Id: <20211227133131.134369-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible for Arria 10 based boards.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 3d7a2f699279..963c83904010 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -23,6 +23,9 @@ properties:
 
       - description: Arria 10 boards
         items:
+          - enum:
+              - altr,socfpga-arria10-socdk
+              - enclustra,mercury-aa1
           - const: altr,socfpga-arria10
           - const: altr,socfpga
 
-- 
2.32.0

