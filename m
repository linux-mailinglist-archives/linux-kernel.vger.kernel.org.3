Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4449489F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbiAJSrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbiAJSrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:47:45 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDA0C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:47:44 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h1so13285649pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rLNNTam0GGSuTPyyVz1PzDH77pSBcTTKBVr91Cfs40=;
        b=Uoh7XeUXB53SMI5MmhJjyywZINMKK+fW95UVEhlKaD5KIHCB0cJoNpiiMzAUhu72hI
         qAgNgBt2717VdpCPmaynmdVRlg0Jitx8iIolBGyoC+C4K0jDCKtPlwT6uxCBmpWsleDW
         RJUMlJw1vM09Dz2ZxU4WSuFUnJEZ3UBW1QD24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rLNNTam0GGSuTPyyVz1PzDH77pSBcTTKBVr91Cfs40=;
        b=k3au6fllnx6NcebGeD8wUHmoDImQ2Olw6U7IoSuWaooBAaE/NXASdhlT/t5q+ebUHh
         g4pVMo3A6q2i1eS0Dh//eERQYphaQ54Ci14s4AbWpovZ0MnARzuxmXFffSmlIzWvgM1N
         hGAEa9OwITE0W+WTaxNZayH1Vt1Pt8K6z2Md64R+dJPGp+8hedv3NgCHaAbrIrZ9THu9
         5PsEi40JAYCrgcyTwT7D0hgBrii4hkO8OgSYXkw3oVzfKKLAwpszm74tDcC4h2bNbURl
         7CM9J4AEX72/Y51/3qHzJ1ByO4MksozLW7aZe72aHH0ZlkdoLHxy7kvgIubqdF1v4T7b
         geQg==
X-Gm-Message-State: AOAM530xQbOSsVFkNf6lruglCe7eVRNKkAoch3HGg279r9tn8gGGUCS4
        oC8bYV5iQX0kMJP2WDE2COznUA==
X-Google-Smtp-Source: ABdhPJzGcI/pzbdJgE6UpbLi6Ea8+bFNov9DkpzFKV0156JTZbqgDhJiHNNy99sc8Fv2zLcrMKIdJg==
X-Received: by 2002:a05:6a00:1249:b0:4bb:4a31:1e0a with SMTP id u9-20020a056a00124900b004bb4a311e0amr858625pfi.81.1641840464396;
        Mon, 10 Jan 2022 10:47:44 -0800 (PST)
Received: from localhost ([2620:15c:202:201:470e:3451:3aa4:4b43])
        by smtp.gmail.com with UTF8SMTPSA id l2sm7332363pfe.189.2022.01.10.10.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 10:47:43 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH v6 1/2] rpmsg: char: Fix race between the release of rpmsg_ctrldev and cdev
Date:   Mon, 10 Jan 2022 10:47:36 -0800
Message-Id: <20220110104706.v6.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sujit Kautkar <sujitka@chromium.org>

struct rpmsg_ctrldev contains a struct cdev. The current code frees
the rpmsg_ctrldev struct in rpmsg_ctrldev_release_device(), but the
cdev is a managed object, therefore its release is not predictable
and the rpmsg_ctrldev could be freed before the cdev is entirely
released, as in the backtrace below.

[   93.625603] ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x7c
[   93.636115] WARNING: CPU: 0 PID: 12 at lib/debugobjects.c:488 debug_print_object+0x13c/0x1b0
[   93.644799] Modules linked in: veth xt_cgroup xt_MASQUERADE rfcomm algif_hash algif_skcipher af_alg uinput ip6table_nat fuse uvcvideo videobuf2_vmalloc venus_enc venus_dec videobuf2_dma_contig hci_uart btandroid btqca snd_soc_rt5682_i2c bluetooth qcom_spmi_temp_alarm snd_soc_rt5682v
[   93.715175] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G    B             5.4.163-lockdep #26
[   93.723855] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
[   93.730055] Workqueue: events kobject_delayed_cleanup
[   93.735271] pstate: 60c00009 (nZCv daif +PAN +UAO)
[   93.740216] pc : debug_print_object+0x13c/0x1b0
[   93.744890] lr : debug_print_object+0x13c/0x1b0
[   93.749555] sp : ffffffacf5bc7940
[   93.752978] x29: ffffffacf5bc7940 x28: dfffffd000000000
[   93.758448] x27: ffffffacdb11a800 x26: dfffffd000000000
[   93.763916] x25: ffffffd0734f856c x24: dfffffd000000000
[   93.769389] x23: 0000000000000000 x22: ffffffd0733c35b0
[   93.774860] x21: ffffffd0751994a0 x20: ffffffd075ec27c0
[   93.780338] x19: ffffffd075199100 x18: 00000000000276e0
[   93.785814] x17: 0000000000000000 x16: dfffffd000000000
[   93.791291] x15: ffffffffffffffff x14: 6e6968207473696c
[   93.796768] x13: 0000000000000000 x12: ffffffd075e2b000
[   93.802244] x11: 0000000000000001 x10: 0000000000000000
[   93.807723] x9 : d13400dff1921900 x8 : d13400dff1921900
[   93.813200] x7 : 0000000000000000 x6 : 0000000000000000
[   93.818676] x5 : 0000000000000080 x4 : 0000000000000000
[   93.824152] x3 : ffffffd0732a0fa4 x2 : 0000000000000001
[   93.829628] x1 : ffffffacf5bc7580 x0 : 0000000000000061
[   93.835104] Call trace:
[   93.837644]  debug_print_object+0x13c/0x1b0
[   93.841963]  __debug_check_no_obj_freed+0x25c/0x3c0
[   93.846987]  debug_check_no_obj_freed+0x18/0x20
[   93.851669]  slab_free_freelist_hook+0xbc/0x1e4
[   93.856346]  kfree+0xfc/0x2f4
[   93.859416]  rpmsg_ctrldev_release_device+0x78/0xb8
[   93.864445]  device_release+0x84/0x168
[   93.868310]  kobject_cleanup+0x12c/0x298
[   93.872356]  kobject_delayed_cleanup+0x10/0x18
[   93.876948]  process_one_work+0x578/0x92c
[   93.881086]  worker_thread+0x804/0xcf8
[   93.884963]  kthread+0x2a8/0x314
[   93.888303]  ret_from_fork+0x10/0x18

The cdev_device_add/del() API was created to address this issue
(see commit 233ed09d7fda), use it instead of cdev add/del().

Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes in v6:
- none

Changes in v5:
- added 'Fixes' tag
- added 'Reviewed-by' tags from Mathieu and Bjorn

Changes in v4:
- call cdev_device_del() from rpmsg_chrdev_remove() instead of
  rpmsg_ctrldev_release_device()
- updated subject (was: "rpmsg: glink: Update cdev add/del API in
  rpmsg_ctrldev_release_device()")
- updated commit message
- replaced backtrace in commit message with one that doesn't have
  a dump_backtrace() call

Changes in v3:
- Remove unecessary error check as per Matthias's comment

Changes in v2:
- Fix typo in commit message

 drivers/rpmsg/rpmsg_char.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 2bebc9b2d163..ba85f5d11960 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -461,7 +461,6 @@ static void rpmsg_ctrldev_release_device(struct device *dev)
 
 	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
 	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
-	cdev_del(&ctrldev->cdev);
 	kfree(ctrldev);
 }
 
@@ -496,19 +495,13 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
 	dev->id = ret;
 	dev_set_name(&ctrldev->dev, "rpmsg_ctrl%d", ret);
 
-	ret = cdev_add(&ctrldev->cdev, dev->devt, 1);
+	ret = cdev_device_add(&ctrldev->cdev, &ctrldev->dev);
 	if (ret)
 		goto free_ctrl_ida;
 
 	/* We can now rely on the release function for cleanup */
 	dev->release = rpmsg_ctrldev_release_device;
 
-	ret = device_add(dev);
-	if (ret) {
-		dev_err(&rpdev->dev, "device_add failed: %d\n", ret);
-		put_device(dev);
-	}
-
 	dev_set_drvdata(&rpdev->dev, ctrldev);
 
 	return ret;
@@ -534,7 +527,7 @@ static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
 	if (ret)
 		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
 
-	device_del(&ctrldev->dev);
+	cdev_device_del(&ctrldev->cdev, &ctrldev->dev);
 	put_device(&ctrldev->dev);
 }
 
-- 
2.34.1.575.g55b058a8bb-goog

