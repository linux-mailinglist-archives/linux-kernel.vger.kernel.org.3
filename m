Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB8D505DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbiDRSKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiDRSKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:10:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E426369E5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650305282; x=1681841282;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dyyMH0xpZtsmvKPKBHxyzRSqFnhpIBPEXWOqpua1DEE=;
  b=YQj2Wk+wvtCBxdy+uZDZsMmnM0HC+CaZ4JM8XrwDBqAtWtSEEEgzaY9o
   VtBn5qPE5K0tuAPDvRvBO0JF7BkCeZy2MgeN94ENWwM9ywGbNRdVGvOwv
   oNZv8rTk8dSt8Y2rFmcWN4sDiBsttCkZGS5IP5UUm/m85RfATpJJhNqb1
   kY4Uf/Y6EzY4BOwgdIZpmIIS9AcoCSuMfJoYxQNiuBvi7rfDCNOlSja5s
   zwjYDHwTBg8b/2XCNwzGGrPG+8s/x/fJfw8/GtU61vztofUqVpnD2wWXQ
   FvORxNpSxfox6zdCiwpNJMST+dFO0PetUx2wdyxdHVHLcJ/+06m1SOV/c
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262440361"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="262440361"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 11:08:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="529659339"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 11:08:01 -0700
Date:   Mon, 18 Apr 2022 11:11:35 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        jean-philippe <jean-philippe@linaro.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220418111135.6260d450@jacob-builder>
In-Reply-To: <BN9PR11MB52765490BFC5F08CD4F7A9208CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
        <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
        <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
        <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
        <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
        <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
        <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
        <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
        <YllADL6uMoLllzQo@fyu1.sc.intel.com>
        <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
        <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
        <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
        <20220415140002.7c12b0d2@jacob-builder>
        <BN9PR11MB52765490BFC5F08CD4F7A9208CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Mon, 18 Apr 2022 06:34:19 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, April 16, 2022 5:00 AM
> > 
> > Hi zhangfei.gao@foxmail.com,
> > 
> > On Fri, 15 Apr 2022 19:52:03 +0800, "zhangfei.gao@foxmail.com"
> > <zhangfei.gao@foxmail.com> wrote:
> >   
> > > >>> A PASID might be still used even though it is freed on mm exit.
> > > >>>
> > > >>> process A:
> > > >>> 	sva_bind();
> > > >>> 	ioasid_alloc() = N; // Get PASID N for the mm
> > > >>> 	fork(): // spawn process B
> > > >>> 	exit();
> > > >>> 	ioasid_free(N);
> > > >>>
> > > >>> process B:
> > > >>> 	device uses PASID N -> failure
> > > >>> 	sva_unbind();
> > > >>>
> > > >>> Dave Hansen suggests to take a refcount on the mm whenever
> > > >>> binding  
> > the  
> > > >>> PASID to a device and drop the refcount on unbinding. The mm
> > > >>> won't  
> > be  
> > > >>> dropped if the PASID is still bound to it.
> > > >>>
> > > >>> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID
> > > >>> allocation and free it on mm exit")
> > > >>>  
> > Is process A's mm intended to be used by process B? Or you really should
> > use PASID N on process B's mm? If the latter, it may work for a while
> > until B changes mapping.
> > 
> > It seems you are just extending the life of a defunct mm?
> >   
> 
> IMHO the intention is not to allow B to access A's mm.
> 
> The problem is that PASID N is released on exit() of A and then
> reallocated to B before iommu driver gets the chance to quiesce
> the device and clear the PASID entry. According to the discussion
> the quiesce operation must be done when driver calls unbind()
> instead of in mm exit. In this case a failure is reported when
> B tries to call bind() on PASID N due to an already-present entry.
> 
> Dave's patch extending the life of A's mm until unbind() is called.
> With it B either gets a different PASID before A's unbind() is 
> completed or same PASID N pointing to B's mm after A's unbind().
> 
As long as B gets a different PASID, that is fine. It seems PASID N has no
use then.

> Thanks
> Kevin


Thanks,

Jacob
