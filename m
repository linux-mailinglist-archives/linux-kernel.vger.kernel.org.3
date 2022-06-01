Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2212C539D9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbiFAG5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243006AbiFAG5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:57:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08F7245AF
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 23:57:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u2so1136638pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuRV5FBrv41rHho37MIz9EOT8FiSBSSfPXgqjEw9bF0=;
        b=QCESBMjvIJze7GTIO257A4okI/BWtD94+pO7JFdkQWdoYVgB6KkMczi7074TfauIgQ
         td3Q8GnUPChnjFCefMvyA/Xid++dmZrJxOXF2MC72w0VlxnKmup8WKRosgoRQmFRBspE
         lcdsw8Yej1JyAQOkp/QmJlzTGL+eCiwyPqRuDGPTI/NqfeRlmO4DGMT7xR/TOuRQfFa2
         BTf2rKjqLCwggxZJBMod8iwPBmG8RLaH8XvBBFRYJvkp6g5F/Cgcieau64sDTXWIm4h3
         SWa32AdR+S40t4y1AGPdDJ7pjwnogGlNoK0ubkrVJxv9a28IOUSN9cuBQ7bZoJRgsQW+
         A0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuRV5FBrv41rHho37MIz9EOT8FiSBSSfPXgqjEw9bF0=;
        b=ZF/X41FOXwO/05NmmEEOKR4eB9pTSzp0WUw76lLbdC0P/KAAF0b3qxvG9SpBYID0JN
         lV/YJqHAI6dZvKiSvjFlitdLAqeURjnNcfmNZ6oBCYZ5CEvrf/geKF2X4nwjkNveh6tS
         1GGrJZaeQVH5g0ZcgtVPb8WX/MbwbD6bPiV7FQLWuYe4L12ANAH6DXSLdn7Qr5GSHBks
         t9Cy4mN9d+4g1WFrnroKPdvYxwviajyx8hNEC8HaR2UHCF17x+oKgUvAakSXSw/dzB8N
         TYWVWgjUUJ/9ElGJ9w1uaRhnWblKxzIRVTgIdfffy77sTlHSS/NrYFtkc0m1/wLMHFd1
         +5oQ==
X-Gm-Message-State: AOAM5300tJVN1P8nqtqQ6SkUtblfZcOrfiz/qBda0XRgreIXqLBkbcBj
        i0/6pj/CBdmJE4gHimuCbmFFGHp2+hE=
X-Google-Smtp-Source: ABdhPJww7tHnbGk9P2xDjVpfHeJDvKncZ9DVzydgmoW7EoQauRaOSHbdmctXOx0gWn0ct2bDLqG7EA==
X-Received: by 2002:a63:455d:0:b0:3fc:7f18:6857 with SMTP id u29-20020a63455d000000b003fc7f186857mr4291177pgk.292.1654066673124;
        Tue, 31 May 2022 23:57:53 -0700 (PDT)
Received: from Vostro-5471.. ([2001:288:7001:2708:d63b:41f9:65b2:fe0d])
        by smtp.gmail.com with ESMTPSA id f11-20020aa782cb000000b0050dc7628134sm650034pfn.14.2022.05.31.23.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 23:57:52 -0700 (PDT)
From:   Jui-Tse Huang <juitse.huang@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jui-Tse Huang <juitse.huang@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Bruno Randolf <br1@einfach.org>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>
Subject: [PATCH] average: Clarify the restrictions
Date:   Wed,  1 Jun 2022 14:57:46 +0800
Message-Id: <20220601065746.18426-1-juitse.huang@gmail.com>
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
 include/linux/average.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/average.h b/include/linux/average.h
index a1a8f09631ce..1618f6519c3d 100644
--- a/include/linux/average.h
+++ b/include/linux/average.h
@@ -13,6 +13,10 @@
  * precision and fall-off coefficient determined at compile-time
  * and built into the generated helper funtions.
  *
+ * This implementation supports upto 30 bits of precition, and for
+ * usage concern, only the api of fetching non-fractional part is
+ * provided for now.
+ *
  * The first argument to the macro is the name that will be used
  * for the struct and helper functions.
  *
-- 
2.34.1

