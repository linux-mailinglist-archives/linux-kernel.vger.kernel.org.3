Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DCE4BD04F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 18:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbiBTRcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 12:32:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiBTRc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 12:32:27 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7176BBE;
        Sun, 20 Feb 2022 09:32:05 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bu29so14629297lfb.0;
        Sun, 20 Feb 2022 09:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfNLrW8iqBQsbuSrzEGTeEHosap22UQqZ1+HJnuvOZs=;
        b=BHp+FJeE/XWtA5QW5XAQhP41fU6oQXQRJg/Sz00627ZRzyn2baPty0r2suPUbqaFZF
         HCSqTeLOaG3ngFSHJjXSJtSHrd0Tx8WHBt+QhuqiZUQla4/NURZn+BG1yiHaXsA3hbsc
         MKk0yMlid+ZwpbzTupLQhrurfKCyhNk3OxmHou0EvUPVOGsQK3KXi1UovCAxVSpKKC1H
         mFCnC1O5VFLAkBHe9ZohGfz55Uw5IWP6r01ze9mc9zrk227E/mJjSxzmNFsesTx5QjkX
         +vaqXEHItGzYrURjhbequKBtmmkAk0TRuz7JHwai0RpxLTbfoYhD5V7rKUOoNDInN3qL
         716Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfNLrW8iqBQsbuSrzEGTeEHosap22UQqZ1+HJnuvOZs=;
        b=D0vcik7QLIfMNvab39chMMVdJ8VK+7oxbrykw1RT8BI7UDr4fABZy3Rt5z1wqF7PBx
         zlq2Wl1iIrMRryNEdzY96WWE/zAl5NK2ZS4EXehH+FYHPDGmj5ztoHmkvALlHu73e/UH
         +vbQzthXgMCr6Oa+bB0isP87UxcAmOzLrBnVQSYBrwm3CZsjaBcZHdFvkqsL02U7aR83
         Q0WW50RD0JAUAGmMjvQwNPxBTEmXwOUeehLY37/jXzhCsENpY/i20MJiHq77Ogvkz/Lj
         VmS/ReBRB4DPCWSuH31OOTgGZZsg/l3iDa8zZnwO60cJrxcBoGmgdCdZ5hLiPPlLr/qk
         TzDQ==
X-Gm-Message-State: AOAM531y+5VOelx3ysxAZDA7BfWdD+I7Xu2CYSu9JHcIRRdJQEZbmIix
        rlk877d7JE6gCBlLCiprliJlEVHCRgE=
X-Google-Smtp-Source: ABdhPJyKJxCG9uzYGHkhlq0B9udz0uguZq3XOLfLkG21gqs/9U6IeV19ya/fQAQw9pot9mkWFVXXPg==
X-Received: by 2002:a19:5206:0:b0:42a:709f:29aa with SMTP id m6-20020a195206000000b0042a709f29aamr11026196lfb.189.1645378324115;
        Sun, 20 Feb 2022 09:32:04 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id f8sm880490ljk.97.2022.02.20.09.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:32:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] media: v4l2-ctrls: Add new V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags
Date:   Sun, 20 Feb 2022 20:29:43 +0300
Message-Id: <20220220172950.3401-2-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220172950.3401-1-digetx@gmail.com>
References: <20220220172950.3401-1-digetx@gmail.com>
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

Reviewed-by: Nicolas Dufresne <nicolas@collabora.com>
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

