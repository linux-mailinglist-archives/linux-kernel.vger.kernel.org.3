Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EDD4ECAC9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiC3RiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349378AbiC3RiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:38:05 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECFE66625
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:36:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso312508wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=si9BL6chisoTSaeqo99DJ1ZOvEtq2ZLE18b5aCraSsg=;
        b=dBTJr/GJXkcyRZzP1rEtXVt5Y4oXfOfUJqY1SbiNl9CFA5AueD//DYeDzQ4Au2Qz+W
         CPFc5Ga24RUstM4ay5k2cvKYCvDgrjZEKJg+QApmv7CGcNvnxCt1Iuk8cUI7HMUbjIrO
         AOkKpA8ApAfMpa/N9xH4CD/uTsVSkK/CB4Vy7vxMiNMUltQInBa/82AxemIc6YavH6ef
         GunkgXr9VifDVb7nD0gzP5/gDmq8/OUn7OHSGbJkHHB4mixLOKXNK9/kPmDmW8/Vv0hG
         9eZMOxQFGaOArRDGnTM0tSNopEP1VA50qqtI2SX7/Jqmt3FFqOD8SfHXGHoFaYEvsALh
         1myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=si9BL6chisoTSaeqo99DJ1ZOvEtq2ZLE18b5aCraSsg=;
        b=mHwoQ6opiClFwcDTiEXvppWCTs7LxAjwMBHjqmMQBxQZWWTzJSvqvQL6exPThkGdr1
         kJbQAgl6sQZAwgYuUUo+uTgtkG4V8zNbiZssSFdxYv8SxP2AytyXAen5QwKHQw4q6LQM
         ghiPzQkiwZmjJAx58UlfDEHfxnNibIAnVp7sJ7qY3OfAoorcAG9LhhnuFCAWDBfKRjlq
         WEdeFZVu3ydZ/IHskmH5Grq8UVDw+QagiyoZS21AnoOwcRwvbd41aRL/PcMJERR7GalT
         1pksnMEKc5mv/fMR5PmKHb7rukvKV2F5CAl3BrXeUvs4CZlvA3xGM9rjXBNS4ljk6d3F
         v59w==
X-Gm-Message-State: AOAM531TFUGjADwHK6+LdgqfSHmEvoJy5GGjAINw7OmVpf1vAQc5Aqj3
        f507gguEYWyiTjtBiUvpxQM4WUfhBCRBgg==
X-Google-Smtp-Source: ABdhPJySbMOHLeU5/XzBjryTSJpkyIppInBQPU+ymDQ0hfmSX4UC3FGqGyZmA0Oo3LbLxLf3acxdrw==
X-Received: by 2002:a05:600c:4296:b0:38c:1b43:1562 with SMTP id v22-20020a05600c429600b0038c1b431562mr528312wmc.122.1648661778522;
        Wed, 30 Mar 2022 10:36:18 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id i31-20020adf90a2000000b00205ad559c87sm12823380wri.21.2022.03.30.10.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 10:36:16 -0700 (PDT)
Date:   Wed, 30 Mar 2022 18:36:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/1] drm/amdkfd: Create file descriptor after client is
 added to smi_clients list
Message-ID: <YkSVDnolf1jltrSR@google.com>
References: <20220330075115.426035-1-lee.jones@linaro.org>
 <a85f7751-8e60-d8f4-a281-4fb50389ae7e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a85f7751-8e60-d8f4-a281-4fb50389ae7e@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022, Felix Kuehling wrote:

> 
> Am 2022-03-30 um 03:51 schrieb Lee Jones:
> > This ensures userspace cannot prematurely clean-up the client before
> > it is fully initialised which has been proven to cause issues in the
> > past.
> > 
> > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 18 +++++++++---------
> >   1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > index e4beebb1c80a2..c5d5398d45cbf 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > @@ -247,15 +247,6 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
> >   		return ret;
> >   	}
> > -	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
> > -			       O_RDWR);
> > -	if (ret < 0) {
> > -		kfifo_free(&client->fifo);
> > -		kfree(client);
> > -		return ret;
> > -	}
> > -	*fd = ret;
> > -
> >   	init_waitqueue_head(&client->wait_queue);
> >   	spin_lock_init(&client->lock);
> >   	client->events = 0;
> > @@ -265,5 +256,14 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
> >   	list_add_rcu(&client->list, &dev->smi_clients);
> >   	spin_unlock(&dev->smi_lock);
> > +	ret = anon_inode_getfd(kfd_smi_name, &kfd_smi_ev_fops, (void *)client,
> > +			       O_RDWR);
> > +	if (ret < 0) {
> 
> Thank you for the patch. This looks like the correct solution. But you also
> need to remove the client from the dev->smi_clients list here before
> kfree(client). With that fixed, the patch is

Yes, that makes perfect sense.

> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Thanks Felix.  I will provide a follow-up tomorrow.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
