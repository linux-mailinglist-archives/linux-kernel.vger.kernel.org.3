Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4127562418
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiF3UXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiF3UXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:23:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E0C38;
        Thu, 30 Jun 2022 13:23:05 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D012C660196E;
        Thu, 30 Jun 2022 21:23:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656620583;
        bh=1v+6BIiQfnlEpsbZeQo8zPsdXAp9SuOZj8i80daLiwc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P69XYB0fXO5KxnstqDFC7Z6J4IyUeL+7tTDTninT2yyPlMsceNxziM91IXFo72ded
         xxoUMj7t5JIYcLXZYFokWqicvqhtYW+pNbg87S5FIpWUOLP0oLPx9AW8vwJJ4BpfAq
         62m9qRCesmuxwgc5wScbtvHUcM/GtCs0rO8BBHvDzyrfkYw+J/6+1ThmidAXVsQuAB
         fsSx/W+GuqL0BWbpAHk+P/M3XkmW+GM1a3xdiH8icCJ9TM6aJsFP2ha+3hEydRrDwc
         vkRRk+fjFf6XNN3V1MMKEgWMNvnMkpxqKocxE67yQ3K8HvGYhshske+7HURrsnbhRT
         KxAAnN1XE8MOA==
Message-ID: <8ab15669-889b-1119-9323-ec47689c7fb7@collabora.com>
Date:   Thu, 30 Jun 2022 23:22:59 +0300
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
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <75b677b6-c704-e270-c921-93c982020c38@shipmail.org>
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

Hello Thomas,

On 6/30/22 23:15, Thomas Hellström (Intel) wrote:
> Hi, Dmitry,
> 
> On 6/30/22 22:04, Dmitry Osipenko wrote:
>> Drivers that use drm_gem_mmap() and drm_gem_mmap_obj() helpers don't
>> handle imported dma-bufs properly, which results in mapping of something
>> else than the imported dma-buf. On NVIDIA Tegra we get a hard lockup when
>> userspace writes to the memory mapping of a dma-buf that was imported
>> into
>> Tegra's DRM GEM.
>>
>> Majority of DRM drivers prohibit mapping of the imported GEM objects.
>> Mapping of imported GEMs require special care from userspace since it
>> should sync dma-buf because mapping coherency of the exporter device may
>> not match the DRM device. Let's prohibit the mapping for all DRM drivers
>> for consistency.
>>
>> Cc: stable@vger.kernel.org
>> Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> This might break drivers whose obj->funcs->mmap() callback already
> handles this case, and has userspace that does the right thing.

The drm-shmem helper should be the only that maps imported GEMs
properly, but drivers that use drm-shmem already prohibit to map
imported GEMs. Okay, I'll try to re-check once again to be sure.

> I think the disabling must be checked on a per-driver basis to avoid
> that; in particular drivers that already call dma_buf_mmap() should be
> able to continue doing this.
> 
> Also the Fixes: review comment remains,

This should've been broken forever, don't think that we have a fixes tag
here. I looked thought all my previous patches and added the Fixes
wherever was possible. If I really missed something, then please let me
know.

-- 
Best regards,
Dmitry
