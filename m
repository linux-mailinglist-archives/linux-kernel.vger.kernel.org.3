Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB524EC7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347808AbiC3PG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347795AbiC3PGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9943185BDC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648652678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tw2K5gl/MCSB4/A/fbU1d6ws7c+ie+K5t32hD35xsYk=;
        b=c6vpyXFSk5rqkJai2V17tt56byBC3Fzs8nWgZjP/ke5HZpC0TbTMb3XBc+uSqJ7PK0BxlP
        WA38ziMdl4gh7CqPmzzDyHKXreR4Y7NPfjd5okNv2uYYB4vUVEeaWFte/9a+otrW7+di/q
        6zKdqDnBwm+FGzAZPBWewWWJdfJj7uU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-JuezJQbhMqmkqlRniSWVKw-1; Wed, 30 Mar 2022 11:04:37 -0400
X-MC-Unique: JuezJQbhMqmkqlRniSWVKw-1
Received: by mail-il1-f199.google.com with SMTP id x1-20020a056e020f0100b002c98fce9c13so6604837ilj.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tw2K5gl/MCSB4/A/fbU1d6ws7c+ie+K5t32hD35xsYk=;
        b=DaTjVwAOfbjwW3S3HaoufRySzYYdURazwjzZtqqVSbrNOxoX1pb5JgN2IetvB6MRIw
         8QNgizeBlPGCR7a8d/4nl3IIOaIXFU0OgGT0UbIsLxDpGxySU1pPzhRl31eQrOPJqqZ9
         xmMQ3PI8Iq4T8hQPK5wgAXJNsG3/65ZbItW/YmFI4VoMFXskiPPjlVVEk/6BLPSDux1B
         sumWEPOU8vlNJDksNCMKFNlptansYdiBKC90YeCuza5r4zylRfP3nTxp94rbXOlHIwJZ
         p0ICObR2PJ9bxHcQV9wVzlo79zTjv3RM2wZAvAIlhx24nJ05GJq3l9/FgVg2yvjUw2vv
         0oYA==
X-Gm-Message-State: AOAM533ysvF/qDARTVujvutIkkp4E5Zt0mrgZUMSBYQ9UfegxNoipfAr
        Iyac4X/D/izOxJEn72FZ9HnG/j3OQNhjh6EL60TOnkkrPqEdEBiDe+WBUNoi5hXGVxC1LrYGbBr
        MBgETG7NXzOjvJznUSxrqTU/i
X-Received: by 2002:a05:6638:191d:b0:321:3acb:ac8a with SMTP id p29-20020a056638191d00b003213acbac8amr28070jal.212.1648652676283;
        Wed, 30 Mar 2022 08:04:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfihFwMtBBStLXYs+CPqbLhTdE7s40ejm+m3PFDIPROzfPRQ4jcPPTcNt2jC4McnNSgGoDWg==
X-Received: by 2002:a05:6638:191d:b0:321:3acb:ac8a with SMTP id p29-20020a056638191d00b003213acbac8amr28045jal.212.1648652675990;
        Wed, 30 Mar 2022 08:04:35 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id h24-20020a6bfb18000000b006497692016bsm11938613iog.15.2022.03.30.08.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 08:04:35 -0700 (PDT)
Date:   Wed, 30 Mar 2022 09:04:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add
 iommu_group_singleton_lockdown()
Message-ID: <20220330090434.22224951.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB52766A3E3BC82EEF437258198C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
        <20220329053800.3049561-3-baolu.lu@linux.intel.com>
        <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20220329114259.GB1716663@nvidia.com>
        <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20220330115820.GE1716663@nvidia.com>
        <BN9PR11MB52766A3E3BC82EEF437258198C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 14:18:47 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> +Alex
> 
> > From: Tian, Kevin
> > Sent: Wednesday, March 30, 2022 10:13 PM
> >   
> > > From: Jason Gunthorpe
> > > Sent: Wednesday, March 30, 2022 7:58 PM
> > >
> > > On Wed, Mar 30, 2022 at 06:50:11AM +0000, Tian, Kevin wrote:
> > >  
> > > > One thing that I'm not very sure is about DMA alias. Even when physically
> > > > there is only a single device within the group the aliasing could lead
> > > > to multiple RIDs in the group making it non-singleton. But probably we
> > > > don't need support SVA on such device until a real demand comes?  
> > >
> > > How can we have multiple RIDs in the same group and have only one
> > > device in the group?  
> > 
> > Alex may help throw some insight here. Per what I read from the code
> > looks like certain device can generate traffic with multiple RIDs.

You only need to look so far as the dma alias quirks to find devices
that use the wrong RID for DMA.  In general I don't think we have
enough confidence to say that for all these devices the wrong RID is
exclusively used versus some combination of both RIDs.  Also, the
aliased RID is not always a physical device.  Thanks,

Alex

