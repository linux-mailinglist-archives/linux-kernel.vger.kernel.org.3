Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF9859ABCA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 08:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbiHTGnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245024AbiHTGni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:43:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DECF1183E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:43:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o22so7916098edc.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dWDV/5GVcx0ceVlPM2V+MXtiSomLloUDOadV6lqtfMg=;
        b=c2xrHvYIlUGROUVRIrTOI1acCiwZdrCJH145opnExd/fHYrjeIJgBZlZNfakbMvXem
         3TQMfLEoeCGKAab/XSjfkxwzya4iteFwDooM9FWmVxfMB+p3xybknBqEMXbKcTy7kCu1
         b05cqX2JvBKcPA4gf7EPbbLQbE/WLrdxQ0AWzczwkD92+wf7vLWecyDI5pI4RfGpuDJS
         Zh6MqAn1uzsLzBHKuKDubvimx5U3cRjGhcfVNpJi7D2W0iKzp2A8er0IPwHBLmQC8TgK
         C1ae7FFxUEQ57OwbQ5OR4ptHG5D6xo0fln/iWJ0JkPaT0A2nueznG4iMts+r9LyqtEvX
         2TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dWDV/5GVcx0ceVlPM2V+MXtiSomLloUDOadV6lqtfMg=;
        b=gAtfhlRjkPwzy3Z8gfajNm0UIA+LQyn+LqLy0FPMbfA/cQc5SYmPDldZedzaNGcpWn
         yDWIBWed7Xq8AzvcA0xwkpU0c45sd6wFdYKkwVcJ6tHcSEVS2Ox5qJzF0xjKqrgMdVI2
         jDNnES9nc5MmacpH567A8xqYcycgNOmpp9UqniqHPvwzDWaM1A/Rx85i0AsWmWcUgqP2
         s3z84hhPZcTmXI0isUUlFMgKQhEf0u2rGHT794+LrhQmDfghhHDbKVa1U692TOtdm3Or
         cRevqAsATYSrkZvXpIJfCXmp3kzL9HSbvvIWXuLDLDltPV3c+e3GBEaPvirtDbF9bAM9
         /CxA==
X-Gm-Message-State: ACgBeo0Q7uZqpWI3S3Lwlx0kc1kzBays4XnYpf0l4E9iUcyuh8Sw3qif
        Ew/sx9vk6o5q5XsEgx4qexA=
X-Google-Smtp-Source: AA6agR46t+9YK94cWnLir63Q/+nawfjA6O9Yc4vsU9nRjXI03iWoAlDdBKAMof8ayDO6kCfa1M97jg==
X-Received: by 2002:aa7:ccd5:0:b0:445:cede:7936 with SMTP id y21-20020aa7ccd5000000b00445cede7936mr8552592edt.223.1660977807206;
        Fri, 19 Aug 2022 23:43:27 -0700 (PDT)
Received: from nam-dell.vm.stuba.sk ([147.175.88.220])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906329b00b0073c0b87ba34sm2935816ejw.198.2022.08.19.23.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 23:43:26 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 2/4] staging: rtl8723bs: remove member noise_level from struct dm_odm_t
Date:   Sat, 20 Aug 2022 08:42:44 +0200
Message-Id: <5a8256d3823baaa72775da80d821749dfbda7ad4.1660977536.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660977535.git.namcaov@gmail.com>
References: <cover.1660977535.git.namcaov@gmail.com>
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

because it is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index 19cfc2915458..033f22b0f394 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -863,7 +863,6 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	u8 Adaptivity_IGI_upper;
 	u8 NHM_cnt_0;
 
-	struct odm_noise_monitor noise_level;/* ODM_MAX_CHANNEL_NUM]; */
 	/*  */
 	/* 2 Define STA info. */
 	/*  _ODM_STA_INFO */
-- 
2.25.1

