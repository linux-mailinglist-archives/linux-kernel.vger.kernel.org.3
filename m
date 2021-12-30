Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CB9481A68
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhL3Hcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhL3Hco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:32:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534A8C061574;
        Wed, 29 Dec 2021 23:32:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q16so48814679wrg.7;
        Wed, 29 Dec 2021 23:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=dnl7F7ofGqHF6QeDzTBMKl07noHtejiBvVANKdLWEqc=;
        b=KOezF837K++3rSfxFAMIm1NiBpQyTCCO0CvKMAMgFgYR2FeaJ9M/tF5zCRUIowb+if
         ZhSQZfkLXYhbJEMZ0XV93Ix4RyVRviuGA8nj3l/I0lmMQ6l4napeERXdFCh2rHfojcEg
         6hbftAR2NNR0/X5nTiZ1/d5V3z/b6srShabh21jdS+eLFBS3IAengqbqOFWIK4z+r3V2
         qZOW3j9LfB2+7fXcUsdPlsP1v2H/e/AiQbMKfd/frw3I+O2v51eOgy3iuFAtN0vm49/V
         j9cPT5QT/hEk7b9s/f1O2jZrEIDb7Od1MG9BjlFglIeCyhpuVaBjes8+C6vsbn2/9QAi
         boxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dnl7F7ofGqHF6QeDzTBMKl07noHtejiBvVANKdLWEqc=;
        b=T9AUIMF18py3CBOHWK+KxNiOywTc7MZV0IkPCVoetsf9HtapIJwJIkTOdVAzXs4xNi
         VgrqVBrPJH9EphbyaX87ZI4lyuXjmqM4sL2BT2U0buShTzY/s+U9lZi+3tkb0zbcdzpi
         ow8tZICVIKz+zavfn6Kf+WkgWWCVD6xZAfH/2Z3xHq1ukwrC5sIIVfgQH5xcargcgvAr
         6eWgrm8xR8PUViYS0IdU3m2XnNEcJYA2P8XQ9jd6N169atcX1mPxDfimd46gl9TWJiU9
         2HAesiyMXAmPIHXkSrHaLN7i1ZTOseBFk/0UzgmIppr0ovDXliM1LX+i7EFsyfJgtrNi
         Kwww==
X-Gm-Message-State: AOAM532tr0aiz/xvKdXCfytUR8bYaehiPTI9V5MnLUH5pFYoa2nYg2ua
        g/Su26bjXvEnmvOT/fbDCdY=
X-Google-Smtp-Source: ABdhPJy0ONqFn84YMo8GdaBqP5/7AJt9x8NkLf+U3bdnK93aKdlIyTlO7swZjdq7uExUaKQtpfMKmg==
X-Received: by 2002:a05:6000:2a9:: with SMTP id l9mr24009882wry.71.1640849562756;
        Wed, 29 Dec 2021 23:32:42 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2626:5600:789b:54e9:fc28:95aa])
        by smtp.gmail.com with ESMTPSA id a198sm22864479wmd.42.2021.12.29.23.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 23:32:42 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] blk-iocost: drop selecting undefined BLK_RQ_IO_DATA_LEN
Date:   Thu, 30 Dec 2021 08:32:25 +0100
Message-Id: <20211230073225.30255-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cd006509b0a9 ("blk-iocost: account for IO size when testing
latencies") selects the non-existing config BLK_RQ_IO_DATA_LEN in
config BLK_CGROUP_IOCOST.

Hence, ./scripts/checkkconfigsymbols.py warns:

  BLK_RQ_IO_DATA_LEN
  Referencing files: block/Kconfig

Probably, this select is just some unintended left-over from an earlier
draft version; BLK_RQ_IO_DATA_LEN was never defined in any commit in the
repository. So, drop this dead select to an undefined config.

Fixes: cd006509b0a9 ("blk-iocost: account for IO size when testing latencies")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
first submission:
https://lore.kernel.org/all/20211112093728.3237-1-lukas.bulwahn@gmail.com/

Patch is already acked by Tejun.
Jens, please pick this quick minor clean-up patch. 

 block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index d5d4197b7ed2..80826e28d0d5 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -136,7 +136,6 @@ config BLK_CGROUP_FC_APPID
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP
-	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
 	help
 	Enabling this option enables the .weight interface for cost
-- 
2.17.1

