Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB84519121
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243500AbiECWLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiECWLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:11:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0761E41F94
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651615698; x=1683151698;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nerbnEt4SBOpwjFze36Ela4kKXjEwa3lOOtHVDvZlP0=;
  b=aE6nPrTcecYb6HLvI34C3NWspuWUcvQOIINm7ptnIeHGhDx8cE7v2zN3
   qtBf63CGfHZ0z2NJgSvElOFTJFxuKrxOFSO/sb0s6od8H8mv6LTd03UZG
   zDRCUymrFxlnYz+kOYAOkM14oiQLcAR7/VJuWy3IhHDy3R//OfIgItUqG
   Q67m/WR8494v+NyvpJYe78X2gTvRm/JV9BuCzVx01VQ2lUxidJkkkvvdD
   gAEKjLI3LOxRhQhuOD92KIYRG/Ua8O5uTsq9zOiVL3dTT3Kk/TiZzkaBO
   VuuAp61aSwtbM7XnH6l4HrOluHizwaKrTnFPHJZ1zks+l1MKQaT+rAC1U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="266445598"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="266445598"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 15:08:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="536539873"
Received: from hsuhsiao-mobl2.gar.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.61.84])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 15:08:13 -0700
Message-ID: <42e1af54bef03361c1a23dac8d1e4ffd8e66114a.camel@intel.com>
Subject: Re: [PATCH v5 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Wander Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 04 May 2022 10:08:11 +1200
In-Reply-To: <cd48825b-7197-fc04-51e6-04bd8502d286@linux.intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <5473f606bd8e60dd7b8d58a540285d126a1361bd.camel@intel.com>
         <e5aed619-20ce-7eb3-22a3-64b51de9cce3@linux.intel.com>
         <b8eadd3079101a2cf93ee87d36dbedf93d8a2725.camel@intel.com>
         <e673ea3d-ae4f-39ed-33a5-c6480e58c6d8@linux.intel.com>
         <CAAq0SU=TPHQ4q8Dj583m0yfVytygN81BTEe8vU5GCOoFau+LWw@mail.gmail.com>
         <cd48825b-7197-fc04-51e6-04bd8502d286@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 08:09 -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> On 5/3/22 7:38 AM, Wander Costa wrote:
> > > I don't want to pollute the dmesg logs if possible. For IOCTL use case,
> > > the return value can be used to understand the failure reason from user
> > > code. But for initcall failure, pr_err message is required to understand
> > > the failure reason.
> > How often is this call expected to fail?
> 
> In general, it should not fail (so very low fail frequency). But the
> point is, we can easily understand this failure from user end. So we
> don't need to print more in non-debug environment.
> 
> > 

To support your statement, all the error codes return to userspace need to be
clearly documented around the IOCTL in the uapi header.  But I think you have to
do this anyway.

-- 
Thanks,
-Kai


