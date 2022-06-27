Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A571A55C1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbiF0QgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiF0Qf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DF4ADEA2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656347757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ajZ6rDuNIkxlTWf9Tu/rlCccLsTD5TfeTqcQISFWLfw=;
        b=fxiYDgTDdtX9G9iaW7YJ/HTc/73hU8Ne3AKKE9DdCPBwj4plGxAmpSwOhNt94oVbPvPh0t
        pwjKn5OJQ9VW5NYhlbamDHIpXymDMagYaS1zfs379vch4Pd6q/6YB/g3Vfm1ca1acxnwxD
        SHZANirE8m62w456jQBoSG8jtuzzl7E=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-XDVFq1HSNFOtWkT-WtuZbQ-1; Mon, 27 Jun 2022 12:35:54 -0400
X-MC-Unique: XDVFq1HSNFOtWkT-WtuZbQ-1
Received: by mail-io1-f71.google.com with SMTP id q13-20020a5d9f0d000000b00669c03397f7so5953889iot.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ajZ6rDuNIkxlTWf9Tu/rlCccLsTD5TfeTqcQISFWLfw=;
        b=06acJGHkGPYB6T3Pv3PlYVDySyhmS1lpS0xj0+hKStIhFqlTuELYSwSD2tEGWhNW6C
         gjQQKKv4sC+DBiXlpvtaTBvAk4Uzfe3oohVsRjmCkJN/py9UH5/gikxSjcj9lEJp8ZaM
         7HW+7FyJ0ZX8nIGcsjpjudaPVDGXSQclDnKO6bq8NsfwFi6NGocT7nB4w9etz+YYF7IA
         JMzl0ORyjoBJpHTVdSUMNelh85rFNPom5yjdjg0F3oXAWekQQnAKcAC5Sv86DjtFLh/D
         OJeuaBFCp7i9zWzEpQMrlZobfq2JPS3btJnPzhmWnWP6bX9P82oXEqkw223o02xUWD3U
         Mp1A==
X-Gm-Message-State: AJIora9wk1+n0qz9hpWroF7KMlHMbh9KI0AZU1GMkqr/ErZ+T3AT63+P
        1EfLAzImxJJO3gd301GXsDUbg4Zigt5/z9OcXtLGThPf5wwoyFwXRBF+Nr88V5iiroaFq4drat/
        Iyd4sRlXmGAe4SMNytKr+k4AK
X-Received: by 2002:a05:6638:dc6:b0:332:3565:397a with SMTP id m6-20020a0566380dc600b003323565397amr7957163jaj.312.1656347753688;
        Mon, 27 Jun 2022 09:35:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vv1JOb9B1ol8/IGTBQLrpbIC5YwburDgiT1ESupNJ64ipmLjowP6AySpptuL2gZYgDyI57hw==
X-Received: by 2002:a05:6638:dc6:b0:332:3565:397a with SMTP id m6-20020a0566380dc600b003323565397amr7957152jaj.312.1656347753485;
        Mon, 27 Jun 2022 09:35:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id p20-20020a02b014000000b00339c015fd84sm4957144jah.59.2022.06.27.09.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:35:52 -0700 (PDT)
Date:   Mon, 27 Jun 2022 10:35:51 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kwankhede@nvidia.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, diana.craciun@oss.nxp.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, yishaih@nvidia.com, hch@lst.de
Subject: Re: [PATCH] vfio: de-extern-ify function prototypes
Message-ID: <20220627103551.48b34517.alex.williamson@redhat.com>
In-Reply-To: <20220610164407.25feeb23.alex.williamson@redhat.com>
References: <165471414407.203056.474032786990662279.stgit@omen>
        <20220610000434.GE1343366@nvidia.com>
        <20220610164407.25feeb23.alex.williamson@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 16:44:07 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 9 Jun 2022 21:04:34 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Jun 08, 2022 at 12:55:13PM -0600, Alex Williamson wrote:  
> > > The use of 'extern' in function prototypes has been disrecommended in
> > > the kernel coding style for several years now, remove them from all vfio
> > > related files so contributors no longer need to decide between style and
> > > consistency.
> > > 
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > > 
> > > A patch in the same vein was proposed about a year ago, but tied to an ill
> > > fated series and forgotten.  Now that we're at the beginning of a new
> > > development cycle, I'd like to propose kicking off the v5.20 vfio next
> > > branch with this patch and would kindly ask anyone with pending respins or
> > > significant conflicts to rebase on top of this patch.  Thanks!    
> > 
> > Can you stick it in your branch please?  
> 
> Thanks for the R-b, it was my plan today to put it in my next branch,
> but I can't currently test vfio on mainline due to:
> 
> https://lore.kernel.org/all/165490039431.944052.12458624139225785964.stgit@omen/
> 
> I'll get this in once there's a mainline base where vfio still works.  Thanks,

This has now been resolved in rc4 via 034e5afad921 ("mm: re-allow
pinning of zero pfns").  I've rebased to rc4 and pushed this patch out
to the vfio next branch.  Thanks,

Alex

