Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DA44617D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354640AbhK2OUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:20:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43392 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243825AbhK2OSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:18:20 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9B0811F44680
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638195300; bh=qg0ogrpDEw7JPiv8EIlq4c9NL0fyYtw+4YIjCYhjohM=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=IbTiE2av+7ihv0Qq9SkHZc2960kgW1bDv5Y9iGihVQFz6IjoUilrYSku9yJtwLhOn
         GtiOrcTSZP1KwdxCklTZWVFd9zNdBMvsCw7Wzr/S9FIw2lOXhp5sJi0CVnWlrnwjj7
         J2KMKlPvhcGnlrI9v8TxzXQUkn9+jA+p/npimhp6aJdSV1FBm0SeShc+a/cMl2B9kj
         C2RqBMpIvyYb/wXEqv+sLCk7rC3teGaG/9busDeEQuj7HwKRwSPh6MELP6fmFTaBG1
         kKSOlDjWlaRx54vzfbVICO5ltEnKJExlwm612kbDKF/n1jEMd1Rxfuu12LU/JcIkWo
         fsx3oYHza5R2g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/msm: Initialize MDSS irq domain at probe time
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, robdclark@gmail.com
Cc:     sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        maxime@cerno.tech, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        jami.kettunen@somainline.org
References: <20211125150947.354076-1-angelogioacchino.delregno@collabora.com>
 <bf1540f1-4a9f-a9d6-d487-929107c487fd@linaro.org>
Message-ID: <9a0158ae-a3b1-21b2-1ba3-82d4901eb873@collabora.com>
Date:   Mon, 29 Nov 2021 15:14:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bf1540f1-4a9f-a9d6-d487-929107c487fd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/11/21 03:20, Dmitry Baryshkov ha scritto:
> Hi,
> 
> On 25/11/2021 18:09, AngeloGioacchino Del Regno wrote:
>> Since commit 8f59ee9a570c ("drm/msm/dsi: Adjust probe order"), the
>> DSI host gets initialized earlier, but this caused unability to probe
>> the entire stack of components because they all depend on interrupts
>> coming from the main `mdss` node (mdp5, or dpu1).
>>
>> To fix this issue, also anticipate probing mdp5 or dpu1 by initializing
>> them at msm_pdev_probe() time: this will make sure that we add the
>> required interrupt controller mapping before dsi and/or other components
>> try to initialize, finally satisfying the dependency.
>>
>> While at it, also change the allocation of msm_drm_private to use the
>> devm variant of kzalloc().
>>
>> Fixes: 8f59ee9a570c ("drm/msm/dsi: Adjust probe order")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> I have been thinking about this. I do not feel that this is the correct approach. 
> Currently DRM device exists only when all components are bound. If any of the 
> subdevices is removed, corresponding component is delteted (and thus all components 
> are unbound), the DRM device is taken down. This results in the state cleanup, 
> userspace notifications, etc.
> 
> With your changes, DRM device will continue to exist even after one of subdevices 
> is removed. This is not an expected behaviour, since subdrivers do not perform full 
> cleanup, delegating that to DRM device takedown.
> 
> I suppose that proper solution would be to split msm_drv.c into into:
> - generic components & drm code to be called from mdp4/mdp5/dpu driver (making 
> mdp4, mdp5 or dpu1 the components master)
> 
> - bare mdss driver, taking care only about IRQs, OF devices population - calling 
> proper mdss_init/mdss_destroy functions. Most probably we can drop this part 
> altogether and just make md5_mdss.c/dpu_mdss.c proper platform drivers.
> 


Hmm... getting a better look on how things are structured... yes, I mostly agree
with you, though I'm not sure about making MDP{4,5}/DPU1 the component master; that
would result in a major change in drm-msm, which may be "a bit too much".

Don't misunderstand me here, please, major changes are fine - but I feel urgency
to get this bug solved ASAP (since drm-msm is currently broken at least for drm 
bridges) and, if we do anything major, that would require a very careful slow
review process that will leave this driver broken for a lot of time.

I actually tried something else that "simplifies" the former approach, so here's
my proposal:
* we introduce {mdp5,dpu}_mdss_early_init(struct device, struct msm_drm_private)
* allocate only msm_drm_private in msm_pdev_probe, leaving the drm_dev_alloc call
   into msm_drm_init(), so that the drm_dev_put() stays in msm_drm_uninit()
* pass msm_drm_private as drvdata instead of drm_device
* change all the drvdata users to get drm_device from priv->dev, instead of getting
   msm_drm_private from drm_device->dev_private (like many other drm drivers are
   currently doing)

This way, we keep the current flow of creating the DRM device at msm_drm_init time
and tearing it down at msm_drm_unbind time, solving the issue that you are
describing.

If you're okay with this kind of approach, I have two patches here that are 95%
ready, can finish them off and send briefly.

Though, something else must be noted here... in the last mail where I'm pasting
a crash that happens when running 'rmmod panel_edp ti_sn65dsi86', I have implied
that this is happening due to the patch that I've sent: after some more research,
I'm not convinced anymore that this is a consequence of that. That crash may not
be related to my fix at all, but to something else (perhaps also related to commit
8f59ee9a570c, the one that we're fixing here).

Of course, that crash still happens even with the approach that I've just proposed.


Looking forward for your opinion!

Cheers,
- Angelo
