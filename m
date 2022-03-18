Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C74DDC21
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiCROuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbiCROtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:49:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C52A32EAF43
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:47:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07B521515;
        Fri, 18 Mar 2022 07:47:49 -0700 (PDT)
Received: from [10.1.29.15] (e122027.cambridge.arm.com [10.1.29.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292833F7D7;
        Fri, 18 Mar 2022 07:47:46 -0700 (PDT)
Message-ID: <049f8b0c-7c3e-8ee1-5ae0-a4348278ee63@arm.com>
Date:   Fri, 18 Mar 2022 14:47:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 8/8] drm/panfrost: Switch to generic memory shrinker
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-9-dmitry.osipenko@collabora.com>
 <4e6256d0-a3c6-ba01-c31f-a5757b79a9ce@arm.com>
 <3dda45b8-1f49-eefd-0167-1f3c13b2c73f@collabora.com>
 <b8d74d79-7d49-658f-5e0b-4a5da4fa2afc@collabora.com>
Content-Language: en-GB
In-Reply-To: <b8d74d79-7d49-658f-5e0b-4a5da4fa2afc@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 14:41, Dmitry Osipenko wrote:
> 
> On 3/17/22 02:04, Dmitry Osipenko wrote:
>>
>> On 3/16/22 18:04, Steven Price wrote:
>>> On 14/03/2022 22:42, Dmitry Osipenko wrote:
>>>> Replace Panfrost's memory shrinker with a generic DRM memory shrinker.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> ---
>>> I gave this a spin on my Firefly-RK3288 board and everything seems to
>>> work. So feel free to add a:
>>>
>>> Tested-by: Steven Price <steven.price@arm.com>
>>>
>>> As Alyssa has already pointed out you need to remove the
>>> panfrost_gem_shrinker.c file. But otherwise everything looks fine, and
>>> I'm very happy to see the shrinker code gone ;)
>>
>> Awesome, thank you.
> 
> Steven, could you please tell me how exactly you tested the shrinker?
> 
> I realized that today's IGT doesn't have any tests for the Panfrost's
> madvise ioctl.
> 
> You may invoke "echo 2 > /proc/sys/vm/drop_caches" manually in order to
> trigger shrinker while 3d app is running actively (like a game or
> benchmark). Nothing crashing will be a good enough indicator that it
> works okay.
> 
> I may get an RK board next week and then will be able to test it by
> myself, so please don't hurry.

I have to admit it wasn't a very thorough test. I run glmark on the
board with the following hack:

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index b014dadcf51f..194dec00695a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -279,6 +279,14 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
        if (ret)
                goto out_cleanup_job;
 
+       {
+       struct shrink_control sc = {
+               .nr_to_scan = 1000
+       };
+       dev->shmem_shrinker->base.scan_objects(&dev->shmem_shrinker->base,
+                       &sc);
+       }
+
        ret = panfrost_job_push(job);
        if (ret)
                goto out_cleanup_job;

That hack was specifically because I had some doubts about the removal
of the 'gpu_usecount' counter and wanted to ensure that purging as the
job is submitted wouldn't cause problems.

The drop_caches file should also work AFAIK.

Steve
