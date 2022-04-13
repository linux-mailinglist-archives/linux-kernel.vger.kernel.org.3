Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1BC50022A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiDMW6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238744AbiDMW6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:58:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4202C58E7B;
        Wed, 13 Apr 2022 15:55:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z99so4210632ede.5;
        Wed, 13 Apr 2022 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dyvjfLWBF83ldDk4yCXAC9aBU6w05cT1GCfa/ITsV5M=;
        b=GjAUZCsq0IIScVS5wpaNnTUGNYz/WuHRVFd6BTprSefXbiclMpphZ0PhN5kV6LbNDI
         e8vvBo2rYCY/sWrOpBAfTQrweOIm10DKQ3FSrHKa4IZUt1HE2PJNcw4IqFnmc+hUlcbn
         LGv5jlv9pMKQu+giZ7qc2yfQBGKv/56qHblvcm82VJ5cQtU8wUT5iRda/IpsgEIC7Omf
         XDSyVq5MHmhOB6I/e31vLizL+mvVTwIKy93HbDMi8YFyD9J/xpfLsVIfrCiM8y3qs930
         Rslk+o0wWO40dKhtbZC9LxjiWu29lRIQOSg8DHJwDgnnuVYFOG1LJuXZbbDad86kYAOR
         bVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dyvjfLWBF83ldDk4yCXAC9aBU6w05cT1GCfa/ITsV5M=;
        b=aUcGGKNIG9V7LeoyjgFQCxJHiAkNER1obnhwd15W/rONUwjyBOGr7aV6IpCUABX//+
         lGthh/E4Lqagf60ppfjARe0Z1jFHiFHTUFggO6RdmvFPppMX4qZ4SYftdXtKV04RYk/9
         8qSpQPklpwE8GT3T8xP6um4MKBL98n4ar26vCfW9o5nOrvLV8R7jD2uruSF25dZL8iAR
         BIhUuCNdu577LxugK9OQj9UDDch3m26znoCRtfzkEc++ET9+0WfIxtV1RCfdTAZSd6nQ
         8La6FK0SNhVQJWSZRFrIjr9Xvu7XnowqTrd+q4HnVa0Dz8JQOCIcTbzfBL/Zv5G3s/Er
         5p3A==
X-Gm-Message-State: AOAM53380zp8x3xUaUD6uKYboOXA4rWPm78XAvoCPnFVkaEPCYaJ1B7q
        u7Ky5wdADN2T00pX7OODsQ4=
X-Google-Smtp-Source: ABdhPJwUF1oJQj2/lXqKcrWMbBCNj86N9kaBYLDVYEjlque7ZruiFwrT8oH+sfxef6CI03oAKpYTwg==
X-Received: by 2002:a05:6402:d0e:b0:413:3d99:f2d6 with SMTP id eb14-20020a0564020d0e00b004133d99f2d6mr1056662edb.189.1649890539778;
        Wed, 13 Apr 2022 15:55:39 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe4d1edc6sm78329ejc.61.2022.04.13.15.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 15:55:38 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_store()
Date:   Thu, 14 Apr 2022 00:55:31 +0200
Message-Id: <20220413225531.9425-1-fmdefrancesco@gmail.com>
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

The use of kmap() is being deprecated in favor of kmap_local_page()
where it is feasible. The same is true for kmap_atomic().

In file pci/hmm/hmm.c, function hmm_store() test if we are in atomic
context and, if so, it calls kmap_atomic(), if not, it calls kmap().

First of all, in_atomic() shouldn't be used in drivers. This macro
cannot always detect atomic context; in particular, it cannot know
about held spinlocks in non-preemptible kernels.

Notwithstanding what it is said above, this code doesn't need to care
whether or not it is executing in atomic context. It can simply use
kmap_local_page() / kunmap_local() that can instead do the mapping /
unmapping regardless of the context.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Therefore, hmm_store()() is a function where the use
of kmap_local_page() in place of both kmap() and kmap_atomic() is
correctly suited.

Convert the calls of kmap() / kunmap() and kmap_atomic() /
kunmap_atomic() to kmap_local_page() / kunmap_local() and drop the
unnecessary tests which test if the code is in atomic context.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/media/atomisp/pci/hmm/hmm.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
index 46ac082cd3f1..54188197c3dc 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
@@ -482,10 +482,7 @@ int hmm_store(ia_css_ptr virt, const void *data, unsigned int bytes)
 		idx = (virt - bo->start) >> PAGE_SHIFT;
 		offset = (virt - bo->start) - (idx << PAGE_SHIFT);
 
-		if (in_atomic())
-			des = (char *)kmap_atomic(bo->page_obj[idx].page);
-		else
-			des = (char *)kmap(bo->page_obj[idx].page);
+		des = (char *)kmap_local_page(bo->page_obj[idx].page);
 
 		if (!des) {
 			dev_err(atomisp_dev,
@@ -512,14 +509,7 @@ int hmm_store(ia_css_ptr virt, const void *data, unsigned int bytes)
 
 		clflush_cache_range(des, len);
 
-		if (in_atomic())
-			/*
-			 * Note: kunmap_atomic requires return addr from
-			 * kmap_atomic, not the page. See linux/highmem.h
-			 */
-			kunmap_atomic(des - offset);
-		else
-			kunmap(bo->page_obj[idx].page);
+		kunmap_local(des);
 	}
 
 	return 0;
-- 
2.34.1

