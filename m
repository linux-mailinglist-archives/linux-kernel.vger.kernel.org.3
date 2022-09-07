Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016645B0CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiIGS4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIGS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3B352DCB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662576991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YJaq4uQt8YTpG3CQacvvUHsHF+mngH79gUDPmqckto=;
        b=I3XQexzloRl+rd/M4olYE5v9JcZPbY6FtwWWT05gNu8ZVrGY5m/ZsYRK7+2WCqZXsw2Mv7
        sqbRIToBaWtBH7PiQJX1bNgcgt32fEg9u+5XkU3/BZfEhN6uB0crSbsdaY2QUcFLXVAD8o
        IXE8K/cDIGbYx7fX1aXzukS5aKZTNoc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-326-6mQW1Y7bNA6cQFngxnZ9zw-1; Wed, 07 Sep 2022 14:56:30 -0400
X-MC-Unique: 6mQW1Y7bNA6cQFngxnZ9zw-1
Received: by mail-io1-f71.google.com with SMTP id a21-20020a5d9815000000b006882e9be20aso9668412iol.17
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 11:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5YJaq4uQt8YTpG3CQacvvUHsHF+mngH79gUDPmqckto=;
        b=bOB5LxdzMG2VwqKkN241OLBtRK9NtoxxsTmCSuYi0CPFwX8sRtVhpmBYGekFe10ct0
         r4WH+OWayEZATtHZudHTCSbiPGBoVjYYfiLnXpAgcSQGbvx/pfFwa7Wytv2CmCH5Ex2r
         k2CVA0lE0JresSSiFS/aAA1X3eiVYNLb3IpR+yPFnPAzSxDzzOdTNjoYgcKmktmk8y7W
         pLbNaA60l7BZrvgxQ9dcjCawWl3DeqbyHT+ochUC9FFfEvkB6pvgBJbwhLoFiJyK1saz
         uORjk7xcz03EvX7SaB9nLVRltO5/3HWAOletjNtjNsI8yzJb6x7bNCJHwiMJoW0DjXGb
         hMsQ==
X-Gm-Message-State: ACgBeo17y2Ti/TopQv68Khrs0mlLuIXXPmKwbIJs0laWBM6ywKQ/NqMP
        vd+g5Xx28uB7lRb0KzZRK7IvCeYEQI0T5pSO5uSamlcpjANSJ9h85ME8QoEBj+YS8apc8KRbcbJ
        OswlGBF/+JGBHxnLnltK9bDTJ
X-Received: by 2002:a05:6638:480d:b0:351:afa0:c0d4 with SMTP id cp13-20020a056638480d00b00351afa0c0d4mr2907981jab.224.1662576990136;
        Wed, 07 Sep 2022 11:56:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5/9wDhADVEi2ig72bDIEuDrX41uZ4Uvmvy7hzrtllkWwtnVqlqgakvbyE2mrVz+pxdDiij1w==
X-Received: by 2002:a05:6638:480d:b0:351:afa0:c0d4 with SMTP id cp13-20020a056638480d00b00351afa0c0d4mr2907970jab.224.1662576989922;
        Wed, 07 Sep 2022 11:56:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i133-20020a6bb88b000000b00689257fef39sm119339iof.4.2022.09.07.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:56:29 -0700 (PDT)
Date:   Wed, 7 Sep 2022 12:56:27 -0600
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
Message-ID: <20220907125627.0579e592.alex.williamson@redhat.com>
In-Reply-To: <YxjJlM5A0OLhaA7K@ziepe.ca>
References: <166182871735.3518559.8884121293045337358.stgit@omen>
        <BN9PR11MB527655973E2603E73F280DF48C7A9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <d71160d1-5a41-eae0-6405-898fe0a28696@redhat.com>
        <YxfX+kpajVY4vWTL@ziepe.ca>
        <b365f30b-da58-39c0-08e9-c622cc506afa@redhat.com>
        <YxiTOyGqXHFkR/DY@ziepe.ca>
        <20220907095552.336c8f34.alex.williamson@redhat.com>
        <YxjJlM5A0OLhaA7K@ziepe.ca>
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

On Wed, 7 Sep 2022 13:40:52 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Sep 07, 2022 at 09:55:52AM -0600, Alex Williamson wrote:
> 
> > > So, if we go back far enough in the git history we will find a case
> > > where PUP is returning something for the zero page, and that something
> > > caused is_invalid_reserved_pfn() == false since VFIO did work at some
> > > point.  
> > 
> > Can we assume that?  It takes a while for a refcount leak on the zero
> > page to cause an overflow.  My assumption is that it's never worked, we
> > pin zero pages, don't account them against the locked memory limits
> > because our is_invalid_reserved_pfn() test returns true, and therefore
> > we don't unpin them.  
> 
> Oh, you think it has been buggy forever? That is not great..
>  
> > > IHMO we should simply go back to the historical behavior - make
> > > is_invalid_reserved_pfn() check for the zero_pfn and return
> > > false. Meaning that PUP returned it.  
> > 
> > We've never explicitly tested for zero_pfn and as David notes,
> > accounting the zero page against the user's locked memory limits has
> > user visible consequences.  VMs that worked with a specific locked
> > memory limit may no longer work.    
> 
> Yes, but the question is if that is a strict ABI we have to preserve,
> because if you take that view it also means because VFIO has this
> historical bug that David can't fix the FOLL_FORCE issue either.
> 
> If the view holds for memlock then it should hold for cgroups
> also. This means the kernel can never change anything about
> GFP_KERNEL_ACCOUNT allocations because it might impact userspace
> having set a tight limit there.
> 
> It means we can't fix the bug that VFIO is using the wrong storage for
> memlock.
> 
> It means qemu can't change anything about how it sets up this memory,
> ie Kevin's idea to change the ordering.
> 
> On the other hand the "abi break" we are talking about is that a user
> might have to increase a configured limit in a config file after a
> kernel upgrade.
> 
> IDK what consensus exists here, I've never heard of anyone saying
> these limits are a strict ABI like this.. I think at least for cgroup
> that would be so invasive as to immediately be off the table.

I thought we'd already agreed that we were stuck with locked_vm for
type1 and any compatibility mode of type1 due to this.  Native iommufd
support can do the right thing since userspace will need to account for
various new usage models anyway.

I've raised the issue with David for the zero page accounting, but I
don't know what the solution is.  libvirt automatically adds a 1GB
fudge factor to the VM locked memory limits to account for things like
ROM mappings, or at least the non-zeropage backed portion of those
ROMs.  I think that most management tools have adopted similar, so the
majority of users shouldn't notice.  However this won't cover all
users, so we certainly risk breaking userspace if we introduce hard
page accounting of zero pages.

I think David suggested possibly allowing some degree of exceeding
locked memory limits for zero page COWs.  Potentially type1 could do
this as well; special case handling with some heuristically determined,
module parameter defined limit.  We might also consider whether we
could just ignore zero page mappings, maybe with a optional "strict"
mode module option to generate an errno on such mappings.  Thanks,

Alex

