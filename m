Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1917E4DC975
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiCQPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiCQPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:01:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF75E7F64
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:00:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h15so7749195wrc.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mpFvwfJ8r7mWj+dQzeS1Ko5nqxYOE3cL38S10CPksII=;
        b=XJCgx6LcQEMvn4y144eWzm616B31j3LhXv3YVPLDtncBdhFDMGHb6IdRciS01qoO8w
         EzRFbR36x4RiHc1iN1gaU6mzYBxAMmzGk9fBCccQRNyIj4esIOnFiHY5ZtZoELO9h4Bp
         rlc61XZKAIdVRBuj9/l8UpjyvziqhICCMc+je8XH2pAtl5tyd+/U6j2XPM0H8kQ2kWx0
         /upgNjAT/SCxhngehW+VAQB8skH550WyrN83Xsb6WirejteaiSrl4f1F41IdrjpT1eS8
         DxBahdWDdMMrkqKlnmAOkcQOD9cJA3skIrIDIje8Fvm/JGW0QSg1iya2liLpVCVLCZiQ
         oy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mpFvwfJ8r7mWj+dQzeS1Ko5nqxYOE3cL38S10CPksII=;
        b=PUDftUEMFh0RyBQJzMtdO6ou9x9F2EFqhrAKmOdovFqA7KVYlVRmN65LPPBNah9wkc
         iBUun5cI1Q6hHKZ4Gt6gQYmmIIb8qQ+BEdVJzmMUvJbbfEJrB9qmoWtv2UmyH+hwvcBw
         nsHB/kll7gLhUva2kcBIQ8CWLX0iuhw2y0Xg6ptRDvcSg6ZzfgQRq2ygc9h1J432RR4A
         DtvA8/KxwPf3Pvm1QbD1CzKqzAaGqraV8ooG0C/RyxXxaPY2UGtwHzH3APFo6ro5E/Fx
         xBcuTSkc/aAtjEy5ovRXk7PzIEgI+rN77jii7jkB+K31L3Y+lNCngMCcx68/ClG24dQ/
         SrIQ==
X-Gm-Message-State: AOAM533hZfVT/Hkt0MO4zNyFfmMctHCbZLm8T76Dp6a7C0CBakbH8Wtu
        hYRqDxpG8TX867kjj0ZqlYxSKw==
X-Google-Smtp-Source: ABdhPJyTIEEopTwTo5wDmIQ/veXAigP05FDsUwMF53Y2w3XzFFiSf+9RPuGMNoeXf4um9LC9CA71Lw==
X-Received: by 2002:a5d:6785:0:b0:203:723c:6b08 with SMTP id v5-20020a5d6785000000b00203723c6b08mr4181698wru.643.1647529228708;
        Thu, 17 Mar 2022 08:00:28 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c228700b00389865c646dsm5888347wmf.14.2022.03.17.08.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:00:27 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:00:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: Protect the Client whilst it is being
 operated on
Message-ID: <YjNNCXc8harOvwqe@google.com>
References: <20220317131610.554347-1-lee.jones@linaro.org>
 <8702f8a5-62a1-c07e-c7b7-e9378be069b6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8702f8a5-62a1-c07e-c7b7-e9378be069b6@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Felix,

Thanks for your review.

> Am 2022-03-17 um 09:16 schrieb Lee Jones:
> > Presently the Client can be freed whilst still in use.
> > 
> > Use the already provided lock to prevent this.
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
> >   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > index e4beebb1c80a2..3b9ac1e87231f 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> > @@ -145,8 +145,11 @@ static int kfd_smi_ev_release(struct inode *inode, struct file *filep)
> >   	spin_unlock(&dev->smi_lock);
> >   	synchronize_rcu();
> > +
> > +	spin_lock(&client->lock);
> >   	kfifo_free(&client->fifo);
> >   	kfree(client);
> > +	spin_unlock(&client->lock);
> 
> The spin_unlock is after the spinlock data structure has been freed.

Good point.

If we go forward with this approach the unlock should perhaps be moved
to just before the kfree().

> There
> should be no concurrent users here, since we are freeing the data structure.
> If there still are concurrent users at this point, they will crash anyway.
> So the locking is unnecessary.

The users may well crash, as does the kernel unfortunately.

> >   	return 0;
> >   }
> > @@ -247,11 +250,13 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
> >   		return ret;
> >   	}
> > +	spin_lock(&client->lock);
> 
> The client was just allocated, and it wasn't added to the client list or
> given to user mode yet. So there can be no concurrent users at this point.
> The locking is unnecessary.
> 
> There could be potential issues if someone uses the file descriptor by dumb
> luck before this function returns. So maybe we need to move the
> anon_inode_getfd to the end of the function (just before list_add_rcu) so
> that we only create the file descriptor after the client structure is fully
> initialized.

Bingo.  Well done. :)

I can move the function as suggested if that is the best route forward?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
