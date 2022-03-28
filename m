Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6454E9584
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbiC1Loa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241877AbiC1Ldz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:33:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8927158E74
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:24:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j15so27915242eje.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LSGVVstA8xSFKqm3J0T/OWA7Sm6ZWqDMvi1oUYKoUQg=;
        b=DPV4As0LqO6PxUoMkKt+gD4Sp4g81m4Uyo0RMYEz2E3P7pfyvtdXjGrBNZDHBP/UB1
         gCFttcV0hthj4q1bL5TNl0zgC1lGn7IRag4nBKsJ8EP2YePrQZ13CN6W5Sfvfp8QF2Sp
         wELX/+cizZqQx47zB7fGuZ9lFxr9AwmUsxdmwe8MW4eic5SAUeR1O8wHo+TyZ21CIyay
         q7N3FAUsLSw2T7TAwO/n3REWByJ0KsJHuB6v+wB5DLXByNeI7ARpMC1EcyMes+d0d++3
         Az1f4uQBXYfarp3CB4XKNCRn8iHQgyIum6DxyH2giFC9U76PXYn+pGn9yYRL50TSN3s1
         2OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LSGVVstA8xSFKqm3J0T/OWA7Sm6ZWqDMvi1oUYKoUQg=;
        b=SHp2GaygXk4bIUpB48g+Yk5GxOSKMtTKNsM3WlY7GszUT7QvnhvrzXwQtR/GGjzYqj
         T1dN19Oov0og+ZPXVlEqUN49l45+zLR6BmuC5LdEyoniSMvVihf4D6QePjA5wJ6n9Chh
         FTs4lArh+ZcQteZY660O9KfEmIvQ9eyNN+UOZF8UHYV2c0emyWhzWgGbV5cMN5UBD9sw
         Wn1lBSC6V10nY0bovRXS46DmMkJTZuEdk8XZGSAcPemRiDA1ncI4lOcbsbLQq3FiC8xT
         9XsibvH1mcZc0oL8ZTfwARvJxnOzvIp8JbX7nwkgzbb4czK8jNqGopACaXv5AMiTSTko
         uhig==
X-Gm-Message-State: AOAM532y33XvMlD7ClJ4GQdiEfjW5hxXz2my9jcuf+OjWF4gxuJHuWqH
        FhXGKfkCqmebIwHS6JuqEwg=
X-Google-Smtp-Source: ABdhPJxl6boSwWBk+hJgPWLFTN1iKFHKVHLRcqYs36e+eXokFUamDhBLmr6Eju0TLSaJYffp3TOQTA==
X-Received: by 2002:a17:907:1623:b0:6df:c9da:a6a8 with SMTP id hb35-20020a170907162300b006dfc9daa6a8mr26762275ejc.303.1648466693755;
        Mon, 28 Mar 2022 04:24:53 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906b10a00b006e1004406easm1839730ejy.93.2022.03.28.04.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:24:52 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Philip <benjamin.philip495@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Charlie Sands <sandsch@northvilleschools.net>,
        Mitali Borkar <mitaliborkar810@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        ira.weiny@intel.com
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rts5208: Convert kmap() to kmap_local_page()
Date:   Mon, 28 Mar 2022 13:24:40 +0200
Message-Id: <20220328112440.17756-1-fmdefrancesco@gmail.com>
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

The use of kmap() is being deprecated and kmap_local_page() is faster.
Use kmap_local_page() in place of kmap().

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 805dc18fac0a..de690d7ee5e3 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -92,13 +92,13 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
 			while (sglen > 0) {
 				unsigned int plen = min(sglen, (unsigned int)
 						PAGE_SIZE - poff);
-				unsigned char *ptr = kmap(page);
+				unsigned char *ptr = kmap_local_page(page);
 
 				if (dir == TO_XFER_BUF)
 					memcpy(ptr + poff, buffer + cnt, plen);
 				else
 					memcpy(buffer + cnt, ptr + poff, plen);
-				kunmap(page);
+				kunmap_local(ptr);
 
 				/* Start at the beginning of the next page */
 				poff = 0;
-- 
2.34.1

