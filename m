Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EEE567101
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiGEO1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiGEO1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:27:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBA7F3D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:27:41 -0700 (PDT)
Received: from [192.168.2.145] (unknown [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C480166018E6;
        Tue,  5 Jul 2022 15:27:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657031259;
        bh=757BlfEAarcDB8teCnXP3bQ++sWI7M4gJpClxrlC6Tc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fAsFTqOvJYrGd2xQrzpm/dbaDi1m8N3QVLox3iMYe5PdwvY8tFS7kTWQNKUKwrwMb
         rU4bNx4CH995+WH4T5Ibp/uKOv3eSw8CYyUjkD5Kkbx0YlB7rHP7XxSQsJ/2c6MCmd
         Egtf1NFGPLUC+ZuwBdruCwIjWARqf9YPHB/VAAJdhuxqvv3TQKLA8FoknCj1EY5ffo
         11M80uepepqQCy8Z+YSr3VXlzo2yRSylu7WYjXHKUPN/Bri3UUXclLiYOGLLrpuEP5
         9up6wmSWsdLukPkXzgj9r7/yXNK76SKqdivQ42+IKCm2EmIlzovZYU8W5K08a1SQfm
         T7skAHXQciYMw==
Message-ID: <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com>
Date:   Tue, 5 Jul 2022 17:27:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 7/9] drm/virtio: Improve DMA API usage for shmem BOs
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
 <20220630200726.1884320-8-dmitry.osipenko@collabora.com>
 <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gerd,

On 7/5/22 16:53, Gerd Hoffmann wrote:
>   Hi,
> 
>> -	 * So for the moment keep things as-is, with a bulky comment
>> -	 * for the next person who feels like removing this
>> -	 * drm_dev_set_unique() quirk.
> 
> Dragons lurking here.  It's not the first attempt to ditch this, and so
> far all have been rolled back due to regressions.  Specifically Xorg is
> notoriously picky if it doesn't find its expectations fulfilled.

I saw the previous attempt. Back then it was a mechanically created
patch that didn't get any testing.

> Also note that pci is not the only virtio transport we have.

The VirtIO indeed has other transports, but only PCI is really supported
in case of the VirtIO-GPU in kernel and in Qemu/crosvm, AFAICT. Hence
only the PCI transport was tested.

> What kind of testing has this patch seen?

The Xorg and virgl work perfectly fine in Qemu (with and without IOMMU
enabled in Qemu) and in crosvm (ChromeOS virtual machine).

-- 
Best regards,
Dmitry
