Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0F520ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 03:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbiEJBoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 21:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiEJBoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 21:44:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42DD2BB1B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652146811; x=1683682811;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DR3wN2x6Pr5dYK0lRzAW/+NtoVTIzkGo2sj/9c7Y7Ek=;
  b=Mq6yP3K7I5ZWSgzLH2Z0By77/thfOZqdfsb4Y2of4k86MuwGmHRZrR/i
   gm/nwKAEYovMvUZA/hlcgG2dgmORiIAsUczHO6b29pRFeazTPu4Q5Wp5j
   e16ui/0Tb+lbx4HQcjT7F0FobHd6kXqK17HrVlyrZwX0ILfepwef6lGq+
   3O8KtAtar+6ioirOtbnzjiUdkMPMXD0LSPjdOOOSoKDqk+4wSObdFegJl
   GR4zDUwY09pLtK/pVjqqxv667D15KSvd+Xw6jR9fAHLvoNBSCGJWL+SEc
   JEUriaOnLr+qv2Dio5ZPVo08LRTNWJWAypIiLPCQJfNlNrV7MW4lQ7KYE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266814670"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="266814670"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 18:40:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="813744001"
Received: from abehrenx-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.1.104])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 18:40:07 -0700
Message-ID: <7cadc7777238a50dec4c18119e1c68fd3c5cfe96.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 May 2022 13:40:05 +1200
In-Reply-To: <20220510013038.ggubvsrwf7pyoamk@box.shutemov.name>
References: <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
         <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
         <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
         <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
         <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
         <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
         <20220507004236.5p5dyksftge7wwr3@black.fi.intel.com>
         <45d184273f1950320843f6696eb3071f7d354fd3.camel@intel.com>
         <20220509120927.7rg6v5pyc3f4pxsh@box.shutemov.name>
         <75d4755c9a376df2e98a267e10e60da3bd178b17.camel@intel.com>
         <20220510013038.ggubvsrwf7pyoamk@box.shutemov.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-10 at 04:30 +0300, Kirill A. Shutemov wrote:
> On Tue, May 10, 2022 at 11:54:12AM +1200, Kai Huang wrote:
> > On Mon, 2022-05-09 at 15:09 +0300, Kirill A. Shutemov wrote:
> > > On Mon, May 09, 2022 at 03:37:22PM +1200, Kai Huang wrote:
> > > > On Sat, 2022-05-07 at 03:42 +0300, Kirill A. Shutemov wrote:
> > > > > On Fri, May 06, 2022 at 12:11:03PM +1200, Kai Huang wrote:
> > > > > > Kirill, what's your opinion?
> > > > > 
> > > > > I said before that I think DMA API is the right tool here.
> > > > > 
> > > > > Speculation about future of DMA in TDX is irrelevant here. If semantics
> > > > > change we will need to re-evaluate all users. VirtIO uses DMA API and it
> > > > > is conceptually the same use-case: communicate with the host.
> > > > 
> > > > Virtio is designed for device driver to use, so it's fine to use DMA API. And
> > > > real DMA can happen to the virtio DMA buffers.  Attestation doesn't have such
> > > > assumption.
> > > 
> > > Whether attestation driver uses struct device is implementation detail.
> > > I don't see what is you point.
> > 
> > No real DMA is involved in attestation.
> 
> As with VirtIO. So what?
> 

No real DMA can happen to virtio buffer.  Consider DPDK which uses virtio +
vhost-user.  But I don't want to argue anymore about this topic. :)

-- 
Thanks,
-Kai


