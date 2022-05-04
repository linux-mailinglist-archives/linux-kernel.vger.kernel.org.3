Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8200E519978
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346106AbiEDIVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbiEDIU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:20:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2E21817
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:17:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p6so255623plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m/o0hH+G5QHI6BeBbELgsZuHhpZprmnBv5abLe2yqZw=;
        b=utj2n8v7+SlIfPP0UvdWLzscrzn18GNJzdKRKdrDC1IZ2DN5Y3iq2S3vGvhfpzuGId
         YAHhIBGTIWf75T0biS3VvaaYqx//o2k/RMP7zvfPpzD2NDACK4mAORhrPQk7oG8mvhhZ
         UEM4K2sAjVc2gOs6s6LyY415L5YhlSUME4TC/btCX3xk2yPBjlObK3Wmz+rdF3Xn63BW
         P+Gyn9z+jVWrvYqWliM3jl60/q/R2kln80+LyzsYAaadmPsgdB5ZIxFpF3RE3n7AX+5U
         PbCeR+QAtfv1lltGS5ubMzbpQhY99Ghpl2VJkcEf887xjCVtvMh3J5r2CDVtcaauMLQI
         o6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m/o0hH+G5QHI6BeBbELgsZuHhpZprmnBv5abLe2yqZw=;
        b=nTLeb1V1YYnOgksYia1Br2Lxbi/i6pIX//kRS2QwHnXNmPSUNx4nTn6i/rxf4O7YSM
         UnL9gRvTImXSkphdEVuYI7WVyi8ZfUdm4jNG+N0t1MlzHDuoqxdZFoke6z9d+wHL5pw+
         brNeazn8Bt9Kpm+bRSwqwqE0heYC1HQfhJG8KVY4LQK8RpobhzQW9Q3iQngEO18EirYM
         2xXqz31YV/3jA/zZjG73ljBnxll73D6XPXAbG6EFJHL9JHrmiR3q/PZAlxOuZLYq+8Zj
         SA7yRzaXuBpXqk/7GEENqKpaxNGA3w4NooZ8Pi0r5RNA3IB0fGAcGkbkF7pH2O1oliBg
         fWBg==
X-Gm-Message-State: AOAM5307xTweNwAKpZmhko03aUQ9skNVxzdeaf9SWS8sl6LXAXtsa7HE
        c2IZ97QAvnfSwsTWJ5VelpHR
X-Google-Smtp-Source: ABdhPJyVZm5WpnJvCG6HDft3D77C9wYdEsY5msncy9Ql91hDJE+u3QyHYsIK/lGBJZQvF+ZflmJmiA==
X-Received: by 2002:a17:902:7009:b0:158:3bcf:b774 with SMTP id y9-20020a170902700900b001583bcfb774mr20133560plk.103.1651652243949;
        Wed, 04 May 2022 01:17:23 -0700 (PDT)
Received: from thinkpad ([27.111.75.248])
        by smtp.gmail.com with ESMTPSA id j11-20020aa7800b000000b0050dc76281basm7901417pfi.148.2022.05.04.01.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:17:23 -0700 (PDT)
Date:   Wed, 4 May 2022 13:47:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com
Subject: Re: [PATCH 5/5] bus: mhi: host: Remove redundant dma_wmb() before
 ctx wp update
Message-ID: <20220504081720.GB5446@thinkpad>
References: <20220502104144.91806-1-manivannan.sadhasivam@linaro.org>
 <20220502104144.91806-6-manivannan.sadhasivam@linaro.org>
 <CAMZdPi_i60TqszUL+=ocMn-4veyoGRQoOGD_B4YiEpz_uWE+ZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZdPi_i60TqszUL+=ocMn-4veyoGRQoOGD_B4YiEpz_uWE+ZQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Loic,

On Wed, May 04, 2022 at 09:21:20AM +0200, Loic Poulain wrote:
> Hi Mani,
> 
> On Mon, 2 May 2022 at 12:42, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > The endpoint device will only read the context wp when the host rings
> > the doorbell.
> 
> Are we sure about this statement? what if we update ctxt_wp while the
> device is still processing the previous ring? is it going to continue
> processing the new ctxt_wp or wait for a new doorbell interrupt? what
> about burst mode in which we don't ring at all (ring_db is no-op)?
> 

Good point. I think my statement was misleading. But still this scenario won't
happen as per my undestanding. Please see below.

> > And moreover the doorbell write is using writel(). This
> > guarantess that the prior writes will be completed before ringing
> > doorbell.
> 
> Yes but the barrier is to ensure that descriptor/ring content is
> updated before we actually pass it to device ownership, it's not about
> ordering with the doorbell write, but the memory coherent ones.
> 

I see a clear data dependency between writing the ring element and updating the
context pointer. For instance,

```
struct mhi_ring_element *mhi_tre;

mhi_tre = ring->wp;
/* Populate mhi_tre */
...

/* Increment wp */
ring->wp += el_size;

/* Update ctx wp */
ring->ctx_wp = ring->iommu_base + (ring->wp - ring->base);
```

This is analogous to:

```
Read PTR A;
Update PTR A;
Increment PTR A;
Write PTR A to PTR B;
```

Here, because of the data dependency due to "ring->wp", the CPU or compiler
won't be ordering the instructions. I think that's one of the reason we never
hit any issue due to this.

Thanks,
Mani

> >
> > So there is no need of an additional dma_wmb() to order the coherent
> > memory writes w.r.t each other. Even if the writes gets reordered, it
> > won't affect the endpoint device.
> >
> > Cc: Loic Poulain <loic.poulain@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/bus/mhi/host/main.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> > index 966ffc2458b9..6706a82d3aa8 100644
> > --- a/drivers/bus/mhi/host/main.c
> > +++ b/drivers/bus/mhi/host/main.c
> > @@ -138,11 +138,6 @@ void mhi_ring_chan_db(struct mhi_controller *mhi_cntrl,
> >
> >         db = ring->iommu_base + (ring->wp - ring->base);
> >
> > -       /*
> > -        * Writes to the new ring element must be visible to the hardware
> > -        * before letting h/w know there is new element to fetch.
> > -        */
> > -       dma_wmb();
> >         *ring->ctxt_wp = cpu_to_le64(db);
> >
> >         mhi_chan->db_cfg.ring_db(mhi_cntrl, &mhi_chan->db_cfg,
> > --
> > 2.25.1
> >
> 
> Regards,
> Loic
