Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615E2529793
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbiEQC6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbiEQC6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:58:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD04746642
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652756323; x=1684292323;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xFqq2ABXOKTX15u5CiIDsBhVn6XBDrfngVVkwx21H4c=;
  b=Vhz75tZy2iYSQOczuD/NWK2UvqL88WnbmkcFW7Ql8K91CRW/6uRy5Rd1
   UR2Vo2K+y2tDu6Nvuq3RyjhQEr/dPrRZsSBG209KE13ysBxHvX6XHD498
   yM/lOgW7wBpjapAkSqLx5IqrUG+FNQkwG+ksI2/FeEr3d0UWyrIF9Zine
   pqBntcO81tTFBDDZ2vQjV/3e/UJMDcg67/bZLZaByG6uHgNE/+RdcsuiU
   kG4jA+CKnjQeZS0b/yM6qGONdAThzXNcwI9R3NASo9kzj7aNKnkmjhjzE
   p6eM4ItKYJUgaW6s+O4aKT+3EmJv3C5L11vJPhowXJmHakNQOpazvbV/h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271159407"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="271159407"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 19:58:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="816688708"
Received: from sandrocx-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.33.66])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 19:58:40 -0700
Message-ID: <38a7c7406f0b0c65e68679fb8399ffe3fae05cb2.camel@intel.com>
Subject: Re: [PATCH v6 5/5] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 17 May 2022 14:58:38 +1200
In-Reply-To: <c07c9fa1-ff6a-df8a-6050-60ade29367f3@linux.intel.com>
References: <20220512221952.3647598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220512221952.3647598-6-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220513185824.GB2913259@ls.amr.corp.intel.com>
         <c07c9fa1-ff6a-df8a-6050-60ade29367f3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-13 at 12:29 -0700, Sathyanarayanan Kuppuswamy wrote:
> > 
> > 
> > > +
> > > +	/* Wait for attestation completion */
> > > +	ret = wait_for_completion_interruptible(&entry->compl);
> > > +	if (ret < 0) {
> > > +		/*
> > > +		 * For premature termination, since VMM still owns the
> > > +		 * shared buffer, mark the request invalid to let
> > > +		 * quote_callback_handler() handle the memory cleanup
> > > +		 * function.
> > > +		 */
> > > +		invalidate_quote_request(entry);
> > 
> > Interrupt can arrive after signal interrupt.  So invalidate_quote_request()
> > should check if the request is already processed, and return 0 or -EINTR.
> > Probably check the state always and del_list under single lock/unlock pair.
> 
> Agree. But I think we should return -EINTR for the interrupted case
> irrespective of the processed status (so no return 0).
> 
> I will hold the lock and handle the cleanup for the processed
> status.

Even if we check the buffer status in invalidate_quote_request(), there's no
guarantee the VMM won't change the buffer status _after_ we do the check, so
looks such check isn't necessary.

-- 
Thanks,
-Kai


