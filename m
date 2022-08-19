Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709965998C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347773AbiHSJgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346985AbiHSJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:36:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BB2D21CA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:36:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a7so7809745ejp.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dWDV/5GVcx0ceVlPM2V+MXtiSomLloUDOadV6lqtfMg=;
        b=A/ERsJ9sQ1PYDiKyL7mwFBD65/CbA4KsnwLlmbCxi7lZGwlhIhvybU+MI5orRZ5s3Q
         1PSnP/B2rhwwxGmLrNCzI201RtZoKioDracSqU0g7DQH0zM6nW3tAWcMLlVEzgNWFlrU
         nDKDJIdELPYCvQZ5J8HBvuOgLTsLPIPQ5p1z9V3AGXHfzpMiUvOrxP+pz3MJbOicX48q
         YtRldte2I4OOaOCgLy5rsGm6WtHw6Wg/asNZ30gh9EYJiTOD0xkapNuXXpS/0cxITEC6
         jSUo05YITtf58iD6Oc4OvKDkVZufWgwwPtPxjNUObqKEQkWYwg04NQcZi1PQxBLr5qoC
         bwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dWDV/5GVcx0ceVlPM2V+MXtiSomLloUDOadV6lqtfMg=;
        b=StirnldrM9p/oX8nkHnitMWAk+3A2BZPA5pEfSsa81nH7DpFDjn81DFVldfxkyWJpH
         GxRIF62gM6FwXWKUjqPiGlgzQYzmtMFQNLZtROCESZnvBDl87jGTYr4GiRgjHU8ilt9H
         /BjJrVVaBoy5rwI0P5vT9vJSb84YU/cjTM3j+4wmZwIJlgdskAO/kbzmAJ4Q1yR/9lpU
         9mPhPMnycAf05GJCdM1v8HcKTKf/kLLhW8E7xset1AxCKZvhGSOGyo1DdlXjypd4u+p4
         mu6x2irEBV4XCOuGlxATqYfbeTWR43XUxG5vEkYztGKq1IlGxZBnqrTrxZfDtFwkaY35
         ij1Q==
X-Gm-Message-State: ACgBeo3H6kCVEOUnW/XrDCUPZ5KQ5tpDRBpaq4TP7Q8GbKQrfKmnb8HE
        qyzIqBzytLnQ156L/gja/7I=
X-Google-Smtp-Source: AA6agR4/0Fx1+XkmnSgIBpZVfYUeqT4M+0nrofIYN9yHBINA3c6J4yyg1zrpSZe9QFx7jhvcejerEw==
X-Received: by 2002:a17:907:9628:b0:731:1e3:b168 with SMTP id gb40-20020a170907962800b0073101e3b168mr4400385ejc.526.1660901769601;
        Fri, 19 Aug 2022 02:36:09 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906941800b00734d4bd1792sm2055929ejx.162.2022.08.19.02.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 02:36:09 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH 2/3] staging: rtl8723bs: remove member noise_level from struct dm_odm_t
Date:   Fri, 19 Aug 2022 11:35:36 +0200
Message-Id: <5a8256d3823baaa72775da80d821749dfbda7ad4.1660901124.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660901124.git.namcaov@gmail.com>
References: <cover.1660901124.git.namcaov@gmail.com>
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

