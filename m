Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CBE4E95A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243433AbiC1Lvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbiC1Loj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:44:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9A05717B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u26so16523005eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CTe1aR5OcBBOwDIeny+aB4PntXqLk/4mfX1YAG71O3U=;
        b=atr0aIYdDMVOJshhfblOWqacBiAVKEwVfbDjG8shUTmy6sNPlKeKTAHTM92cqmtOXu
         1ksX2Guin9hE/vP8jqZzrrtzynRbo5u0dctijjDLgbV0ubhKlazibkVBt/G3ZRqnAQUs
         2LRfXMc8TiZFZF4KpF6cwUlsupv/TqNwTmPO4zdvqiWTEWYSVZC4IFrRDlt6nyOlK1QC
         3u0WcTx/HMvlUNv13fXfxheOk4m80p/v0gis8yIRVA9DM0ga9SeqF2nfxhJ5ZMNseAbt
         7OJzR/xiY/6iS7LKhDvRvmrfCPcLR7NGbTU94qLMIHxJiwXfLnjmMeV1BXj07rAO2wUq
         PteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CTe1aR5OcBBOwDIeny+aB4PntXqLk/4mfX1YAG71O3U=;
        b=fCpRcjq0BKcYSwsEQ3wkmpOTANIRBSC8APVnK5mM0IAxaU2HDKsD8bGFOeepccEVqq
         orvdSZCgj5dAgHG3oDEJESVxgtFokN+Z6lqqaJkvVBCoJFdMxhzEBhrVVt4IOiTAWKXb
         RS1B0LB/HPiRw590P/xBS6MnmMSa0LVYbHW7ekSG7c45ndHPbtMr/Gorqq5Bh7jYuYEQ
         K6bWwCt06zp7JiS2RjVMl7rUDkJO6pvM2U0Y0XUPxm4p2pah2EZRn9poFeyclIUYMpNP
         8jVQqqlHmQhFSYB6X1/XPG18zJUXmIvGKD6GRus6Evz0vlScGnsb3w2LjK5ZotYZLpvn
         yEbw==
X-Gm-Message-State: AOAM532c3t2jvF6xgkITHSbGA8hhLFLLK8tdqa2+rcjleOAH42bNVtqR
        BbidNYwXYUIv6RJy4jTEnEQHK2panW4=
X-Google-Smtp-Source: ABdhPJxgp8CfIhItzgswwUIi/UV+3j3Lk01yEt2iQobYQcLbGkOO1Vbk2xgcZbc1+zg2PGKNcO7J/w==
X-Received: by 2002:aa7:c58e:0:b0:418:f6f7:ccd4 with SMTP id g14-20020aa7c58e000000b00418f6f7ccd4mr15584346edq.132.1648467596398;
        Mon, 28 Mar 2022 04:39:56 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id hq39-20020a1709073f2700b006dfc58efab9sm5938556ejc.73.2022.03.28.04.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:39:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/9] staging: r8188eu: remove unnecessary if statement
Date:   Mon, 28 Mar 2022 13:39:37 +0200
Message-Id: <20220328113940.6396-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328113940.6396-1-straube.linux@gmail.com>
References: <20220328113940.6396-1-straube.linux@gmail.com>
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

The local variable threshold in rtw_joinbss_reset() is set to 0 and
immediately set to another value if it is 0. Remove this unnecessary
if and assign the final value in the first place.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 14aff6a2040a..83841cf85a0d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1816,10 +1816,8 @@ void rtw_joinbss_reset(struct adapter *padapter)
 		if (padapter->registrypriv.wifi_spec == 1)
 			threshold = 1;
 		else
-			threshold = 0;
-
-		if (threshold == 0)
 			threshold = USB_RXAGG_PAGE_COUNT;
+
 		rtw_write8(padapter, REG_RXDMA_AGG_PG_TH, threshold);
 	} else {
 		threshold = 1;
-- 
2.35.1

