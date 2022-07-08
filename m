Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA6B56B9B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiGHMax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbiGHMaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:30:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED4E326C8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:30:51 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="264049734"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="264049734"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 05:30:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="661758508"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 05:30:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1o9n88-00183d-0o;
        Fri, 08 Jul 2022 15:30:44 +0300
Date:   Fri, 8 Jul 2022 15:30:44 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Andy Shevchenko <andy@kernel.org>, Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
Message-ID: <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
References: <20220707091301.1282291-1-cezary.rojewski@intel.com>
 <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
 <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com>
 <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c8e4104-2239-a188-649d-585f059cabdd@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 02:13:14PM +0200, Cezary Rojewski wrote:
> On 2022-07-08 1:46 PM, Andy Shevchenko wrote:
> > On Fri, Jul 8, 2022 at 1:33 PM Cezary Rojewski
> > <cezary.rojewski@intel.com> wrote:

...

> > > When I'd written the very first version of this function many months
> > > ago, get_options() looked as it does not fulfill our needs. It seems to
> > > be true even today: caller needs to know the number of elements in an
> > > array upfront.
> > 
> > Have you read a kernel doc for it? It does return the number of
> > elements at the first pass.
> 
> Yes, I've checked several parts of it. Perhaps I did miss something but
> simple_strtoull() doc reads: use kstrtox() instead.

Doc was fixed to make clearer that in some cases it's okay to use
simple_strtox(). And this was exactly due to obfuscation code with this
recommendation. Yes, in general one supposed to use kstrtox(), but it's
not 100% obligatory.

> Thus the strsplit_u32()
> makes use of kstrtox().

Yeah...

> > > Also, kstrtox() takes into account '0x' and modifies the
> > > base accordingly if that's the case. simple_strtoull() looks as not
> > > capable of doing the same thing.
> > 
> > How come?! It does parse all known prefixes: 0x, 0, +, -.
> 
> Hmm.. doc says that it stops at the first non-digit character. Will
> re-check.

Yes, but under non-digit implies the standard prefixes of digits.
simple_strtox() and kstrotox() use the very same function for prefixes.

> > > The goal is to be able to parse input such as:
> > > 
> > > 0x1000003,0,0,0x1000004,0,0
> > > 
> > > into a sequence of 6 uints, filling the *tkns and *num_tkns for the caller.
> > 
> > Yes. Have you checked the test cases for get_options()?

(1)

...

> > > avs-driver, which is also part of the ASoC framework has very similar
> > > debug-interface. I believe there's no need to duplicate the functions -
> > > move them to common code instead.
> > 
> > Taking the above into account, please try to use get_options() and
> > then tell me what's not working with it. If so, we will add test cases
> > to get_options() and fix it.
> 
> There is a difference:
> 
> 	// get_options
> 	int ints[5];
> 
> 	s = get_options(str, ARRAY_SIZE(ints), ints);
> 
> 	// strsplit_u32()
> 	u32 *tkns, num_tkns;
> 
> 	ret = strsplit_u32(str, delim, &tkns, &num_tkns);
> 
> Nothing has been told upfront for in the second case.

It seems you are missing the (1). The code has checks for the case where you
can do get number upfront, it would just require two passes, but it's nothing
in comparison of heave realloc().

  unsigned int *tokens;
  char *p;
  int num;

  p = get_options(str, 0, &num);
  if (num == 0)
	// No numbers in the string!

  tokens = kcalloc(num + 1, sizeof(*tokens), GFP_KERNEL);
  if (!tokens)
	return -ENOMEM;

  p = get_oprions(str, num, &tokens);
  if (*p)
	// String was parsed only partially!
	// assuming it's not a fatal error

  return tokens;

-- 
With Best Regards,
Andy Shevchenko


