Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC65F4D242C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbiCHWYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiCHWYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:24:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFE358387
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:23:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k24so269806wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 14:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLNTenH17gTL++hzFtoUTNEHN+pSYqZsQ93MYsewbsE=;
        b=B+Y+aj0Kp1KcmHD1TJUXHwyix6ApB1/FqwmXZGhx1wcc4TAOmxh9gxTlBgAGamLqPE
         vpKcowdhEgZzk2U98r53D5Hy1Scrw6xH8PQcSydekPlZ5HI3qiA9pxOFbKVYi/9OQf1Z
         2z+/4YhPKMZ9oKQH20k7HP91wcJX8Isk8gqkO9jES0i3L0GPwD3p1LcGOB9U6h/BRgsQ
         8084feHyzqqtSFPTbppFkm13Ecg1wAy6AkYXNngnc+JaHTQVPUGmgGjdIb5GLtIM4Q/G
         bFqhl4gpP3fujkTcmelxXGFmAibfXsgFjzDNGvuS4OkzK2lYWp6unZQFj+/yXcyvAvNf
         Zjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLNTenH17gTL++hzFtoUTNEHN+pSYqZsQ93MYsewbsE=;
        b=xQMtrp1FktAexxu3sXQF9sJiSgMt6klYuNQAaKHV1b0FPQRApr7zFywvXedwl1Bh9Y
         vh+a5s0u9zQywtLN8K6IYpfRSVXk8mdWaRL8saaY95aFSCrQgwLZUoYMukNJf4Cr3gmf
         K80u5Eqii3vrlu2jmbORtiCntRnWyi0Jmbc1bW65afypB6ezQcR8BsFPOGi4CGpSNYYN
         YmmWrv5xF2SJaWALOwxw0nLTz1k0RVwyg1s21pZqsQnBO8+EIz0hyjQW9dK7su0A3GWU
         dm+DUgWZy7bJOTABpZQ5NomHoApwKpKOIrHhHbxJyn3zzbncNHjUyCO8TZ8DPp+k7Mo+
         M0Bw==
X-Gm-Message-State: AOAM530NbfLzekrmovBwKHlvUbR8dlAWfOo2PpT4pw6b5gxRX7cAa2Wh
        2qBqDxWoenw8bZLaHcpZ6PWHtsXAcQm7stXbdOE=
X-Google-Smtp-Source: ABdhPJyGuPzIrRNVs2k9a2b1qGUaqAliN4KUm5RnUtzkOdj1rRLWp/R6GjNYrs64hWACoBMY67pIWSlhNB+JjFA13n4=
X-Received: by 2002:a05:6000:15c5:b0:1f1:e64d:e4c3 with SMTP id
 y5-20020a05600015c500b001f1e64de4c3mr11545524wry.328.1646778234465; Tue, 08
 Mar 2022 14:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <CAF6AEGt=aVJ9nR+Wv+bJEFZrn-cNOSNXG1TaJr=Cx-FTgutwKA@mail.gmail.com> <d2290971-ea22-8203-631e-b896c76a994b@collabora.com>
In-Reply-To: <d2290971-ea22-8203-631e-b896c76a994b@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 8 Mar 2022 14:24:22 -0800
Message-ID: <CAF6AEGuR8B6z+z=VFQ6y01wbboYS_qpkghD1GYdLES_RZOW1wA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 11:28 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 3/8/22 19:29, Rob Clark wrote:
> > On Tue, Mar 8, 2022 at 5:17 AM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> Hello,
> >>
> >> This patchset introduces memory shrinker for the VirtIO-GPU DRM driver.
> >> During OOM, the shrinker will release BOs that are marked as "not needed"
> >> by userspace using the new madvise IOCTL. The userspace in this case is
> >> the Mesa VirGL driver, it will mark the cached BOs as "not needed",
> >> allowing kernel driver to release memory of the cached shmem BOs on lowmem
> >> situations, preventing OOM kills.
> >
> > Will host memory pressure already trigger shrinker in guest?
>
> The host memory pressure won't trigger shrinker in guest here. This
> series will help only with the memory pressure within the guest using a
> usual "virgl context".
>
> Having a host shrinker in a case of "virgl contexts" should be a
> difficult problem to solve.

Hmm, I think we just need the balloon driver to trigger the shrinker
in the guest kernel?  I suppose a driver like drm/virtio might want to
differentiate between host and guest pressure (ie. consider only
objects that have host vs guest storage), but even without that,
freeing up memory in the guest when host is under memory pressure
seems worthwhile.  Maybe I'm over-simplifying?

> > This is
> > something I'm quite interested in for "virtgpu native contexts" (ie.
> > native guest driver with new context type sitting on top of virtgpu),
>
> In a case of "native contexts" it should be doable, at least I can't see
> any obvious problems. The madvise invocations could be passed to the
> host using a new virtio-gpu command by the guest's madvise IOCTL
> handler, instead-of/in-addition-to handling madvise in the guest's
> kernel, and that's it.

I think we don't want to do that, because MADV:WILLNEED would be by
far the most frequent guest<->host synchronous round trip.  So from
that perspective tracking madvise state in guest kernel seems quite
attractive.

If we really can't track madvise state in the guest for dealing with
host memory pressure, I think the better option is to introduce
MADV:WILLNEED_REPLACE, ie. something to tell the host kernel that the
buffer is needed but the previous contents are not (as long as the GPU
VA remains the same).  With this the host could allocate new pages if
needed, and the guest would not need to wait for a reply from host.

> > since that isn't using host storage
>
> s/host/guest ?

Yes, sorry, I meant that it is not using guest storage.

BR,
-R
