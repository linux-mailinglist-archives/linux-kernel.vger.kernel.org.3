Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6954DB31A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiCPOZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358065AbiCPOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:25:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A95229CA2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:23:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 7C6C51F446BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647440634;
        bh=/+1jMsTuGfyM9tAc0LJ0oAzRyZbFMVXpcUs37THZdNA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ay2xIE3SmlC7qBGaqVOyicXDU1zXPcsq9e/mJbym99HPurDWneWzgRyrOxaIQ4ok9
         GvbA+fV8OGVKgoGCwstBkv/ZAvMlFAaHJnS7PAM+lJlu+CfoncbuBXEVeRyKodsYkX
         xzONZVZdPiqR1UD25SzPMcIg8AqAixEGqy5Ch9jflZ7jTlfUIKwLEK2H9AXE3a6bLt
         mneuww9fK/bMgnFo7uiVUBCtgoQGYiKvK74TunbAe/qh3HtV4HnZOF/cNrw7gggyz8
         md/I9pY7vnLLqTHrz1CkaWRVNFjSvzyox7WQNuvUl9ORpYWVu6X72eiZAxq61z4qOR
         CsxomGU7C4xoQ==
Message-ID: <16a43784-27d4-6362-5e4d-465ddc5e5380@collabora.com>
Date:   Wed, 16 Mar 2022 17:23:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 7/8] drm/virtio: Support memory shrinking
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
 <20220314224253.236359-8-dmitry.osipenko@collabora.com>
 <CACvgo52-pd-g=ZnR=m0T7W2yQ4i7_Q6gWy22=vm-fX+eA-YwQg@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CACvgo52-pd-g=ZnR=m0T7W2yQ4i7_Q6gWy22=vm-fX+eA-YwQg@mail.gmail.com>
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

On 3/15/22 15:43, Emil Velikov wrote:
> Greetings everyone,
> 
> Food for thought: Would it make sense to have the madvise ioctl as
> generic DRM one?
> Looking around - i915, msm & panfrost already have one and the virtio
> implementation [below] seems as generic as it gets.
> 
> On Mon, 14 Mar 2022 at 22:44, Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
> 
>> +#define VIRTGPU_MADV_WILLNEED 0
>> +#define VIRTGPU_MADV_DONTNEED 1
>> +struct drm_virtgpu_madvise {
>> +       __u32 bo_handle;
>> +       __u32 retained; /* out, non-zero if BO can be used */
>> +       __u32 madv;
>> +       __u32 pad;
> 
> This seems to be based on panfrost/msm yet names (bo_handle vs
> handle), layout and documentation varies.
> Why is that - copy/paste is cheap :-P

Indeed, there is copy/pasting among drivers. But I'm doubtful about
making madvise a generic ioctl because some drivers already have own
ioctl for that and h/w capabilities vary, so some drivers may want to
have extra features later on and then this doesn't feel like a common
thing anymore.
