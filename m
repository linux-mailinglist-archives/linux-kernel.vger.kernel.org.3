Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E7156AC80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiGGUHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbiGGUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:07:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C12860501;
        Thu,  7 Jul 2022 13:07:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n10so2509441wrc.4;
        Thu, 07 Jul 2022 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rTCSXAVDcHhaWmF5B1mtYzKPQt4FAy2X4j0BObLT6Xs=;
        b=IeURnp416D4+YsTeFKP2dgsRCa/QZTTbliByXDOLciA/80Uy5ICS87ZoiMZ3O59n2n
         pj4mBx9veTy4ym/9LoDGKlSQSDVMi4U+VXiKCMrPGzHzJpOhL0bfZ7Y3PSFhprcuzqWP
         Kja9EN3vE9GVptFD3uu8YOyIEYaJwh/fSVOXkrAzjsQozGYIkLrizM+lAeVOcyg04e6t
         lDAG6JQ06DeC+u3KciW2NQj3T1X/pBM3XBXlOHiEHOYrSaxNuAUXlSg5ECzS0itAy7YA
         53I2Bfv+CLcK3u+rqhU0jbvYEg6oN5smI8O22ZHL+dLCzyApmOeR1d4HQO8m1mSnAGxF
         Ld7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTCSXAVDcHhaWmF5B1mtYzKPQt4FAy2X4j0BObLT6Xs=;
        b=buxEGvScTIvqF4eH4cXJzKoZbA9+wYwc31EjcC7LT6/SfSk04foXdjF4/sEId03TXq
         1EQv9kyhQ7EdNDQLQnLhnlo99xBXnG68zQaSm767ooeI3hjnZ4VNACh4FEZESsWmgTCR
         8uManJcSthiXlHhaRWXG88TSGfSmC6Eqv5qK67ENHaiKqXyGD8u15eEqxl/BbJ5TuV9L
         KhzT4SNPcvnR1/5wITpFAUa0QKyPuD46PNvBb5x9af3bWJ7Q0zqquGy/oZVH+zIdtADu
         0iKADBesb96xQoIR9R6O1ZtpGAlmptPWED5vxrg+A4S3RMj4JkBY88HWA5JGNTkWPqXA
         KSGQ==
X-Gm-Message-State: AJIora/HxsASj2y2jsqo6hv3huzIoEJRT9qwdIzcnEnz/9E8qBeyCo0/
        R/dhlSmkaRd3ae1uaaVFqGc=
X-Google-Smtp-Source: AGRyM1vip8b5inVLn8Zh2y8lxHZ//ajL4cRb/xdWnfmA56uw+IgIBLYInrGJCfNuexzpzmxCqScMFg==
X-Received: by 2002:a5d:4e04:0:b0:21d:6ec3:38a2 with SMTP id p4-20020a5d4e04000000b0021d6ec338a2mr17906129wrt.362.1657224463909;
        Thu, 07 Jul 2022 13:07:43 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0039ee391a024sm25096752wms.14.2022.07.07.13.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:07:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RESEND PATCH 3/3] staging: media: atomisp: Use kmap_local_page() in hmm_store()
Date:   Thu,  7 Jul 2022 22:07:18 +0200
Message-Id: <20220707200718.26398-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707200718.26398-1-fmdefrancesco@gmail.com>
References: <20220707200718.26398-1-fmdefrancesco@gmail.com>
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

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
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
2.36.1

