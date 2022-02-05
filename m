Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5460A4AA6EC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 06:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbiBEFls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 00:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiBEFln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 00:41:43 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Feb 2022 21:41:42 PST
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D2CC061346
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 21:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644039702; x=1675575702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e7h91uG9gFzk8os7ey825VYijrgfLN45ZHagC7mGNZ8=;
  b=iVamqqcCqMY6h4RSYnH74Wiayox7Ft1g8er2+ohtrfDMbj2f4CruSOk8
   wcsGjdeKPZ9+TLAHAydFxySn3glcRqYCsmurovSOvjDg+SUUvz5WDSUaF
   oX2FeKtP4/jAZ2jSdczeBev+hwnEqMcEFY5oBXhNWPqK7zH0raBPrRzeQ
   oI0FR6RHp/EHSGyA87r3nrwFmHMQ6jjY783Qj40V3Aa0C3+kKDJnq2THX
   /yFYH7WcTdNo4ORSOp8LwDujXj3oU47+yEvvqvWUTSidIT8yIobcezGvC
   aORH5hmddqUw0oquObUDEPhhYXA1aRmqLlGnJ6Mgj5rXBg2raoPQkUMXr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248439406"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="248439406"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 21:40:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="539432637"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 21:40:39 -0800
Date:   Fri, 4 Feb 2022 21:40:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 36/44] memremap_pages: Reserve a PKS PKey for eventual
 use by PMEM
Message-ID: <20220205054039.GE785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-37-ira.weiny@intel.com>
 <2193142f0cf3785a4225e0393eace397cbbe86e6.camel@intel.com>
 <CAPcyv4i_Jc865zEzNxbQB_XHqCwSS6zm_evquLv2BBu9ipa39Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i_Jc865zEzNxbQB_XHqCwSS6zm_evquLv2BBu9ipa39Q@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 09:12:11AM -0800, Dan Williams wrote:
> On Tue, Feb 1, 2022 at 10:35 AM Edgecombe, Rick P
> <rick.p.edgecombe@intel.com> wrote:
> >
> > On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> > >  enum pks_pkey_consumers {
> > > -       PKS_KEY_DEFAULT         = 0, /* Must be 0 for default PTE
> > > values */
> > > -       PKS_KEY_TEST            = 1,
> > > -       PKS_KEY_NR_CONSUMERS    = 2,
> > > +       PKS_KEY_DEFAULT                 = 0, /* Must be 0 for default
> > > PTE values */
> > > +       PKS_KEY_TEST                    = 1,
> > > +       PKS_KEY_PGMAP_PROTECTION        = 2,
> > > +       PKS_KEY_NR_CONSUMERS            = 3,
> > >  };
> >
> > The c spec says that any enum member that doesn't have an "=" will be
> > one more than the previous member. As a consequence you can leave the
> > "=" off PKS_KEY_NR_CONSUMERS and it will get auto adjusted when you add
> > more like this.
> >
> > I know we've gone around and around on this, but why also specify the
> > value for each key? They should auto increment and the first one is
> > guaranteed to be zero.

Because it was easier to ensure that the init value had all the defaults
covered.

> >
> > Otherwise this doesn't use any of the features of "enum", it's just a
> > verbose series of const int's.

True but does this really matter?

> 
> Going further, this can also build in support for dynamically (at
> build time) freeing keys based on config, something like:
> 
> enum {
> #if IS_ENABLED(CONFIG_PKS_TEST)
> PKS_KEY_TEST,
> #endif
> #if IS_ENABLED(CONFIG_DEVMAP_PROTECTION)
> PKS_KEY_PGMAP_PROTECTION,
> #endif
> PKS_KEY_NR_CONSUMERS,
> }

This is all well and good until you get to the point of trying to define the
initial MSR value.

What Rick proposes without the Kconfig check is easier than this.  But to do
what both you and Rick suggest this is the best crap I've been able to come up
with that actually works...


/* pkeys_common.h */
#define PKR_AD_BIT 0x1u
#define PKR_WD_BIT 0x2u
#define PKR_BITS_PER_PKEY 2

#define PKR_PKEY_SHIFT(pkey)    (pkey * PKR_BITS_PER_PKEY)

#define PKR_KEY_INIT_RW(pkey)   (0          << PKR_PKEY_SHIFT(pkey))
#define PKR_KEY_INIT_AD(pkey)   (PKR_AD_BIT << PKR_PKEY_SHIFT(pkey))
#define PKR_KEY_INIT_WD(pkey)   (PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))


/* pks-keys.h */
#define PKR_KEY_MASK(pkey)   (0xffffffff & ~((PKR_WD_BIT|PKR_AD_BIT) << PKR_PKEY_SHIFT(pkey)))

enum pks_pkey_consumers {
        PKS_KEY_DEFAULT                 = 0, /* Must be 0 for default PTE values */
#if IS_ENABLED(CONFIG_PKS_TEST)
        PKS_KEY_TEST,
#endif
#if IS_ENABLED(CONFIG_DEVMAP_ACCESS_PROTECTION)
        PKS_KEY_PGMAP_PROTECTION,
#endif
        PKS_KEY_NR_CONSUMERS
};

#define PKS_DEFAULT_VALUE PKR_KEY_INIT_RW(PKS_KEY_DEFAULT)
#define PKS_DEFAULT_MASK  PKR_KEY_MASK(PKS_KEY_DEFAULT)

#if IS_ENABLED(CONFIG_PKS_TEST)
#define PKS_TEST_VALUE PKR_KEY_INIT_AD(PKS_KEY_TEST)
#define PKS_TEST_MASK  PKR_KEY_MASK(PKS_KEY_TEST)
#else
/* Just define another default value to fool the CPP */
#define PKS_TEST_VALUE PKR_KEY_INIT_RW(0)
#define PKS_TEST_MASK  PKR_KEY_MASK(0)
#endif

#if IS_ENABLED(CONFIG_DEVMAP_ACCESS_PROTECTION)
#define PKS_PGMAP_VALUE PKR_KEY_INIT_AD(PKS_KEY_PGMAP_PROTECTION)
#define PKS_PGMAP_MASK  PKR_KEY_MASK(PKS_KEY_PGMAP_PROTECTION)
#else
/* Just define another default value to fool the CPP */
#define PKS_PGMAP_VALUE PKR_KEY_INIT_RW(0)
#define PKS_PGMAP_MASK  PKR_KEY_MASK(0)
#endif

#define PKS_INIT_VALUE ((0xFFFFFFFF & \
                        (PKS_DEFAULT_MASK & \
                                PKS_TEST_MASK & \
                                PKS_PGMAP_MASK \
                        )) | \
                        (PKS_DEFAULT_VALUE | \
                        PKS_TEST_VALUE | \
                        PKS_PGMAP_VALUE \
                        ) \
                        )


I find the above much harder to parse and of little value.  I'm pretty sure
that someone adding a key is much more likely to get the macro maze wrong.
Reviewing a patch to add a key would be much more difficult as well, IMHO.

I'm a bit tired of this back and forth trying to implement this for features
which may never exist.  In all my discussions I don't think we have reached
more than 10 use cases in our wildest dreams and only 4 have even been
attempted with real code including the PKS test.

So I'm just a bit frustrated with the effort we have put in to try and do
dynamic or even compile time dynamic keys.

Anyway I'll think on it more.  But I'm inclined to leave it alone right now.
What I have is easy to review for correctness and only takes a bit of effort to
actually use.

Ira
