Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2379056AC88
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiGGUHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiGGUHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:07:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058ED5C9D0;
        Thu,  7 Jul 2022 13:07:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a5so13122918wrx.12;
        Thu, 07 Jul 2022 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V2FS0wBh6E9v0AAYp9N7QfTmBvANd9d4CAwWxz+lUhw=;
        b=Ykw7pgymVxW4ylR5nKhiE1dhV2hoWH7nArSOhhTxP0I8M2oMRqYFWN/Jdym800AzKK
         1pmhrwNm6Hnn0lJwTmzL8lcc2UF3IYEKrCTGiM8MgAH6V2zkhcEPNDoBdu2/R2I/NeOg
         EQSCCqUuEsmmwqqVrLAbXDlmihtiuOw+NrAuDOjwkkXR49flD57a24twRCKBv+5ru6bU
         5VTIs7W95tfqXbZWLQwowaQmSw41uKzFPmHdikUUnvK+znE5Q3zXLJS7T6wS93LK9NGp
         CNlNsqbadEiNfPwLfQK7dJwvNZ9qk5xjCxheVSBKYOJhrpbD/ARCuP7unQOe2UHFuRix
         KONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V2FS0wBh6E9v0AAYp9N7QfTmBvANd9d4CAwWxz+lUhw=;
        b=LFR/5WEXTicg7517RVCvnF4Pu6FPrf5IMJVzonOYP2biyKzuJulwPCuja81pUBVf8j
         0Du0NSbEDMbp3Ta1rRzABokni77sOUTloc/C0TN70JA+XGFlJQX157TjpsAxu8TiJkAJ
         uVhZ1NLYYJ47VDX3vnuu+8hQx7BpnSu4EgbaK4e19s/4+93PrFIpOrie/gsBjL40hkWu
         nDn9zLwygDTwKerqCGAqRS8g1ZusZ0w6J4i5FwPx3NLvvoxYXBisBR2lY+h9qluWC0E9
         mdZoFoioWOEUx6kcdAa+43gp/0TfQUfH0YRx95hxCYFp/tx+N4a5hEbRwLndVYrLOJtA
         N9+w==
X-Gm-Message-State: AJIora/qzyQ3JdwPRivBV7nZDEVB0WnDMb6Tprbqt2xg2LyhH1OecKNQ
        o/fe/zIb0DWq5l09XyJDzlqnu2r279Y=
X-Google-Smtp-Source: AGRyM1ubdp0wk/SF4+PuVsdl1on/yZsAcXjLUt3BabHTAdSDH41RpBq7sOL1nlatyS0ikOB+cRm4aA==
X-Received: by 2002:a5d:440e:0:b0:21d:85ce:6b8e with SMTP id z14-20020a5d440e000000b0021d85ce6b8emr5281027wrq.248.1657224458493;
        Thu, 07 Jul 2022 13:07:38 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0039ee391a024sm25096752wms.14.2022.07.07.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:07:37 -0700 (PDT)
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
Subject: [RESEND PATCH 1/3] staging: media: atomisp: Convert kmap() to kmap_local_page()
Date:   Thu,  7 Jul 2022 22:07:16 +0200
Message-Id: <20220707200718.26398-2-fmdefrancesco@gmail.com>
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

The use of kmap() is being deprecated in favor of kmap_local_page() where
it is feasible. With kmap_local_page(), the mapping is per thread, CPU
local and not globally visible.

load_and_flush_by_kmap() is a function where the use of kmap_local_page()
in place of kmap() is correctly suited.

Convert load_and_flush_by_kmap() from kmap() to kmap_local_page().

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/media/atomisp/pci/hmm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
index c1cda16f2dc0..6394385b6637 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
@@ -350,7 +350,7 @@ static int load_and_flush_by_kmap(ia_css_ptr virt, void *data,
 		idx = (virt - bo->start) >> PAGE_SHIFT;
 		offset = (virt - bo->start) - (idx << PAGE_SHIFT);
 
-		src = (char *)kmap(bo->page_obj[idx].page) + offset;
+		src = (char *)kmap_local_page(bo->page_obj[idx].page) + offset;
 
 		if ((bytes + offset) >= PAGE_SIZE) {
 			len = PAGE_SIZE - offset;
@@ -369,7 +369,7 @@ static int load_and_flush_by_kmap(ia_css_ptr virt, void *data,
 
 		clflush_cache_range(src, len);
 
-		kunmap(bo->page_obj[idx].page);
+		kunmap_local(src);
 	}
 
 	return 0;
-- 
2.36.1

