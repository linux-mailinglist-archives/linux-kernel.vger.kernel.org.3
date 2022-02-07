Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548434AC1AA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383051AbiBGOn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356664AbiBGOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:20:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D30BC0401C0;
        Mon,  7 Feb 2022 06:20:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z4so12370993lfg.5;
        Mon, 07 Feb 2022 06:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1DmVvauQogPdSOmMYGT0+c2REtcYPYAhJ2C4GBTFK30=;
        b=CnVeLw94cVE8wp1I0kVfya/qFwXTtg7iHHYV01GdMNk+F7D/oT9bCwgwB7aX5nx9k5
         L8CkRIw+dwBQOE0YkE3PiK5Ni89obtbAaZPp9/P/Dm3rhlZil+TACFihNXsLUkC6hnFY
         /R03waGawnU/WJuy9qvO8gvFKUVprj7bb7MrFLDbR+04L7v1FFTWYUNuuDjanskS8rJo
         GzIZy63aOyVzMdzOg7ND3J/sLgOj8I/wPctYKDppNkXW2gVzqKPIUAuggUqp3zyO9P4y
         ZSBTUNXDskwYbJp8u4EUaVe9+TsOisynY+hEnAC+2vCtXda0QpI2YJvQZboKS0V0xj1Y
         SPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1DmVvauQogPdSOmMYGT0+c2REtcYPYAhJ2C4GBTFK30=;
        b=m3XPNj35bg0QY62AMUo+Sfa8eb9AG9wQV6+7OMKh/2tPIhwLIX6hWi8qe/ds5OQccm
         gYgdo2bffMWyzVfPWsNVBO4ULFyipox7xq1fdcdfiVzgDl1jFg8bq7nVDh17ySzksHZZ
         meUBkQ6qXexGYy0pQwxzgG9LLpQAkfWHD7dBi0YTUQX+eGqNMemQ5WbPv0/0Bj+MqIae
         Ia8cuHxL4Xp1MTTZZ3Vnu42sKjQgGT04UhxFtmoF2AdvceRqSuan25V8PJkKevzl5Rk3
         5c/SQ5bUYuOd7z74ojiQpBDdoxtXA1ZJ3ZW3x4mhTLENs5DZnZDDPi6SIMt9vXHPT5a1
         dupQ==
X-Gm-Message-State: AOAM530wSTXHXhHcai7TSQvrKVSCqq/KHp4IV+tT7eMudWl2sFzmH9Nw
        BQSSWGTbCyc7uSAbe5AA60g=
X-Google-Smtp-Source: ABdhPJxvM5gUBekTZyRtGOm7YurnBNVe5BKjYWy0gnPR9eGrgX1FB2eAMv4Tl6pIecOFJrpQTaSkMg==
X-Received: by 2002:ac2:46c9:: with SMTP id p9mr8527758lfo.365.1644243621652;
        Mon, 07 Feb 2022 06:20:21 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id t13sm1515599lfl.94.2022.02.07.06.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 06:20:21 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] media: v4l2-ctrls: Add new V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags
Date:   Mon,  7 Feb 2022 17:19:34 +0300
Message-Id: <20220207141937.13089-2-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207141937.13089-1-digetx@gmail.com>
References: <20220207141937.13089-1-digetx@gmail.com>
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

Add new V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags that are needed by
NVIDIA Tegra video decoder. Userspace will have to set these flags in
accordance to the type of a decoded frame.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../userspace-api/media/v4l/ext-ctrls-codec-stateless.rst   | 6 ++++++
 include/uapi/linux/v4l2-controls.h                          | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
index cc080c4257d0..f87584ad90ba 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec-stateless.rst
@@ -616,6 +616,12 @@ Stateless Codec Control ID
     * - ``V4L2_H264_DECODE_PARAM_FLAG_BOTTOM_FIELD``
       - 0x00000004
       -
+    * - ``V4L2_H264_DECODE_PARAM_FLAG_PFRAME``
+      - 0x00000008
+      -
+    * - ``V4L2_H264_DECODE_PARAM_FLAG_BFRAME``
+      - 0x00000010
+      -
 
 .. raw:: latex
 
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c8e0f84d204d..e3d48d571062 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -1563,6 +1563,8 @@ struct v4l2_h264_dpb_entry {
 #define V4L2_H264_DECODE_PARAM_FLAG_IDR_PIC		0x01
 #define V4L2_H264_DECODE_PARAM_FLAG_FIELD_PIC		0x02
 #define V4L2_H264_DECODE_PARAM_FLAG_BOTTOM_FIELD	0x04
+#define V4L2_H264_DECODE_PARAM_FLAG_PFRAME		0x08
+#define V4L2_H264_DECODE_PARAM_FLAG_BFRAME		0x10
 
 #define V4L2_CID_STATELESS_H264_DECODE_PARAMS	(V4L2_CID_CODEC_STATELESS_BASE + 7)
 /**
-- 
2.34.1

