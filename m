Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89364493126
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350181AbiARXEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350172AbiARXET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:04:19 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A238C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:04:19 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id f8so565089pgf.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=vmI5obZJChROSVQzReKLArfFA6O6EbFVOPbqT4ROOPo=;
        b=QfQD1u5VB3E351cX8YrjWGZk8vfWE2crrmBoY6ipDg4SX2/GS7Uck5C8/8Ixyl/ee6
         5RwrN57TS0g+L9P/syCEvZqk3jluxNUUZuyAfiG3xxUYULGwOJOOuqCc82sm7+BwX3M8
         uy83V4j/0LH7R2BhpkH71Jf/XHK5C5M7SnUlJFhokGszQ5UE6bb2OJLwiDN6rjwC7orl
         YvDv0rY6byus6J8y3Eyq5xO2hbztgN95nVDx57MDOsvjMyPjZGX2NeHSlxDCyrrP2gqR
         0sEm+3hypvO86f1fGdg4wQJxJ/utQ8csuzhfsQrj3pgNEuPaiGB8UyU8fC3AiRsRZvtH
         9Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=vmI5obZJChROSVQzReKLArfFA6O6EbFVOPbqT4ROOPo=;
        b=nnDBug6r4MpLaIqTqifLQztLAa/YdojwV1MNFb9G2xShOhyIpgZgjEsjscntRS7EjU
         TtKPkFYkTvn1L/mMnaFMJyL1F8pHpKiDFhbFWE3BSkMCXVaWJ5+GgCPqlPw9O31KSGcK
         8DbDqnHqm8221x8iWCIfWW/ILfuh0Rsq+irgoVJ9NnVr6Z+l/RUVgbYep87udtikJGjB
         xWyRTWn1gT+aPTVTu3K+VFJ1D0GL1f8pc2yrDFLUTWimrTS482e90gZ+mtHwq8YIIn0j
         0nwMB5wrouRZnnR/pLRvR2IRDF/wF5MhidTbsYyzkO/q4CoV68cIe+gABKa4RSz4C3QL
         O6WQ==
X-Gm-Message-State: AOAM531UnMGDDnvWVDPnH05JGE/bwSu7bb04e1hoQSkfss2bfOjKgst7
        prjqa6WBd2ZrDEYxb5iIJd3Gr4nFoj7IVc2/pBw=
X-Google-Smtp-Source: ABdhPJw+EJr9CIkmWZMT2kuFRRthOjv28RD0JsJY7pNppfXdsHHhYSV2ChZdm54sofXo+ulJRhvEMg==
X-Received: by 2002:a62:1c12:0:b0:4bc:6d81:b402 with SMTP id c18-20020a621c12000000b004bc6d81b402mr27869091pfc.40.1642547058817;
        Tue, 18 Jan 2022 15:04:18 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id x15sm20422153pfh.157.2022.01.18.15.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 15:04:18 -0800 (PST)
Date:   Wed, 19 Jan 2022 12:04:13 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] staging: pi433: fix validation for min bit rate
 supported by the device
Message-ID: <20220118230413.GA4859@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118230312.GA4826@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf69 datasheets establishes that the minimum supported bit rate is
1.2 kbps regardless of modulation.

this patch replaces the errouneous validation with the correct value

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/rf69.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index ee8c81d164e1..f4ac17adcd83 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -226,14 +226,12 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
 int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
 {
 	int retval;
-	u32 bit_rate_min;
 	u32 bit_rate_reg;
 	u8 msb;
 	u8 lsb;
 
 	// check input value
-	bit_rate_min = F_OSC / 8388608; // 8388608 = 2^23;
-	if (bit_rate < bit_rate_min) {
+	if (bit_rate < 1200) {
 		dev_dbg(&spi->dev, "setBitRate: illegal input param");
 		return -EINVAL;
 	}
-- 
2.25.4

