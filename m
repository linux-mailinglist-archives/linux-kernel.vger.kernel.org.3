Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1F49EEA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbiA0XJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344400AbiA0XIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:08:50 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94967C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:50 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id u130so4372414pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EE6yOukYiRv5t8m4wLbwnB8xsnP3xhP8Res4dSCKaao=;
        b=nmRFGuUfVGO1KN+i396jwFdqW3ji1pT8oIqYTB5EuvvDuDjJ4JLEpzIqppQ63Ye9oy
         hIC7Gfe2HCmAYKlFN7ntRE0NoWVXbgljdPNyr9JIyCzAFu3DbwqJUQ5DfovNWtpqnxdG
         58KCpRNpof8Q2dQeySnSxQSVVVH/YetiHbpPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EE6yOukYiRv5t8m4wLbwnB8xsnP3xhP8Res4dSCKaao=;
        b=R5KtuG9LdOPvYUvNXBtspx4+mE03EntfIkGr1YWFKsWSdx5YmjszPhni7S2AN/2dRg
         RNzYwvMawfiNxDXy4xEXsXTmgX/iILR5IF8p2qIbRhvxkM9EOKtevsLSBfhGQWHsj5N4
         SpW/OnYdQa4MLTeYwA1SXigVp4wRc493KAUscHpdhpkP/8/P4CPcJIeJvfPFinO/4/Fh
         TltK0v0+P7BmNTz2drAhoEG2aF/zM7zQxOSg9225SwNJi98bA8BG/DcbD2fZdd+xL8n/
         gdooRWS4S4icEe2URlB2T92DWmbS2OH6tPhxDm0icAyG6Wo8wQFBW4hiXCfJ7cJPqb83
         z1rQ==
X-Gm-Message-State: AOAM5308wuMQJ/0gCLTEMi7KE/pQ+GEznQr9hWUz2Qw+UxhvUnYCjjs8
        l4ERqOGNZ/05iX1IjLLQmWK2mg==
X-Google-Smtp-Source: ABdhPJz2hxjAYMq7nKYFqCN7bLNZ95pkrVKsFwO5nn2OivAjhokfFleQHjW/LAwoP5kPOvqwcxld4Q==
X-Received: by 2002:a65:6951:: with SMTP id w17mr4482809pgq.108.1643324930151;
        Thu, 27 Jan 2022 15:08:50 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id v20sm5384419pfu.155.2022.01.27.15.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:49 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 13/15] PM / devfreq: rk3399_dmc: Disable edev on remove()
Date:   Thu, 27 Jan 2022 15:07:24 -0800
Message-Id: <20220127150615.v2.13.I1476960b2586441beaef21dca4feb3ecc067f768@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127230727.3369358-1-briannorris@chromium.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise we hit an unablanced enable-count when unbinding the DFI
device:

[ 1279.659119] ------------[ cut here ]------------
[ 1279.659179] WARNING: CPU: 2 PID: 5638 at drivers/devfreq/devfreq-event.c:360 devfreq_event_remove_edev+0x84/0x8c
...
[ 1279.659352] Hardware name: Google Kevin (DT)
[ 1279.659363] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
[ 1279.659371] pc : devfreq_event_remove_edev+0x84/0x8c
[ 1279.659380] lr : devm_devfreq_event_release+0x1c/0x28
...
[ 1279.659571] Call trace:
[ 1279.659582]  devfreq_event_remove_edev+0x84/0x8c
[ 1279.659590]  devm_devfreq_event_release+0x1c/0x28
[ 1279.659602]  release_nodes+0x1cc/0x244
[ 1279.659611]  devres_release_all+0x44/0x60
[ 1279.659621]  device_release_driver_internal+0x11c/0x1ac
[ 1279.659629]  device_driver_detach+0x20/0x2c
[ 1279.659641]  unbind_store+0x7c/0xb0
[ 1279.659650]  drv_attr_store+0x2c/0x40
[ 1279.659663]  sysfs_kf_write+0x44/0x58
[ 1279.659672]  kernfs_fop_write_iter+0xf4/0x190
[ 1279.659684]  vfs_write+0x2b0/0x2e4
[ 1279.659693]  ksys_write+0x80/0xec
[ 1279.659701]  __arm64_sys_write+0x24/0x30
[ 1279.659714]  el0_svc_common+0xf0/0x1d8
[ 1279.659724]  do_el0_svc_compat+0x28/0x3c
[ 1279.659738]  el0_svc_compat+0x10/0x1c
[ 1279.659746]  el0_sync_compat_handler+0xa8/0xcc
[ 1279.659758]  el0_sync_compat+0x188/0x1c0
[ 1279.659768] ---[ end trace cec200e5094155b4 ]---

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 - New patch

 drivers/devfreq/rk3399_dmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index f778564cab49..fca9fcbd4249 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -452,6 +452,8 @@ static int rk3399_dmcfreq_remove(struct platform_device *pdev)
 {
 	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(&pdev->dev);
 
+	devfreq_event_disable_edev(dmcfreq->edev);
+
 	/*
 	 * Before remove the opp table we need to unregister the opp notifier.
 	 */
-- 
2.35.0.rc0.227.g00780c9af4-goog

