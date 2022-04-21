Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E097F50A140
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387697AbiDUN4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiDUN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9F60140C4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650549208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZJT9EPj2AF0BAgtE5D1IQ2psGEhfq4Pud3Pk1dFggms=;
        b=Jad1U7mn+yROkDP2bmYnHSXQr4bLSI81bG/jcEL5sQ2vzCql2FPswQg9bc7ejJ1hQtpUq1
        PYxY1MY+p89ub9ZsOIMywxbsv3YvX6hNy1DOHUMHawJfr3Z42h3WeiKSU/WXn1KEAFhTyN
        6Db4gV6dZigcrSQ9uI7qEZx4dTEQjH0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-5C8CBZXZOhyDZI51AbD1oQ-1; Thu, 21 Apr 2022 09:53:25 -0400
X-MC-Unique: 5C8CBZXZOhyDZI51AbD1oQ-1
Received: by mail-qt1-f199.google.com with SMTP id f22-20020ac840d6000000b002dd4d87de21so2993344qtm.23
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJT9EPj2AF0BAgtE5D1IQ2psGEhfq4Pud3Pk1dFggms=;
        b=BVZxLwBIr8JJdmONpKcifl5vG/2ga6egpNRUEyDVVeyvdf/KOaGOLoA7LwQ9wCOQQP
         1/V5gRh+XeSoEeWnDvluzl5jUYuGgkZ4MTvxqhjiU5UuXLFPH79OytuCo3NpH7YpJ0V8
         4jPDaSrJb8LnhhII00IioBMWSbPg6wJWFOsaV/K2MX6USRxsN/QhbrPKVUmcypQol5rh
         dhrmBB1qzAryZt82jIW7EzVuBTI8+n8wilLuFjmqfGSRSZyU3niVyNyLtezwA4bM6I7R
         +yEvw3q7B1E8o/v6qhVd65Uy9zd5VSAhoimm43PEYIRWMNt5qO4ckwyzHJej/VJ+hdvb
         0Ngg==
X-Gm-Message-State: AOAM530jl44OVW0eDZLrc8lHfY6PzjcIyJogr42othW8igk7RMsSQ2ib
        Q48VeYIqgQgoPCr7ZMUAO1dg00TbsassQlJoJGHJh9Bt9l8lj0+IBzt5IMgxxcux9ct822dm4zV
        H24rP3LYxNsTKONPGCL5XAMVi
X-Received: by 2002:a05:620a:472c:b0:69e:adc8:31bb with SMTP id bs44-20020a05620a472c00b0069eadc831bbmr10391134qkb.357.1650549205302;
        Thu, 21 Apr 2022 06:53:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ65Ni7KuvPVTHG9wXSVhaowghVkjzp4/JMCxuoAouEEprDA9UV4imd4z+Od6KwvJEfM7RhQ==
X-Received: by 2002:a05:620a:472c:b0:69e:adc8:31bb with SMTP id bs44-20020a05620a472c00b0069eadc831bbmr10391122qkb.357.1650549205053;
        Thu, 21 Apr 2022 06:53:25 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h123-20020a379e81000000b0069e955169e5sm2969054qke.2.2022.04.21.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:53:24 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     mchehab@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] EDAC/ghes: change ghes_hw from global to static
Date:   Thu, 21 Apr 2022 09:53:19 -0400
Message-Id: <20220421135319.1508754-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
ghes_edac.c:44:3: warning: symbol 'ghes_hw' was not declared. Should it be static?

ghes_hw is only used in ghes_edac.c so change its
storage-class specifier to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/edac/ghes_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 2805d5610300..59b0bedc9c24 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -38,7 +38,7 @@ static struct ghes_pvt *ghes_pvt;
  * This driver's representation of the system hardware, as collected
  * from DMI.
  */
-struct ghes_hw_desc {
+static struct ghes_hw_desc {
 	int num_dimms;
 	struct dimm_info *dimms;
 } ghes_hw;
-- 
2.27.0

