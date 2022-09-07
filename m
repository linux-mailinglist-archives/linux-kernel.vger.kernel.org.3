Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71095B0E17
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIGUYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIGUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F5C6B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662582261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5UaXSiIgbyH1ySYWRQbLchBzx/eapwdqMLWdZscfW6U=;
        b=YOxdtNw57C8mcniVbtcXNYAZyL4ElpFxQ0FfArVLhCyrabaiqGQy6tvS+lDdRCXgtlZkuU
        rQs6P31rdzxHqoo39zXUjbV2g34eGDfX2JPhN5nDT6ktXz5RpIae9WlO34puw4AVyAvcmQ
        BzMfRV0PMkh/kebpcVazrbMKUcoDMlM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-470-7jkWVr3zPw-HZA9OT1assg-1; Wed, 07 Sep 2022 16:24:20 -0400
X-MC-Unique: 7jkWVr3zPw-HZA9OT1assg-1
Received: by mail-io1-f69.google.com with SMTP id b21-20020a5d8915000000b0068aaf634432so10034890ion.20
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 13:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5UaXSiIgbyH1ySYWRQbLchBzx/eapwdqMLWdZscfW6U=;
        b=7+RL65V9f+RR9lsaP/EsBzcPcSt5mwl6SancTT1jZW/wyURQXzc0ROEvA/CGzf+CwT
         PR6362w66d/aybipvsN9bU35IdiOiEMW86tbinBHVb48Ksc+jrVT3A4RiOFDRkGJSVcL
         LYpgBewpGXsGLfKWSLcQCn4q6UTVbOG8LmXW+GrK43p7rck3iX8yTxAnhmz1YcoLVxc2
         1hJgAOQT4c1q1dmxAZbOLu+8vzcCMuWnOh9E0LJce3T+8Bkwiu6s7rAvQlj8+9dT+ygL
         mCluknboGajn7QvL/I0EBut6vbzVGmhoofiU9C5xoK1nqAtGfGE9uD54gGdbNILSOuF+
         YSaQ==
X-Gm-Message-State: ACgBeo3tnHfXmEKSSskh1W9b1i8arYbwWIiGiEbmtm2kRauddTXHbljo
        9CVT2REbYft0+AdO5o+GCYxWypQ6y9F3VuNrMYnlCdJlOKAipvRlO62ij5vxJanWZgIRXsoW+sj
        FkSQxzVTlXgqhLE54wIB2s/9E
X-Received: by 2002:a05:6602:2d90:b0:689:bd77:5e62 with SMTP id k16-20020a0566022d9000b00689bd775e62mr2726528iow.176.1662582259107;
        Wed, 07 Sep 2022 13:24:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5MWr4hcZDzqPdQ1iXI8T98Zm9Rgv5WG1hrysH/zKP4LVZnm4+Zk3jgFjKc9Hk3tXQeUa5gNg==
X-Received: by 2002:a05:6602:2d90:b0:689:bd77:5e62 with SMTP id k16-20020a0566022d9000b00689bd775e62mr2726518iow.176.1662582258789;
        Wed, 07 Sep 2022 13:24:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id b17-20020a026f51000000b0034e0cdeecc2sm7584330jae.98.2022.09.07.13.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:24:18 -0700 (PDT)
Date:   Wed, 7 Sep 2022 14:24:16 -0600
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
Message-ID: <20220907142416.4badb879.alex.williamson@redhat.com>
In-Reply-To: <Yxj3Ri8pfqM1SxWe@ziepe.ca>
References: <166182871735.3518559.8884121293045337358.stgit@omen>
        <BN9PR11MB527655973E2603E73F280DF48C7A9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <d71160d1-5a41-eae0-6405-898fe0a28696@redhat.com>
        <YxfX+kpajVY4vWTL@ziepe.ca>
        <b365f30b-da58-39c0-08e9-c622cc506afa@redhat.com>
        <YxiTOyGqXHFkR/DY@ziepe.ca>
        <20220907095552.336c8f34.alex.williamson@redhat.com>
        <YxjJlM5A0OLhaA7K@ziepe.ca>
        <20220907125627.0579e592.alex.williamson@redhat.com>
        <Yxj3Ri8pfqM1SxWe@ziepe.ca>
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

On Wed, 7 Sep 2022 16:55:50 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Sep 07, 2022 at 12:56:27PM -0600, Alex Williamson wrote:
> 
> > I thought we'd already agreed that we were stuck with locked_vm for
> > type1 and any compatibility mode of type1 due to this.  Native iommufd
> > support can do the right thing since userspace will need to account for
> > various new usage models anyway.  
> 
> We did, that was for the iommufd situation (which will also hit the
> same zeropage issue, sigh) - this discussion is about fixing a bug in
> vfio and what many consider a bug in GUP.
> 
> My point is I'm still not convinced we can really consider these
> limits as ABI because it opens a pandoras box of kernel limitations.
> 
> > I've raised the issue with David for the zero page accounting, but I
> > don't know what the solution is.  libvirt automatically adds a 1GB
> > fudge factor to the VM locked memory limits to account for things like
> > ROM mappings, or at least the non-zeropage backed portion of those
> > ROMs.  I think that most management tools have adopted similar, so the
> > majority of users shouldn't notice.  However this won't cover all
> > users, so we certainly risk breaking userspace if we introduce hard
> > page accounting of zero pages.  
> 
> It sounds like things will be fine. 1GB fudge is pretty big.
> 
> For things like this ABI compat is not about absolute compatability in
> the face of any userspace, but a real-world compatibility "does
> something that actually exists break?"

Magic 8 ball says "Cannot predict now."  Unfortunately there's a lot of
roll-your-own scripting that goes on in this space, many users reject
the overhead of things like libvirt, let alone deeper management
stacks.  Private clouds have constraints that might also generate custom
solutions.  I can't predict the degree to which libvirt is a canonical
example.
 
> So I would be happier if we had an actual deployed thing that breaks..
> I would be inclined to go with the simple fix and rely on the
> fudge. If someone does come with an actual break then lets do one of
> the work arounds.

We should probably have a workaround in our pocket for such a case.

Also, I want to clarify, is this a recommendation relative to the
stable patch proposed here, or only once we get rid of shared zero page
pinning?  We can't simply do accounting on the shared zero page since a
single user can overflow the refcount.

> Given the whole thing is obstensibly for security it is better to keep
> it simple and sane then to poke it full of holes.
> 
> > module parameter defined limit.  We might also consider whether we
> > could just ignore zero page mappings, maybe with a optional "strict"
> > mode module option to generate an errno on such mappings.  Thanks,  
> 
> Once GUP is fixed vfio won't see the zero pages anymore :( That really
> limits the choices for a work around :(

I was afraid of that.  Thanks,

Alex

