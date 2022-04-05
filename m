Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A253A4F4B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575249AbiDEXD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390729AbiDENnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:43:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA3B29833
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:43:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n18so10799261plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkFtcq8jG36lKpEqQXtgVBWpO9PXs+dvDcrkyl4I1JE=;
        b=K3A6+NSJs8BRIGtFtREYuYGdt+I2mfbSCX/qAgVN8Llkj+IqkdCnfKCE0OmVCR0oTL
         ZuQ3c53uY19nlODYpvTvtL6e+pdMZJzomxMY2twipmZFpfCjtCvMDW6n91+hsCXCjO/9
         SEJ4wUwiPIoumxXLjQKMitubVLWNKHTeOuDRaoprMeakAxZYyQMAULiHDXdNvPtbmOLs
         UXC4VhPTrG5tTZ2mzWL9Pc7C5YqeDBJ6ZKI+Hl6AESA4BgIIrbFskHFl7AOOmGuIr4Oa
         hbMKmf5C/jKh8/gf+IzMn5ywVlKLy0IPwvSBH8P2FO1gh+Y2a3Gxsjb63cktIDXT7UNV
         oCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkFtcq8jG36lKpEqQXtgVBWpO9PXs+dvDcrkyl4I1JE=;
        b=Ut3XkyU6HrSdkOnIoAF3NFbyZnIiGFnFgeltQ5h/vMidnjTzlDFBjjSsSh5l6YAjd4
         XPJJFtzssqcnDAgf6WgBTmPpqYFN/7xDpu2DVIkE86XKYCIji/HYEEOhDLKqvxFne1zS
         osFdvlci817NkN6sGYEnYUgULT+o24q2Efe90fA72yHG+tE307Rqk2MTYr6MUK7HY4OV
         h9VaxoXbUaj+LF1BziYje1VCnnEylml53o2jmtnKtQ0y+WfMRhTDS13isLqovhbDue7C
         TKh3v5qHytTyPHJTLvJWHdf53PYRUSwTSl5teSu91C+GKE/5qpxLP5UYZsxXqtK2ELYU
         ynqw==
X-Gm-Message-State: AOAM533kPO1La/s2dbpeW4DJxgd36m0JNStmYi9SWNvQNCGxmu0DNjEX
        HE2xds8HQqHnJ5LHlfLM5wc=
X-Google-Smtp-Source: ABdhPJxA7BYupDalxQpTgWbwDIy06f39XbgqEQMzEvGNOezRhIRWoxVZMoYFVgURNXmPQjcaobeYZA==
X-Received: by 2002:a17:902:f243:b0:156:b615:dd38 with SMTP id j3-20020a170902f24300b00156b615dd38mr3322253plc.174.1649162618681;
        Tue, 05 Apr 2022 05:43:38 -0700 (PDT)
Received: from vihas.localhost.com ([103.85.9.59])
        by smtp.gmail.com with ESMTPSA id nl17-20020a17090b385100b001c70883f6ccsm2760014pjb.36.2022.04.05.05.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 05:43:38 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: drop redundant if check in IS_MCAST
Date:   Tue,  5 Apr 2022 18:12:38 +0530
Message-Id: <20220405124239.3372-2-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405124239.3372-1-makvihas@gmail.com>
References: <20220405124239.3372-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The if check is redundant. Drop it and simplify the funciton.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index e10cf17d6..88ed6b4a0 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -244,10 +244,7 @@ enum WIFI_REG_DOMAIN {
 
 static inline bool IS_MCAST(unsigned char *da)
 {
-	if ((*da) & 0x01)
-		return true;
-	else
-		return false;
+	return (*da) & 0x01;
 }
 
 static inline unsigned char *get_da(unsigned char *pframe)
-- 
2.30.2

