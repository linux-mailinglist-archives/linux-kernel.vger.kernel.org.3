Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514F35307D4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353259AbiEWCxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240967AbiEWCxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:53:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9414137A3E
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 19:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653274380; x=1684810380;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F71fg+0c4rtIQ1B5kg3uKaHKYbi2n82vhHHmVyMFuq8=;
  b=GPaWgFyGa8HnDqThJI+DzzTWhoYcA4KpSObZN0R8oI4sn+bjByX87Wh5
   uSNKjyORyuqm/6WHI0AZXp2lv6+OWIcqD1ZW5WeUKEu10rVvhlY63CCDv
   gCzZGgAIRaKLQ6dTsLdQrkALRXwvgiFUiq9u23it1vm9AaqNu/gzSSA2P
   8nKvt/PMWX5JWai1GImBV7jMUN3W8GL73q+7eMxIeinlD7D7qPx4Pzxtm
   269NnpqPt5CXw8hEOv2LLzzKrts1BkXqQNEjagxT8UnAFDJLYGWH7eWdy
   jL5tFsdczeONO4DLYMLE88dao5QkEJHAwt393fJ2eAWq5mmCVSBhTYmwU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="333726691"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="333726691"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 19:53:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="547687326"
Received: from avkale-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.2.202])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 19:52:56 -0700
Message-ID: <a4b2571d29accce04f0bd5308e31e557a8034caa.camel@intel.com>
Subject: Re: [PATCH v6 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 14:52:54 +1200
In-Reply-To: <aa8d221c-049c-24da-dc41-6d6572e29afb@linux.intel.com>
References: <20220512221952.3647598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220512221952.3647598-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <1292fe3206bef08304dc1bfe3185a9e6cec690fd.camel@intel.com>
         <aa8d221c-049c-24da-dc41-6d6572e29afb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-17 at 07:54 -0700, Sathyanarayanan Kuppuswamy wrote:
> > > +struct tdx_report_req {
> > > +	union {
> > > +		__u8 reportdata[TDX_REPORTDATA_LEN];
> > > +		__u8 tdreport[TDX_REPORT_LEN];
> > > +	};
> > > +};
> > 
> > As a userspace ABI, one concern is this doesn't provide any space for future
> > extension.  But probably it's OK since I don't see any possible additional
> > input
> > for now.  And although TDREPORT may have additional information in future
> > generation of TDX but the spec says the size is 1024 so perhaps this won't
> > change even in the future.
> > 
> > Anyway will leave to others.
> 
> IMO, if the spec changes in future we can revisit it.

I don't think the problem is how to revisit _this_ ABI.  The problem is, once it
is introduced, you cannot break the ABI for the compatibility of supporting the
userspace software written for old platforms.  So basically you cannot just
increase the TDX_REPORT_LEN to a larger value.  This means if we have a larger
than 1024B TDREPORT in future, the old userspace TD attestation software which
uses this ABI will not work anymore on the new platforms.

If we need to make sure this ABI work for _ANY_ TDX platforms, I think we either
need to make sure TDREPORT will always be 1024B for _ANY_ TDX platforms, or we
need to have a flexible ABI which doesn't assume TDREPORT size.

For instance, we might need another IOCTL (or other interfaces such as /sysfs)
to query the TDREPORT size, and make this IOCTL like below:

	struct tdx_report_req {
		__u8 reportdata[TDX_REPORTDATA_LEN];
		__u8 reserved[...];
		__u8 tdreport[0];
	};

The actual TDREPORT buffer size is allocated by userspace after it queries the
TDREPORT size.

-- 
Thanks,
-Kai


