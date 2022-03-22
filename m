Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601914E3C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiCVKEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiCVKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:04:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670DD11A0D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:03:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id yy13so35086224ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jr6+3DLiK22UGPA/4UCdBp/K4JK2YnXWo0BRCRlc9P4=;
        b=oua8H4T2ABH4Fxb1AEHnQqs0+Nd/DRrkBFpa5TciYJATj1RP0krVsGQpLeZsaxvYF0
         N+Urr+Hx/Kh6pC+k2QptfrGexg2ley1p7XYCdfZWE8Ivu73f9AgKKmG7hf8lkXf8bzw/
         Z0NpdKYwpTQ+sJ9mMM5PlAZ0202v6wMvFE1o21BYlWi/zNDQglcErQlVwqDDxe4Js9dl
         fj2WRHeMhjOc4rbk/7y4lwFGU3IDEhGkHDXbNd5e70/+yzvGNxFbETpiUdqHdrImVWZg
         g1I7jnZOvGlJaiRe/ibZpxZ/cfu/Dupp8Eab0RUVMo1OJaBEk82skw39t9scygaCuyfe
         8a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jr6+3DLiK22UGPA/4UCdBp/K4JK2YnXWo0BRCRlc9P4=;
        b=muARSrBiOKoTV5umV6/rIT9j5qwY+5LiP9kEnNwIMGm5NlNnvLCxKFknOipZoAjT/L
         ST6QKlmGcg162oYt6o9Y4+6H0nYTV2JrOoVvAqDYI6XV89OE96yOUQGOR1DYs90/Polp
         1M6Emh0vfE/tOTfdASr9S9LDaDYD8y18AWcHDtZyByWvP2tm1emtZ0H8VbVmrLtuhAJ7
         /y9FKhJBlRlrvqw1RVjt1BwhWfTw94MCGTNHqq2o9nffydqT5+61ZlyjEPPZB9UvYE6u
         bf6HCZWbniRQ9HUL1NX26XiADpCKJs4KZraO/v3bXetf+x6+IJAsYockl4VO3uUqobhG
         bInQ==
X-Gm-Message-State: AOAM530CBgIIgLxcojGs+e0eLhqOFwF4yvlKN5xWSbcyflmgpwSEnMhp
        XWSKDOzx0NlzAFQsDllbq4oaRQ==
X-Google-Smtp-Source: ABdhPJwSJoDYsl+ypeZ55jb14aW2EgS7Ir7T4NruIJDojVC2fATtynQ+pT99XhjRyuMJT6TZzCejFw==
X-Received: by 2002:a17:907:6092:b0:6db:ab31:96a2 with SMTP id ht18-20020a170907609200b006dbab3196a2mr23916489ejc.361.1647943386426;
        Tue, 22 Mar 2022 03:03:06 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id sd33-20020a1709076e2100b006e0339b4a5asm1216694ejc.109.2022.03.22.03.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:03:06 -0700 (PDT)
Date:   Tue, 22 Mar 2022 10:02:41 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Message-ID: <YjmeweWTTUtPztYz@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica>
 <20220321124346.GP11336@nvidia.com>
 <64fa931b-ea2d-f425-5baa-654216bac779@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64fa931b-ea2d-f425-5baa-654216bac779@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 01:03:14PM +0800, Lu Baolu wrote:
> On 2022/3/21 20:43, Jason Gunthorpe wrote:
> > On Mon, Mar 21, 2022 at 11:42:16AM +0000, Jean-Philippe Brucker wrote:
> > 
> > > I tend to disagree with that last part. The fault is caused by a specific
> > > device accessing shared page tables. We should keep that device
> > > information throughout the fault handling, so that we can report it to the
> > > driver when things go wrong.
> > SVA faults should never be reported to drivers??
> > 
> 
> When things go wrong, the corresponding response code will be responded
> to the device through iommu_page_response(). The hardware should then
> report the failure to the device driver and the device driver will
> handle it in the device-specific way. There's no need to propagate the
> I/O page faults to the device driver in any case. Do I understand it
> right?

In theory yes, but devices don't necessarily have the ability to report
precise errors, we may have more information.

Thanks,
Jean

