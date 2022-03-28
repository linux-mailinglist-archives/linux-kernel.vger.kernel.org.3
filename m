Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392BD4EA2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiC1WJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiC1WHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:07:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B122A13CED5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648504875; x=1680040875;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MoJJ7PpyY30zJiWm4s27HVjf2QmYd2IbqH48aFV+r4o=;
  b=ezbr+1WecsUVnzOlGib5YzuCjxLK7by4BGLw3kkIw38OmXDUdTUcfB9+
   K41itfz+pkuEn9UaFs6tjR2uz7rcLF1HeSqek3TZWbiwsGGWy6PwTU10s
   wxATxupkB4UsTzWMlsNfaiWvjQ6NKW/ZeyvLsFKRtPWnxPyXP8uxma1oK
   WWzamK0lKBt/zEcyjO1zKvFfd8fMSTt1mz8pP7muPRG6LrL7diRGO+VwM
   ECuElNRCPmeQDAePmaLDyRLKak2zELujnAfmig48y+q8cwX8O6Kt7ktQL
   qAEVKzHGkCRcQQMg5QI9/YWK5DH5imNY5UuSrOTpRajozHvQ+LrtlHFJK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="257936479"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="257936479"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 14:38:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="564026275"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 14:38:33 -0700
Date:   Mon, 28 Mar 2022 14:41:56 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220328144156.66ba6f39@jacob-builder>
In-Reply-To: <BN9PR11MB5276FF347A54098F469936978C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
        <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
        <20220315143322.GW11336@nvidia.com>
        <BN9PR11MB5276E98AE37EA912B01EB0B68C119@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20220316140140.76bb24c6@jacob-builder>
        <BN9PR11MB5276FF347A54098F469936978C139@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Fri, 18 Mar 2022 05:33:38 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan
> > Sent: Thursday, March 17, 2022 5:02 AM
> > 
> > Hi Kevin,
> > 
> > On Wed, 16 Mar 2022 07:41:34 +0000, "Tian, Kevin" <kevin.tian@intel.com>
> > wrote:
> >   
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Tuesday, March 15, 2022 10:33 PM
> > > >
> > > > On Mon, Mar 14, 2022 at 10:07:07PM -0700, Jacob Pan wrote:  
> > > > > +	/*
> > > > > +	 * Each domain could have multiple devices attached with
> > > > > shared or  
> > > > per  
> > > > > +	 * device PASIDs. At the domain level, we keep track of
> > > > > unique PASIDs  
> > > > and  
> > > > > +	 * device user count.
> > > > > +	 * E.g. If a domain has two devices attached, device A
> > > > > has PASID 0, 1;
> > > > > +	 * device B has PASID 0, 2. Then the domain would have
> > > > > PASID 0, 1, 2.
> > > > > +	 */  
> > > >
> > > > A 2d array of xarray's seems like a poor data structure for this
> > > > task.  
> > >  
> > Perhaps i mis-presented here, I am not using 2D array. It is an 1D
> > xarray for domain PASIDs only. Then I use the existing device list in
> > each domain, adding another xa to track per-device-domain PASIDs.  
> > > besides that it also doesn't work when we support per-device PASID
> > > allocation in the future. In that case merging device PASIDs together
> > > is conceptually wrong.
> > >  
> > Sorry, could you elaborate? If we do per-dev PASID allocation, we could
> > use the ioasid_set for each pdev, right?  
> 
> My point is simply about the comment above which says the domain
> will have PASID 0, 1, 2 when there is [devA, PASID0] and [devB, PASID0].
> You can maintain a single  PASID list only when it's globally allocated
> cross devices. otherwise this has to be a tuple including device and
> PASID.
> 
Got you, you are right we don't want to limit to globally allocated scheme.

Thanks,

Jacob
