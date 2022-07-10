Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F37456D00D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 18:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiGJQko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 12:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 12:40:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241E612AEE;
        Sun, 10 Jul 2022 09:40:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h17so4317491wrx.0;
        Sun, 10 Jul 2022 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZgK7bRkBFJLRMMGrwO6re8Cnn2zcwI8WXZ8S5IYZjuE=;
        b=MtzSSfkACFqAnssgDHTqhehwTc/UPvXLNwzuJ0QAnZ7U6ZrgqXepuZpId9JXhRpqjQ
         BdrQDFbq8RuSSbUTT0Y+EBzluPWb/RVl/s7d5gIR5uuxPxMLc5Qu3nf+J77DQIjfY+y/
         cD+c6qKvSk5L9TxugwYV8aKOpuxnHewE58bjiDLzStAldqXohs8SruQ1q0OZQH252RIt
         ouQ0hXMCku4cYRKUwBedxmfJbtlNp+dIAv5qm5x59aV2S6kS0iaZDiCj+5V4Mp4MQlZ5
         2sLfq4/QLMsbtrfbAOINn5m5Fj9gevFzyZNeDf7zyJ8lW0A6lVQmurayxN54LaCTlo7Q
         6mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZgK7bRkBFJLRMMGrwO6re8Cnn2zcwI8WXZ8S5IYZjuE=;
        b=ZyztJmUu0gAsHsmWN21m2xZgwl2xmUhdo4nl6NmlkKPEnztthhZDMNMV8ZpG1Y2DBV
         OY3VE/g8uSinBoUBsHLXr1RuOuI09uusvgPLFLN2jSv5WYiAawPVRVjb3RJeanPYWycB
         isnnrcBMilbamDYzDOAbM/t2WQIODJ8IUs6ziDbJKXZxM/eTjpKj1wDTlJzM3KlsosAW
         6chalbUKwHEkANvKl8r2QT0ybD1Pz/EbnQNtNDwd8/iOXWJr7CY2ARvcf4/eqt3vYqwG
         o7GjrWW65t7edlvWI788w7aH/VDaIRTeVQX/Q4Dx92/S7Wq4VczzGpl+Qotb2HIA3w1h
         xl2A==
X-Gm-Message-State: AJIora8G07ssnpeoClr5VODvAFLTX78h4WqVdx20lSz+DkGifh5GzjNZ
        PkR8vWcd/mfhcwl6K7BzXM76AyQrHJs=
X-Google-Smtp-Source: AGRyM1vrfsVX+1je17NxkkxBp+G7CGS0Hm4GBu41hWyBJhmgjCoxoX+hPfwLUOGshhXjn7WAcjdq8w==
X-Received: by 2002:a5d:64c1:0:b0:21b:981a:594e with SMTP id f1-20020a5d64c1000000b0021b981a594emr13202193wri.171.1657471240356;
        Sun, 10 Jul 2022 09:40:40 -0700 (PDT)
Received: from roman-Latitude-3400.globallogic.com ([195.234.74.2])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d40cb000000b0020d07d90b71sm3887123wrq.66.2022.07.10.09.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 09:40:39 -0700 (PDT)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org, megi@xff.cz,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [RFC] thermal/core: Disable uevent messages for cooling devices
Date:   Sun, 10 Jul 2022 19:40:26 +0300
Message-Id: <20220710164026.541466-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.34.1
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

During suspend, the big CPU cluster is turned off first while a little
is still running. This forcibly unregisters the cooling device which
sends a "REMOVE" uevent to all subscribers [1].

In case userspace netlink subscriber has set the EPOLLWAKEUP flag, a
wakeup event is triggered that causes suspend to be aborted.

Without this change, suspend doesn't work on PinePhone PRO with AOSP
userland.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5c238a8b599f1ae25eaeb08ad0e9e13e2b9eb023
Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 drivers/thermal/thermal_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cdc0552e8c42e..e6b21f2792a85 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -925,6 +925,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 	thermal_cooling_device_setup_sysfs(cdev);
+	dev_set_uevent_suppress(&cdev->device, true);
 	ret = device_register(&cdev->device);
 	if (ret)
 		goto out_kfree_type;
-- 
2.34.1

