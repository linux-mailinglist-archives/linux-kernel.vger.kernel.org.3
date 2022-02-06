Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6024AB23D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbiBFVNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiBFVNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:13:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51746C06173B;
        Sun,  6 Feb 2022 13:13:24 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id s13so36368474ejy.3;
        Sun, 06 Feb 2022 13:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f9FB0LY+dCar991Pis7i7FQYT3UDxcaUPHPXiBU054c=;
        b=GubcTaPPqQu/HO2US1FaY5R8FchW29Wzy8xA3a4yguDXqK/21y75jxJKV8RYGK2I1y
         HHQ1WC5lGSX9aze8mS+J2j7fLVXIV22CLpPf3FUoGT/fBp9x7d5xdCFgKx83XoYvoiRt
         ioX0lAW6MiAWqEmvnXm8eFmld0ZO2NksIrfKCPZvHkyA5R5+DWwtbI8MHUKJz6onPcAo
         icJLlSKnClSLN3nFubtGGCTmSb0TaRUb0zv8UYU+I1gMu1hQ0dvaFW+lcbDIsf2RoFlx
         Vct/YoRMa82i1LxUrWIHHnr8TB7KA3VhiuJX/fgsm93hV0iKgX/YONF9xqBxF0SBH9eR
         O4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f9FB0LY+dCar991Pis7i7FQYT3UDxcaUPHPXiBU054c=;
        b=Lxk/iaOq98XHf9vTkkPjRNAAVywVp5280pLOWuqljwcHRSEiE2r5zGx4Uvh5QRcid9
         fhcf0HLxb+7fPyX/S0xJ0I5P1H6Sz96J70lPXvIkDA5LPwby/PUFYujzrm0rwpNUccWA
         6kiUUg8YAsGd7a4wef6A4T3KYWqRKjrB2u7/riEwiHSeKwf3SFpXmaEeHcKOqIllqcu9
         a0uIT2b3ckynX74OPn2viakvpjeGgJUn1DNW2FCLrvtrB7aUhiDSV11EEK0cV+I+A0mP
         +KH3QcphpguQzutUNiT2Uwc7wdgDExj2nzqhQFztrVf0+a6p4fx73DPbbUvdhbYTzujC
         EwpQ==
X-Gm-Message-State: AOAM530DkhmEGhkmEWKZ4TnLav4VYzhNkGlZZLfG9me5KY6kvj+OW3Tm
        xuvfx0qinHf16lBGji31hhU=
X-Google-Smtp-Source: ABdhPJxq/rLEG4mVhe4ens6tStaUaHT2AdS4YzbzI36FZq+SI4SZKnxDouaN4HtFALEECHtzTxqeMg==
X-Received: by 2002:a17:907:6d1b:: with SMTP id sa27mr7420122ejc.166.1644182002726;
        Sun, 06 Feb 2022 13:13:22 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id a4sm1248598edr.33.2022.02.06.13.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:13:22 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] iio: introduce mag_referenced
Date:   Sun,  6 Feb 2022 23:13:03 +0200
Message-Id: <20220206211307.1564647-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220206211307.1564647-1-cosmin.tanislav@analog.com>
References: <20220206211307.1564647-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some accelerometers that support activity and inactivity
events also support a referenced mode, in which the
gravitational acceleration is taken as a point of
reference before comparing the acceleration to the
specified activity and inactivity magnitude.

For example, in the case of the ADXL367, for activity
detection, the formula is:

abs(acceleration - reference) > magnitude

Add a new event type that makes this behavior clear.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/industrialio-event.c | 1 +
 include/uapi/linux/iio/types.h   | 1 +
 tools/iio/iio_event_monitor.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index d0732eac0f0a..ce8b102ce52f 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -230,6 +230,7 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
 	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
 	[IIO_EV_TYPE_CHANGE] = "change",
+	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
 };
 
 static const char * const iio_ev_dir_text[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 48c13147c0a8..472cead10d8d 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -104,6 +104,7 @@ enum iio_event_type {
 	IIO_EV_TYPE_THRESH_ADAPTIVE,
 	IIO_EV_TYPE_MAG_ADAPTIVE,
 	IIO_EV_TYPE_CHANGE,
+	IIO_EV_TYPE_MAG_REFERENCED,
 };
 
 enum iio_event_direction {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index b94a16ba5c6c..2f4581658859 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -68,6 +68,7 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
 	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
 	[IIO_EV_TYPE_CHANGE] = "change",
+	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
 };
 
 static const char * const iio_ev_dir_text[] = {
-- 
2.35.0

