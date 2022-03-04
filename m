Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392C94CCFB0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiCDINA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiCDIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:12:51 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920631965CD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:12:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ay10so11453621wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nPMlV5C7FYeJ+MAQJRKVZgOqaeGd8xaenfi4KkbtLPY=;
        b=G6/LTYQ4LqwZ8ilqV1vwoxFaGxSsLGHoRQsqa5tR3COs03q6CFyLomCeOuZVrA44/s
         1xgWkjlm4471bRHfGIi1S4HcpjQlLSCIGaOXg9722H/mIk9xB0WyRt3mLgoyn28ZaFAt
         OAoP9ZohsokwXisW4TmpPjlkWR9iEFUmEJs90GQuHPa9UNRiYFyoqSpX3AOaeEFE3jUt
         RvWE6bZ8/rDyDBooFJhgouse5hCvgf5xVcnkhlWsrYA+UvWO2yvSOIjBcLOEaR7y/48b
         BsKFxxoLtzjkAcAs4NBdDUCrgc19O+txMoQYvQ5TGyT+KPA+JLDT8k5On7vsH+AsMxNn
         nPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nPMlV5C7FYeJ+MAQJRKVZgOqaeGd8xaenfi4KkbtLPY=;
        b=5jmEAdZNzswX6FP+Dn+ZbWv6x7/bd7hFwygpEeSSUr4TIccF5mqXHBZCgHrvsjB3Xs
         4PxAbNb7aokdblichmvdL5DbuS/m8ve5fOE46RPwi6ZiMYZoRZmUGzQj+/ZDkcSpB7Fw
         IzQWJthXibOkGtiXjxUPtoBREdwKNOqmQACRgeYnFAjK5WMdhF4+J4lj4fdfTWQw7GaH
         zg6l3D0iGuTvhPdoonrVCnQqCXlew+6v4vpN19gjsru0jt7QGU1em0sSTVumcMLVFEKw
         ZxRrrzoBZNzewvqKaCnVheSpSnGml18T1i0cAJNgEL0Io7pmJ1sQxU9UsFAwU2L4QxXa
         u3nA==
X-Gm-Message-State: AOAM533mMEksZuP7cWZQptexDp4gngcF4hoOHAOHNqLkVet8KUHXmyVC
        QFREZ+0ThQ+3J8PlFBENXd92JQ==
X-Google-Smtp-Source: ABdhPJxMCC1LKXJexZ/2tGgpFJil8EHA0GqnSaR3HMWbpY+mDxcJyFlSsBF+YcH9jpwZ01DwXlpjUg==
X-Received: by 2002:adf:c00b:0:b0:1ed:a100:d62 with SMTP id z11-20020adfc00b000000b001eda1000d62mr28708755wre.266.1646381522045;
        Fri, 04 Mar 2022 00:12:02 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b00380fc02ff76sm4758071wms.15.2022.03.04.00.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:12:01 -0800 (PST)
Date:   Fri, 4 Mar 2022 08:11:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] vhost: Provide a kernel warning if mutex is held
 whilst clean-up in progress
Message-ID: <YiHJzxvxqwcCM882@google.com>
References: <20220303151929.2505822-1-lee.jones@linaro.org>
 <YiETnIcfZCLb63oB@unreal>
 <20220303155645-mutt-send-email-mst@kernel.org>
 <YiG61RqXFvq/t0fB@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YiG61RqXFvq/t0fB@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Mar 2022, Leon Romanovsky wrote:

> On Thu, Mar 03, 2022 at 04:01:06PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Mar 03, 2022 at 09:14:36PM +0200, Leon Romanovsky wrote:
> > > On Thu, Mar 03, 2022 at 03:19:29PM +0000, Lee Jones wrote:
> > > > All workers/users should be halted before any clean-up should take place.
> > > > 
> > > > Suggested-by:  Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/vhost/vhost.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index bbaff6a5e21b8..d935d2506963f 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -693,6 +693,9 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > >  	int i;
> > > >  
> > > >  	for (i = 0; i < dev->nvqs; ++i) {
> > > > +		/* Ideally all workers should be stopped prior to clean-up */
> > > > +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> > > > +
> > > >  		mutex_lock(&dev->vqs[i]->mutex);

                HERE ---^

> > > I know nothing about vhost, but this construction and patch looks
> > > strange to me.
> > > 
> > > If all workers were stopped, you won't need mutex_lock(). The mutex_lock
> > > here suggests to me that workers can still run here.
> > > 
> > > Thanks
> > 
> > 
> > "Ideally" here is misleading, we need a bigger detailed comment
> > along the lines of:
> > 
> > /* 
> >  * By design, no workers can run here. But if there's a bug and the
> >  * driver did not flush all work properly then they might, and we
> >  * encountered such bugs in the past.  With no proper flush guest won't
> >  * work correctly but avoiding host memory corruption in this case
> >  * sounds like a good idea.
> >  */
> 
> This description looks better, but the check is inherently racy.
> Why don't you add a comment and mutex_lock()?

We do, look up.  ^

> The WARN_ON here is more distraction than actual help.

The WARN() is just an indication that something else has gone wrong.

Stefano patched one problem in:

  vhost: Protect the virtqueue from being cleared whilst still in use

... but others may crop up and the WARN() is how we'll be informed.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
