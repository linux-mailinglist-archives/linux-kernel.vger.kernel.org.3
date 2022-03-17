Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038E74DC9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiCQPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiCQPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:14:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1431A1EC6D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:13:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r7so3296133wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nQqbWtH5pfKnl7ntBQnMna6KGgKeLVbC9temYzdbrVk=;
        b=jmPQuC0gcd7cVIo3rSP/TX3nT+TeQj+v9JPsb3+HNkEXYNGVZawetow5Z2hnZIlwz1
         enueRIfh+3xPAy+wyBjmg6HTmAnGRTS3UNFVvjEzNOFZlbbcZIWJYIMWNfrAAiV18x1u
         B04ZhhSUezK2Y6L6opNRDOzvXt3b8Zrp+G/nVdxhrldjtCvUcdT43gXRxBKtJSR6Fe2i
         0GcLQmp/1a55cGSKTLClpOwxBvyHtdXqe31s0Zpm0GmUCGQejjSJnsXl49RplKJN086R
         l0NlPTW8n9kOxKEUG5tBfu09d3hlUdyDsWjb/QEQPNEZVY+TBbECzQplDjsvwgPZ2Zam
         APNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nQqbWtH5pfKnl7ntBQnMna6KGgKeLVbC9temYzdbrVk=;
        b=ZcS2raHSSPCir01HdrxC2mP5V9hsWCJTUUVogoW4X2qufcgDgy4wRiAzLdUGqABNmc
         7lgjXu0UUKB2laD1tXCSkBYEnvd94oZdheZ/9DddTA6WCO6eDyo+jZPUYa8gKQST91nj
         KLzDO+HZSyZ4EtB6qcnLFB/rBsYzTfA0+5p2jPo6wniC9rvwUffQCbCjy9MVVnP1/QpV
         cm/VVTh3Apl98WTwITfMhz/322EIh5aUcqQtnQXD5OQsLADHewPxocBT7GaKwjU0VDbC
         JjmzzUuIC7F1mqdGSa4e8agMxpCDZwCFtX5V9raOoUwvP77ZFbel5XgcLTfNwrgzTrWL
         1Fbw==
X-Gm-Message-State: AOAM530hwD1W1l7Brppo/94mwpU94Al9A3XKpd0ydGlvAIvouTsT1Nyu
        1jiFRyz0Tl9/2VlwHGImtwjyXA==
X-Google-Smtp-Source: ABdhPJzqUVa6RciYrP1Fyl38aF2HC6O1bKNmreDFYFmrsonBxUtm8n/rju3WMT43L8SJZFzSztNf3Q==
X-Received: by 2002:a05:600c:27d0:b0:38c:6c01:9668 with SMTP id l16-20020a05600c27d000b0038c6c019668mr8492847wmb.59.1647529989621;
        Thu, 17 Mar 2022 08:13:09 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f7-20020a0560001a8700b00203c23e55e0sm4405777wry.78.2022.03.17.08.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:13:09 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:13:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: Protect the Client whilst it is being
 operated on
Message-ID: <YjNQA80wkWpy+AmA@google.com>
References: <20220317131610.554347-1-lee.jones@linaro.org>
 <8702f8a5-62a1-c07e-c7b7-e9378be069b6@amd.com>
 <YjNNCXc8harOvwqe@google.com>
 <1f003356-3cf9-7237-501e-950d0aa124d1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f003356-3cf9-7237-501e-950d0aa124d1@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022, Felix Kuehling wrote:

> 
> Am 2022-03-17 um 11:00 schrieb Lee Jones:
> > Good afternoon Felix,
> > 
> > Thanks for your review.
> > 
> > > Am 2022-03-17 um 09:16 schrieb Lee Jones:
> > > > Presently the Client can be freed whilst still in use.
> > > > 
> > > > Use the already provided lock to prevent this.
> > > > 
> > > > Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: "Christian König" <christian.koenig@amd.com>
> > > > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > > > Cc: David Airlie <airlied@linux.ie>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: amd-gfx@lists.freedesktop.org
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >    drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 6 ++++++
> > > >    1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > > > index e4beebb1c80a2..3b9ac1e87231f 100644
> > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > > > @@ -145,8 +145,11 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
> > > >    	spin_unlock(&dev->smi_lock);
> > > >    	synchronize_rcu();
> > > > +
> > > > +	spin_lock(&client->lock);
> > > >    	kfifo_free(&client->fifo);
> > > >    	kfree(client);
> > > > +	spin_unlock(&client->lock);
> > > The spin_unlock is after the spinlock data structure has been freed.
> > Good point.
> > 
> > If we go forward with this approach the unlock should perhaps be moved
> > to just before the kfree().
> > 
> > > There
> > > should be no concurrent users here, since we are freeing the data structure.
> > > If there still are concurrent users at this point, they will crash anyway.
> > > So the locking is unnecessary.
> > The users may well crash, as does the kernel unfortunately.
> We only get to kfd_smi_ev_release when the file descriptor is closed. User
> mode has no way to use the client any more at this point. This function also
> removes the client from the dev->smi_cllients list. So no more events will
> be added to the client. Therefore it is safe to free the client.
> 
> If any of the above were not true, it would not be safe to kfree(client).
> 
> But if it is safe to kfree(client), then there is no need for the locking.

I'm not keen to go into too much detail until it's been patched.

However, there is a way to free the client while it is still in use.

Remember we are multi-threaded.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
