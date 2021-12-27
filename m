Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323AB47FD9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 14:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbhL0Ngc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 08:36:32 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54770
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236978AbhL0NgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 08:36:19 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 803A93FFDB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 13:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640612178;
        bh=JFavKQ4EpkcOZ7wQmRTeTvx/mZGmly/qZElot/QHLH0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ovccCiQa7qdNxqeXUU/zPG7ClxUN5kK9DKsRS39XI2JdYQgd7b/spAWE88xG8/qt0
         1tahMGMpwOWOcpUgYssKsuULc8RL5zmPN383OhWeleGcR9bXcxrczkA37nchCKrfPa
         +MNDCHwiODlN+TMt7xA4+hOtb1PaFO9QZn1lsnWUqG1pcZsS1dzxIHFIje5Xi0NBNl
         EWomnn309S1vDpwbNcFmlIR7WqSnvER4QeSB/nIcTHINpvTVH5uzymo5grkpBJksVF
         SeQIHN0+V3FpxqAxWQnDbd2FTQ3f/+f5kuzfLTN/+kvewMqRDS2MCZjPjKdIpnSL5H
         GKM0FOL/RoFrA==
Received: by mail-lj1-f198.google.com with SMTP id a29-20020a2e7f1d000000b0022d7438b7e4so4932084ljd.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 05:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFavKQ4EpkcOZ7wQmRTeTvx/mZGmly/qZElot/QHLH0=;
        b=GoXoT022UQ4wCE4skWKh7wQKro26JKh/s3tBFA1ST485ASW/XMk5yofMnt1HPXC/QT
         okRVoKaqP0sTzMA14lAaaJacfykcHGaPFTD92h9Ca3i186EYygyeGmbz/pEXVBS52qpT
         lkmeRJWmiuzBoF9+p2CEkewjTc5FtoMeJIe2QmaKBnrXKqDydDmf5d1JeOq/jAHETMXW
         +m+LDk6A4bKvnGjr1LckPBjJKLa28wiS0SS8wN329d2eb2tsw9ENYivF9DkIjpEcni79
         FobkCHzanuXJNzxnd/JisCg3Vc3qzMBJDU0CsstaDvfSjnvTg28D16z+FBJZw54QdbdN
         8MnQ==
X-Gm-Message-State: AOAM530jPvBIy3JDJ9xePxDNEIOVM3U003gK/oMrOYlptRd7cugm/aWe
        19VljYKJiRTQxfVXjThK0S0MbQCyGXGDbW4n6jeRWcp3Ls9w/luTJkByKgMOPjU/LW0RBkE7F2l
        UTmbYdgBpc7897VG/kvc2/ExwWQzy82wHj/yLhASjSg==
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr14341418lje.383.1640612176048;
        Mon, 27 Dec 2021 05:36:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyigWSTBhHMTJw9c+BMRCCqABSOCIw31rtBFtt3dBgwEbcNUZTxOPbnbqo+v1WaY9WCE71FlQ==
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr14341415lje.383.1640612175896;
        Mon, 27 Dec 2021 05:36:15 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id g18sm800107ljj.124.2021.12.27.05.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:36:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 18/19] arm64: dts: agilex: add board compatible for N5X DK
Date:   Mon, 27 Dec 2021 14:35:57 +0100
Message-Id: <20211227133558.135185-12-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel SoCFPGA N5X SoC Development Kit is a board with
Agilex, so it needs its own compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
index f3c1310dae0a..5609d8df6729 100644
--- a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -6,6 +6,7 @@
 
 / {
 	model = "eASIC N5X SoCDK";
+	compatible = "intel,n5x-socdk", "intel,socfpga-agilex";
 
 	aliases {
 		serial0 = &uart0;
-- 
2.32.0

