Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96CE4ABE51
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 13:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391584AbiBGMCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 07:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388275AbiBGLnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:43:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52E8C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644234200; x=1675770200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w6w2ccADFu4cgHqYIRIYRuBh3hLMbxfmsazq1+C6hWg=;
  b=JX14QN5VjuHXYw9U3PEm5T7eJ8eEXg6Ul7wY1wFcOl7IlUvE+eZt03KZ
   kDSZq2JTsFsTng/oqK5RnC+0Ysql+xqGuyim+KFkHKN/gdltUXA8NiDJw
   E81Ytshbk3mU+moYbSLfE7juyeYaatY5nQF3VtlHXGDbKD/yhWgvSnOWB
   Bs+qE57bTwxgKE67R0HD9JT/tyaAwO890hmI9rI0/3Xe9YlDEy9Y14nll
   Kwylp2VnwdhWEu6LJbZXQI8P1uDq2xaR64CsMihfFJTajOL4Q8sdC2eFd
   Q2JppkRJSt/7cpWiBYCz4nc+UXvJiPMFNzYKaabNtjYgKWVQ9sAlG46v1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="246287263"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="246287263"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 03:42:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="700436349"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 03:42:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nH2OO-001ss2-Lg;
        Mon, 07 Feb 2022 13:41:12 +0200
Date:   Mon, 7 Feb 2022 13:41:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jan =?utf-8?B?RMSFYnJvxZs=?= <jsd@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Easow, Nimesh" <Nimesh.Easow@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/2] i2c: designware: Add AMD PSP I2C bus support
Message-ID: <YgEFWN8K7Yh452GY@smile.fi.intel.com>
References: <20220120001621.705352-2-jsd@semihalf.com>
 <20220202144302.1438303-1-jsd@semihalf.com>
 <20220202144302.1438303-2-jsd@semihalf.com>
 <YfqtkBIZZxp2Au2l@smile.fi.intel.com>
 <CAOtMz3O_j5-0ZLJngQpzQSGduhZVnQ8awBvGkMdUQWAX8nN5Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOtMz3O_j5-0ZLJngQpzQSGduhZVnQ8awBvGkMdUQWAX8nN5Hw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:27:12AM +0100, Jan Dąbroś wrote:
> śr., 2 lut 2022 o 17:16 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> napisał(a):
> > On Wed, Feb 02, 2022 at 03:43:02PM +0100, Jan Dabros wrote:

...

> > > +struct psp_i2c_req {
> > > +     struct psp_req_buffer_hdr hdr;
> > > +     enum psp_i2c_req_type type;
> > > +} __aligned(32);
> >
> > I forgot if this alignment is requirement due to DMA or so?
> > We may use ____cacheline_aligned in such case.
> 
> I used some old code as a reference - this structure is mapped by PSP,
> thus alignment applied here. I'm checking this with AMD whether it is
> really needed or at least can be somehow limited - still waiting for
> their response.
> I propose to left this as is right now and eventually remove or make
> more liberal in the future.

Would be nice to clarify sooner than later.
In either case it needs a good comment.

...

> > > +     return readl_poll_timeout(&mbox->cmd_fields, tmp, (tmp == expected),
> > > +                               0, 1000 * PSP_CMD_TIMEOUT_MS);
> >
> > 0?!
> 
> Yes, we are checking for readiness of PSP mailbox in a tight loop. We
> would like to proceed further quickly as soon as this bit is set.
> Actually checking this twice per every ACQUIRE&RELEASE - once before
> sending command (to check whether PSP is ready to accept requests) and
> second time after sending it. Do you think we should increase
> @sleep_us value?

It depends on what you have in mind about hardware. I'm fine with either way,
but 0 has to be explained (in the comment).

-- 
With Best Regards,
Andy Shevchenko


