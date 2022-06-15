Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C461754D331
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347010AbiFOVAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiFOVAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:00:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB0255222
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655326810; x=1686862810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IRFJBh+zoP1ebZry6XfT/kFqI5RhbjM1nScJRBf3RrE=;
  b=kErM1cVXR5WCKpBWyOirExR9Xl3qtzKzWZ2ZuG0SlGaekhrtSyGBhoIe
   ylUzPzRdbASBg/0yajqpkrlfFI52VPe+SUoaFqp5ggsKkZ8VuQw700fDh
   VcVyCRZl45MylPohnyrEc6jkoiGUR5byKywq5s5KHwSB4e2Ff+UML3BAO
   txDXKEyWNFS18bEFPFUaj45HG2H2MjasCexqd7h+tE8ihfjyu69dVUi9m
   DQnuTW3apphh3CghdE0nz+lLsOpRUhVsnCBPIJ+Aor44lAPrnDxZiuvB0
   HH+vXQs7iyy1Fso++Te01fXJ9+TF8RJjrUb3llg6skP1dzl3TwNn97U4u
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279152128"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279152128"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 13:59:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="612910288"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 13:59:50 -0700
Date:   Wed, 15 Jun 2022 13:59:33 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alex Bazhaniuk <alex.bazhaniuk@eclypsium.com>
Subject: Re: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
Message-ID: <20220615205933.GA1524841@alison-desk>
References: <20220614210217.1940563-1-martin.fernandez@eclypsium.com>
 <20220615190519.GA1524500@alison-desk>
 <CAD2FfiGxy=9ARK5FT_iaLACZSzR+R4crmGJv7T+v_w3+ktOzCQ@mail.gmail.com>
 <20220615195425.GA1524649@alison-desk>
 <CAFmMkTGFpehSFOsnDuQN4aTnwfgYGwTbGBxtvUU_byDcoRVPPA@mail.gmail.com>
 <CAKgze5aQsh2VY4tjsDco_Wc6CTU+KXZM3bhFR+73AVp3gLWHuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgze5aQsh2VY4tjsDco_Wc6CTU+KXZM3bhFR+73AVp3gLWHuA@mail.gmail.com>
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 05:48:34PM -0300, Martin Fernandez wrote:
> On 6/15/22, Daniel Gutson <daniel.gutson@eclypsium.com> wrote:
> > On Wed, Jun 15, 2022 at 4:54 PM Alison Schofield
> > <alison.schofield@intel.com> wrote:
> >>
> >> On Wed, Jun 15, 2022 at 08:34:58PM +0100, Richard Hughes wrote:
> >> > On Wed, 15 Jun 2022 at 20:06, Alison Schofield
> >> > <alison.schofield@intel.com> wrote:
> >> > > My first reaction is lying about the cpuinfo is not a soln, since
> >> > > it creates a problem for a users currently relying on cpuinfo to be
> >> > > the source of truth for TME.
> >> >
> >> > I think you have to qualify "source of truth". At the moment the CPU
> >> > reports "Yes! I support TME!" and then for one reason or another the
> >> > platform turns it off and actually there's no memory encryption of
> >> > your secrets at all. There's seemingly no userspace way of telling if
> >> > TME is actually active. We were told that we shouldn't export the
> >> > "platform has disabled a CPU feature" in sysfs and just to clear the
> >> > cpuid flag that gets exported (like AMD is currently doing) which is
> >> > what Martin proposed here. Programs want to know the true CPU
> >> > capability can do __get_cpuid_count() like they can for the SME/SEV
> >> > capabilities.
> >> >
> >> Disagree on sending folks to use __get_cpuid_count() when they already
> >> have cpuinfo.
> >>
> >> Why is a sysfs entry TME-enabled 0/1 a bad thing?
> >
> > :)))
> > This was my very first patch, and I got half of the community complaining
> > It was so long ago that I don't recall everything, maybe Martín does?
> > or Richard?
> 
> The discussion triggered the fact that checking that TME is active is
> not enough to tell if memory is being encrypted or not (which we
> thought it was true by that time), and that triggered a series of patches to
> address the other checks required, which is currently going nowhere
> [1].
> 
> The sysfs _wasn't_ discarded perse, but since Boris suggested the
> change in cpuinfo (several times now that I recalled that Daniel patch
> [2]) I think that is cleaner, besides the backwards compatibility.
> 
> [1] https://lore.kernel.org/linux-efi/20220429201717.1946178-1-martin.fernandez@eclypsium.com/
> 
> [2] https://lkml.iu.edu/hypermail/linux/kernel/2006.2/05231.html
> 

Martin,
The commit message here seemed to assume that we've all been following
along on this journey with you. Perhaps a commit message that explains
the need and includes alternatives considered/rejected. Links are good!
Alison


> >> It can be documented
> >> to have the same meaning as the log message.
> >>
> >> You keep referring to AMD. How is their exception documented?
> >>
> >> Alison
> >>
> >> > > Are we to tell them to go look in the
> >> > > log now, because fwupd folks didn't want to ;)
> >> >
> >> > We're not telling anyone to use the log; grepping megabytes of
> >> > unformatted kernel logs is a terrible (and slow) way to get one
> >> > boolean value.
> >> >
> >> > Richard.
> >
