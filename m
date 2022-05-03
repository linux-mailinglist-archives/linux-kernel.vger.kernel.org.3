Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F61E51911E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiECWQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiECWQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:16:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E8122BD0
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651615990; x=1683151990;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9y1o13Jnc3sNHkfQ4nWL2H1O8Uay9UdoCnrexGtkWpg=;
  b=n3+zLmRGMn5FC0SOf5STwMpkiy9khOeH9eRj096VhTwBEu6H7HPDKRdc
   BCo5PnhDqW0RZN6eL9V0WpETT8AGyFgxb14VJUDHF/+rIpCD0rWQYr74u
   UNzHZCiqT9od/VqhvVFiA0Db4JIq3FQX44bVdFQ9GTmEm2WTZL0qZNrl9
   gsQuEYJlULqw3fRYPCRlGuxfs8T7dM0hZFil71EyyEcpxlrQqIBjvxa/c
   XBSefXhcFS//Msi8GarMx5G7AscwIQKoMbxB3TE+JtLkkyuwdiEe1abGR
   apR6uOADi+txqmKTAsdYLL8we5h89nndwLn5Kq1TSIF9ZfV6CkwAno66/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="247508585"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="247508585"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 15:13:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="708204922"
Received: from hsuhsiao-mobl2.gar.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.61.84])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 15:13:07 -0700
Message-ID: <44c001bc83efa58df7cd8f67cd1fb0916e8a3e9d.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 May 2022 10:13:05 +1200
In-Reply-To: <ac299f99-7ef6-7fc2-a9fe-7ed2586b9b09@linux.intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
         <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
         <4cf22a0799cc13fa6f09ffbf0e5d83ed7eeb32ad.camel@intel.com>
         <ac299f99-7ef6-7fc2-a9fe-7ed2586b9b09@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-02 at 19:39 -0700, Sathyanarayanan Kuppuswamy wrote:
> > 
> > Using vmap() we can still (almost) avoid private/shared conversion at IOCTL
> > time
> > by allocating a default size buffer (which is large enough to cover 99%
> > cases,
> > etc) at driver initialization time:
> 
> Allocating fixed size buffer pool will work for dma buffer allocation
> as well.
> 
> So the comparison is between platform driver boilerplate code vs vmap
> and shared/unshared code addition. It is arguable which is better. I
> think it is about preference.

Not really.  DMA buffer is guaranteed to be shared for now, but it's not
guaranteed in the future generations of TDX.

-- 
Thanks,
-Kai


