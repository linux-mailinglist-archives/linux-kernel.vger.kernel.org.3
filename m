Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680D14AE58F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbiBHXmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiBHXmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:42:17 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BBBC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644363736; x=1675899736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZN/KZTfrbYax2SZ9l2CHYYmA37NRe0JPlS8tinExvVo=;
  b=AHaJ+hLnDnuzFM9xbXxZYBhXYjd3u5COl+vKcm9j0dEpCuOckxeZJ0To
   fSdQy9cBFDHqbPGLnZRQhLFp2bSR1dczUqPTK0+6kgBXBd/8btzQa6dMg
   3f6iHOtCyhoYPXhlbQVPoEcAEERyJsjZPgr2Y7Zft6d8eGHDe/FAoHqgV
   OHkN7b6FjLnh84L9NFUEdcYSJJsWLQqe1SulrNNaWtVj9k6kujW20VOl1
   MzGknK35e3m5PKk3mOWVQv2H3AOoDaN04FHvu/lr9n2wKUqUqq5J0UXko
   r/bR0ITCPWQT2y9iMMJcC0hCHmbmwh0VfERarhg+TEgcaX54GJrKJxaes
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="309822141"
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="309822141"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 15:42:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="540838470"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 15:42:16 -0800
Date:   Tue, 8 Feb 2022 15:42:16 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 36/44] memremap_pages: Reserve a PKS PKey for eventual
 use by PMEM
Message-ID: <20220208234215.GJ785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-37-ira.weiny@intel.com>
 <2193142f0cf3785a4225e0393eace397cbbe86e6.camel@intel.com>
 <CAPcyv4i_Jc865zEzNxbQB_XHqCwSS6zm_evquLv2BBu9ipa39Q@mail.gmail.com>
 <20220205054039.GE785175@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hcKsy1Z78OyhPK+gPCqqEsbr9fuNRzOBNah03guDzktA@mail.gmail.com>
 <20220208224803.GI785175@iweiny-DESK2.sc.intel.com>
 <CAPcyv4iPT8r9ButHRJ2DsPQQMBN1rHCe1zSiV-rrag9vdqoW7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iPT8r9ButHRJ2DsPQQMBN1rHCe1zSiV-rrag9vdqoW7w@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:22:22PM -0800, Dan Williams wrote:
> On Tue, Feb 8, 2022 at 2:48 PM Ira Weiny <ira.weiny@intel.com> wrote:
> [..]
> >  *      // 5) Add initial value to PKS_INIT_VALUE
> >  *      #define PKS_INIT_VALUE ((PKS_ALL_AD & (GENMASK(31, PKS_KEY_MAX * PKR_BITS_PER_PKEY))) | \
> >  *                              PKS_KEY_DEFAULT_INIT | \
> >  *                              PKS_KEY_MY_FEATURE_INIT | \
> 
> Does this compile? I.e. can you have a '|' operator with nothing on
> the right hand side?

Oops... yes but only because this is a comment (kernel doc) from the compiler
POV.  Thanks I'll fix it.

> 
> >  *                              )
> >  */
> >
> >
> > Let me know if this is clear enough?
> 
> Looks good to me.

Thanks,
Ira
