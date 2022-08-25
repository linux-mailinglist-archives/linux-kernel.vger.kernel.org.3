Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A935D5A0A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiHYH2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiHYH1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:27:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99474266;
        Thu, 25 Aug 2022 00:27:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso4064960pjk.0;
        Thu, 25 Aug 2022 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qKOr3DMPndOCat2irEJB9Q52jID8xwcmfDfhmMWCtTo=;
        b=Vsbt9La98r+vRe+WqdSyAGFCskx2ijdSe0VPwhFZL8Wpl4Et9WglLaJ7FISDpryrB0
         bjg4cOn6FGrciHIlZZO6TWZK/bkPgU4bqdDKEC9HPmKh52QhOs4wx+T6P+dioNSPPO9d
         RXHQNi3xvQx2tSA0TcBzHQ4bsU8Wse16irOUsGSApZ/lFsccdofMYYuWDMBZuiEqJf6O
         LUkO1UOt966kZHRrQOJRrbg2/pVnp/3Vet72vpRAuj0Ip0NtHDe/PETenLZHsKqMG357
         zEqaWMJgvK34R0qQa7zlLILDD+15bFmFtC6bybgE8/YFYn0NAhZ8D6mrvoqsWGOdssiI
         M4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qKOr3DMPndOCat2irEJB9Q52jID8xwcmfDfhmMWCtTo=;
        b=6uAVOwGoAs9cShJabqow3GofyGFcVctELyqGSnj1WZKEhQej2XV515xgriwpTcsaTb
         u7JrChQFiVF/i2AlTD28oc78EYGaxB8gpiiKter/t7nJutKCswVXKZglybQ9wIu+U/5Z
         /IW/lKps1ecdllubAchWHP7xZDz6KSDV+RjskMXSLQRPk54JGrup3KR7F/DOe3siA7pi
         J5JlRXj+jh3QH3OY6OW3Is4bgCqWnreImOi/AievBRBzc4j8It8IMVBqXLDULdE7XseN
         vZ3WegSq3LPDPFuk1/KgMiOWCBfh0lJMtcILE/Kx2+Mmi3fUBka9dqwt9zb2HbtJtwKk
         fTXw==
X-Gm-Message-State: ACgBeo2y8cAd7pMwJev7FzwyMV5Le8OvFtl6xJopn/ynkO9exIWSwQ0d
        08lPMVIvVUws2c1rG98/TOs=
X-Google-Smtp-Source: AA6agR7D3OwM+2i+6XVsc2c3Ac3qP417Ykw0jCC4ImW4Fls1vV/M06DKfib/3v/IXTrelFUozAkLyA==
X-Received: by 2002:a17:902:edc3:b0:172:8ae3:9778 with SMTP id q3-20020a170902edc300b001728ae39778mr2540155plk.72.1661412468100;
        Thu, 25 Aug 2022 00:27:48 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c6-20020aa79526000000b005365aee486bsm10129655pfp.192.2022.08.25.00.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:27:47 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ACPI: EC: Remove the unneeded result variable
Date:   Thu, 25 Aug 2022 07:27:44 +0000
Message-Id: <20220825072744.229231-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value acpi_ec_write() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/acpi/ec.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c95e535035a0..9b42628cf21b 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -917,14 +917,10 @@ EXPORT_SYMBOL(ec_read);
 
 int ec_write(u8 addr, u8 val)
 {
-	int err;
-
 	if (!first_ec)
 		return -ENODEV;
 
-	err = acpi_ec_write(first_ec, addr, val);
-
-	return err;
+	return acpi_ec_write(first_ec, addr, val);
 }
 EXPORT_SYMBOL(ec_write);
 
-- 
2.25.1
