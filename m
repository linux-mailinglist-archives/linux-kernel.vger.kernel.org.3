Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0006562DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiGAIYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiGAIXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:23:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99CC735B2;
        Fri,  1 Jul 2022 01:22:06 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 324386600BA8;
        Fri,  1 Jul 2022 09:22:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656663725;
        bh=rjfOD5XJ4oMrFc0ADdNTY8d0gJRB40Z3xVocscFIFek=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IuIzOVGwc5ZfP59Dw1rJgrS3VGGnhLBrSQFAyYkMfG/wkNtXOx+waALYJU2CDfhqN
         NOsW/fygf0Mcxr4sUkOk+45rNt/47gERiVx0466vCvzG2YOpTt2ac1ftqqBV1r3SzU
         BUIO5i/T6t7nMUY7F4qtbZJJ/vO1T6FFRtrYmQOp3fILGb65v4YjIr7jYQDa2sk7fK
         E4yl6eTuWIRwIMVDl/LnWVUl80bFxQM78Y7S7XSbjIPOwot91w+u55iA2vuWP1Kbaq
         U5ol2uJNXoLN+8tFEAh6H7xUe5b8f3nJoRcoCSRyDcwInxxv3PonjkQ0aq8lQzWOld
         7RbIo1eLD7jJg==
Message-ID: <7f33ec06-5325-b0f9-3e62-df00c356906e@collabora.com>
Date:   Fri, 1 Jul 2022 11:22:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 2/2] drm/gem: Don't map imported GEMs
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
References: <20220630200405.1883897-1-dmitry.osipenko@collabora.com>
 <20220630200405.1883897-3-dmitry.osipenko@collabora.com>
 <75b677b6-c704-e270-c921-93c982020c38@shipmail.org>
 <8ab15669-889b-1119-9323-ec47689c7fb7@collabora.com>
 <22005f1b-4ae2-0fda-beda-1d9847bb2ade@shipmail.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <22005f1b-4ae2-0fda-beda-1d9847bb2ade@shipmail.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 23:26, Thomas Hellström (Intel) wrote:
> 
> On 6/30/22 22:22, Dmitry Osipenko wrote:
>> Hello Thomas,
>>
>> On 6/30/22 23:15, Thomas Hellström (Intel) wrote:
>>> Hi, Dmitry,
>>>
>>> On 6/30/22 22:04, Dmitry Osipenko wrote:
>>>> Drivers that use drm_gem_mmap() and drm_gem_mmap_obj() helpers don't
>>>> handle imported dma-bufs properly, which results in mapping of
>>>> something
>>>> else than the imported dma-buf. On NVIDIA Tegra we get a hard lockup
>>>> when
>>>> userspace writes to the memory mapping of a dma-buf that was imported
>>>> into
>>>> Tegra's DRM GEM.
>>>>
>>>> Majority of DRM drivers prohibit mapping of the imported GEM objects.
>>>> Mapping of imported GEMs require special care from userspace since it
>>>> should sync dma-buf because mapping coherency of the exporter device
>>>> may
>>>> not match the DRM device. Let's prohibit the mapping for all DRM
>>>> drivers
>>>> for consistency.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> This might break drivers whose obj->funcs->mmap() callback already
>>> handles this case, and has userspace that does the right thing.
>> The drm-shmem helper should be the only that maps imported GEMs
>> properly, but drivers that use drm-shmem already prohibit to map
>> imported GEMs. Okay, I'll try to re-check once again to be sure.
> 
> OK. If you aren't 100.1% sure, then please drop the Cc: stable tag and
> let the patch ride out at least an -rc series, because breaking a stable
> kernel is something we woudln't want to do.

Apparently the OMAP DRM driver should be broken similarly to the Tegra
DRM. Unlikely that anyone else maps the imported GEMs in practice, other
drivers are prohibiting the mapping AFAICS. I'll make the v8 without the
stable tag since it's not a critical problem after all because it never
worked for the broken drivers.

-- 
Best regards,
Dmitry
