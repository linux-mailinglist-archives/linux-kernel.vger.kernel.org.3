Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180914D108F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344230AbiCHG57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbiCHG5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:57:55 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F523D1DF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:56:58 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9305B3F7EA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646722615;
        bh=/nQH0xMVMGOl4ilEFj0NRFMKFBrrtbNt+lvO7kMd8B8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=bvKwDIdeaJr9K5ihdLiF0JxqqJxPDzgCESu5aK+cz4hHdzPyq5pwxmujHDUmkf8ZL
         2Kbvh7gCa1Byx+7vcyN8B6cY14RLKUz8ychYF1pSRV4yhL4jQswiOaIGDEAfy2Y9Ri
         RgmDbiNCF8WjB8d8+MA9di4FDFDqoIvTM6NUVFNKkbWBaUy7b6+VeyZmrfgEkZrnTo
         BV/dtvTvOynExP5eFdqhZvsQ3uwGO5SaN6Fdpg2vv4xnV+Pg3xsl+i5Qb/0sc0hdsB
         SRBm3kQRqT14Q2De7D1UdLUNtS+24k2XvtJE4zOiR0w6xVzJYgTY5xt7YxcDAJ+G/A
         yakMPjuSmdhRQ==
Received: by mail-ed1-f69.google.com with SMTP id r9-20020a05640251c900b00412d54ea618so9960160edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 22:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/nQH0xMVMGOl4ilEFj0NRFMKFBrrtbNt+lvO7kMd8B8=;
        b=DU2YbwOTm8rV3uBblK/o8K6I0lKdmaPCYSe7Eev0Cs8llV0pKTjjxFcqiy8xO3aPBQ
         C6R6pUvRbeioc9QL5Hc/SL5MvI+3W0FI0Yv5Fw0C1lM6khtWvUhSVVYr8Q4Be0hkEIW+
         gyE6Y4USJt5OJZppqVBvzm0gZT5fCHgSeRG8mGsM9sMxU0D+kIjOehn9Dh8ZoOyqerrL
         2N6s+Qg99neule2j61L/SRZ9X6V/AIpOQu+B58W1HuPgGzN+XWTeei4VdVBPNUVpRzme
         wxsJqqZHevfnRS7+F3sZIptyNuT8JeYC8EBH3FUDHGS+oyq+ujZAy7xfqgH2hwVN0Qa+
         jNKg==
X-Gm-Message-State: AOAM531DSQqXnxecfB79fNMrCS7ROeephSBp4E++R+QI22ZsEO60WSHX
        z2jDLPkfWWjgimLc0pi1VMzHGjuGgxuaqtIKZZ0HZ/P5pQcMCNkfThNjAV2asOS0rurBxYHw91O
        +LRUPEFmE7FZ2Y4SONimD8HkH9saoJyrdXF/3ED1O2w==
X-Received: by 2002:a17:906:a08b:b0:6b9:2e20:f139 with SMTP id q11-20020a170906a08b00b006b92e20f139mr12768805ejy.463.1646722615194;
        Mon, 07 Mar 2022 22:56:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUUfasT4Wjs6f1SXSBcbJnAlAC2IvlRrhE2phlpmtyxBZWf0RDTazNUP3wQmlNW1PxEj37jQ==
X-Received: by 2002:a17:906:a08b:b0:6b9:2e20:f139 with SMTP id q11-20020a170906a08b00b006b92e20f139mr12768790ejy.463.1646722615008;
        Mon, 07 Mar 2022 22:56:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709067f8500b006da68bfdfc7sm5517952ejr.12.2022.03.07.22.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 22:56:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] MAINTAINERS: thermal: samsung: update Krzysztof Kozlowski's email
Date:   Tue,  8 Mar 2022 07:56:48 +0100
Message-Id: <20220308065648.6443-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use Krzysztof Kozlowski's @kernel.org account in dt-bindings maintainer
entry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Hi Daniel,

Could you take this one directly (optionally squash with the last
patch)?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?h=arm/fixes&id=5125091d757a251a128ec38d2397c9d160394eac
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8c471cb93ef..48b0cf606be0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17382,7 +17382,7 @@ F:	drivers/net/ethernet/samsung/sxgbe/
 
 SAMSUNG THERMAL DRIVER
 M:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
-M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-- 
2.32.0

