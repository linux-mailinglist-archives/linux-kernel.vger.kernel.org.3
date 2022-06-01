Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396E6539E0C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350202AbiFAHUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350413AbiFAHUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:20:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96DE6461
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:20:11 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c2so988421plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MC41gEQuVXDAqpv4xe0itsDAYcLiXNNvtLvOXnYJomI=;
        b=gdRCXYyPwtL93x7erslFonthTsqPPXlZ0UgsTR8AVRJYsOq8MvZJPvbLGsreKshXqi
         fz7DK3PEIiNHGy/PPfhuZMFta+U3NxNCsPdWrmEdCA9aRfFfM1n8S6izYx7QmllKgDFF
         XEv/ilDs9dvvhochneQ7KZzX3YiAaDv2QMwEhLbFk2IIlSU3jkA4pTjO0ga/ScryjxcX
         qdA3PHCX0cJpLHPVE0cNpCX84fdZI7L5T2iKWpg1cAhGbAKZ6t8tfRbLijKjDL3HsBl9
         0oK77ctPv47PahAHbsMhjm7HAOBF4xXzRZWxlyam2MN6mQRR5wxMxaK2zbxza7kt1oO0
         133A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MC41gEQuVXDAqpv4xe0itsDAYcLiXNNvtLvOXnYJomI=;
        b=atuyDNvVrLlftHrg+mgxBOkCr42Zx/7zTLq86JMhrUMKaxLzNJhWzk9MbEoaZnIXJT
         TcNlguWRhw5Nsed6ZNgrr3C9+kio7+mkay82RBjb+mEzoBcZP5ibAmwkXRtZoY257xjA
         KLBdoLsLR6pRDAsPN/NSLGIR0OF/wjuhzVtasMgMeml8ruFSGMUnDyNgAay7MtBtO0Z1
         O7eNWvyUZAh2Q3iKSWYaN9zYkiF+wWCDa7N7SoNoyYLU2eJxVB+M0N2Loyr9t9k0eQV3
         2Qrp52ZQ7pw2ksTZXXYT/ZJhw1Zb+h4XaJVfvY6aPBLRBbfs5iEAXbygSsLsB22aFBz5
         M3Yg==
X-Gm-Message-State: AOAM530tJsfAtaPefXcaxQ9rn1nAHinzqWLguIgOamK4gYPtutxkoNc0
        UbNE9rU/CESYbQVUJ5eet2VK+YR7POs=
X-Google-Smtp-Source: ABdhPJytqL76MOI+aqc7h42RwJx2/Icf5zWS/KnylCaqAGDVX70Bn3WD3b9VofJvcmvhZ6MH2bXQ4w==
X-Received: by 2002:a17:902:8c92:b0:161:e861:861f with SMTP id t18-20020a1709028c9200b00161e861861fmr61330746plo.33.1654068010907;
        Wed, 01 Jun 2022 00:20:10 -0700 (PDT)
Received: from Vostro-5471.. ([2001:288:7001:2708:d63b:41f9:65b2:fe0d])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902684100b001637fd08a75sm471297pln.63.2022.06.01.00.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 00:20:10 -0700 (PDT)
From:   Jui-Tse Huang <juitse.huang@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jui-Tse Huang <juitse.huang@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Bruno Randolf <br1@einfach.org>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
Subject: [PATCH v2] average: Clarify the restrictions
Date:   Wed,  1 Jun 2022 15:19:06 +0800
Message-Id: <20220601071907.22070-1-juitse.huang@gmail.com>
X-Mailer: git-send-email 2.34.1
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

There is several restrictions in the EWMA helper macro that the
developers should take care of, but the comment does not mentioned yet,
thus, this patch clarify the restrictions.

Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
---

Notes:
    v2: fix spelling and wording (Bruno Randolf)

 include/linux/average.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/average.h b/include/linux/average.h
index a1a8f09631ce..ff0953ba2820 100644
--- a/include/linux/average.h
+++ b/include/linux/average.h
@@ -13,6 +13,9 @@
  * precision and fall-off coefficient determined at compile-time
  * and built into the generated helper funtions.
  *
+ * This implementation supports up to 30 bits of precition, and only
+ * the API for fetching non-fractional part is provided for now.
+ *
  * The first argument to the macro is the name that will be used
  * for the struct and helper functions.
  *
-- 
2.34.1

