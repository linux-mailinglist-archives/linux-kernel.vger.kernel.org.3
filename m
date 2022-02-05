Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905664AA79A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 09:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiBEITl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 03:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiBEITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 03:19:40 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFE3C061346
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 00:19:39 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i186so7166694pfe.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 00:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=paBqmuu478q2rXZrtWsn4b97nu3hT1PEdB6U35C9rvI=;
        b=n52w2LGP507L06FUIwpZ6bhzL2wh68jEbqTVgKVuah+Sydw/byU2gCaWq7/fSJZ3JV
         +A9oDOol/FwgTCrX/tnl/ZJETT5ecAeRNUzOrHjQaf1OepQ4L0ozq0eXJk58kwr6y7H6
         eqDhC+OzoYbsnKIqmcQKzBK05a9qDQqsRU/eivQd/H+b8YPzNo8dGB5TSpsa+EJTnalE
         Wko51XVAzRTRDMFSemFJtaoG//0cbrm/dIF7i/X9ao3qTJ78beUkkztS7gLrsdvDaJPg
         TdOqsKa4aDgQOje+WrhzkCJyuVRVoiRMXB9QuMDUu53iApd7RE1RGkS38tkjP3N/Uou/
         6cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=paBqmuu478q2rXZrtWsn4b97nu3hT1PEdB6U35C9rvI=;
        b=aEYyKjrS196S5urrWAGjUs+1kxbYQ/3GzNORV/Za+K7QpylbJ1F0aNAhQGz6mEdki4
         /bWq84gGJ+2D48+5eIGMsRnRD9HpzB1jv25+UQynNyYdEuF3Qgf2WvmD7EFEECjsxPFy
         IJ9C0p5g0Pc4PArgWUjvJD0zxIAUXAxSbGId/CRoNOH8RtTwudbuJPOEor6Yj1QYa9H6
         98RQxSkvrXsOvS5xl2qR/llzm1AWAmYCsyL/GobLu3D4ONn9eTrGP/J5+SNK0nrJC/X6
         VaLSORgMlRub0MSEIFz7O0RJ38DU++E6PH/nYvlYbx3L7d6ya0g8b6hFB0AwU/6opZ7Z
         jMBQ==
X-Gm-Message-State: AOAM530KaOZYrvCRjcB523YavYxK5FW7SMxEIkkhU6a8oELoS88YrbYS
        VlNK2oWRrmIFh+48R8bw1m9d+MsR7d6veB/cCHD6CMx+seybiw==
X-Google-Smtp-Source: ABdhPJwEz3+o7xrbeCV/v3liyb6unATfXzQ1+u3nc1bN/5nc+QZbtdO+0EZ7xJHqjVS9/+NXSY08Z6PuX/nvl/t4RVE=
X-Received: by 2002:a63:550f:: with SMTP id j15mr2191237pgb.40.1644049178591;
 Sat, 05 Feb 2022 00:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-37-ira.weiny@intel.com>
 <2193142f0cf3785a4225e0393eace397cbbe86e6.camel@intel.com>
 <CAPcyv4i_Jc865zEzNxbQB_XHqCwSS6zm_evquLv2BBu9ipa39Q@mail.gmail.com> <20220205054039.GE785175@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20220205054039.GE785175@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 5 Feb 2022 00:19:27 -0800
Message-ID: <CAPcyv4hcKsy1Z78OyhPK+gPCqqEsbr9fuNRzOBNah03guDzktA@mail.gmail.com>
Subject: Re: [PATCH V8 36/44] memremap_pages: Reserve a PKS PKey for eventual
 use by PMEM
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 9:40 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Feb 04, 2022 at 09:12:11AM -0800, Dan Williams wrote:
> > On Tue, Feb 1, 2022 at 10:35 AM Edgecombe, Rick P
> > <rick.p.edgecombe@intel.com> wrote:
> > >
> > > On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> > > >  enum pks_pkey_consumers {
> > > > -       PKS_KEY_DEFAULT         = 0, /* Must be 0 for default PTE
> > > > values */
> > > > -       PKS_KEY_TEST            = 1,
> > > > -       PKS_KEY_NR_CONSUMERS    = 2,
> > > > +       PKS_KEY_DEFAULT                 = 0, /* Must be 0 for default
> > > > PTE values */
> > > > +       PKS_KEY_TEST                    = 1,
> > > > +       PKS_KEY_PGMAP_PROTECTION        = 2,
> > > > +       PKS_KEY_NR_CONSUMERS            = 3,
> > > >  };
> > >
> > > The c spec says that any enum member that doesn't have an "=" will be
> > > one more than the previous member. As a consequence you can leave the
> > > "=" off PKS_KEY_NR_CONSUMERS and it will get auto adjusted when you add
> > > more like this.
> > >
> > > I know we've gone around and around on this, but why also specify the
> > > value for each key? They should auto increment and the first one is
> > > guaranteed to be zero.
>
> Because it was easier to ensure that the init value had all the defaults
> covered.
>
> > >
> > > Otherwise this doesn't use any of the features of "enum", it's just a
> > > verbose series of const int's.
>
> True but does this really matter?
>
> >
> > Going further, this can also build in support for dynamically (at
> > build time) freeing keys based on config, something like:
> >
> > enum {
> > #if IS_ENABLED(CONFIG_PKS_TEST)
> > PKS_KEY_TEST,
> > #endif
> > #if IS_ENABLED(CONFIG_DEVMAP_PROTECTION)
> > PKS_KEY_PGMAP_PROTECTION,
> > #endif
> > PKS_KEY_NR_CONSUMERS,
> > }
>
> This is all well and good until you get to the point of trying to define the
> initial MSR value.
>
> What Rick proposes without the Kconfig check is easier than this.  But to do
> what both you and Rick suggest this is the best crap I've been able to come up
> with that actually works...
>
>
> /* pkeys_common.h */
> #define PKR_AD_BIT 0x1u
> #define PKR_WD_BIT 0x2u
> #define PKR_BITS_PER_PKEY 2
>
> #define PKR_PKEY_SHIFT(pkey)    (pkey * PKR_BITS_PER_PKEY)
>
> #define PKR_KEY_INIT_RW(pkey)   (0          << PKR_PKEY_SHIFT(pkey))
> #define PKR_KEY_INIT_AD(pkey)   (PKR_AD_BIT << PKR_PKEY_SHIFT(pkey))
> #define PKR_KEY_INIT_WD(pkey)   (PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
>
>
> /* pks-keys.h */
> #define PKR_KEY_MASK(pkey)   (0xffffffff & ~((PKR_WD_BIT|PKR_AD_BIT) << PKR_PKEY_SHIFT(pkey)))
>
> enum pks_pkey_consumers {
>         PKS_KEY_DEFAULT                 = 0, /* Must be 0 for default PTE values */
> #if IS_ENABLED(CONFIG_PKS_TEST)
>         PKS_KEY_TEST,
> #endif
> #if IS_ENABLED(CONFIG_DEVMAP_ACCESS_PROTECTION)
>         PKS_KEY_PGMAP_PROTECTION,
> #endif
>         PKS_KEY_NR_CONSUMERS
> };
>
> #define PKS_DEFAULT_VALUE PKR_KEY_INIT_RW(PKS_KEY_DEFAULT)
> #define PKS_DEFAULT_MASK  PKR_KEY_MASK(PKS_KEY_DEFAULT)
>
> #if IS_ENABLED(CONFIG_PKS_TEST)
> #define PKS_TEST_VALUE PKR_KEY_INIT_AD(PKS_KEY_TEST)
> #define PKS_TEST_MASK  PKR_KEY_MASK(PKS_KEY_TEST)
> #else
> /* Just define another default value to fool the CPP */
> #define PKS_TEST_VALUE PKR_KEY_INIT_RW(0)
> #define PKS_TEST_MASK  PKR_KEY_MASK(0)
> #endif
>
> #if IS_ENABLED(CONFIG_DEVMAP_ACCESS_PROTECTION)
> #define PKS_PGMAP_VALUE PKR_KEY_INIT_AD(PKS_KEY_PGMAP_PROTECTION)
> #define PKS_PGMAP_MASK  PKR_KEY_MASK(PKS_KEY_PGMAP_PROTECTION)
> #else
> /* Just define another default value to fool the CPP */
> #define PKS_PGMAP_VALUE PKR_KEY_INIT_RW(0)
> #define PKS_PGMAP_MASK  PKR_KEY_MASK(0)
> #endif
>
> #define PKS_INIT_VALUE ((0xFFFFFFFF & \
>                         (PKS_DEFAULT_MASK & \
>                                 PKS_TEST_MASK & \
>                                 PKS_PGMAP_MASK \
>                         )) | \
>                         (PKS_DEFAULT_VALUE | \
>                         PKS_TEST_VALUE | \
>                         PKS_PGMAP_VALUE \
>                         ) \
>                         )
>
>
> I find the above much harder to parse and of little value.  I'm pretty sure
> that someone adding a key is much more likely to get the macro maze wrong.
> Reviewing a patch to add a key would be much more difficult as well, IMHO.
>
> I'm a bit tired of this back and forth trying to implement this for features
> which may never exist.  In all my discussions I don't think we have reached
> more than 10 use cases in our wildest dreams and only 4 have even been
> attempted with real code including the PKS test.
>
> So I'm just a bit frustrated with the effort we have put in to try and do
> dynamic or even compile time dynamic keys.
>
> Anyway I'll think on it more.  But I'm inclined to leave it alone right now.
> What I have is easy to review for correctness and only takes a bit of effort to
> actually use.

Sorry, for the thrash Ira, I felt compelled to put some skin in the
game and came up with the below. Ignore the names they are just to
show the idea:

#define KEYVAL(prev, config) (prev + __is_defined(config))
#define KEYDEFAULT(key, default, config) ((default << (key * 2)) *
__is_defined(config))
#define KEYX KEYVAL(0, ENABLE_X)
#define KEYY KEYVAL(KEYX, ENABLE_Y)
#define KEYZ KEYVAL(KEYY, ENABLE_Z)
#define KEYMAX KEYVAL(KEYZ, 1)

#define KEY0_INIT 0x1
#define KEYX_INIT KEYDEFAULT(KEYX, 2, ENABLE_X)
#define KEYY_INIT KEYDEFAULT(KEYY, 2, ENABLE_Y)
#define KEYZ_INIT KEYDEFAULT(KEYZ, 2, ENABLE_Z)

#define ALL_AD 0x55555555
#define DEFAULT (ALL_AD & (GENMASK(31, KEYMAX * 2))) | KEYX_INIT |
KEYY_INIT | KEYZ_INIT | KEY0_INIT

The idea is that this relies on a defined key order, but still
dynamically assigns key values at compile time. It's not as simple as
an enum, but it still seems readable to me.

The definition is done in 2 parts key slot numbers (KEYVAL()) and the
values they need to inject into the combined global init mask
(KEYDEFAULT()). The KEYVAL() section above defines the key order where
each key gets an incremented value in the order, but only if the
previous key was defined. KEYDEFAULT() defines the init value and
optionally zeros out the init value if the config is disabled. Finally
the DEFAULT mask is initialized to all 5s if there are zero keys
defined, but otherwise masks 2-bits per defined key + 1 and ORs in the
corresponding key init values. This uses some of the magic behind the
IS_ENABLED() macro to turn undefined symbols into 0s.

It seems to work, for example if I just define KEYX and KEYZ,

#define ENABLE_X 1
#define ENABLE_Z 1

        printf("X: %d:%#x Y: %d:%#x Z: %d:%#x MAX: %d DEFAULT: %#x\n", KEYX,
               KEYX_INIT, KEYY, KEYY_INIT, KEYZ, KEYZ_INIT, KEYMAX, DEFAULT);

# ./a.out
X: 1:0x8 Y: 1:0 Z: 2:0x20 MAX: 3 DEFAULT: 0x55555569
