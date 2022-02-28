Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7304C7BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiB1V2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiB1V2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:28:39 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2C2125C87;
        Mon, 28 Feb 2022 13:28:00 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="240402952"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="240402952"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 13:28:00 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="708807672"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 13:27:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nOnXx-009bWI-8V;
        Mon, 28 Feb 2022 23:27:09 +0200
Date:   Mon, 28 Feb 2022 23:27:08 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
Message-ID: <Yh0+LA8B1jw8tnl9@smile.fi.intel.com>
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com>
 <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:02:43PM +0100, Ard Biesheuvel wrote:
> On Mon, 28 Feb 2022 at 21:47, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Feb 28, 2022 at 9:28 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > From: Alexander Graf <graf@amazon.com>
> > >
> > > We create a list of ACPI "PNP" IDs which contains _HID, _CID, and CLS
> > > entries of the respective devices. However, when making structs for
> > > matching, we squeeze those IDs into acpi_device_id, which only has 9
> > > bytes space to store the identifier. The subsystem actually captures the
> > > full length of the IDs, and the modalias has the full length, but this
> > > struct we use for matching is limited. It originally had 16 bytes, but
> > > was changed to only have 9 in 6543becf26ff ("mod/file2alias: make
> > > modalias generation safe for cross compiling"), presumably on the theory
> > > that it would match the ACPI spec so it didn't matter.
> >
> > > Unfortunately, while most people adhere to the ACPI specs, Microsoft
> > > decided that its VM Generation Counter device [1] should only be
> > > identifiable by _CID with a value of "VM_Gen_Counter", which is longer
> > > than 9 characters.
> >
> > Then why do we not see the ECR from somebody to update the spec or to
> > fix MS' abuse of it?
> > I believe _this_ should be the prerequisite to the proposed change.
> 
> What exactly are you suggesting here? That the contributor of this
> patch joins the UEFI forum as an individual adopter in order to get
> the ACPI spec updated before we can advance with this patch? Or that
> he works with Microsoft to get them to refrain from violating it?
> 
> I don't think that is reasonable or realistic. The kernel is already
> riddled with UEFI and ACPI quirks that are only there because some
> teams at MS don't take the ACPI spec too literally (which is why they
> have their own AML compiler, for one), and PC vendors only care about
> the Windows sticker, so they don't care about the ACPI spec either.
> 
> So I don't think this is the right time to get pedantic about this.
> Our ACPI subsystem already deals with CIDs that are longer than 8
> characters (which are btw permitted by the ACPI spec for bus topology
> related metadata), the only thing being changed here is the ability to
> actually match against such identifiers.

My point is that this is clear abuse of the spec and:
1) we have to enable the broken, because it is already in the wild with
   the comment that this is an issue

AND

2) issue an ECR / work with MS to make sure they understand the problem.

This can be done in parallel. What I meant as a prerequisite is to start doing
2) while we have 1) on table.


-- 
With Best Regards,
Andy Shevchenko


