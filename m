Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A2F53C04C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbiFBVNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiFBVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:13:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343E2625C;
        Thu,  2 Jun 2022 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654204394; x=1685740394;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Zp4sc8G+nrANzk6FDQgpWf+CkA0v1TyW1fbthBdGtM=;
  b=MP+cNoilOODPBFOu3iiLlegrT14WQCh4xcRu3WatN1KSdrUa8N/KEdZd
   yD6fgKZPZUhzlIFaC9fOdUBTzsiePawFUoWOxOZW4e1qv/VJxiOOOclPV
   2y18NvFuYNmcErKUjbRe3WsTjkk+D5BJPyUY3nLJ6q5jpA2H+i2mljUXb
   8YcTJ41+fyq2VZKfFZoUc6vUlBXgYU9pKIJZbI+jGDrASrydOdv+L0QaW
   EHARvPFK+vLZynBGwAXIKlgNSZbqyMfJsOEUSMcnOiy1GWlJRSWlGmLNr
   wacfF6rPD5ir58NERYTqdbdzntqE4YxsDSeNBxcKViB7nK03ATaJCZhDu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="276095445"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="276095445"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 14:13:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="680844129"
Received: from saianand-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.27.112])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 14:13:11 -0700
Message-ID: <71399a4c1584139763587534957a435bafa47051.camel@linux.intel.com>
Subject: Re: x86/mce/therm_throt incorrect THERM_STATUS_CLEAR_CORE_MASK?
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Jun 2022 14:13:10 -0700
In-Reply-To: <CAK8P3a2ZhHoA3mKC7fFNubC3i+bADdem1W_o-NVR0KBYg2Z8eg@mail.gmail.com>
References: <CAK8P3a1mkHEjRJgJPsRy+kuN=48=JEDJAeR2z9n+O71qbJ8hSA@mail.gmail.com>
         <6caf53e059758234ee12a236f967412f1df1f8a0.camel@linux.intel.com>
         <CAK8P3a1mHe3TkZa443fzsPnGUP1XT3w-DN3U5KAL6NBhc2nEsw@mail.gmail.com>
         <079945077b128fcc3cb470e9d52267f7ac763b7a.camel@linux.intel.com>
         <CAK8P3a3aUtQ6C6kVmEZKzHv2tGL3=3WXK=_agc-Mg5Pq47vbdA@mail.gmail.com>
         <21b7d5a3de39e9eee4ccda48ad0c66d31b1fe7d1.camel@linux.intel.com>
         <CAK8P3a2ZhHoA3mKC7fFNubC3i+bADdem1W_o-NVR0KBYg2Z8eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-02 at 22:42 +0200, Arnd Bergmann wrote:
> On Thu, Jun 2, 2022 at 10:10 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > On Thu, 2022-06-02 at 20:53 +0200, Arnd Bergmann wrote:
> > > 
> > > I wonder how common this problem it is. Would it help to add a
> > > driver
> > > workaround
> > > like this?
> > This issue affects only certain skews. The others already working
> > as
> > expected. These are important log bits for debug, we don't want to
> > clear in this path. Printing warning for CLX stepping is fine
> > without
> > clearing unrelated bits 13 and 15.
> > Read-modify-update should always work where we only update the bits
> > of
> > interest. Writing 1s to this register should be NOP.
> 
> The patch I suggested doesn't change the behavior unless the initial
> write causes an exception. As long as only buggy microcode rejects
> the
> write, the second write just serves to clear the state that causes
> the
> repeated stack dumps.
But it will clear BIT 13 and 15 in this case. So atleast print the
current msr value in the warning message so that we don't loose the BIT
13 and BIT 15 values, in case we need them for debug.

Thanks,
Srinivas

> 
>        Arnd
> 
> > > @@ -214,7 +214,13 @@ static void clear_therm_status_log(int
> > > level)
> > > 
> > >         rdmsrl(msr, msr_val);
> > >         msr_val &= mask;
> > > -       wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
> > > +       if (wrmsrl_safe(msr, msr_val &
> > > ~THERM_STATUS_PROCHOT_LOG)) {
> > > +               /* work around Cascade Lake SKZ57 erratum */
> > > +               printk_once(KERN_WARNING "Failed to update
> > > IA32_THERM_STATUS, "
> > > +                                       "please upgrade
> > > microcode\n");
> > > +               wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG &
> > > +                       ~BIT(13) & ~BIT(15));
> > > +       }
> > >  }
> > > 

