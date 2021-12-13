Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52064737FA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243949AbhLMWuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243947AbhLMWuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:50:20 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB6C061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:50:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o20so57489968eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ipG1LSQW/9iSSyZPDhT+k/6HhSVjRHiJ4NqSSlt+/Q=;
        b=P54pk2ScxjqT1erEgAkw3DXcI3w/8DTUShx6W4nfWiJRVaTF5gt1TydA6z1Qi53XHS
         tSwg/SYixG593nPDc0YGoWtSEqHmFQjiwyQLZMyCOGz4pxKKWvxu151u2FMe6zu6CHRz
         ewky1NEjOYUV0sa1Emzr401Irp5Ij/jrnnntwkxb5S506fIeh+u1iNtj3cMz3iGXZMm/
         Ij/JwZZjaokl0zwFg/OkMkT+EG43/3G0b1Zg595s/N9QIgE/MkaGnXE3AEslIzOgZnd9
         mV15EXkh3z/v2ua1dMA7Is6pGeSlBaP3U9Fe33ON4srV+nWmFPuO9SMSct4K5Ii5x9qD
         yw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ipG1LSQW/9iSSyZPDhT+k/6HhSVjRHiJ4NqSSlt+/Q=;
        b=IIomRdU9NIEYZ2G9FL69q9+774d9bAAfIf9XkneKweQnkOOPZWBuGsFN1MT2LBC5L0
         OaF1yOUGs7Z9rnSlbSbWws7HusOP12xonW/SIrBk7J6GdwjBmGcY2nfv3XpqJDtDkBzp
         1fSdhLI3gInBpegKiUbGlCwSGRq0wzNDTsaXG8NYP230oK3T8Dh7ygI3FpwkM84cMl8I
         K8lQBIcmV/RY6568fzbbiX+kBucexX7TjdYFSY/tlg9TY414xbouiEfkVC6fzhD4GohS
         JXFgahHjdhlSos2YNIqF+iUpf9e2oDvka4OdheYGUDhJRQNhul1u+T1hTgSMEgaGNoGh
         6DWw==
X-Gm-Message-State: AOAM530Oo+cTyyPSS6HgCvZzwGR0qOYS9KZX3EGE6glb+SZOiSYVM7EU
        k+KXRhb/0jZhhxm/S2DKXB1pTP/43Sy+0g==
X-Google-Smtp-Source: ABdhPJz2VBMgM9w832l5AdMpUctZB2V9HaWMLRqF7VOMSvexz2Pn/o1U5WneCvxu9NsrPbtwMXJIZA==
X-Received: by 2002:a17:906:7e0a:: with SMTP id e10mr1461121ejr.404.1639435817774;
        Mon, 13 Dec 2021 14:50:17 -0800 (PST)
Received: from [192.168.1.15] (hst-221-97.medicom.bg. [84.238.221.97])
        by smtp.googlemail.com with ESMTPSA id e20sm578110ejl.189.2021.12.13.14.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 14:50:17 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v2] media: venus: Synchronize probe() between venus_core
 and enc/dec
To:     John Stultz <john.stultz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211029214833.2615274-1-tadeusz.struk@linaro.org>
 <YZ2x+xuvnHC48MHg@ripper>
 <CALAqxLV7YzuHLzNFSWawjpoJGb3WwO4bgnMN_5mWoHmB582kZw@mail.gmail.com>
 <CALAqxLWjK4h-ghF5s8qV6Q3Wp3K1N816dTfiLNatBTms6NDe3A@mail.gmail.com>
Message-ID: <fee96315-28cb-58a1-7f2d-eb82d9ecb56a@linaro.org>
Date:   Tue, 14 Dec 2021 00:50:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLWjK4h-ghF5s8qV6Q3Wp3K1N816dTfiLNatBTms6NDe3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 12/9/21 5:11 AM, John Stultz wrote:
> On Tue, Nov 30, 2021 at 8:49 PM John Stultz <john.stultz@linaro.org> wrote:
>> On Tue, Nov 23, 2021 at 7:29 PM Bjorn Andersson
>> <bjorn.andersson@linaro.org> wrote:
>>> Rather than trying to synchronize away the side effects of
>>> of_platform_populate() I think we should stop using it.
>>>
>>> I had the very same problem in the qcom_wcnss remoteproc driver and
>>> in below change I got rid of that by manually initializing a struct
>>> device for the child node. In the event that the child probe defer I
>>> would just probe defer the parent as well.
>>>
>>> 1fcef985c8bd ("remoteproc: qcom: wcnss: Fix race with iris probe")
>>>
>>> The change might look a little bit messy, but the end result it much
>>> cleaner than relying on various locks etc.
>>>
>>>
>>> But in the qcom_wcnss case I have a child _device_ because I need
>>> something to do e.g. regulator_get() on. I fail to see why venc and vdec
>>> are devices in the first place.
>>
>> I definitely agree with Bjorn that all this asynchronous component
>> probing feels overly complicated, and a rework is probably the better
>> solution.
>>
>> Though my only question is:  is someone planning to do this rework?
>>
>> In the meantime, Tadeusz' patch does resolve a *very* frequent boot
>> crash seen when the venus driver is enabled.
>> So Stanimir, should we consider merging this as a stop gap until the
>> larger probe rework is done?
> 
> Stanimir? Does the above sound reasonable?

Apologize for the delay.

I'd like to avoid one more mutex in the driver,  I think some reordering
in the .probe and changing the firmware_request API could help. I'll
spend some time to dig more deeply into the problem.

See untested patch below (I have to simulate firmware load from ufs
partition on Debian).

> 
> thanks
> -john
> 

-- 
regards,
Stan

From 9bfb69026374fa010d36680554e2634d5d435681 Mon Sep 17 00:00:00 2001
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Date: Tue, 14 Dec 2021 00:45:18 +0200
Subject: [PATCH] venus: WIP: Rework and reorder firmware load

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c     |  8 +++----
 drivers/media/platform/qcom/venus/core.h     |  2 ++
 drivers/media/platform/qcom/venus/firmware.c | 22 +++++++++++++++++++-
 drivers/media/platform/qcom/venus/vdec.c     |  3 ++-
 drivers/media/platform/qcom/venus/venc.c     |  3 ++-
 5 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c
b/drivers/media/platform/qcom/venus/core.c
index 877eca125803..7f65b08b2bac 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -344,10 +344,6 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_runtime_disable;

-	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
-	if (ret)
-		goto err_runtime_disable;
-
 	ret = venus_firmware_init(core);
 	if (ret)
 		goto err_of_depopulate;
@@ -372,6 +368,10 @@ static int venus_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_venus_shutdown;

+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		goto err_venus_shutdown;
+
 	ret = pm_runtime_put_sync(dev);
 	if (ret) {
 		pm_runtime_get_noresume(dev);
diff --git a/drivers/media/platform/qcom/venus/core.h
b/drivers/media/platform/qcom/venus/core.h
index 7c3bac01cd49..6455efb35168 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -182,6 +182,8 @@ struct venus_core {
 	atomic_t insts_count;
 	unsigned int state;
 	struct completion done;
+	struct completion fwload_done;
+	bool fwload_success;
 	unsigned int error;
 	unsigned long sys_error;
 	wait_queue_head_t sys_err_done;
diff --git a/drivers/media/platform/qcom/venus/firmware.c
b/drivers/media/platform/qcom/venus/firmware.c
index 14b6f1d05991..d523fbeb9d56 100644
--- a/drivers/media/platform/qcom/venus/firmware.c
+++ b/drivers/media/platform/qcom/venus/firmware.c
@@ -76,6 +76,14 @@ int venus_set_hw_state(struct venus_core *core, bool
resume)
 	return 0;
 }

+static void firmware_async_load(const struct firmware *fw, void *context)
+{
+	struct venus_core *core = context;
+
+	core->fwload_success = true;
+	complete(&core->fwload_done);
+}
+
 static int venus_load_fw(struct venus_core *core, const char *fwname,
 			 phys_addr_t *mem_phys, size_t *mem_size)
 {
@@ -101,10 +109,22 @@ static int venus_load_fw(struct venus_core *core,
const char *fwname,
 	if (ret)
 		goto err_put_node;

-	ret = request_firmware(&mdt, fwname, dev);
+	init_completion(&core->fwload_done);
+	core->fwload_success = false;
+
+	ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOUEVENT, fwname,
+				      dev, GFP_KERNEL, core,
+				      firmware_async_load);
 	if (ret < 0)
 		goto err_put_node;

+	wait_for_completion(&core->fwload_done);
+
+	if (!core->fwload_success) {
+		ret = -ENOENT;
+		goto err_put_node;
+	}
+
 	fw_size = qcom_mdt_get_size(mdt);
 	if (fw_size < 0) {
 		ret = fw_size;
diff --git a/drivers/media/platform/qcom/venus/vdec.c
b/drivers/media/platform/qcom/venus/vdec.c
index 91da3f509724..0e718d24a3b3 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1718,6 +1718,8 @@ static int vdec_probe(struct platform_device *pdev)
 	if (!vdev)
 		return -ENOMEM;

+	core->dev_dec = dev;
+
 	strscpy(vdev->name, "qcom-venus-decoder", sizeof(vdev->name));
 	vdev->release = video_device_release;
 	vdev->fops = &vdec_fops;
@@ -1731,7 +1733,6 @@ static int vdec_probe(struct platform_device *pdev)
 		goto err_vdev_release;

 	core->vdev_dec = vdev;
-	core->dev_dec = dev;

 	video_set_drvdata(vdev, core);
 	pm_runtime_set_autosuspend_delay(dev, 2000);
diff --git a/drivers/media/platform/qcom/venus/venc.c
b/drivers/media/platform/qcom/venus/venc.c
index 84bafc3118cc..1b3fb927eb16 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1448,6 +1448,8 @@ static int venc_probe(struct platform_device *pdev)
 	if (!vdev)
 		return -ENOMEM;

+	core->dev_enc = dev;
+
 	strscpy(vdev->name, "qcom-venus-encoder", sizeof(vdev->name));
 	vdev->release = video_device_release;
 	vdev->fops = &venc_fops;
@@ -1461,7 +1463,6 @@ static int venc_probe(struct platform_device *pdev)
 		goto err_vdev_release;

 	core->vdev_enc = vdev;
-	core->dev_enc = dev;

 	video_set_drvdata(vdev, core);
 	pm_runtime_set_autosuspend_delay(dev, 2000);
-- 
2.25.1

