Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D734654F4EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381605AbiFQKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiFQKJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:09:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14DB2182A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:09:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cv13so1274211pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUh/bHw36MKI9KfeYCyLalDxvnkYkNzB5fpZd7noo7A=;
        b=EBcPCrvNrluTSrKM0n6wApN287TyqIr9nV0eEF20OBwFtM9Bej0q/bAUjf/svaLoVn
         Ai/CmuhHaA+QXb4hVeknvDmwAVQwHVG1EAWhtibEc0eSjLdnS1AzCYeYt2slCt75sh9t
         loaz7o7UhssdYICnUoit5N6TBY03YQtXr4juA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JUh/bHw36MKI9KfeYCyLalDxvnkYkNzB5fpZd7noo7A=;
        b=ppC4n4O3Z5ScRQW1FchwjWV+lTjPjU6vBT6aBdAa3ZxpRiTSV8RfZCdwYrId1kXdsw
         icsP2VppU7U4yE8lSMJO/PpNxR0XS3FUiocNkdvJgHueGueqruEU3oPhgWz15tpPwdKn
         dq85NH8Ks/lBemX/iaQ5Jso+sQ4gn8cfDefsSorfK3vDIdoVPWtZfo+PJoog5Qxepyyj
         3eU/DTuSVBRKzsu43IKRmZcWg3DC64eSG2UwOR5HFo2yU4/UvYHDt6k66TtuREgJS5Uc
         Oty8+aaZA04tH5yr0NN69FmVLcoeOMx5m4Yd0dCyXlJuaZDGH2JRSTNV2YjHhXMbtHlY
         qo9w==
X-Gm-Message-State: AJIora+EzDhdrv3GqTvGBePdIs0QYEPMcWAqS365z2aQnaAfwHH6rcga
        7sEMEgLJbSW8MAjpxpFr3Zoa9g==
X-Google-Smtp-Source: AGRyM1vR4p23EKYSOBmxfH5Y3pMbGolPl1H0MOWkXYoT2MFmzc0ACWYKnY2gHyd0rGFDz3Llpf+bkg==
X-Received: by 2002:a17:903:22d0:b0:164:ec0:178c with SMTP id y16-20020a17090322d000b001640ec0178cmr9145864plg.127.1655460580273;
        Fri, 17 Jun 2022 03:09:40 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:e616:b34a:9b5b:24ef])
        by smtp.gmail.com with ESMTPSA id o12-20020a62f90c000000b0051b4e53c487sm3337533pfh.45.2022.06.17.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 03:09:39 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Fei Shao <fshao@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: mt8186: Fix mutex double unlock in GPIO request
Date:   Fri, 17 Jun 2022 18:06:33 +0800
Message-Id: <20220617100632.1447811-1-fshao@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdep mechanism reveals an unbalanced unlocking on MT8186:

  [    2.993966] WARNING: bad unlock balance detected!
  [    2.993971] 5.15.46-421fef3b44d7-lockdep #16 Not tainted
  [    2.993978] -------------------------------------
  [    2.993983] kworker/u16:1/10 is trying to release lock (gpio_request_mutex) at:
  [    2.993994] [<ffffffdcd9adebf8>] mt8186_afe_gpio_request+0xf8/0x210
  [    2.994012] but there are no more locks to release!
  [    2.994017]
  [    2.994017] other info that might help us debug this:
  [    2.994022] 3 locks held by kworker/u16:1/10:
  [    2.994028]  #0: ffffff80c004a148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1a8/0x364
  [    2.994054]  #1: ffffffc0080d3d58 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1d0/0x364
  [    2.994074]  #2: ffffff80c12ab9a0 (&dev->mutex){....}-{3:3}, at: __device_attach+0x44/0x150
  [    2.994096]
  [    2.994096] stack backtrace:
  [    2.994102] CPU: 6 PID: 10 Comm: kworker/u16:1 Not tainted 5.15.46-421fef3b44d7-lockdep #16 a2af0e2c6b3eeab6799b5aa8091c1d05d3a7bbb1
  [    2.994113] Hardware name: Google Kingler board (DT)
  [    2.994120] Workqueue: events_unbound deferred_probe_work_func
  [    2.994130] Call trace:
  [    2.994135]  dump_backtrace+0x0/0x1d4
  [    2.994144]  show_stack+0x20/0x2c
  [    2.994152]  dump_stack_lvl+0x78/0x9c
  [    2.994163]  dump_stack+0x18/0x44
  [    2.994172]  print_unlock_imbalance_bug+0xf0/0xf4
  [    2.994184]  lock_release+0x150/0x388
  [    2.994193]  __mutex_unlock_slowpath+0x4c/0x1bc
  [    2.994202]  mutex_unlock+0x44/0x50
  [    2.994210]  mt8186_afe_gpio_request+0xf8/0x210
  [    2.994220]  mt8186_afe_gpio_init+0xcc/0x134
  [    2.994230]  mt8186_mt6366_rt1019_rt5682s_dev_probe+0x14c/0x220
  [    2.994238]  platform_probe+0xb0/0xd0
  [    2.994247]  really_probe+0xcc/0x2c8
  [    2.994253]  __driver_probe_device+0xbc/0xe8
  [    2.994264]  driver_probe_device+0x48/0xf0
  [    2.994271]  __device_attach_driver+0xa0/0xc8
  [    2.994278]  bus_for_each_drv+0x8c/0xd8
  [    2.994288]  __device_attach+0xc4/0x150
  [    2.994298]  device_initial_probe+0x1c/0x28
  [    2.994308]  bus_probe_device+0x3c/0xa0
  [    2.994318]  deferred_probe_work_func+0xa0/0xe0
  [    2.994325]  process_one_work+0x208/0x364
  [    2.994334]  worker_thread+0x288/0x3fc
  [    2.994343]  kthread+0x140/0x160
  [    2.994351]  ret_from_fork+0x10/0x20

The cause is that the mutex will be double unlocked if dai is unknown
during GPIO selection, and this patch fixes it.

Fixes: cfa9a966f12a ("ASoC: mediatek: mt8186: support gpio control in platform driver")

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 sound/soc/mediatek/mt8186/mt8186-afe-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
index 255ffba637d3..274c0c8ec2f2 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-gpio.c
@@ -230,7 +230,6 @@ int mt8186_afe_gpio_request(struct device *dev, bool enable,
 		sel = enable ? MT8186_AFE_GPIO_PCM_ON : MT8186_AFE_GPIO_PCM_OFF;
 		break;
 	default:
-		mutex_unlock(&gpio_request_mutex);
 		dev_err(dev, "%s(), invalid dai %d\n", __func__, dai);
 		goto unlock;
 	}
-- 
2.36.1.476.g0c4daa206d-goog

