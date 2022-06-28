Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4E55E759
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346187AbiF1OLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345924AbiF1OLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:11:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E91736150
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:11:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l68so2402848wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z6rZSThE7hjHMykxwD6G3CLunLDgT8dkRZWO7hFrMlc=;
        b=E14bCHFAJHEKjAz3a2lSSKKAKgMH8nSUaKpBBhdBtLPYkBu0W31aQtkY03sC1zEkVc
         FiDofXOMIBM6p89lrcTgMas9mDeuNZ2IdHzWfFBULzcC45sbYJVkKgvhrufDwGDkwSby
         mbNRGEjJ2jkCWZBxE+1M5f+xMG1cZFeiJeiWGhuCZcZedEV9Yee4Kij8RkBC9PhrLfj0
         jzR8t7i4zLmaqwwRlVbW5uh5yAr+iVTRaNP2FGEOa72yoXEOY1DDzcVlb03F08k3F7C/
         MaAJ3rAMWURmtIcyWHe+yyTuzKWiOEq6IjUKpQCN+SFhgMUN4uNUHhdkVX6DFfwXzc+c
         Wp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z6rZSThE7hjHMykxwD6G3CLunLDgT8dkRZWO7hFrMlc=;
        b=S+giV4jLBtywBX9e3iNYh5cojcAOGE5f3/gOoBdPFNDERPm7gD0VvVahNS8ks7yX+r
         kSaiy6xMN45Yl8LMr2n9YlNp1QH0IaML6f4PeALXgOMMO7N2sr7KSC5clMnv9DihET8I
         9RC5pxljv1n0VKqrlE6aSjycMNeEliEPFbGu+jLIad3DV3E4IX+r9vU0lBt/FCWSWUp4
         U+1hKS/rzAPZ+RKBBH9EtF5Nd/FjaJC6NWBwYsi41Ly9d9vC39vwcqWw56OGqYHk3hOQ
         UDZxzXfDITMdGrn9AFTyCStnRv8wVcEAUkpq6+pjesASdUblYB+bd9Rbn1uat6ay6VzB
         5PAw==
X-Gm-Message-State: AJIora8qqQjpXizd7KfpzDziYGOCvo6UJb9pEjsmmFr+h1ED7q1sivY0
        UHdlJlskuHcSTtYiP4gQGUnW5w==
X-Google-Smtp-Source: AGRyM1sYVVXgAazao0K/lpqse9gQZXQrTog4KvhzBzsiHswnBk9UIffH0I3WCPb3MN3iprzQZzmnFQ==
X-Received: by 2002:a05:600c:34d0:b0:3a0:2c07:73ac with SMTP id d16-20020a05600c34d000b003a02c0773acmr27247171wmq.85.1656425498512;
        Tue, 28 Jun 2022 07:11:38 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id ay5-20020a05600c1e0500b003a04e900552sm3796880wmb.1.2022.06.28.07.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:11:38 -0700 (PDT)
Date:   Tue, 28 Jun 2022 14:11:36 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, qperret@google.com,
        maz@kernel.org, linux-watchdog@vger.kernel.org, will@kernel.org,
        vdonnefort@google.com
Subject: Re: [PATCH v8 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YrsMGAVljIcypDl4@google.com>
References: <20220627102810.1811311-1-sebastianene@google.com>
 <20220627102810.1811311-3-sebastianene@google.com>
 <b87a4407-29fd-4715-1394-ae6afaf4a192@roeck-us.net>
 <YrrP3NvAuxso0rzO@google.com>
 <194f5edc-5877-af3f-9aa1-be1e275ea304@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194f5edc-5877-af3f-9aa1-be1e275ea304@roeck-us.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 07:00:05AM -0700, Guenter Roeck wrote:
> On 6/28/22 02:54, Sebastian Ene wrote:
> [ ... ]
> > > > +static struct platform_device *virt_dev;
> > > > +

Hi,

> > > 
> > > virt_dev is only used to call platform_set_drvdata() and platform_get_drvdata()
> > > on it. Why not just have a static variable named vm_stall_detect ?
> > > 
> > 
> > I think this should also work. I wanted to make use of the provided APIs
> > like platform_set/platform_get.
> > 
> 
> That doesn't mean such APIs should be used just to get used, though.
> 

I will remove these calls and keep it static.

> > > > +
> > > > +	vm_stall_detect = (struct vm_stall_detect_s __percpu *)
> > > > +		platform_get_drvdata(virt_dev);
> > > 
> > > platform_get_drvdata() returns void *; typecast to it is unnecessary.
> > > 
> > > 
> > 
> > I needed this typecast because the variable is per-cpu and some
> > compilers(eg. gcc for ARCH=h8300) complain if we don't specify this
> > hint.
> > 
> Hmm, interesting. I didn't know that. We live and learn.
> Though h8300 is gone now :-)

I had some Intel robot complaining about this in my previous series(v5) and
I fixed the warnings by adding these compiler hints.

> 
> Did you reply in private on purpose ?
> 

I misused my CC list but I will fix this in my reply. 

> Thanks,
> Guenter

Thanks for the response,
Seb
