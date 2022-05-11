Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B78523C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345972AbiEKR7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbiEKR7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:59:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24996FA29;
        Wed, 11 May 2022 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652291985; x=1683827985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DUZOrjH7fqcgzazv/V/BB2Fhn7UYV7GJ3oGWLAcIRoM=;
  b=OsH32nJY+pgaP1aBhQvZvIifx+g2oVjatvMJh1B53HnkgrFnKncmELP2
   Gb/qVQxa8Kf83X2GYj9GJSmuCm1zeD1kgdiJpOYiFLXjZrOzwwK0EEa52
   zUBRvNZY5dC65kPD4NX7d+mbehuGpcefVyxBYYt3+NBZhYTBX1fB2h/cD
   Di88iI3oBEHpyiV4+6YZBIk01qkKY40swZhwSsbcxq2Y46o+D/VnFEGq6
   ZnUYc4E4q6G6bK4bS/OleVAIPUm6T/iHQlvflciHvDiztL9+/+MAc+Pt/
   k+v9EWZdPc6vNvm43MQK9qWXgNeXMJ0bYv3hNNv5mVRIbpyIYqhjnAk7Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269441238"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="269441238"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:59:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="895453533"
Received: from mkmishra-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.36.168])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:59:44 -0700
Date:   Wed, 11 May 2022 10:59:43 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH V10 14/44] mm/pkeys: Introduce pks_set_readwrite()
Message-ID: <Ynv5j6nN8hyHob3C@iweiny-desk3>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
 <20220419170649.1022246-15-ira.weiny@intel.com>
 <202205091304.434A9B45@keescook>
 <YnraD8URWxWtaltF@iweiny-desk3>
 <202205101504.5B5C693F7C@keescook>
 <76ee55622592d531c82cb42b96d4bb27deb26287.camel@intel.com>
 <202205102008.88C15972@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205102008.88C15972@keescook>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 08:15:45PM -0700, Kees Cook wrote:
> On Tue, May 10, 2022 at 10:26:43PM +0000, Edgecombe, Rick P wrote:
> > v2: 
> > https://lore.kernel.org/lkml/20210830235927.6443-1-rick.p.edgecombe@intel.com/#r
> > 
> > Mostly it fit together pretty easily, but there was memory overhead
> > required to protect the page tables that map the direct map fully
> > (unless a better solution can be found).
> 
> Oh my, I totally missed this. Yay for Too Much Email Every Day. ;)
> 
> I'll give this a read; thanks for working on it!
> 
> Also, can you speak to the schedule of availability for PKS?

Sapphire Rapids is the first CPU.  But I can't speak to any dates.

I'm reworking the series now with your changes.

Thanks again for the review!
Ira
