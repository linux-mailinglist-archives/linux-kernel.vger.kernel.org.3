Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50F4D2E79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiCIL42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiCIL40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:56:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9352760078
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:55:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 8E7501F44A74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646826925;
        bh=PynJJsoLYdl1Gvc0xzkLN+51ws0jXntVzWj+p9ce160=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dhtEPY66d4f949FzrfR1Gz129VcXzngI9xCwPitlNnWdd/t1ySgyteRFbpRcI03Hr
         kGYqsPdcvyWV9vc8TrTHTapgcflALoPO0AP4fvXBOyQDp5PriQZqU2VuSy/sPCvFT2
         3L4WmNNQsf01RrZAC/C3oafVO+EByoZMbfmY+bjxawYde9QrkHUsWiaflrxixu0EXt
         jz9uVUsdPTPE2WwXgn5Idz0s5x5UyeoFKZc3Z3hb4WJSs605WkaDmUKYQX7ssc9NFH
         9mbbab1IPlEMnzF1mnz4z8cm4vSuH7tTnI/I0wCU5X5Z8vtx1xkpmNwxO1/A45ECij
         ICu6WWaVn4+Yg==
Message-ID: <caa9a2ea-d1b4-fa96-0e90-37a89aa0c000@collabora.com>
Date:   Wed, 9 Mar 2022 14:55:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel@lists.freedesktop.org, Dmitry Osipenko <digetx@gmail.com>
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <4ce1e172-799c-cba3-0a72-4a6fdf2c6d2f@suse.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <4ce1e172-799c-cba3-0a72-4a6fdf2c6d2f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 3/9/22 11:59, Thomas Zimmermann wrote:
> Hi
> 
> Am 08.03.22 um 14:17 schrieb Dmitry Osipenko:
>> Hello,
>>
>> This patchset introduces memory shrinker for the VirtIO-GPU DRM driver.
>> During OOM, the shrinker will release BOs that are marked as "not needed"
>> by userspace using the new madvise IOCTL. The userspace in this case is
>> the Mesa VirGL driver, it will mark the cached BOs as "not needed",
>> allowing kernel driver to release memory of the cached shmem BOs on
>> lowmem
>> situations, preventing OOM kills.
> 
> Virtio-gpu is build on top of GEM shmem helpers. I have a prototype
> patchset that adds a shrinker to these helpers. If you want to go
> further, you could implement something like that instead. Panfrost and
> lima also have their own shrinker and could certainly be converted to
> the gem-shmem shrinker.

I had a thought that it could be possible to unify shrinkers into a
common DRM framework. Could you please give me a link to yours prototype
patchset?
