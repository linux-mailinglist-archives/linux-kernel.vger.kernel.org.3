Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241D2481BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbhL3LdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbhL3LdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:33:13 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EBCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 03:33:12 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id q3so21793618qvc.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NAb92aP3BvHX/H/r7xcS0pDvxqvrorYUGqTqAdSQus=;
        b=A9gJExEihB/bAGFoBMIBq18odmtsTOCydFD2wgMeuWGTGJ3MFb6CqvVl7rmzJptGby
         45SuFMl4GHtVNDMdIEezv4fpEfhXmJWSJrmsNZXt3EZoL1QFT8BwszUdJU/g1l0d9pHc
         XtSfHGfHRgiJnZUfSf1P8TaYErGPK/0gGC4qCSS4pMTeiZ/qCt9wrah1f3VMqO3ggNkS
         dswRWt+db55IzbzIJv8SjnWR4GmbqGK/FxMNjdrLVWiLweC/IO5OvCL0FxEWkOcRSzbH
         XcGQkyC9oC5gGhYxbOgXfe5uTOTmSpAq2Ugm9FDxN/nDaK6pjirB2SUKVmxPcgzk+MNA
         vIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NAb92aP3BvHX/H/r7xcS0pDvxqvrorYUGqTqAdSQus=;
        b=cHlvGuNouB/oE+C4lVVKEXxajPzeU8bkjgoJwhOqejMDrsQR+26Sbaz2mvdQGvWr4v
         hb3YLJcxUk4lCzZ0QfM1OZdyv1RnKulBHiTC+H387SmkEm77t80TIVwJQTxqHCJpxpbt
         mkN9ZLfLvVOJGf3K5ZAgc2Q7w7kegr0vD6bj5bhVxE42vfZY01trDp94KD32hRexGaKQ
         C0QXTfqenR5LSkFcMGpdOCcab/B66oUKJjC4Krje76HL//avygbN5D7svF08P2ab1Do6
         ZyYMBOOgJj8IbFLxVYXW1LiRnQlehnv5TgVplSFztZnVsM2uNQMecU3ialRg5kfc668o
         4lUg==
X-Gm-Message-State: AOAM532Hd58BM/kWnA8UH9oJmBo1aVPl8OnZzzFRqHxkHZIM+FfKSHiX
        fbw0P802Z1cOxipke4G4ZYI=
X-Google-Smtp-Source: ABdhPJym1DmSfFDOm0+uJkMnhCuNXQ/vZE1Hb0Km0uMhLyBPVYS1yLSZhyh+rXnBWdszqWcIzY3AJg==
X-Received: by 2002:a05:6214:2344:: with SMTP id hu4mr11691004qvb.55.1640863991767;
        Thu, 30 Dec 2021 03:33:11 -0800 (PST)
Received: from localhost.localdomain ([181.23.70.139])
        by smtp.gmail.com with ESMTPSA id v5sm20348559qkp.126.2021.12.30.03.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 03:33:11 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gascoar@gmail.com
Subject: [PATCH v2 3/3] staging: vc04_services: update TODO file
Date:   Thu, 30 Dec 2021 08:31:29 -0300
Message-Id: <3f560a75063a0bb744bb34c410e49f792d2c3d21.1640776340.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1640776340.git.gascoar@gmail.com>
References: <cover.1640776340.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no struct typedef remaining inside vc04_services/. Hence, remove the
task from the TODO file.

While at it, fix the items sequential numbering.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/TODO | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
index 39810ce017cd..241ca004735c 100644
--- a/drivers/staging/vc04_services/interface/TODO
+++ b/drivers/staging/vc04_services/interface/TODO
@@ -80,11 +80,7 @@ vchiq-core.ko and vchiq-dev.ko. This would also ease the upstreaming process.
 
 The code in vchiq_bcm2835_arm.c should fit in the generic platform file.
 
-12) Get rid of all the struct typedefs
-
-Most structs are typedefd, it's not encouraged in the kernel.
-
-13) Get rid of all non essential global structures and create a proper per
+11) Get rid of all non essential global structures and create a proper per
 device structure
 
 The first thing one generally sees in a probe function is a memory allocation
@@ -92,6 +88,6 @@ for all the device specific data. This structure is then passed all over the
 driver. This is good practice since it makes the driver work regardless of the
 number of devices probed.
 
-14) Clean up Sparse warnings from __user annotations. See
+12) Clean up Sparse warnings from __user annotations. See
 vchiq_irq_queue_bulk_tx_rx(). Ensure that the address of "&waiter->bulk_waiter"
 is never disclosed to userspace.
-- 
2.34.1

