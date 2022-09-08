Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE75B11D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiIHBK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiIHBK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2516481697
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 18:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662599423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBVNTAaj/cyOP+0D1quiD6nGu9/sCuXJHNiZG6zvz1Y=;
        b=aN8cwZO13VU6Brsj8v4rr1n+hvDyYRZWs68AS10/rPSnO84378Z1QInpl+K8Pzz7XbUn+s
        PmXEZBr+brzRhOT3YYgwJ68wx3dOMLeePHP8ljd30zwM9SugJu2LALP5cVCWtD3heq+qdB
        kPc7SXiszLvhLS++ya9uMoyKfTHcFuA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-zygMO9qGNBC0Q1A6zUPJRQ-1; Wed, 07 Sep 2022 21:10:21 -0400
X-MC-Unique: zygMO9qGNBC0Q1A6zUPJRQ-1
Received: by mail-il1-f197.google.com with SMTP id o15-20020a056e02188f00b002f01f1dfebcso12729635ilu.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 18:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=KBVNTAaj/cyOP+0D1quiD6nGu9/sCuXJHNiZG6zvz1Y=;
        b=TrT4EECA+pbQ5wpbS1uFwDQKjMN1dtfD1SE5UvNeZlwMt2iIOmqmxGmVWJ+ev2/psV
         ytVNR4Ttg1WPp/94HzGSMhTV1BgDPsaUtLnVW/WSb5R93hX0QiAbgFR6ppcGcQ8O24es
         yVwKZl2RiksF0B/yJcDKCfydbZfd9HSJuw55iwWAadDT9A7NLOhr6kLDYOtVko4Hu6XL
         ASlaVRQBrvdQAr8HwF/pXSHAqtqbH6IMA8g4F0/HqzChzpPMF1iz4/DG9mXK0l08FCMr
         tolXQTIyQwjR5OQ/6aZYALPPFco+LA1NuLVhZfNkJcqRI/qo965Xo6KatJlGle5LfEgb
         nk7w==
X-Gm-Message-State: ACgBeo0qrjA64HrZAFOXsDiMKmWaQLJZgC6YbBl8Yfzv4ZWeBs2kkZQ+
        Zrf5+Um4Pj2XHjNqH6G5nS3Z4dabCzQJmBMbiuUA+R/KjsxE7thaxAhjTT9LtQvINNvvw2w6x5u
        491x2B7wmZSO/Q8/+jamNxsEv
X-Received: by 2002:a05:6638:2614:b0:350:248:ab1a with SMTP id m20-20020a056638261400b003500248ab1amr3637709jat.269.1662599421193;
        Wed, 07 Sep 2022 18:10:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6MvU+kgY20NRGKN9anTKXZxglys0F1AnqNzqNoZt+NdhDd+9sucOubCjbbgHlRJMMzGYqI+w==
X-Received: by 2002:a05:6638:2614:b0:350:248:ab1a with SMTP id m20-20020a056638261400b003500248ab1amr3637696jat.269.1662599420949;
        Wed, 07 Sep 2022 18:10:20 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 66-20020a020a45000000b00349c2336d39sm7820954jaw.171.2022.09.07.18.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 18:10:20 -0700 (PDT)
Date:   Wed, 7 Sep 2022 19:10:19 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     David Hildenbrand <david@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lpivarc@redhat.com" <lpivarc@redhat.com>,
        "Liu, Jingqi" <jingqi.liu@intel.com>,
        "Lu, Baolu" <baolu.lu@intel.com>
Subject: Re: [PATCH] vfio/type1: Unpin zero pages
Message-ID: <20220907191019.6340f754.alex.williamson@redhat.com>
In-Reply-To: <YxkkFiToNSw3CgrP@ziepe.ca>
References: <BN9PR11MB527655973E2603E73F280DF48C7A9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <d71160d1-5a41-eae0-6405-898fe0a28696@redhat.com>
        <YxfX+kpajVY4vWTL@ziepe.ca>
        <b365f30b-da58-39c0-08e9-c622cc506afa@redhat.com>
        <YxiTOyGqXHFkR/DY@ziepe.ca>
        <20220907095552.336c8f34.alex.williamson@redhat.com>
        <YxjJlM5A0OLhaA7K@ziepe.ca>
        <20220907125627.0579e592.alex.williamson@redhat.com>
        <Yxj3Ri8pfqM1SxWe@ziepe.ca>
        <20220907142416.4badb879.alex.williamson@redhat.com>
        <YxkkFiToNSw3CgrP@ziepe.ca>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022 20:07:02 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Sep 07, 2022 at 02:24:16PM -0600, Alex Williamson wrote:
> 
> > Also, I want to clarify, is this a recommendation relative to the
> > stable patch proposed here, or only once we get rid of shared zero page
> > pinning?  We can't simply do accounting on the shared zero page since a
> > single user can overflow the refcount.  
> 
> Yes, here I would account properly in a way that keeps working for
> future GUP changes because if something goes wrong with this simple
> patch it has a simple fix.
> 
> Trialing it will get some good data to inform what David's patch
> should do.
> 
> Overall have the feeling that a small group of people might grumble
> that their limits break, but with a limit adjustment they can probably
> trivially move on. It would be very interesting to see if someone
> feels like the issue is important enough to try and get something
> changed.
> 
> You could also fix it by just using FOLL_FORCE (like RDMA/io_uring
> does), which fixes the larger issue Kevin noted that the ROM doesn't
> become visible to DMA.

That's only a theoretical problem, I suspect there are absolutely zero
cases where this is an actual problem.  Doing anything other than
simply fixing the leak for stable seems reckless, we're not actually
consuming resources that need to be accounted until David's changes
come through, and we risk breaking users on a broad scale.  IMO, the
fix proposed here is the correct first step and we can start
experimenting with accounting the zero page moving forward.  Thanks,

Alex

