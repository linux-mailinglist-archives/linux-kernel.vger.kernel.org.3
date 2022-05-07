Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D3451E2D9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 03:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445132AbiEGBEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 21:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiEGBEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 21:04:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE98382
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651885221; x=1683421221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EOSFhRhbz+/bz+QOG86PzVeITplmnupDdPk76oBcmd8=;
  b=fW1mYDXPPrk9HKnpZlidpvXiFQY4jD4gZchiM/VCsM2rcONnHJeuxTeP
   nbcXqVpTqDVJq0O0ejh8CNDFOKDV6D1k5TFO1Wq+7arPSeY3gGixEBn/E
   DXI2zcAFMVRASAaftA613GSbcFhgzvCfnLd81AkRGSwrstRQr9JNRFveV
   H3ZEYUx2WC6AxkxzZZrDKrN0ov0qgL1rVWcH/dgf5OB12ZVn5ldBQ1aY2
   H/iOLBeP64lSA92hxXkKIef4/axDmiL72ItbkfYgTxnFDCBGvWoXHRb5Z
   NA+XQ92U0yammYSXiuIQwOCD4hvb5pvyxo2n2WEn3MrmvYbN4fX13tCaP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="266210778"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="266210778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 18:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="550099699"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 06 May 2022 18:00:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4090C9B; Sat,  7 May 2022 04:00:15 +0300 (EEST)
Date:   Sat, 7 May 2022 04:00:15 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
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
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Message-ID: <20220507010015.fcnaupwbenzl5qbs@black.fi.intel.com>
References: <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
 <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
 <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
 <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
 <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
 <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
 <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
 <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
 <c3003e378504d2cd034e54bca6cab4d6bb53e008.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3003e378504d2cd034e54bca6cab4d6bb53e008.camel@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 11:00:29PM +1200, Kai Huang wrote:
> However I may have missed something.  Kirill please help to confirm if you see
> this.

That's correct. set_memory_decrypted() will change direct mapping as well
even if called on vmap(). I should have catched it before. Sorry.

-- 
 Kirill A. Shutemov
