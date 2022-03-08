Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674274D216C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349503AbiCHT3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349129AbiCHT3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:29:05 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C832FFFF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:28:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 8E2181F444B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646767685;
        bh=wTrQZzTeDzl3S/Woe+temKvCkXTTxdkP03ZFoe6Rj9E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JaIccFmi1jX1ewpbOHkkQGyiOhdvqKxkBql/3KQWmeEBQn/mP+wHpnZhb1wis3XJI
         XZhjoIwXc65vjwfJ/RWJzRoRjZQ17T4hYNBj1rk3qnMxIBzU2jmPIgD53sRpDbTvCA
         L5xqICzA0o8+u8NbxpCDnGKpDaGP08JoVK46goArxgFJElNE/jkMtCa15MfDt/YGzi
         LYURN3gjJ0/HMiCflPowekOpYyKzx0v55sCPVNEipd7jXFkRabu2pEmsAeOc8J+/+p
         EV4yRSp29+JTPdXCnN+2MrvPyFySxaO9NBklmjUqlJftdKQ6RDxPu8nNXlPWuZh1+k
         0ZqbjSNLJScNg==
Message-ID: <d2290971-ea22-8203-631e-b896c76a994b@collabora.com>
Date:   Tue, 8 Mar 2022 22:28:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rob Clark <robdclark@chromium.org>
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <CAF6AEGt=aVJ9nR+Wv+bJEFZrn-cNOSNXG1TaJr=Cx-FTgutwKA@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAF6AEGt=aVJ9nR+Wv+bJEFZrn-cNOSNXG1TaJr=Cx-FTgutwKA@mail.gmail.com>
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

On 3/8/22 19:29, Rob Clark wrote:
> On Tue, Mar 8, 2022 at 5:17 AM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> Hello,
>>
>> This patchset introduces memory shrinker for the VirtIO-GPU DRM driver.
>> During OOM, the shrinker will release BOs that are marked as "not needed"
>> by userspace using the new madvise IOCTL. The userspace in this case is
>> the Mesa VirGL driver, it will mark the cached BOs as "not needed",
>> allowing kernel driver to release memory of the cached shmem BOs on lowmem
>> situations, preventing OOM kills.
> 
> Will host memory pressure already trigger shrinker in guest? 

The host memory pressure won't trigger shrinker in guest here. This
series will help only with the memory pressure within the guest using a
usual "virgl context".

Having a host shrinker in a case of "virgl contexts" should be a
difficult problem to solve.

> This is
> something I'm quite interested in for "virtgpu native contexts" (ie.
> native guest driver with new context type sitting on top of virtgpu),

In a case of "native contexts" it should be doable, at least I can't see
any obvious problems. The madvise invocations could be passed to the
host using a new virtio-gpu command by the guest's madvise IOCTL
handler, instead-of/in-addition-to handling madvise in the guest's
kernel, and that's it.

> since that isn't using host storage

s/host/guest ?
