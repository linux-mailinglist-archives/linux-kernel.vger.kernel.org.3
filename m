Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594835715BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiGLJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiGLJaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:30:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED96D9D514;
        Tue, 12 Jul 2022 02:30:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bf13so7028378pgb.11;
        Tue, 12 Jul 2022 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZP4xj5NTGSJTpf2UMl/1n42zvx53xHebMpp6uYSD4U=;
        b=GS8Z7h47eocNxH6d06o/nRqe8Qkf9GVh23rUxcZCxyFkgU3Q80l7QWut1MVZ4H1q41
         /9SWKq5ga2GocGH1NKHbHBF8DICbXsAy0xprWhTYhbuT+2z7R7oiOcJPZnrKDAvVDomy
         Np5AhP7wtaD83rz1o+J4IkMkI/IdpimnT8J+O8Ym1pYfsCiqrhUwh6r2AgBcvzDxS21H
         RhnkkHOB0/XBzLc6Rns9mG6d2d/k9LhMmDVx9+MH+iZrHFdgOVhQD/9X1hX/ROPJ3+Cw
         K7gcjbGt86sBfLZNWzrv/WQLeqQ5NshGoIu6fxv/liGQIMDLmu2enTG+ZipzcLcXdrj/
         AeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZP4xj5NTGSJTpf2UMl/1n42zvx53xHebMpp6uYSD4U=;
        b=QiSfd3zaoNC7D6lI+mOTUIFkZpHhpp4MC0fI0Z62qnv9EM7S6EEP35RzfRzzbnvTAK
         gVbyablBtNR0YXYewDfRzmnUhEHUfcfhVB9euFBLbDtlBsHLQY+s3EWv393wt5xUaYoZ
         Ek0jIG0yv9BDuQeoZFx1AxswleNfSrE7ZyFvc7CYSMhetTAPGmm2yGL838Zc3ie4Ka+5
         UZ0MUfsjiI2x+NysYK3xQ7uEe7qod/6ane/Kzm+ase8yl1EfIw9UFc81vUFN6/dBs5qj
         2Pis3hoJXBtXk6avSZdRN8rsPhrSljFTjzo85jigEHsGh+cxBnQ6XGmyjEGOSOTanBmZ
         WQwg==
X-Gm-Message-State: AJIora80wcb+rTWhEAVplzzto87z4yS46E5TxT9hlZ8PMeCy2s+S7txn
        8uQS+Rn/uWDyrbfZdJevDlMhvtWH88k=
X-Google-Smtp-Source: AGRyM1s6rg8AwGm7QOzibd18/3g9CAE4UNCtXYkOuHCHBy0Ptn9ya8bThMzHTsF0YVH7zxZ4bQQhYQ==
X-Received: by 2002:a63:6b0a:0:b0:40d:ffa6:85c5 with SMTP id g10-20020a636b0a000000b0040dffa685c5mr19542901pgc.327.1657618205524;
        Tue, 12 Jul 2022 02:30:05 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-9.three.co.id. [180.214.233.9])
        by smtp.gmail.com with ESMTPSA id u3-20020a627903000000b00528999fba99sm6479684pfc.175.2022.07.12.02.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 02:30:04 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BAC23103973; Tue, 12 Jul 2022 16:29:58 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vladis Dronov <vdronov@redhat.com>,
        Tomasz Kowallik <tomaszx.kowalik@intel.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH next 1/3] Documentation: qat: Use code block for qat sysfs example
Date:   Tue, 12 Jul 2022 16:29:52 +0700
Message-Id: <20220712092954.142027-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712092954.142027-1-bagasdotme@gmail.com>
References: <20220712092954.142027-1-bagasdotme@gmail.com>
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
Cc: Wojciech Ziemba <wojciech.ziemba@intel.com>
Cc: Adam Guerin <adam.guerin@intel.com>
Cc: Fiona Trahe <fiona.trahe@intel.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
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

