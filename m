Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC959AF57
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiHTSAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiHTSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:00:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3C62A710
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:00:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so5522141ejt.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dWDV/5GVcx0ceVlPM2V+MXtiSomLloUDOadV6lqtfMg=;
        b=JiEBkifvfg0lWSRIxGwa+OENQ+A+yfxE3zt8rjdb/C/QQhREWZifNHSEEWG51lNFoR
         egp/MFromiOsaLYfI2u1yWKIdkgNy1lFRnL8obL1p5piurJ8vfKOzI12VPklVAnnOr4h
         JqIlugN2d7y3B2kzkAzq8HHFC6IOsAVEv7AXQTn8Db+wuhy4UgbHXK75Y+Z8iKjNTgTn
         mgqYFOj/P52jfp+W6TlsCUNWaXnw2ZBedihrHhyf45omFxKnIHsuZYEjKTcb0nHeaw34
         RjtQK/KHiKZ+AFKqakDs6Fv9Od5+we5R/nir2k1Z12zZsWc/NcOZYZsRa5tgt8FBp2Gp
         PKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dWDV/5GVcx0ceVlPM2V+MXtiSomLloUDOadV6lqtfMg=;
        b=HwHRhKc9Epm2I1wg4VezVxtBSfxSnq53fbM5nzUrhrrgD3UMwsB7fifu788UHbD2u/
         G+JFHUJfFaGzGT4oaM7Cv9reyQ3aiTMV9HfDds40yjVo8ekCp6cFwOdjHWhhdmqh5UoN
         VQnFDeq/DHLP6FCMoG4b4uaf5bnmcj2bSXUtA/OKGrx/FhW6jn1I1/60Degen1KQPYuo
         TTktD0pBq79O118n0LHRP7XFBgRxbCFQZzCmnMAZMirtx0yyxJdiz2bH1fDHhW5JVg43
         2kAN8hkXDmWNS3J/WA216PaSwTbNdimsUwx0e4oLjm4cWZnT+q/RZ68D8o/fpcoJb0He
         K52g==
X-Gm-Message-State: ACgBeo16dTApeiv4Iq61+akF1CftNubv6xki2UkFa76H9cJ8C/vTpps5
        DwOU0Shvc1vMeMkJS3SXP0s=
X-Google-Smtp-Source: AA6agR727ufje9R4miZjxMKOqFBcm7cPFP4BNgnDN69z8tkeYwUpFtDqh6qCLsiin3KTUKI8kTQByg==
X-Received: by 2002:a17:907:1c1f:b0:73d:6883:9869 with SMTP id nc31-20020a1709071c1f00b0073d68839869mr1894852ejc.241.1661018434912;
        Sat, 20 Aug 2022 11:00:34 -0700 (PDT)
Received: from nam-dell.vm.stuba.sk ([147.175.88.220])
        by smtp.gmail.com with ESMTPSA id x19-20020aa7d6d3000000b00445e037345csm4938841edr.14.2022.08.20.11.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:00:34 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     hdegoede@redhat.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, lkp@intel.com, namcaov@gmail.com
Subject: [PATCH v3 2/3] staging: rtl8723bs: remove member noise_level from struct dm_odm_t
Date:   Sat, 20 Aug 2022 20:00:03 +0200
Message-Id: <5a8256d3823baaa72775da80d821749dfbda7ad4.1661018051.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661018051.git.namcaov@gmail.com>
References: <cover.1661018051.git.namcaov@gmail.com>
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

