Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7AA56CB68
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 22:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiGIUmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 16:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIUmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 16:42:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9750513F04
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 13:42:15 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="283213830"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="283213830"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 13:42:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="594460189"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 13:42:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1oAHHE-0019Qg-0W;
        Sat, 09 Jul 2022 23:42:08 +0300
Date:   Sat, 9 Jul 2022 23:42:07 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
Message-ID: <YsnoH64cKCT7gndw@smile.fi.intel.com>
References: <CAHp75VceKBoxXVPP4dRYb8LQqHMMDHFp6-E2iuZ-h2RTK8PWQQ@mail.gmail.com>
 <e0c7d254-ace3-625c-cc83-52ca0b45e9fc@intel.com>
 <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com>
 <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com>
 <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
 <e2fe6351-f9ee-48eb-ad7f-280249f7f3f7@intel.com>
 <CAHp75VfvN-iJTpgg6JeKhOqJLhtYSieo7d7SOCBoUu-81FtSqg@mail.gmail.com>
 <c19ed4a6-6a96-b4a4-0f5a-7ca1dba925d1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c19ed4a6-6a96-b4a4-0f5a-7ca1dba925d1@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 10:45:49AM +0200, Cezary Rojewski wrote:
> On 2022-07-08 6:49 PM, Andy Shevchenko wrote:
> > On Fri, Jul 8, 2022 at 6:32 PM Cezary Rojewski
> > <cezary.rojewski@intel.com> wrote:
> > > 
> > > On 2022-07-08 5:25 PM, Andy Shevchenko wrote:
> > > > On Fri, Jul 8, 2022 at 2:34 PM Péter Ujfalusi
> > > > <peter.ujfalusi@linux.intel.com> wrote:
> > 
> > > A long shot, but what if we were to modify get_options() so it takes
> > > additional element-size parameter instead?
> > 
> > But why? int / unsigned int, u32 / s32  are all compatible in the current cases.
> 
> I'd like to avoid any additional operations, so that the retrieved payload
> can be provided to the IPC handler directly. The IPC handlers for AudioDSP
> drivers are expecting payload in u32s.
> 
> // u32 **tkns, size_t *num_tkns as foo() arguments
> // u32 *ints, int nints as locals
> 
> 	get_options(buf, 0, &nints);
> 	if (!nints) {
> 		ret = -ENOENT;
> 		goto free_buf;
> 	}
> 
> 	ints = kcalloc(nints + 1, sizeof(*ints), GFP_KERNEL);
> 	if (!ints) {
> 		ret = -ENOMEM;
> 		goto free_buf;
> 	}
> 
> 	get_num_options(buf, nints + 1, ints, sizeof(*ints));
> 
> 	*tkns = ints;
> 	*num_tkns = nints;
> 
> No additional operations in between. The intermediate IPC handler can later
> refer to the actual payload via &tkns[1] before passing it to the generic
> one.
> 
> Casting int array into u32 array does not feel right, or perhaps I'm missing
> something like in the doc case.

C standard.

int to unsigned int is not promoted. And standard says that "The rank of any
unsigned integer type shall equal the rank of the corresponding signed integer
type, if any."

I don't know why one needs to have an additional churn here. int and unsigned
int are interoperable with the adjustment to the sign when the other argument
is signed or lesser rank of.

-- 
With Best Regards,
Andy Shevchenko


