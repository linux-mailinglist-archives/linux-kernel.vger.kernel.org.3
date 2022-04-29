Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD5A514AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376287AbiD2NlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376309AbiD2Nky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:40:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EF1CB02C;
        Fri, 29 Apr 2022 06:37:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 27DF61F46597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651239454;
        bh=kcEQjWB3+aoh/KNYmS+gc/t6zz5Iohch35uok/tdZ2g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ebK2702xHh6jZr+XuacSG3T6K77O0e6jE4yrdtu4TG85TlKoWWfyhRSUooxkXDMXR
         0OoI3Ng05ua+RkKFNWUxH4AKEsV2ra3A4nupIfjQHulZQbrn6NeJ3nCemO0i8EO37n
         Zy4XpKKUqXxOTV8OlHIP6DfbqvUFKinAR4IbQvSyfDWJSguh8+h9IFwVR4AczojijI
         fHPfWMfaBjbACP1E9gfPgSRultAXHSnBqumARBke0iTzk2dgTcyd8nlMhywjJYwjXY
         90Lw1KN5skaMwO/WgwifwowJDIbGtdpeo4AnFoss0MfbjjpxdBGDAD+TB59o8vj/XP
         k4LE+kVxfrPkg==
Message-ID: <5f252726-3757-b063-d34f-c76beaa5d31b@collabora.com>
Date:   Fri, 29 Apr 2022 15:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rpmsg: mtk_rpmsg: Fix circular locking dependency
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     bjorn.andersson@linaro.org, matthias.bgg@gmail.com,
        pihsun@chromium.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220114144737.375621-1-angelogioacchino.delregno@collabora.com>
 <20220428173148.GA2268704@p14s>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220428173148.GA2268704@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/04/22 19:31, Mathieu Poirier ha scritto:
> On Fri, Jan 14, 2022 at 03:47:37PM +0100, AngeloGioacchino Del Regno wrote:
>> During execution of the worker that's used to register rpmsg devices
>> we are safely locking the channels mutex but, when creating a new
>> endpoint for such devices, we are registering a IPI on the SCP, which
>> then makes the SCP to trigger an interrupt, lock its own mutex and in
>> turn register more subdevices.
>> This creates a circular locking dependency situation, as the mtk_rpmsg
>> channels_lock will then depend on the SCP IPI lock.
>>
>> [   18.014514]  Possible unsafe locking scenario:
>> [   18.014515]        CPU0                    CPU1
>> [   18.014517]        ----                    ----
>> [   18.045467]   lock(&mtk_subdev->channels_lock);
>> [   18.045474]                                lock(&scp->ipi_desc[i].lock);
>> [   18.228399]                                lock(&mtk_subdev->channels_lock);
>> [   18.228405]   lock(&scp->ipi_desc[i].lock);
>> [   18.264405]
> 
> I finally understand the problem, something that would have been impossible
> without the pastebin you provided in your latest email.  Please add the content
> of that pastebin to the changelog and send another revision (checkpatch
> warnings can be ignored).
> 

Thanks for giving it another look... I'll add a cover letter with the contents
of the pastebin to avoid possible confusion for anyone looking at the patch.

>>
>> To solve this, simply unlock the channels_lock mutex before calling
>> mtk_rpmsg_register_device() and relock it right after, as safety is
>> still ensured by the locking mechanism that happens right after
>> through SCP.
> 
> The integrity of the subdev->channels list is guaranteed by relocking the
> mutex, I'm not sure what "through SCP" adds to the sentence.

I'll clarify the commit message.

> 
>> Notably, mtk_rpmsg_register_device() does not even require locking.
>>
> 
> I don't agree with the above sentence - if locking doesn't happen in
> mtk_rpmsg_create_device(), there can be two CPUs accessing the list at the same
> time.
> 

That's right, I have largely underestimated that for some reason, sorry about that.

Regards,
Angelo

> Thanks,
> Mathieu
> 
