Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653F15203A8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbiEIRfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbiEIRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:35:39 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E840E7F
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 10:31:41 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id ij27-20020a170902ab5b00b0015d41282214so8602504plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gvBYc9Z7tx5NglqwSxg+zwAl6dAby6itwXwpRJGwKHQ=;
        b=mJKfqdXEHQ5ong3MKpfPaGcYCeLXKGz1q2mtqvnDqghvzkpL8HoRl2bH1MTIrqci+l
         85mrUoAbvZUYnzOIlm4iFtxK3/xo0wPbklJyF/kDSFPClxcrrX2dIP3lmmOm6bNPb6NE
         XCFjOyMbuQhuTDZugkcvlQLxf7vWwZ4UbYXAyHtKPhvrbXxLEGQIJ9ELS+glnweTTFe5
         6Hnym552rdsBTVHDvw/lENCNq6/YgY6Ndq3FUwhnLRUcXzX8zMO+MQkffijdv10+uPy+
         axd5yU1hK9kBx4rYtMWNkGxogXdv8TgEP/ojXzlJH75rvtxoywAfZdNz0rEyfHFfA2mk
         QMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gvBYc9Z7tx5NglqwSxg+zwAl6dAby6itwXwpRJGwKHQ=;
        b=R2sAw2pcC7AMhGznHc989p1EMsmc4qR5v2nAiGUr+WBx5xHA+dGRA4QtqkASr1Vvi1
         k+yqyj7gxinCskn5RYyKrG7EpysgLYsJlfN9ny7cWkbc//EjCZGfW1txKbqmt4mqofVO
         Ih3iLwFQHH+cxbM+oFoKEqUOv2GWi09Ght8NJtDTMY8DHAQlbhmX1SaSIJdib6MR5CP8
         FAFXypPxUNTWW+97KZGtG/a52HCChkC2GQWC+R8idZpK1farDZ6MDwAzl9VOKoHvUN8t
         KF+Sam5TMsTUOzA/TseB6572tq2Rm9zOVVpi3RYhVEuy+4/5eF9l4wEsIoHqTFb2j3iw
         hAMg==
X-Gm-Message-State: AOAM530jgLatBIScNJsG8XLklNUjj/8Q7I3InZnmScbxXpsdNpgUvFH0
        +k8Kj8dTg/krjLJkjqkf2pTM/l4O8i+lIw==
X-Google-Smtp-Source: ABdhPJzMCrvmq5sQA1aUeKBB7H+OiFnamg6LKELTSnCQR+XvGiOxnJqvEMkB4mPoBPnSsax5y04jbeB3SWlIaA==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:903:1104:b0:15f:bce:1a0c with SMTP id
 n4-20020a170903110400b0015f0bce1a0cmr7310596plh.149.1652117500591; Mon, 09
 May 2022 10:31:40 -0700 (PDT)
Date:   Mon,  9 May 2022 17:31:35 +0000
Message-Id: <20220509173135.3515126-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH] driver core: location: Free struct acpi_pld_info *pld
From:   Won Chung <wonchung@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Watanabe <watanabe.yu@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After struct acpi_pld_info *pld is used to fill in physical location
values, it should be freed to prevent memleak.

Suggested-by: Yu Watanabe <watanabe.yu@gmail.com>
Signed-off-by: Won Chung <wonchung@google.com>
---
 drivers/base/physical_location.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/physical_location.c b/drivers/base/physical_location.c
index fbd9f9839e92..617ada542b00 100644
--- a/drivers/base/physical_location.c
+++ b/drivers/base/physical_location.c
@@ -32,6 +32,7 @@ bool dev_add_physical_location(struct device *dev)
 	dev->physical_location->dock = pld->dock;
 	dev->physical_location->lid = pld->lid;
 
+	ACPI_FREE(pld);
 	return true;
 }
 
-- 
2.36.0.512.ge40c2bad7a-goog

