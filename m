Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C06E46AF3E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 01:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378522AbhLGAmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 19:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378477AbhLGAmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 19:42:12 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CEC0613FE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:38:43 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g14so49504895edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 16:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXKIR4ShytX0tALgioiRUa/C0O1E2qZGhrAtM8+wVCU=;
        b=VmcRrIhZbEKMr6Uyl2IeEUz7d2vsgn86w1wsvjwb+gIRd2ld1Yby8+loXnmkNeotQz
         7Fj7s2AyudylTzYQ49DbsQubu6vTKOPDSHKxbOCocbqHevAeWaehK9HutsCMb/eatgna
         I3P3Ab6K3TMLqmBfq00eii2NsTm2/uMNCGaNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXKIR4ShytX0tALgioiRUa/C0O1E2qZGhrAtM8+wVCU=;
        b=nDC0Vp04FW/N/IH5cVVVFCG1Walsoh/57UmBYhdUa8b15ZEOW3XQVKnqk6ZbF4p+uQ
         gy84tuRjQbF4CEPV6zmolMnR7FQbLYaux8V0u37QrrywdI1OnJTEfI+CtjakqN7MyJLf
         CHee0tKG5MeI565fim9Zp9LqelUpkvzaEXno4xJ/62ZF/SmbU1BDSXzC+RpitGkX+D+v
         EtxpIR3e+F5xr4oYHDFWmULCSF2NW8Lk4iW07J77BL4BgnJU2S1fPconhT14xKdsGSHs
         nqMG5CollnkeaKtjEHBtiiHXMY8dD/zaqvlQ8z8W4zuDejzPHNT/oG4SaPVEo7sue8vb
         i8jQ==
X-Gm-Message-State: AOAM531pWyF7SNatMv2+s3g7wlpQZyAfhcq0JUJJ8Fn/d9aMjKwo3Go6
        0l2fhp24HmSRirvZv+ToUwAbaQ==
X-Google-Smtp-Source: ABdhPJz//31u0B873vqMLuqK/8zZqYenWGLqXSani8DfAMuVN6VDXAwU47iKA3ruvGE3bbpv6BxPSw==
X-Received: by 2002:a05:6402:348c:: with SMTP id v12mr3852752edc.170.1638837521896;
        Mon, 06 Dec 2021 16:38:41 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hg19sm7422531ejc.1.2021.12.06.16.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 16:38:41 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/4] uvc: Restore old vdev name
Date:   Tue,  7 Dec 2021 01:38:36 +0100
Message-Id: <20211207003840.1212374-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have unique entity names, we decided to change the name of
the video devices with their functionality.

This has resulted in some (all?) GUIs showing not useful names.

This patchset reverts the original patch and introduces a new one to
allow having different entity and vdev names.

Since some distros have ported the reverted patch to their stable
kernels, it would be great if we can get this sent asap, to avoid making
more people angry ;).

v2:
 - Add Documentation
 - Mark maybe unused variables as __maybe_unused
 - Add Suggested-by

Ricardo Ribalda (4):
  Revert "media: uvcvideo: Set unique vdev name based in type"
  media: v4l2-dev.c: Allow driver-defined entity names
  media: Documentation/driver-api: Document entity name
  media: uvcvideo: Set unique entity name based in type

 Documentation/driver-api/media/v4l2-dev.rst |  4 ++++
 drivers/media/usb/uvc/uvc_driver.c          | 14 +++++++++++---
 drivers/media/v4l2-core/v4l2-dev.c          |  4 +++-
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.34.1.400.ga245620fadb-goog

