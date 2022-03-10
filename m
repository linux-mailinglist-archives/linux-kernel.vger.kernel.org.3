Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929624D53A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245745AbiCJVdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiCJVdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:33:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F06F8EB78
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:32:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id C791A1F4625B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646947961;
        bh=Ad6/roeSAR4BixHcrT4+iGSvNLDw1gu2KhDRPm1QmOI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DAjwBk9IS4h+tkGWFqJgy653Mej/36sRdc+xbnApxYzqc8yJloEoMOnVFTkkXES6f
         cpoI4OPaCh3SyI9cA6kBBGardXWx5w6u/YfWEddJGCM04h5ROvuYd7GZlS+8wLkfoW
         Cqx0asjEytolyRKKJaX5mILV851glPROg3vYET/59Yqjw8iBBH5LxnuresEsIlfZtt
         gfuFTfdSXcf64glac0pqPyEpWfhCV+UhI2fhKOv3b01+hGZKXP/i0CtjVF2m/bumWS
         UECBIX3FyQGjThzDNlt6BWweBJ3oNdk/uE2QrR41rAZj509FRn9V56ucG0KXeGr7kQ
         KXl2tvoSwKVCA==
Message-ID: <ef372381-2a80-bb2f-c999-bb55c5596475@collabora.com>
Date:   Fri, 11 Mar 2022 00:32:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel@lists.freedesktop.org,
        Dmitry Osipenko <digetx@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <4ce1e172-799c-cba3-0a72-4a6fdf2c6d2f@suse.de>
 <caa9a2ea-d1b4-fa96-0e90-37a89aa0c000@collabora.com>
 <d1169f34-ccd8-299d-af1f-f45da37556db@suse.de>
 <c9b344ab-b674-d600-da13-94b329a9d46b@collabora.com>
 <3caec8f4-1bc8-bd52-4a36-5223b633704e@suse.de>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <3caec8f4-1bc8-bd52-4a36-5223b633704e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 22:02, Thomas Zimmermann wrote:
> Hi
> 
> Am 09.03.22 um 23:25 schrieb Dmitry Osipenko:
>>>
>>> The reason for this work is to keep GEM shmem pages mapped and allocated
>>> even while the BO is neither mapped nor pinned.  As it is now, GEM SHMEM
>>> creates and releases pages on each pin and unpin, and maps and unmaps
>>> memory ranges on each vmap and vunmap.  It's all wasteful. Only the
>>> first pin and vmap calls should establish pages and mappings and only
>>> the purge and free functions should release them.
>>
>> Hm, aren't maps and pins already refcounted?
> 
> They are. But even when the refcounter reaches 0 on deref, there's no
> need to remove the mapping or free the memory pages. We can keep them
> around for the next ref operation.  Only the shrinker's purge or freeing
> the object has to do such clean-up operations.  Such behavior is
> supported by TTM and we already use it in VRAM helpers as well.

When driver won't want to pin BO at the creation time? Looks like all
shmem users do this today, and thus, pages shouldn't be freed until BO
is destroyed or purged.
