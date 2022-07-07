Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A956956ACDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiGGUhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiGGUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:37:50 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6312A94D;
        Thu,  7 Jul 2022 13:37:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y9so7478973pff.12;
        Thu, 07 Jul 2022 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+geEsEXr8SYIv24S/+eDc33ess9qsrayZqcANcvXgxw=;
        b=VQ4iWKkEgwYAVHDsVofS+De2Stdpz49igJRUooGZGzFhW+rnPkJDhZ3w+qzpF8dRrN
         ImyxFh89+jfATPO9uaAuCgJI7BxoAzhWUCGDjB4F6mRRtCA9Ek61LHBEVZ9rGm2ReYZ9
         /Q0C+ioUtuZsXpCZdi4174xUQn32UUoQO4RonGoQG8Vw78nD9y1xTjxYdgbF1AbpaiTd
         KIQ+hxdxzMmw5HGkrwOcWdY8Qa/wDQpFrl8Q3OtCA7q3K+aQVDujGQgRvHZuvCFW1Otb
         AYoxKi4SsZX2DHYV4hwjjr6th51zMU5jjMTTxh5C9c0Gcpm3wtp6wMcMc4gamQWpCmdh
         jsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+geEsEXr8SYIv24S/+eDc33ess9qsrayZqcANcvXgxw=;
        b=D9kJYnHfCkBl8LbU9mvv4O++ERPz76JTUMj6PYI9zrY4wFovQ3OEV4qp8q32+C0i0Z
         J7PQpV+BwDy/Xr65lSLhMBoHNgUYihvXiynJ53vpVDTFyNZoN1O5BkWnDQfzj9AUbeM3
         6Apb3E/ZsTFn2+rI8jXtkSAnQrdXIdWdgIjkHoim45IztsUF69ngcWXqtPm1Uz+L43la
         kG55F2YewzlWVxVBGLdDrQ/vwA9KZzjG1tgi9CrRRoSwfsd6HyqNj/ijICK2pBQVlgzp
         /F+Ymnc0Er8I3gi3AkD6loHt5ok+5wL2RzG+7NqnvxnJKbeAYzdNI9pk87CgLA9q91pi
         mnlg==
X-Gm-Message-State: AJIora9GcYpmSPb/Azq+asWdKsPKqnaYFaQbWGzK27XzerDLcx6b9w7c
        EmW+CB5vcj5Qxu4aMwUKNEfao22NIho=
X-Google-Smtp-Source: AGRyM1uX7UEfMdlbOZw1Vu4ZA+9y37oWzOBkOMoP6JqDlrfnmm3/EKgu/Zq7rT0MVALJ6iPkwyYcyQ==
X-Received: by 2002:a05:6a00:3307:b0:527:cbdc:d7dc with SMTP id cq7-20020a056a00330700b00527cbdcd7dcmr52757734pfb.85.1657226268866;
        Thu, 07 Jul 2022 13:37:48 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id lt6-20020a17090b354600b001efb6d18b8dsm3987713pjb.8.2022.07.07.13.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:37:48 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MIPS: Make phys_to_virt utilize __va()
Date:   Thu,  7 Jul 2022 13:37:42 -0700
Message-Id: <20220707203743.1226302-1-f.fainelli@gmail.com>
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

The implementation is exactly the same, so avoid open-coding it in two
different locations.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 6f5c86d2bab4..880048a54362 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -131,7 +131,7 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
  */
 static inline void * phys_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
+	return __va(address);
 }
 
 /*
-- 
2.25.1

