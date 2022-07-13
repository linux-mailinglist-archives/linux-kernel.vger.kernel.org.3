Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736FC572BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiGMDES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiGMDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:04:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9126567;
        Tue, 12 Jul 2022 20:03:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id o12so9091373pfp.5;
        Tue, 12 Jul 2022 20:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BbmHqIsS3LgTRBAHaCLnc7YjI6SPA8/UqmwKvGHG6c=;
        b=nsfHfTVqf90nEaiU6k56lVhPYCBIEYDk4kIaHhxKKC2Af6TF9nsJZVwV59NUAvJhbx
         1E3EF34yHVhJ88LHTBq3ZsR8+I699/7CQ+yYYSTcPHjjehjTx4C0FNwoJ//hhQgyxdcO
         DzzOkH9IprQbyq9cORzqtauFSpc7ZuRJDfbGQuAHfU/wPt5s4dF+CNQnuKW/gpMN+BYn
         TEKe85oJxCGbJXVd0AvZ7XeSKi0JXE+j3HAISQc4C+mnbuhBAePPEjUGm7I4OwAZmU/t
         WKjscUDWZ/cwLXiF3vyMBaQx+Fl2ydvIW6BHRcMsYNk+VnSll9ZhgLS5PkEm0Eq6dSXm
         ppxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BbmHqIsS3LgTRBAHaCLnc7YjI6SPA8/UqmwKvGHG6c=;
        b=zrJkY+lIHca/nlWvJvF3MKfwaoosdbxJGYFZDIBPVQREbrNE3VFI64spqTkOpl/If7
         2uf6+Qdg6PfzAO3FN8ceVpme+U43NmXrAG1+ZY1iczmIlCBd/FtPHqfmlYhuKy4Gucg2
         G3JVE3wd/Hc0eAXsN61LSGvdt7ltXCM4G++FkrPTzHE4EMetshtLzX4udECnHHgsac+h
         Cxw0SIRwrSIy4pxsk3uNBHk35CbjTFN5Bf2b3fxnkxNVRR7wwTS5RlhhsjtvoD9j3/wA
         UNIpW7nOgS4yADlXSgC5+I7/fGoq0RKL8gFc6pGAIrbZxDu3lFR8O2VMsJLGO2ck92EP
         Oaaw==
X-Gm-Message-State: AJIora954w3mA2IlHS0hiF7RY6ByYWzU3w9R3pnmqLmmgE9Oh5h2OUeT
        TfjbdHyzOFR1BnoqFVM1cUxmsv9pBLKK/A==
X-Google-Smtp-Source: AGRyM1sFEVXE8R9JzFF5X/rPxNJh3P77fMfRFwqdya5oRjJl3g+1tCHo0tlt1d77OFs4PThnzM6/+w==
X-Received: by 2002:a05:6a00:158e:b0:52a:e628:8b3b with SMTP id u14-20020a056a00158e00b0052ae6288b3bmr1278718pfk.80.1657681434169;
        Tue, 12 Jul 2022 20:03:54 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-20.three.co.id. [180.214.232.20])
        by smtp.gmail.com with ESMTPSA id lk2-20020a17090b33c200b001eee7950428sm313605pjb.44.2022.07.12.20.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 20:03:53 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 113F3103132; Wed, 13 Jul 2022 10:03:47 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vladis Dronov <vdronov@redhat.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Documentation: qat: Use code block for qat sysfs example
Date:   Wed, 13 Jul 2022 10:03:32 +0700
Message-Id: <20220713030332.158525-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713030332.158525-1-bagasdotme@gmail.com>
References: <20220713030332.158525-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot and Stephen Rothwell reported htmldocs warning:

Documentation/ABI/testing/sysfs-driver-qat:24: WARNING: Unexpected indentation.

The warning isn't caused by Date: field pointed by the warning, but rather
by sysfs example that isn't in literal code block.

Add the code block marker.

Link: https://lore.kernel.org/linux-next/20220711204932.333379b4@canb.auug.org.au/
Link: https://lore.kernel.org/linux-doc/202207090803.TEGI95qw-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: d4cfb144f60551 ("crypto: qat - expose device config through sysfs for 4xxx")
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Wojciech Ziemba <wojciech.ziemba@intel.com>
Cc: Adam Guerin <adam.guerin@intel.com>
Cc: Fiona Trahe <fiona.trahe@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Vladis Dronov <vdronov@redhat.com>
Cc: Tomasz Kowallik <tomaszx.kowalik@intel.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-qat | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-qat b/Documentation/ABI/testing/sysfs-driver-qat
index a600531e95628f..43e081ec22cc4a 100644
--- a/Documentation/ABI/testing/sysfs-driver-qat
+++ b/Documentation/ABI/testing/sysfs-driver-qat
@@ -46,7 +46,8 @@ Description:	Reports the current configuration of the QAT device and allows
 
 		The following example shows how to change the configuration of
 		a device configured for running crypto services in order to
-		run data compression:
+		run data compression::
+
 			# cat /sys/bus/pci/devices/<BDF>/qat/state
 			up
 			# cat /sys/bus/pci/devices/<BDF>/qat/cfg_services
-- 
An old man doll... just what I always wanted! - Clara

