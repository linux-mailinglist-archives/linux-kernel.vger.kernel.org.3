Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5775898D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbiHDHzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbiHDHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:55:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178339C;
        Thu,  4 Aug 2022 00:55:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z187so8753284pfb.12;
        Thu, 04 Aug 2022 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6Eo/VaBVywfJU01xr3jTASOO7w/sIGuJ4/Z7ZpDiOj8=;
        b=UOuSg6wVrzSTjFGbuEtNUrcrCCr8bp5vtWloOxj3p7apkWak/NzWCtNt8COSPx1Y/7
         MnPYwKzpsLA2cMnSHnkMT4MInV3QRwdrqwKuXAPB1YiH9ZwqT1b52ClCH8473URKpDKI
         ZocDvO0ijdmPojnr9IhHTMvn8CL7gPMtdm/hxWllg6InGrRbGIhg8wiIFuHkulGbKsht
         HtEfPK7UJJntsGyqeNAfUIx4hk+80x++HfpnieSfDQcbKOJO1niOXtphoniuQDeiWKpx
         clh1+bj+60gcOUcuFQxIu32PqZ+JZeQI9wOsGJiRxPihIiHW+plR07i/MxhnS8m+rjm3
         smHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6Eo/VaBVywfJU01xr3jTASOO7w/sIGuJ4/Z7ZpDiOj8=;
        b=mEoPbOdsdVyjwRHKnE5K5yDRe9/A9FnLi1IxgHkp2p2TFTFq9paCC4O54mQpiFZ7VI
         GMR08rXarsSzleFap+s0/2YCrU6G5k9UG1v6Kz9IFcDNHfbG0OrqYE2za4doyaYpWHOV
         U1++0q+qamkEL7FWJli0oQfWfWcmzheEy7HxV8pmmvA6PNLL7ZHOGxHmXOIri9aPWZm2
         OUuOx0WliO5KsgohTj3GcEQ+pyjdRkx2srWf0vpaTJXC9e8skw4Om1FkBFZTPbS6bGke
         uvHOamlZa5MI/KwKucqJRxH+Yn9UKn7lhIed7Q9es6ByI/R8z+SPRJLLIZSnzf1DQhO3
         GIiQ==
X-Gm-Message-State: ACgBeo160zyhVcnwlCliY+8ffcnqooolQIWh8nSOR10cTp0WrOoQjj/e
        blpMOO95jSddEDHuGntrsH0=
X-Google-Smtp-Source: AA6agR770qyF7a49wJ+cWCkfQ9hc0Fq6/vp81cI+AIUFFu1uqEethgrcKYfBPmQKYywU1Nzn80zv2A==
X-Received: by 2002:a63:6a89:0:b0:419:d863:321a with SMTP id f131-20020a636a89000000b00419d863321amr675348pgc.9.1659599710935;
        Thu, 04 Aug 2022 00:55:10 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-23.three.co.id. [180.214.232.23])
        by smtp.gmail.com with ESMTPSA id x13-20020a63b20d000000b0041a67913d5bsm506798pge.71.2022.08.04.00.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 00:55:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2EF99103A34; Thu,  4 Aug 2022 14:55:05 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-next@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/3] cxl/region: describe targets and nr_targets members of cxl_region_params
Date:   Thu,  4 Aug 2022 14:54:47 +0700
Message-Id: <20220804075448.98241-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804075448.98241-1-bagasdotme@gmail.com>
References: <20220804075448.98241-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=bagasdotme@gmail.com; h=from:subject; bh=4WRYALTrUN77SAeI/OXcYTvEOCNaChDbrptGKeU1dXg=; b=owGbwMvMwCn83935mHOB8QHG02pJDEmvq93/rj/PwOkZ7d1176nTuhChrgTHzdt3FQra7eY5sWLN sc13O6ayMAhzMsiKKbK8qdwtxvFh5dH+4O+ZMHNYmUCGMHBxCsBEvk1lbFgsUTaV34dZYM6sl3/PJK WvUJ8Y+5Tvk8lzgbsbdnUnRPvqzLykX3no2Kx9SwRCZNr5bjI29DKlTN3W8jXynnjmUb19+btnb4v8 P3meSS1zRWjUb7PCqbOar6Rv4Fgv475g+/GYl4qdAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=EC79BB1608F0A9C58F53F769FF4743C6437033C0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx reported undescribed parameters in cxl_region_params struct:

./drivers/cxl/cxl.h:376: warning: Function parameter or member 'targets' not described in 'cxl_region_params'
./drivers/cxl/cxl.h:376: warning: Function parameter or member 'nr_targets' not described in 'cxl_region_params'

Describe these members.

Fixes: dd5ba0ebbdc414 ("cxl/region: Add a 'uuid' attribute")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/cxl/cxl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 75674400cc8d41..65aaf15aa17e29 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -362,6 +362,8 @@ enum cxl_config_state {
  * @interleave_ways: number of endpoints in the region
  * @interleave_granularity: capacity each endpoint contributes to a stripe
  * @res: allocated iomem capacity for this region
+ * @targets: active ordered targets in current decoder configuration
+ * @nr_targets: number of targets
  *
  * State transitions are protected by the cxl_region_rwsem
  */
-- 
An old man doll... just what I always wanted! - Clara

