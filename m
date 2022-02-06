Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684254AB12F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 19:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345836AbiBFSOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 13:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiBFSOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 13:14:39 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E967C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 10:14:38 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v3so9696454pgc.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qDL+9onodww3VGHQMDBvqXylLHLC3c9tV9/0PPilpLY=;
        b=5kTgzDwYdeqxfuk2v6wlZYEJTDkEDyAwAu6CLUYTdZmVqz23MMtfSU4U7LSSIPoY1d
         WP3HZL3p9XCnQ4ylUrOJaWK2RDP1FVlsu3de6x0fVXcz+g/x3RRdGkB3C/eGzZn2u73t
         iL31I+7KSD1Irmp7eUompKQBq/CA/iDcBw2nkwgj8J/Qk2hywj2G712lg8SXAlaxXUC/
         yPm7v4BpiPA5Hp6LCYRvQOEqXUvhIE0Ls616olFvSV7G+9sYIzseanS+6eMGM/Jw/QkY
         VdagOSs8r6xEfn6YPs9PL/YIkIA5aXQT8y7NSiSM5vTpaFaFige2xjP93YeNNYHGiUU1
         KwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qDL+9onodww3VGHQMDBvqXylLHLC3c9tV9/0PPilpLY=;
        b=F+RqW1j0LLWoblpeSCWlhiw3F9bttNBs34FbWwqDpOj5mcCVWeelYip/noeGf/uWTf
         onfNh9iKhnWRqjkn3XvGV3vhb5UdQ+bGnQ7NJdb1FvD/OU7y//xjmTstYCMYLbToQdYs
         Yix63uOAdUovSJsTNfqaIrDUihEhbFGmPSkgsYuJIXHzppwyeX897tFKwYxZXc7k49Lh
         Ub4BHItIXS12B53zHMGyceQcDJ+OdP4LebzZVaDwkPbusLv68EU3ii3N7bO4pNLxoIlD
         Rj1APEUUZiAozdSQaCs2fe67qk4OCAfFq2BkyyQsRLREv3ljT26bdLrrb5nRnkgsywmg
         QiYg==
X-Gm-Message-State: AOAM530KkzaMAB9hzsGPF05Q9MaKHHl2/VErltsKMtYjXcus5jwd/A+o
        nPmG23SLpEgs/5xuKozeM4EeNFZRNgUht6M73YOv9Q==
X-Google-Smtp-Source: ABdhPJws6xsahtgkldYulVwzNQ3c6Nja+ZuVcgw2gCzJEASJqzm9ozPUSJZ/oroE2Yf4rf7CsXaP06lT45Q3Mc0B3gs=
X-Received: by 2002:a05:6a00:1312:: with SMTP id j18mr12235909pfu.61.1644171277172;
 Sun, 06 Feb 2022 10:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-37-ira.weiny@intel.com>
 <2193142f0cf3785a4225e0393eace397cbbe86e6.camel@intel.com>
 <CAPcyv4i_Jc865zEzNxbQB_XHqCwSS6zm_evquLv2BBu9ipa39Q@mail.gmail.com>
 <20220205054039.GE785175@iweiny-DESK2.sc.intel.com> <CAPcyv4hcKsy1Z78OyhPK+gPCqqEsbr9fuNRzOBNah03guDzktA@mail.gmail.com>
In-Reply-To: <CAPcyv4hcKsy1Z78OyhPK+gPCqqEsbr9fuNRzOBNah03guDzktA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 6 Feb 2022 10:14:26 -0800
Message-ID: <CAPcyv4gN0hg-BcdAszSsWa6Z7ANLqhSfCtHGFe+QCGWbRGDJJQ@mail.gmail.com>
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

On Sat, Feb 5, 2022 at 12:19 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
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

I should add that the reason that I think this is important is to
allow key scaling *within* use cases. For example, why should one
thread get access to all PMEM in a kmap_local_page() section? A simple
extension would be to use several keys, hashed by namespace, to give
finer grained protection. Another idea that scales with keys is to use
PKS faults to sample accesses by memory type or namespace. In other
words a handful of use cases can expand to exhaust all the keys for
finer grained access control / samping.
