Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBEC4AE4FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiBHWxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiBHWxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:53:12 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FB1C03BFC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644360484; x=1675896484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bDjbc7a8gSNWr0CNwiCwFD57OMjLNFpmq07jWfLcy2c=;
  b=istsD0rla+Wu1sEotBK9fpPk1aBXkDcnBaZi7uJQ6N22DRA4Ntq2498N
   VnIwJYI7hkYPB6UPaG4VLjj11uZ6o4zUa7GdlkV7Lo9FQ6EGvnTKJI+1j
   ytVMIfZ4WdX0mv7AeztBkLg/GjbJjCtZ9A4OAtpgxYjQI4c+LYhSVWCZi
   Za3caBTcYrqSuUEbr1alzG6hpcUqZdFyTTkw/rtLJQqjaYRTBIRwjByI2
   hXRzEH04XP90drFOd2eo1Nih3vBqaHKYiPKIs20aAd9/HYUBtR/wLf0BV
   m7TEJNkk9URKjR8ijn+x3Y023djgK43cg2SeOJuzPuoWae5qa67yMThj0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="273603216"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="273603216"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 14:48:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,354,1635231600"; 
   d="scan'208";a="540821583"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 14:48:04 -0800
Date:   Tue, 8 Feb 2022 14:48:03 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 36/44] memremap_pages: Reserve a PKS PKey for eventual
 use by PMEM
Message-ID: <20220208224803.GI785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-37-ira.weiny@intel.com>
 <2193142f0cf3785a4225e0393eace397cbbe86e6.camel@intel.com>
 <CAPcyv4i_Jc865zEzNxbQB_XHqCwSS6zm_evquLv2BBu9ipa39Q@mail.gmail.com>
 <20220205054039.GE785175@iweiny-DESK2.sc.intel.com>
 <CAPcyv4hcKsy1Z78OyhPK+gPCqqEsbr9fuNRzOBNah03guDzktA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hcKsy1Z78OyhPK+gPCqqEsbr9fuNRzOBNah03guDzktA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 12:19:27AM -0800, Dan Williams wrote:
> On Fri, Feb 4, 2022 at 9:40 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Fri, Feb 04, 2022 at 09:12:11AM -0800, Dan Williams wrote:
> > > On Tue, Feb 1, 2022 at 10:35 AM Edgecombe, Rick P
> > > <rick.p.edgecombe@intel.com> wrote:
> > > >
> > > > On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> > > > >  enum pks_pkey_consumers {
> > > > > -       PKS_KEY_DEFAULT         = 0, /* Must be 0 for default PTE
> > > > > values */
> > > > > -       PKS_KEY_TEST            = 1,
> > > > > -       PKS_KEY_NR_CONSUMERS    = 2,
> > > > > +       PKS_KEY_DEFAULT                 = 0, /* Must be 0 for default
> > > > > PTE values */
> > > > > +       PKS_KEY_TEST                    = 1,
> > > > > +       PKS_KEY_PGMAP_PROTECTION        = 2,
> > > > > +       PKS_KEY_NR_CONSUMERS            = 3,
> > > > >  };
> > > >
> > > > The c spec says that any enum member that doesn't have an "=" will be
> > > > one more than the previous member. As a consequence you can leave the
> > > > "=" off PKS_KEY_NR_CONSUMERS and it will get auto adjusted when you add
> > > > more like this.
> > > >
> > > > I know we've gone around and around on this, but why also specify the
> > > > value for each key? They should auto increment and the first one is
> > > > guaranteed to be zero.
> >
> > Because it was easier to ensure that the init value had all the defaults
> > covered.
> >
> > > >
> > > > Otherwise this doesn't use any of the features of "enum", it's just a
> > > > verbose series of const int's.
> >
> > True but does this really matter?
> >
> > >
> > > Going further, this can also build in support for dynamically (at
> > > build time) freeing keys based on config, something like:
> > >
> > > enum {
> > > #if IS_ENABLED(CONFIG_PKS_TEST)
> > > PKS_KEY_TEST,
> > > #endif
> > > #if IS_ENABLED(CONFIG_DEVMAP_PROTECTION)
> > > PKS_KEY_PGMAP_PROTECTION,
> > > #endif
> > > PKS_KEY_NR_CONSUMERS,
> > > }
> >
> > This is all well and good until you get to the point of trying to define the
> > initial MSR value.
> >
> > What Rick proposes without the Kconfig check is easier than this.  But to do
> > what both you and Rick suggest this is the best crap I've been able to come up
> > with that actually works...
> >
> >
> > /* pkeys_common.h */
> > #define PKR_AD_BIT 0x1u
> > #define PKR_WD_BIT 0x2u
> > #define PKR_BITS_PER_PKEY 2
> >
> > #define PKR_PKEY_SHIFT(pkey)    (pkey * PKR_BITS_PER_PKEY)
> >
> > #define PKR_KEY_INIT_RW(pkey)   (0          << PKR_PKEY_SHIFT(pkey))
> > #define PKR_KEY_INIT_AD(pkey)   (PKR_AD_BIT << PKR_PKEY_SHIFT(pkey))
> > #define PKR_KEY_INIT_WD(pkey)   (PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
> >
> >
> > /* pks-keys.h */
> > #define PKR_KEY_MASK(pkey)   (0xffffffff & ~((PKR_WD_BIT|PKR_AD_BIT) << PKR_PKEY_SHIFT(pkey)))
> >
> > enum pks_pkey_consumers {
> >         PKS_KEY_DEFAULT                 = 0, /* Must be 0 for default PTE values */
> > #if IS_ENABLED(CONFIG_PKS_TEST)
> >         PKS_KEY_TEST,
> > #endif
> > #if IS_ENABLED(CONFIG_DEVMAP_ACCESS_PROTECTION)
> >         PKS_KEY_PGMAP_PROTECTION,
> > #endif
> >         PKS_KEY_NR_CONSUMERS
> > };
> >
> > #define PKS_DEFAULT_VALUE PKR_KEY_INIT_RW(PKS_KEY_DEFAULT)
> > #define PKS_DEFAULT_MASK  PKR_KEY_MASK(PKS_KEY_DEFAULT)
> >
> > #if IS_ENABLED(CONFIG_PKS_TEST)
> > #define PKS_TEST_VALUE PKR_KEY_INIT_AD(PKS_KEY_TEST)
> > #define PKS_TEST_MASK  PKR_KEY_MASK(PKS_KEY_TEST)
> > #else
> > /* Just define another default value to fool the CPP */
> > #define PKS_TEST_VALUE PKR_KEY_INIT_RW(0)
> > #define PKS_TEST_MASK  PKR_KEY_MASK(0)
> > #endif
> >
> > #if IS_ENABLED(CONFIG_DEVMAP_ACCESS_PROTECTION)
> > #define PKS_PGMAP_VALUE PKR_KEY_INIT_AD(PKS_KEY_PGMAP_PROTECTION)
> > #define PKS_PGMAP_MASK  PKR_KEY_MASK(PKS_KEY_PGMAP_PROTECTION)
> > #else
> > /* Just define another default value to fool the CPP */
> > #define PKS_PGMAP_VALUE PKR_KEY_INIT_RW(0)
> > #define PKS_PGMAP_MASK  PKR_KEY_MASK(0)
> > #endif
> >
> > #define PKS_INIT_VALUE ((0xFFFFFFFF & \
> >                         (PKS_DEFAULT_MASK & \
> >                                 PKS_TEST_MASK & \
> >                                 PKS_PGMAP_MASK \
> >                         )) | \
> >                         (PKS_DEFAULT_VALUE | \
> >                         PKS_TEST_VALUE | \
> >                         PKS_PGMAP_VALUE \
> >                         ) \
> >                         )
> >
> >
> > I find the above much harder to parse and of little value.  I'm pretty sure
> > that someone adding a key is much more likely to get the macro maze wrong.
> > Reviewing a patch to add a key would be much more difficult as well, IMHO.
> >
> > I'm a bit tired of this back and forth trying to implement this for features
> > which may never exist.  In all my discussions I don't think we have reached
> > more than 10 use cases in our wildest dreams and only 4 have even been
> > attempted with real code including the PKS test.
> >
> > So I'm just a bit frustrated with the effort we have put in to try and do
> > dynamic or even compile time dynamic keys.
> >
> > Anyway I'll think on it more.  But I'm inclined to leave it alone right now.
> > What I have is easy to review for correctness and only takes a bit of effort to
> > actually use.
> 
> Sorry, for the thrash Ira, I felt compelled to put some skin in the
> game and came up with the below. Ignore the names they are just to
> show the idea:
> 
> #define KEYVAL(prev, config) (prev + __is_defined(config))
> #define KEYDEFAULT(key, default, config) ((default << (key * 2)) *
> __is_defined(config))
> #define KEYX KEYVAL(0, ENABLE_X)
> #define KEYY KEYVAL(KEYX, ENABLE_Y)
> #define KEYZ KEYVAL(KEYY, ENABLE_Z)
> #define KEYMAX KEYVAL(KEYZ, 1)
> 
> #define KEY0_INIT 0x1
> #define KEYX_INIT KEYDEFAULT(KEYX, 2, ENABLE_X)
> #define KEYY_INIT KEYDEFAULT(KEYY, 2, ENABLE_Y)
> #define KEYZ_INIT KEYDEFAULT(KEYZ, 2, ENABLE_Z)
> 
> #define ALL_AD 0x55555555
> #define DEFAULT (ALL_AD & (GENMASK(31, KEYMAX * 2))) | KEYX_INIT |
> KEYY_INIT | KEYZ_INIT | KEY0_INIT
> 
> The idea is that this relies on a defined key order, but still
> dynamically assigns key values at compile time. It's not as simple as
> an enum, but it still seems readable to me.
> 
> The definition is done in 2 parts key slot numbers (KEYVAL()) and the
> values they need to inject into the combined global init mask
> (KEYDEFAULT()). The KEYVAL() section above defines the key order where
> each key gets an incremented value in the order, but only if the
> previous key was defined. KEYDEFAULT() defines the init value and
> optionally zeros out the init value if the config is disabled. Finally
> the DEFAULT mask is initialized to all 5s if there are zero keys
> defined, but otherwise masks 2-bits per defined key + 1 and ORs in the
> corresponding key init values. This uses some of the magic behind the
> IS_ENABLED() macro to turn undefined symbols into 0s.
> 
> It seems to work, for example if I just define KEYX and KEYZ,
> 
> #define ENABLE_X 1
> #define ENABLE_Z 1
> 
>         printf("X: %d:%#x Y: %d:%#x Z: %d:%#x MAX: %d DEFAULT: %#x\n", KEYX,
>                KEYX_INIT, KEYY, KEYY_INIT, KEYZ, KEYZ_INIT, KEYMAX, DEFAULT);
> 
> # ./a.out
> X: 1:0x8 Y: 1:0 Z: 2:0x20 MAX: 3 DEFAULT: 0x55555569

Yes this seems to work.  I still think it is a bit clunky, but after
documenting it I think it is clear enough.  I also played with making it a bit
more straight forward with the macro names.

Here is the doc:

/**
 * DOC: PKS_KEY_ALLOCATION
 *
 * Users reserve a key value in 5 steps.
 *      1) Use PKS_NEW_KEY to create a new key
 *      2) Ensure that the last key value is used in the PKS_NEW_KEY macro
 *      3) Adjust PKS_KEY_MAX to use the newly defined key value
 *      4) Use PKS_DECLARE_INIT_VALUE to define an initial value
 *      5) Add the new PKS default value to PKS_INIT_VALUE
 *
 * The PKS_NEW_KEY and PKS_DECLARE_INIT_VALUE macros require the Kconfig
 * option to be specified to automatically adjust the number of keys used.
 *
 * PKS_KEY_DEFAULT must remain 0 (prev = 0) key with a default of
 * PKS_DECLARE_DEFAULT_RW support non-pks protected pages.
 *
 * For example to configure a key for 'MY_FEATURE' with a default of Write
 * Disabled.
 *
 * .. code-block:: c
 *
 *      #define PKS_KEY_DEFAULT    PKS_NEW_KEY(0, 1)
 *
 *      // 1) Add PKS_KEY_MY_FEATURE
 *      // 2) Be sure to use the last defined key in the macro
 *      #define PKS_KEY_MY_FEATURE PKS_NEW_KEY(PKS_KEY_DEFAULT, CONFIG_MY_FEATURE)
 *
 *      // 3) Adjust PKS_KEY_MAX
 *      #define PKS_KEY_MAX        PKS_NEW_KEY(PKS_KEY_MY_FEATURE, 1)
 *
 *
 *      #define PKS_KEY_DEFAULT_INIT    PKS_DECLARE_INIT_VALUE(PKS_KEY_DEFAULT, RW, 1)
 *
 *      // 4) Define initial value
 *      #define PKS_KEY_MY_FEATURE_INIT PKS_DECLARE_INIT_VALUE(PKS_KEY_MY_FEATURE, WD, CONFIG_MY_FEATURE)
 *
 *      // 5) Add initial value to PKS_INIT_VALUE
 *      #define PKS_INIT_VALUE ((PKS_ALL_AD & (GENMASK(31, PKS_KEY_MAX * PKR_BITS_PER_PKEY))) | \
 *                              PKS_KEY_DEFAULT_INIT | \
 *                              PKS_KEY_MY_FEATURE_INIT | \
 *                              )
 */


Let me know if this is clear enough?
Ira
