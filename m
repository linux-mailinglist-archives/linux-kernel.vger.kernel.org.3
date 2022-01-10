Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1276488ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 04:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiAJDF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 22:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiAJDF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 22:05:27 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C43C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 19:05:26 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x15so10757582plg.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 19:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=asONcDbDvxPAfc46+OAh6NbEDRkAhrnwb09q3Jil4GU=;
        b=Gki/1AbznyCzfqVPv/C4SNZVXgKEO7JGJ2u2ohLExiiCIe1jBMzYuhdxjKJwaW/Ejq
         y1QoB/o+OU4dtgZGesOw6IKMawv1INl6/4XAb7Ui1BbrfWS5IS5u2GFAEmsscP/Xj7Cm
         k2GeVvwJMbSPvh781s3tXGctfHfUnP14c9aAPTy6TFd2/sKpYAdk76XDXKWh+NNx94cG
         J3B90JeCsPUSINVhqoVf9QV8DYyLywmdvSQJQ2R8TDgEg2sRXPn/9BL0s3KW0GDKblv4
         fU8lCl/IS7B9pm4RYaetLpI0h+eT1lPIBD73JASFwxEwlruCDg5OoEEQSE1HNVoiqfw7
         rlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=asONcDbDvxPAfc46+OAh6NbEDRkAhrnwb09q3Jil4GU=;
        b=lGjOgWDwxSqx6hjVOVNEKFyUgrG3vWCKgXYqBRiGFiO8Af2RnqoB6QB0Zl7j6wK3Jy
         zu7JFfS4+S0xtnOSmzK4nWkgpdZ9p07cZvQrfmrLGmYVkGhSDG+KwPFwtCeO9s6DdU+M
         s9VuFY2RB2Og5WPwEMI1HlW/VKowMvZ26WBF6NQNnBEFf3PQspEijDR3jzJvfjOMowPd
         7+cBJUZc0McAgWVHrXivAQE8Fq+zhuBUKO3Qg0PanVcmkBLRC+h7kjTSFA0yHh8qOhup
         +SOpZSc+dAY5lKEjX1EkhKIhpjYRXAyJ7w3ZlHHYt9KwNPQLZmc4TR4EX0MPLXa2yTvx
         0Tqg==
X-Gm-Message-State: AOAM532YkgJ8tg5bEqW6VYpAqpvZpIq2v6Ip/J41j20AMQLfT6Medflp
        4D9G8pvkicFWcpavDqRFOI34FDnADP7pDLd6V0M=
X-Google-Smtp-Source: ABdhPJxjS8A7jPBlm0xNP4FEPredazSkzoH27TxeoQqlnlAHVkafY4wMVyY9t7M60rXHGpdWGR8K0Q==
X-Received: by 2002:a17:902:a509:b0:143:7eb6:c953 with SMTP id s9-20020a170902a50900b001437eb6c953mr73574142plq.4.1641783926508;
        Sun, 09 Jan 2022 19:05:26 -0800 (PST)
Received: from VICKYMQLIN-NB1.localdomain ([103.172.116.195])
        by smtp.gmail.com with ESMTPSA id ng7sm7099786pjb.41.2022.01.09.19.05.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jan 2022 19:05:26 -0800 (PST)
Date:   Mon, 10 Jan 2022 11:05:21 +0800
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Melissa Wen <mwen@igalia.com>
Cc:     dave.stevenson@raspberrypi.com, emma@anholt.net, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        eric@anholt.net
Subject: Re: [PATCH v2] drm/v3d: Fix PM disable depth imbalance in
 v3d_platform_drm_probe
Message-ID: <20220110030521.GA500@VICKYMQLIN-NB1.localdomain>
References: <CAPY8ntAdknutH=OmV1dWPbez1ZqLgaOj-BoQQkZAu0WbhbE6nQ@mail.gmail.com>
 <20220106124657.32737-1-linmq006@gmail.com>
 <20220109174817.drma7zfckeywvndc@mail.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109174817.drma7zfckeywvndc@mail.igalia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Melissa,

On Sun, Jan 09, 2022 at 04:48:17PM -0100, Melissa Wen wrote:
> On 01/06, Miaoqian Lin wrote:
> > The pm_runtime_enable will increase power disable depth.
> > If the probe fails, we should use pm_runtime_disable() to balance
> > pm_runtime_enable().
> > 
> >  	if (ret)
> > -		goto dma_free;
> > +		goto pm_disable;
> >  
> >  	ret = v3d_irq_init(v3d);
> >  	if (ret)
> > @@ -298,7 +298,8 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
> >  	v3d_irq_disable(v3d);
> >  gem_destroy:
> >  	v3d_gem_destroy(drm);
> > -dma_free:
> > +pm_disable:
> > +	pm_runtime_disable(dev);
> 
> Hi,
> 
> I see this pm_runtime_disable balancing is also missing for
> v3d_platform_drm_remove(), right?
> 
I think, yes. 

> >  	dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
> >  	return ret;
> >  }
> > -- 
> > 2.17.1
> > 


