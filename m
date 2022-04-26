Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610BB50FE92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350782AbiDZNPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350708AbiDZNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:14:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445E2606FD;
        Tue, 26 Apr 2022 06:11:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s21so10713865wrb.8;
        Tue, 26 Apr 2022 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijpwGqsXgBPBiVhSs+YP8TRmDX5KTxyG7N6/z3tSNi4=;
        b=lETHOxN1TKX8nqXi01vTXSkjRusVehwmj5mQzQxd9G/x17TVh+KiEX28nFRW29XN/a
         +8KCx5ESsiazXEN63iCxfpQxRwTqKTA5fpkEsAggsH/oIdcitS694ChZWgcPo4xgEZ8U
         kEUB+o3wpJxtSfuiIhC4bAmZLcATWwk58ySBfADZH1aB62KrJd7pvVIPOIxHNquo8SJK
         rjxUF5BQ9BOBxW9B12Liq/QR8YQ8QefbDIdqLsjc7JSUecVGvioqAZCoMRbjp3MXcqd6
         xq4x+IoIJsXjNBziY0d2sYdWSEDOwe3y/HOZdEV/WPSAxk2/JHVxm6m7WWcJiILoOGz7
         1f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijpwGqsXgBPBiVhSs+YP8TRmDX5KTxyG7N6/z3tSNi4=;
        b=uYubSBjoDeUUgHDPAMGtnHrcwesbp6tuZk7TuC/3FoD8r1vyr6FT7p1RNFeSnmfOrG
         NAVfark6QbfgfQ+gyDDJRgQb+9/rEuOlYfE15PiMytd+9uTYcdrXsjRxtCu7UjBrMuAl
         XPcj3+xmvMevNiHoZfh7zpNgJB+mgJJrx9eYYMkU5SNyVukgrpcCZpdXyZj2S9J2ka5d
         KSjS2qiPd5ugJcqx7fF8/z5uOh0FATBYnSFegxDBOyzg4hmnMlQoHz/x6BLADZtd1AQI
         FwNE/OEAYKrnzYvKkPrmpVneOvDY/Rw+daVjCZDwgsJ88Fq7jWJfhL+kb/zS2a51Mc+b
         QQTw==
X-Gm-Message-State: AOAM530A1rlAALByAF+EpQwifY0RMt86sPb2uWWFMV28xJIC+q8ieZUB
        3lwPT2Blpy0bQMMO4pA8ZP4=
X-Google-Smtp-Source: ABdhPJzpn+67vgdP0A4C/ajFpADSwxzFD3/hRjCOsfgDi1ayAx6Tve0NeO706EkxfEzCPciBidEj7A==
X-Received: by 2002:a5d:64e3:0:b0:20a:87e9:7daa with SMTP id g3-20020a5d64e3000000b0020a87e97daamr18667024wri.345.1650978673857;
        Tue, 26 Apr 2022 06:11:13 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:13 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 06/14] iio: event_monitor: add pitch, yaw and roll modifiers
Date:   Tue, 26 Apr 2022 15:10:54 +0200
Message-Id: <20220426131102.23966-7-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426131102.23966-1-andrea.merello@gmail.com>
References: <20220426131102.23966-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Following the introduction of pitch, yaw and roll IIO modifiers, update the
event_monitor tool accordingly.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 tools/iio/iio_event_monitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 1fee44abb836..ee3f78c47655 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -125,6 +125,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LINEAR_X] = "linear_x",
 	[IIO_MOD_LINEAR_Y] = "linear_y",
 	[IIO_MOD_LINEAR_Z] = "linear_z",
+	[IIO_MOD_PITCH] = "pitch",
+	[IIO_MOD_YAW] = "yaw",
+	[IIO_MOD_ROLL] = "roll",
 };
 
 static bool event_is_known(struct iio_event_data *event)
-- 
2.17.1

