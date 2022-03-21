Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE444E3381
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiCUWuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiCUWuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB454370C90
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647901809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EAE8HCtpjM+jUc1ApTBvyoxBSZREVuBpm/2ip+JPuvw=;
        b=g3xaE9ts4I5zA/pQyhDUnSj3damHaMO3Yj9chLDNMvrH0e4NOKUF3iUbtuNf6CqkKXgZtK
        j8zBKaRtV6GeN1vxq6huZ+ZdiS5vq2kVllc363sMkny7Kd5myoo45YoycskZUUshOq7F6G
        DZwpPHvPWgQKAGFpdrSVai7A8CLpndg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-KyK5Dv_UMbOhSg7CnAfObA-1; Mon, 21 Mar 2022 18:04:24 -0400
X-MC-Unique: KyK5Dv_UMbOhSg7CnAfObA-1
Received: by mail-qv1-f71.google.com with SMTP id x6-20020ad44626000000b0044119c7bf4aso4243963qvv.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EAE8HCtpjM+jUc1ApTBvyoxBSZREVuBpm/2ip+JPuvw=;
        b=UrNQ9wtDjgcsvF0Bd3StqUflFoSky4JGwTfmCiAU5PI/d/Q5jR87AvtHZbJTzW+Wwu
         //EtIdX3/oJvf95eOkiT8HH4nkrACeAL8f8X5CUgrFooFXSjbcJ7IpDRxJPcLNobuOCL
         Y68zfPozxUibzjixm5aR0hyTQyFdjNj2O3PqDD/G7o75jvNEXZN6wPQ6Pj82tAbMqEGI
         pZAPe6s6kBA8M8jpAOmQR+JgLxPQtA8LgevJy5jtGkT43ytbW7NjW38JAgDY+edymJbX
         fFLcJhlKEVA/zWI9YzAZD1Ezoul95akXo7Q0ZZ43A8YV0619RN0Xusc65ugWN/39p3Nk
         4Hhg==
X-Gm-Message-State: AOAM531O+jMNIe7wS1qXy6AbSQ++03Tuvm4N42qtg7N1BrO5nbnW4ccQ
        l8pTAKWaNH0sLuZBWfPNfptUqs9HHN4mzpJooGISUc/E3ZZvNGBqLifJZ+4L8GDuVkS98M+C6Ry
        XGbF+BphuaT27guLN6iItJntN
X-Received: by 2002:a05:622a:13d2:b0:2e1:eedb:c81a with SMTP id p18-20020a05622a13d200b002e1eedbc81amr17047682qtk.437.1647900263482;
        Mon, 21 Mar 2022 15:04:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1U5Tj/wJe6NsZNnB2FgrrKyvSVD8FAkqs6udLgi3vy3yBsH2/Xd1pfjMZojGr6sjDBC2Sug==
X-Received: by 2002:a05:622a:13d2:b0:2e1:eedb:c81a with SMTP id p18-20020a05622a13d200b002e1eedbc81amr17047671qtk.437.1647900263231;
        Mon, 21 Mar 2022 15:04:23 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id de26-20020a05620a371a00b0067dc7923b14sm8218854qkb.132.2022.03.21.15.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 15:04:22 -0700 (PDT)
From:   trix@redhat.com
To:     corbet@lwn.net, dan.j.williams@intel.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nvdimm/blk: Fix title level
Date:   Mon, 21 Mar 2022 15:04:08 -0700
Message-Id: <20220321220408.2381974-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

make htmldocs fails with
Sphinx parallel build error:
docutils.utils.SystemMessage: ...nvdimm.rst:146:
  (SEVERE/4) Title level inconsistent:

PMEM-REGIONs, Atomic Sectors, and DAX
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The PMEM vs BLK section was removed without changing
the PMEM-REGIONS... title line.  Replace '^' with '_'.

Fixes: f8669f1d6a86 ("nvdimm/blk: Delete the block-aperture window driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 Documentation/driver-api/nvdimm/nvdimm.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
index 7917f64710920..be8587a558e1e 100644
--- a/Documentation/driver-api/nvdimm/nvdimm.rst
+++ b/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -15,7 +15,7 @@ Version 13
 	    Supporting Documents
 	    Git Trees
 	LIBNVDIMM PMEM
-	        PMEM-REGIONs, Atomic Sectors, and DAX
+	    PMEM-REGIONs, Atomic Sectors, and DAX
 	Example NVDIMM Platform
 	LIBNVDIMM Kernel Device Model and LIBNDCTL Userspace API
 	    LIBNDCTL: Context
@@ -144,7 +144,7 @@ can be immediately attached to nd_pmem. This latter mode is called
 label-less or "legacy".
 
 PMEM-REGIONs, Atomic Sectors, and DAX
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+-------------------------------------
 
 For the cases where an application or filesystem still needs atomic sector
 update guarantees it can register a BTT on a PMEM device or partition.  See
-- 
2.26.3

