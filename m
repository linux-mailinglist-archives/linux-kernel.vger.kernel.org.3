Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251AA524FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354826AbiELOPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiELOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:15:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464CD21255
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:15:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j25so6454331wrc.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n/7pYmQpfwFthS/9oBJ6j9sdvjU7gecjyTu7MlWAR7k=;
        b=kUmh1oG60Fx0A6U56QVurQQLGKQ7477RCDCtn29lmcK1mpvRBMpGiD6hdcAaMvFXmV
         qOGgXhg3PVoHSSWjxbVmU5G5zNZqptA0VHiElu7Vy6cSSsGOyRC0I3lk0Tn4mIUNZlAw
         AsnpIb4hk5Q+SIPopSbDEj41i4yu8DkWC+t4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=n/7pYmQpfwFthS/9oBJ6j9sdvjU7gecjyTu7MlWAR7k=;
        b=OU5KzEOI9qsy+fd3eRD5uBmp1r5QdaDB0QM3FGStKEmd/HyKWlLm96S/NNC6QdEEHO
         N6gu9ClFUYp2YdIkWOg7Z09IBglfmFh9hpYKnUAutFCSxnA0tLVFOvqyE5rY9sFjVQJ6
         TIob60oYxvP14/iNkm6DhoYWx+XnG3RRU/nJDPy0dPHAFBxOG13NKS6Wg05Uxqu/k7dn
         CZLrXUh6bFb3JA0BKFEX5zNMyptIgrauUfmVro5ZsFLSEWedJfca9YKE8AbGCIWQz631
         q+JjpnMSs4v4chkRDVgkASvyrUuuhVx8HLKyeKPjHBHKVC91kJYNowKheKlRdgs3Y3Ye
         UskQ==
X-Gm-Message-State: AOAM5339VqzlRNuxOxeXsG0lOFka7gYBfxDB/9ZzurDlNDQg3+mbQRQs
        hEXE6U/+VVKs+KzU0vUg+jjKEg==
X-Google-Smtp-Source: ABdhPJxgE25FTVTyKaDpk3JLkWltkhrtfTRyeVsxBvMnjZwfuCI1/qUzdN0GY0T1EvfVBkrJ5o12Vw==
X-Received: by 2002:a5d:6d8d:0:b0:20c:5f60:d551 with SMTP id l13-20020a5d6d8d000000b0020c5f60d551mr27919826wrs.427.1652364940783;
        Thu, 12 May 2022 07:15:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c13-20020adfed8d000000b0020c5253d8d7sm4428980wro.35.2022.05.12.07.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:15:39 -0700 (PDT)
Date:   Thu, 12 May 2022 16:15:37 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Stone <daniel@fooishbar.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Message-ID: <Yn0WicACq5Y46DGU@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Stone <daniel@fooishbar.org>,
        David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <83e68918-68de-c0c6-6f9b-e94d34b19383@collabora.com>
 <YnkaUk0mZNuPsZ5r@phenom.ffwll.local>
 <4d08b382-0076-1ea2-b565-893d50b453cb@collabora.com>
 <YnuziJDmXVR09UzP@phenom.ffwll.local>
 <56787b70-fb64-64da-6006-d3aa3ed59d12@gmail.com>
 <3a362c32-870c-1d73-bba6-bbdcd62dc326@collabora.com>
 <YnvWUbh5QDDs6u2B@phenom.ffwll.local>
 <ba2836d0-9a3a-b879-cb1e-a48aed31637d@collabora.com>
 <YnwI5UX/zvmnAHvg@phenom.ffwll.local>
 <f6e42cfb-0252-1273-2ba3-76af818e0799@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6e42cfb-0252-1273-2ba3-76af818e0799@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 09:29:35AM +0200, Christian König wrote:
> Am 11.05.22 um 21:05 schrieb Daniel Vetter:
> > [SNIP]
> > > > > It's unclear to me which driver may ever want to do the mapping under
> > > > > the dma_resv_lock. But if we will ever have such a driver that will need
> > > > > to map imported buffer under dma_resv_lock, then we could always add the
> > > > > dma_buf_vmap_locked() variant of the function. In this case the locking
> > > > > rule will sound like this:
> > > > > 
> > > > > "All dma-buf importers are responsible for holding the dma-reservation
> > > > > lock around the dmabuf->ops->mmap/vmap() calls."
> > > Are you okay with this rule?
> > Yeah I think long-term it's where we want to be, just trying to find
> > clever ways to get there.
> > 
> > And I think Christian agrees with that?
> 
> Yes, completely.
> 
> A design where most DMA-buf functions are supposed to be called with the
> reservation lock held is exactly what I have in mind for the long term.
> 
> > > > > > It shouldn't be that hard to clean up. The last time I looked into it my
> > > > > > main problem was that we didn't had any easy unit test for it.
> > > > > Do we have any tests for dma-bufs at all? It's unclear to me what you
> > > > > are going to test in regards to the reservation locks, could you please
> > > > > clarify?
> > > > Unfortunately not really :-/ Only way really is to grab a driver which
> > > > needs vmap (those are mostly display drivers) on an imported buffer, and
> > > > see what happens.
> > > > 
> > > > 2nd best is liberally sprinkling lockdep annotations all over the place
> > > > and throwing it at intel ci (not sure amd ci is accessible to the public)
> > > > and then hoping that's good enough. Stuff like might_lock and
> > > > dma_resv_assert_held.
> > > Alright
> > So throwing it at intel-gfx-ci can't hurt I think, but that only covers
> > i915 so doesn't really help with the bigger issue of catching all the
> > drivers.
> 
> BTW: We have now somebody working on converting the existing libdrm_amdgpu
> unit tests over to igt.

This sounds awesome.

/me throws a happy dance

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
