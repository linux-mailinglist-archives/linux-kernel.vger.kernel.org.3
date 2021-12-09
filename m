Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9E46E27B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhLIGdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbhLIGdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:33:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70249C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 22:29:42 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id q17so3131857plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l70yrT2MnFH7bNPw1mTKeaVZEUJsCzdp2hTTSYAY8Ho=;
        b=G9PjGpIwWFcaeZ9f8ADTb/FlHKQkjX6igYz6ah6WZAInRXZD+vkwfQ1LOFhycuoA5c
         2QW5FPVY5C+vOPq/aJkB2+DeRiB6DZw2W/hpITZBWUc4NCoMv27ACwhwu4hW475e5JkT
         IwsLGkFZ6KmRXqwoPIh7S5iZ+DHKsleobUh5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l70yrT2MnFH7bNPw1mTKeaVZEUJsCzdp2hTTSYAY8Ho=;
        b=lsFRo/ncZZ4Ey6iof5YC60ICVcQz/3vtGxIRsCsWU5Dn533fng4JlaErZ0PlD2iHyn
         FxIZC/ZpGksFvt/fR2FO/UuTFzyjhSpTneqxPusXRgn8hNgst6Fj4Cs7uwIKAgcVVxzw
         fJBRTs51Zs/9XGIS2tDVxS/DZnAHOaMrIrKWhFLvxq5LEy2nJ3BCT5MhcD8egt13H8/k
         fTpvGUCL0giARqabHldQJnVs1ERXGjMd/1UXkuXMl4tTtP6SJT/iCwnkd5gb3E4Asa2e
         K+GcVbKlpWqv5E0cJecFnnBKeiixCjbU0HvBeQSGFYwmTWXKawmh5jiwv1Y7Lyk552Op
         xoMQ==
X-Gm-Message-State: AOAM533aVyY7k5cPrFIpI/sCSRpHhzoan0x51ODmRtMNXGR3qbN3I6so
        QGTlx5ZGb/hWus7FznDtfaoUhw==
X-Google-Smtp-Source: ABdhPJzUq9ICMOJkOd3j4HnkBJOY1s8yXIXSMq2SXIN0DuDNBSRr7qKyOZ1Svq/OniclaWGRN+PRJQ==
X-Received: by 2002:a17:902:8214:b0:142:61cf:7be with SMTP id x20-20020a170902821400b0014261cf07bemr65238289pln.0.1639031381883;
        Wed, 08 Dec 2021 22:29:41 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:edb5:3ef8:a855:9380])
        by smtp.gmail.com with ESMTPSA id h20sm4158955pgh.13.2021.12.08.22.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 22:29:41 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: docs: vidioc-dqbuf: State all remaining fields are filled by driver
Date:   Thu,  9 Dec 2021 14:29:25 +0800
Message-Id: <20211209062926.991516-1-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The specification for VIDIOC_DQBUF is slightly ambiguous on what fields
of |struct v4l2_buffer| is filled by the driver.

Reword it so things are clear: the driver fills in all remaining fields
not specified to be filled in by userspace applications.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/userspace-api/media/v4l/vidioc-qbuf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-qbuf.rst b/Documentation/userspace-api/media/v4l/vidioc-qbuf.rst
index 77e0747a6d28..e4b3d9beb9ab 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-qbuf.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-qbuf.rst
@@ -125,7 +125,7 @@ Applications call the ``VIDIOC_DQBUF`` ioctl to dequeue a filled
 queue. They just set the ``type``, ``memory`` and ``reserved`` fields of
 a struct :c:type:`v4l2_buffer` as above, when
 ``VIDIOC_DQBUF`` is called with a pointer to this structure the driver
-fills the remaining fields or returns an error code. The driver may also
+fills all remaining fields or returns an error code. The driver may also
 set ``V4L2_BUF_FLAG_ERROR`` in the ``flags`` field. It indicates a
 non-critical (recoverable) streaming error. In such case the application
 may continue as normal, but should be aware that data in the dequeued
-- 
2.34.1.400.ga245620fadb-goog

