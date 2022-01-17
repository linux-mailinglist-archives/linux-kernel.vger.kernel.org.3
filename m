Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5BF491163
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243341AbiAQVo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235812AbiAQVo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642455894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CyA4F2l4Ga8KW0MgR+7KYufjdXJ2AvOgHyksYubBhw=;
        b=JcTpW353ACewlfGk0AXeiodWUjaI1Ru2vfp1UnCeUQYYYM26c4TvJK3YYKy9raj/HjBjiP
        JID4CDBfedDyv7UhpC/FE/6HTfflNffVYuKNhRNO5M6XsuTbOuMrzzXHDHHm3uMi0PPgfn
        6gJ2JZRZzzX0uGwM3eZ8gg/iwKPq+cQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-G1Y7Ym08MES-uANjNq1DYQ-1; Mon, 17 Jan 2022 16:44:53 -0500
X-MC-Unique: G1Y7Ym08MES-uANjNq1DYQ-1
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso15124672edt.20
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 13:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0CyA4F2l4Ga8KW0MgR+7KYufjdXJ2AvOgHyksYubBhw=;
        b=C8Rx+w69g9MKwMqFMowOP7zZsZRf9CObaJ8nASAS7JQHuyPQlZsffDJ740fcot0o0A
         QTLK8ywBE6pBoKyr942LjoceHwQbYpm0PKSm3cFmzzKhWwMg/Ro1B0VKUan5wVZYJV84
         T2GC/6Pjsj6XhfLE9qfC+u25UYkVD7hdw4QVhT5hU3ryRFHUstXozm7nE6l0sg8uWEHL
         FFqiNvBJndEetFfi488VWYuXh0vLaChqismVAcbIxCYiDUyc0ncZ1s4V7yU3pKK0nKje
         O0hhs+7b2P6Fa5+hjjET5YOBnQ8PA9oBi4PPe7GnrcHmfC5yyk/eArQ6pDdX66XMIiue
         WwtQ==
X-Gm-Message-State: AOAM532YZrTYjc2J+OgGSK/ex/L99PIzLrLcQHXQJ9/SYQkPHCC6cGO5
        udav9GMtrUDr4ATkuESSb4zMk83dyO5EkF6IoVfPWyam7jBu5NWuG9yPpv0DCvddOVlLSg3W9Fr
        seuWHCK7pPmQAP2gkrM3xcPql
X-Received: by 2002:a17:907:62a3:: with SMTP id nd35mr18836045ejc.650.1642455892018;
        Mon, 17 Jan 2022 13:44:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/if0AA69UEdFPdjv36EaSPlb3X89ozwxa4kaHHPL/Xm4Ik082CAGiBTzwK/mjl2j6tlWgLw==
X-Received: by 2002:a17:907:62a3:: with SMTP id nd35mr18836030ejc.650.1642455891787;
        Mon, 17 Jan 2022 13:44:51 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
        by smtp.gmail.com with ESMTPSA id s16sm6331099edt.30.2022.01.17.13.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 13:44:48 -0800 (PST)
Date:   Mon, 17 Jan 2022 16:44:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_mem: break device on remove
Message-ID: <20220117164427-mutt-send-email-mst@kernel.org>
References: <20220114214324.239444-1-mst@redhat.com>
 <1f703ebf-0f78-e530-0fe1-163613397cad@redhat.com>
 <20220117025341-mutt-send-email-mst@kernel.org>
 <7ec8218e-9d76-a9b7-ccd0-b7c8ce257fe2@redhat.com>
 <20220117033644-mutt-send-email-mst@kernel.org>
 <44f4ee97-562c-ce37-a5af-9f58e052f3a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44f4ee97-562c-ce37-a5af-9f58e052f3a9@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 11:25:12AM +0100, David Hildenbrand wrote:
> On 17.01.22 09:40, Michael S. Tsirkin wrote:
> > On Mon, Jan 17, 2022 at 09:31:56AM +0100, David Hildenbrand wrote:
> >> On 17.01.22 08:55, Michael S. Tsirkin wrote:
> >>> On Mon, Jan 17, 2022 at 02:40:11PM +0800, Jason Wang wrote:
> >>>>
> >>>> 在 2022/1/15 上午5:43, Michael S. Tsirkin 写道:
> >>>>> A common pattern for device reset is currently:
> >>>>> vdev->config->reset(vdev);
> >>>>> .. cleanup ..
> >>>>>
> >>>>> reset prevents new interrupts from arriving and waits for interrupt
> >>>>> handlers to finish.
> >>>>>
> >>>>> However if - as is common - the handler queues a work request which is
> >>>>> flushed during the cleanup stage, we have code adding buffers / trying
> >>>>> to get buffers while device is reset. Not good.
> >>>>>
> >>>>> This was reproduced by running
> >>>>> 	modprobe virtio_console
> >>>>> 	modprobe -r virtio_console
> >>>>> in a loop, and this reasoning seems to apply to virtio mem though
> >>>>> I could not reproduce it there.
> >>>>>
> >>>>> Fix this up by calling virtio_break_device + flush before reset.
> >>>>>
> >>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>>>> ---
> >>>>>   drivers/virtio/virtio_mem.c | 2 ++
> >>>>>   1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> >>>>> index 38becd8d578c..33b8a118a3ae 100644
> >>>>> --- a/drivers/virtio/virtio_mem.c
> >>>>> +++ b/drivers/virtio/virtio_mem.c
> >>>>> @@ -2888,6 +2888,8 @@ static void virtio_mem_remove(struct virtio_device *vdev)
> >>>>>   		virtio_mem_deinit_hotplug(vm);
> >>>>>   	/* reset the device and cleanup the queues */
> >>>>> +	virtio_break_device(vdev);
> >>>>> +	flush_work(&vm->wq);
> >>>>
> >>>>
> >>>> We set vm->removing to true and call cancel_work_sync() in
> >>>> virtio_mem_deinit_hotplug(). Isn't is sufficient?
> >>>>
> >>>> Thanks
> >>>
> >>>
> >>> Hmm I think you are right. David, I will drop this for now.
> >>> Up to you to consider whether some central capability will be
> >>> helpful as a replacement for the virtio-mem specific "removing" flag.
> >>
> >> It's all a bit tricky because we also have to handle pending timers and
> >> pending memory onlining/offlining operations in a controlled way. Maybe
> >> we could convert to virtio_break_device() and use the
> >> &dev->vqs_list_lock as a replacement for the removal_lock. However, I'm
> >> not 100% sure if it's nice to use that lock from
> >> drivers/virtio/virtio_mem.c directly.
> > 
> > We could add an API if you like. Or maybe it makes sense to add a
> > separate one that lets you find out that removal started. Need to figure
> > out how to handle suspend too then ...
> > Generally we have these checks that device is not going away
> > sprinkled over all drivers and I don't like it, but
> > it's not easy to build a sane API to handle it, especially
> > for high speed things when we can't take locks because performance.
> 
> The interesting case might be how to handle virtio_mem_retry(), whereby
> we conditionally queue work if !removing.
> 
> Having that said, in an ideal world we could deny removal requests for
> virtio_mem completely if there is still any memory added to the system ...
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb


removal requests might come from guest admin.

-- 
MST

