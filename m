Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D373E57982A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbiGSLGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbiGSLGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:06:46 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CC92E9EF;
        Tue, 19 Jul 2022 04:06:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b2so11648417plx.7;
        Tue, 19 Jul 2022 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yR8dSMQDO3J8EOIN4BAJE5lx9Xt0RDylNrSQoIJCuJo=;
        b=oUtFGjXBj2eDMm2rIPXFyGpY3ltaSAQ2mFlSV46WNd5sq/rBeaZuQxybtZtaoOoxAb
         auQV/OGNYt29DG2T1R1Dv+zOajGv/ADQVwK/lX9ty4loTmuSGTTF8bm5AtqT499ujWnE
         vWhhfpdu+oowTU6LChfjRR/a+khUJ7YUKeFxKdIbvRv9Nbk1bkwYghvwsoCkLRgT/2Yq
         GqekKHAOxoVaJ0DcamP6j8aKK7C0o2162MajCTRCTbeiiPsplnfD7jpKUio0OyhrPJOy
         ZTRUHURlinVM+d6IJKcUUYCmtFxCTmW9DAygUTFeDzXAorMsf3k+xIIwY4PHoL4/VHre
         MJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yR8dSMQDO3J8EOIN4BAJE5lx9Xt0RDylNrSQoIJCuJo=;
        b=1VKYUOrEkUnbvNJSQLgO04wGSPwUURqnh1oP+s+VTmeWTVozfDBmJ/YdjvGvbceURr
         7EPnEmBI/Pnnv+4XsM+TwU3OZ9PPkVed/wDHUtKXLtTh8qQWfq0q3rg/nPfFQ3wGlOna
         Y5i557f3YFEEJbkpwq2RHYrg5Vck7gu2Ms5XKR3Oh9TU9Tr0TCjBGobhbFvrBOBlc5AR
         YF9kIaYqiZX8Ls5m3uK/cVl0xSxkWjPu/WBYgQau99xVzCfdWuE/KibNZDdad1MUX/DM
         S5ybjoaN107BsjQWZKJ66CxCMthJ8s69GOyWHinRUKV1UgXhuZz3fLqIwjve8RYYxkKP
         rMNQ==
X-Gm-Message-State: AJIora9b9iCUwr1oWviELEZ0domQY+xWAwVUPr41gC2u4vSSeTfXLYYM
        3dNkHV7FCNv6tQqu/I1HHgz3Q1hVrno=
X-Google-Smtp-Source: AGRyM1uj72yKztTPnmKYMx7Fya8r0/CFyaVMpMTTRZKk41PWwHtFT2+u/qNTrbG93EUA0Jt9lFDPcg==
X-Received: by 2002:a17:902:f544:b0:16c:5119:d4c2 with SMTP id h4-20020a170902f54400b0016c5119d4c2mr32592390plf.1.1658228804931;
        Tue, 19 Jul 2022 04:06:44 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id c6-20020a63d146000000b0040d75537824sm9863033pgj.86.2022.07.19.04.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 04:06:44 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] selftests: gpio: fix include path to kernel headers for out of tree builds
Date:   Tue, 19 Jul 2022 19:06:01 +0800
Message-Id: <20220719110601.136474-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building selftests out of the kernel tree the gpio.h the include
path is incorrect and the build falls back to the system includes
which may be outdated.

Add the KHDR_INCLUDES to the CFLAGS to include the gpio.h from the
build tree.

Fixes: 4f4d0af7b2d9 ("selftests: gpio: restore CFLAGS options")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kent Gibson <warthog618@gmail.com>
---

The test bot suggested
4f4d0af7b2d9 ("selftests: gpio: restore CFLAGS options")
as the commit to be fixed, but the previous fix which turned out to be
incomplete seems more appropriate.

 tools/testing/selftests/gpio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 71b306602368..616ed4019655 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -3,6 +3,6 @@
 TEST_PROGS := gpio-mockup.sh gpio-sim.sh
 TEST_FILES := gpio-mockup-sysfs.sh
 TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info gpio-line-name
-CFLAGS += -O2 -g -Wall -I../../../../usr/include/
+CFLAGS += -O2 -g -Wall -I../../../../usr/include/ $(KHDR_INCLUDES)
 
 include ../lib.mk
-- 
2.37.1

