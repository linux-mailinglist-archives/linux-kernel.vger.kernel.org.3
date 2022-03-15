Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C68F4D9BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348532AbiCONMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346906AbiCONME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:12:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0F351325
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:10:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 777951F42E0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647349851;
        bh=33AAkH9s29H6uygjWgaoSJbflOjcm0qgg2dEz6pYJB4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VJHjRw8IfW1HVBKHMW9GLkJCc7xHIhrvzaI+s1rr8QXFUxZmpuOMjzZbz9Ar/B4mY
         yM1moo7Iz5YiWmbnIF/lA3altQ9chKwiHviyDO6XuunEiI+oCBeCjFJ88xKwMgCvYy
         TxTAya+AdyNA2M1qrqFnktGLxR9ca/xEZu9qZ5LKWz56b6Rb0wT6qm8gqdx17BRfX8
         x5sTIWIvj0Um6TYNjAabDQSAYfn61lokAA43yFBGg34U0gN5HWydRJMEFo1Ly+0A3h
         HfL9iqdcDbl0i4S6dhtMGCvtVw4e88fL2VseP0XqK03pg/TsNHrL+wPeH5kZ11yVN6
         SWsGIWYsGN/og==
Message-ID: <fa7b0191-b9e0-de3a-22c1-8513195af426@collabora.com>
Date:   Tue, 15 Mar 2022 16:10:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 0/8] Add memory shrinker to VirtIO-GPU DRM driver
Content-Language: en-US
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <CACvgo50Fxn6D1d2_20etnL1TWfNkzJFydyDgr6DwGKFoxzg0_A@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CACvgo50Fxn6D1d2_20etnL1TWfNkzJFydyDgr6DwGKFoxzg0_A@mail.gmail.com>
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

On 3/15/22 15:47, Emil Velikov wrote:
> On Mon, 14 Mar 2022 at 22:44, Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
> 
>> Dmitry Osipenko (8):
>>   drm/virtio: Correct drm_gem_shmem_get_sg_table() error handling
>>   drm/virtio: Check whether transferred 2D BO is shmem
>>   drm/virtio: Unlock GEM reservations in error code path
> 
> These three are legitimate fixes that we want regardless of the shrinker.
> 
> Please add the respective "Fixes" tag, so they find their way in the
> stable trees. With that, them 3 are:
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

Thank you, I already added stable tag to the first patch. The other
patches aren't critical for the stable kernels, IMO, but we can tag them
too for completeness. I'll do in v3.
