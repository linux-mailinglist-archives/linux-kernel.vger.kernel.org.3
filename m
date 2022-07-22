Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F4957E0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiGVLtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGVLtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:49:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28E0B9A05;
        Fri, 22 Jul 2022 04:49:49 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E91B6601ABD;
        Fri, 22 Jul 2022 12:49:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658490587;
        bh=MqYe4u+ECqLUduFF9nwMt5GMNViDvgSNcNPt7s7OdOg=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=IlVzO74uGYOg3STIPTgPoK/ufASUrLboQfexLEzLvhl4nkY3ynwbYX3zEiUuttlXX
         QjVJ4xVw5BkkKQSg0DMuSsWKaTER4UyzIsji3cESZTVVw3nHr4zI0RmVpvDdBj7QQ0
         /KdakXVjs3EE+a8ossr2CuDP1voSOhE/IL2bLcgrvjRwQZsQAmMdtbYhm1W1oE1uVJ
         KNT56XW/UqsUv05jE+NKlVv0yDIUI/CnC5hYIYjfDLIuxCr83HFUpuYLBWWpYfS33r
         H3se/b0lR0RJtJ6QlU5lwvfd1yXQEIm7qMKqRv/WuHiAY8EuPUr0/VWvFNPMroAEqU
         U60inhtdqnXkA==
Message-ID: <5c560ee2-c586-fd3e-c57c-d58825e1a73e@collabora.com>
Date:   Fri, 22 Jul 2022 14:49:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v8 0/2] DRM GEM fixes
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/1/22 12:02, Dmitry Osipenko wrote:
> This patchset fixes two problems in the common GEM code. First fixed problem
> is the bogus lockdep splat that complicates debugging of DRM drivers. Second
> problem is the inconsistency in behaviour and improper handling of mapping
> the imported GEMs by some drivers, to fix it we will prohibit to map the
> imported GEMs like majority of drivers already do.
> 
> Changelog:
> 
> v8: - Dropped stable tag from the "Don't map imported GEMs" patch,
>       like was suggested by Thomas Hellström in the review comment to v7.
> 
> v7: - Factored out GEM patches from [1] since I'll be working on the
>       dma-buf locking in a separate patchset now.
> 
> [1] https://lore.kernel.org/all/20220526235040.678984-1-dmitry.osipenko@collabora.com/
> 
>     - Improved commit message and added fixes tag to the "Properly annotate
>       WW context" patch.
> 
>     - Replaced "Move mapping of imported dma-bufs to drm_gem_mmap_obj()"
>       patch with "Don't map imported GEMs", like was suggested by
>       Thomas Hellström.
> 
>     - Added r-b and suggested-by from Thomas Hellström.
> 
> Dmitry Osipenko (2):
>   drm/gem: Properly annotate WW context on drm_gem_lock_reservations()
>     error
>   drm/gem: Don't map imported GEMs
> 
>  drivers/gpu/drm/drm_gem.c              | 8 ++++++--
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ---------
>  2 files changed, 6 insertions(+), 11 deletions(-)
> 

Could anyone please take this into drm-misc-next? Maybe Thomas?

Thanks in advance

-- 
Best regards,
Dmitry
