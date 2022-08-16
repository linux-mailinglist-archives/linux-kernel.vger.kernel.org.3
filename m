Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51090595B73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiHPMMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiHPMLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:11:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAD1FE0;
        Tue, 16 Aug 2022 05:03:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a7so18516643ejp.2;
        Tue, 16 Aug 2022 05:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qXuUFA6dzcSFji6bQgTrBDhPKkRTpOenjFFFaEBg5kI=;
        b=UHJLCRj6aZC7JExmGfMqmbjBJMSLQus4l90cEIpD6oiFn5t7AIznfp4vmnoBDBuC89
         Co8rtShOazIQ1/pDTdlKWtiDgaw+N7eefL9j3Hq2vAfUThLRyO9Rb7B5ngUEUCtueeNx
         6zSUM4gJc5mS4F3GNo20/DWYfPsbSyNlWwtfn3dACfywQVqDk01eJeq7pEy3b4eVmyg+
         /xLDWvCsTCVL3VwOqW9vNz1sctfDZfporzdWriNN6X7XNFHs3beFmG8e+snUYDmbD7Xt
         ORToYO/CXU5ilyofZPtHvw1MVcO6aMT9wteaJfa84CKp6U5/G52ooNG3LZs/OF+1Fzi1
         DFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qXuUFA6dzcSFji6bQgTrBDhPKkRTpOenjFFFaEBg5kI=;
        b=qFUP1MYgKpwR7nTRTPT54C3DMAuoCk+46XQPbMbvmg0EeM3UKpMSUfg3LyOpZYiNxo
         2h6wKTCNGqIaS9dYKZ3n5nk0FVVasyhTJUaa+X846TKaVUqKeuw/idjSm2cj3DsbBrne
         L/JyOZMByytm4UzCb61yEnr0e5GDcXcAhbI//5N/PnJxHlhQIXBPmEGPJQKfTgVqybIK
         d7MXhvVn4rDmDnFf5p1aEEmh0MJVCKqBwp+ApYAdLn4UV9IDzB4s8IymTht9Q5eGEtmo
         H2yg+AxnoMT+Y2CA5zJgbJJkYY6aGUFADS9jSflB5/XudnBx5eaibo+TWCOY+Pn8IrBJ
         1u9A==
X-Gm-Message-State: ACgBeo1QNUHt60Wv/9cYKoDGFLAuDnbusA8CCgTKFce8dP8dkwaFpa8M
        D+OiUjTg+D812ERhRCxf9J0=
X-Google-Smtp-Source: AA6agR5153oYV8kafc+i58iRbni/4o0+HJFRM9ywzhXxF6J2iekcXpA4igafMBRomyjZJGm0DD3PGA==
X-Received: by 2002:a17:906:9752:b0:738:364a:4ac with SMTP id o18-20020a170906975200b00738364a04acmr8730502ejy.759.1660651432330;
        Tue, 16 Aug 2022 05:03:52 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
        by smtp.gmail.com with ESMTPSA id op9-20020a170906bce900b0072b810897desm5209994ejb.105.2022.08.16.05.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 05:03:51 -0700 (PDT)
Message-ID: <2ce5ff0a-9ab2-d146-04db-487a64714fce@gmail.com>
Date:   Tue, 16 Aug 2022 14:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas_os@shipmail.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        kernel@collabora.com, Daniel Vetter <daniel@ffwll.ch>
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com>
 <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
 <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com>
 <YvOav/vF2awVWIu0@phenom.ffwll.local>
 <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com>
 <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com>
 <CAF6AEGv1cVC9ZNMwpwFOki5CrwD3kSAHM9EUFZGWY-y5zcQsCg@mail.gmail.com>
 <fc019528-7ec7-9e5b-1b6d-c44da14346cf@collabora.com>
 <CAF6AEGv8zSd0fEYB9hd2QOyTt53gFSQoL8JdZtCvtCdYfMfB2Q@mail.gmail.com>
 <73b51dde-689f-64ce-a1c8-0d7c84a2ed66@collabora.com>
 <CAF6AEGuR1cRQYaQBYGnMBzy=XJUcN2o2gzabZaGO2Dj62Uq1DA@mail.gmail.com>
 <CAF6AEGvvR1NUd_GKP=Bxp3VTDMBYT+OwTkkgOWxgYFijZaVVEQ@mail.gmail.com>
 <5f118e10-db7a-a128-1e87-c9dddb65b2ac@collabora.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <5f118e10-db7a-a128-1e87-c9dddb65b2ac@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 16.08.22 um 13:44 schrieb Dmitry Osipenko:
> [SNIP]
>> The other complication I noticed is that we don't seem to keep around
>> the fd after importing to a GEM handle.  And I could imagine that
>> doing so could cause issues with too many fd's.  So I guess the best
>> thing is to keep the status quo and let drivers that cannot mmap
>> imported buffers just fail mmap?
> That actually should be all the drivers excluding those that use
> DRM-SHMEM because only DRM-SHMEM uses dma_buf_mmap(), that's why it
> works for Panfrost. I'm pretty sure mmaping of imported GEMs doesn't
> work for the MSM driver, isn't it?
>
> Intel and AMD drivers don't allow to map the imported dma-bufs. Both
> refuse to do the mapping.
>
> Although, AMDGPU "succeeds" to do the mapping using
> AMDGPU_GEM_DOMAIN_GTT, but then touching the mapping causes bus fault,
> hence mapping actually fails. I think it might be the AMDGPU
> driver/libdrm bug, haven't checked yet.

That's then certainly broken somehow. Amdgpu should nerve ever have 
allowed to mmap() imported DMA-bufs and the last time I check it didn't.

Regards,
Christian.

>
> So we're back to the point that neither of DRM drivers need to map
> imported dma-bufs and this was never tested. In this case this patch is
> valid, IMO.
>

