Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135234BD192
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244999AbiBTUrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:47:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbiBTUrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:47:04 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F29CD7A;
        Sun, 20 Feb 2022 12:46:42 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v28so4416123ljv.9;
        Sun, 20 Feb 2022 12:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfNLrW8iqBQsbuSrzEGTeEHosap22UQqZ1+HJnuvOZs=;
        b=PfGxrADPB6mhlOpeWEyWO5AzrcYFLDV02zdvc+QHYuU4DcBp7BZBlQp+WW8/4cz+44
         0+yGzk/r/24AUe+gCRqSYC5Zo/zzb0SUmLuw1hnmx6NsYj8EvZbF5TVMuPS4j8bAXbaW
         mkMPuuSoW1PjfInsi3yx3tbUu5B9iBKlPDHprWnuGLCI1zDqt6+PydMVrzAJ+2tWNjho
         WdcPvO+aiWx+MdbW+YKMtVzbIGUJPWCvH7eQr1DAUYKr62VhPrVwZv/GTNTqCtZ15Tos
         1v4BFBqH4sNim7MOxT6/pVotL2LEha6Yk2XNN8C0hr7vv/Bq9a5jVWe4ITUNLa5vB1fz
         UV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfNLrW8iqBQsbuSrzEGTeEHosap22UQqZ1+HJnuvOZs=;
        b=NiJ3pBiQ1UfRZWM1DqrRHIouGAl+3qd3L06gIYCpOiL0t61dKBTO2DVpwABW1FfZDU
         EHM+/uooXKZVs06zTNlTUlHp2N9WUa47GdyHpaUYqUaElfzLKYEewuFDeIn3iCdlbelh
         K0/AKx1LxVQW/AG9oh/ara0aCSC7vfeQBVQbV3rg8aq6MF5pKm476Nyr5C6pAxaYwqjr
         gCQAtE0UWFaxuNwn1hkMNSLVfKi4WUeZxn92xD1CQSiycgQLvkLIc1956oDbAUpt/LXp
         05gLnzLC54tWrOytKAzAak2RQTQuFSU4lbrRUjuLE3PgilPTS5MPyIEs+6to3Uz37yiN
         /i1A==
X-Gm-Message-State: AOAM532zTtCZZYPcXe6tEusWC3bJBE4FUK0LD9dRX0BxL22bHRt6/SJN
        uWElwAnltXsqLdfATPBoCqU=
X-Google-Smtp-Source: ABdhPJzXxCc5Z27UtlP/L0OJQyfw4lL0OQBW35y9EZ+Y87DGJO3eBPZfPrOw+S07A3MOGQO6vOT2Qw==
X-Received: by 2002:a2e:819a:0:b0:240:8b4c:ef10 with SMTP id e26-20020a2e819a000000b002408b4cef10mr12697127ljg.180.1645390000525;
        Sun, 20 Feb 2022 12:46:40 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id o14sm913955lfo.117.2022.02.20.12.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 12:46:40 -0800 (PST)
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
Subject: [PATCH v5 1/8] media: v4l2-ctrls: Add new V4L2_H264_DECODE_PARAM_FLAG_P/BFRAME flags
Date:   Sun, 20 Feb 2022 23:46:16 +0300
Message-Id: <20220220204623.30107-2-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220204623.30107-1-digetx@gmail.com>
References: <20220220204623.30107-1-digetx@gmail.com>
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

