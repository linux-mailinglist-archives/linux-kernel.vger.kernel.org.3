Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C781855FC38
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiF2JkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiF2JkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:40:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E3D35A92;
        Wed, 29 Jun 2022 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656495605; x=1688031605;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UvfKTTXIzcaGutYTfgsUtP7uWtw3jgtcsccJyaLDLuk=;
  b=BijxxWGDyA/vsBYprVv5RV80pCG9qK4jh/WzPE1I+DeKA3qAV7o4bT+S
   OlmDQPKq4NxCZ9cdbU10OOF5pzd3g9o3paph5+jtwE1Gdeu0Euz4jRfZM
   5lrfq7iyTQsn00AOs9pWCy6TIkxK+WKEt7C9FqG7LOz7edgy7wqA6z4mJ
   wQe5Yp77Wo6IrTh2uePugADrmnNvNPr/mtbV8tLWfLnfro6ddVPsrZBIK
   cpAKBAElUuxEVjSqTmwSJNHXUwfL/fYFzP+xOoE/uONPapzFAuoMtQ6NB
   G5tTIYeM2gMQHGM4t7B/aMzHsiqKg5HOzbNwvTyMhFk41+ZGlReVtyhqk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="283081451"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="283081451"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 02:40:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="595172772"
Received: from dsummer-mobl.ger.corp.intel.com ([10.252.38.121])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 02:40:02 -0700
Date:   Wed, 29 Jun 2022 12:40:01 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] serial: 8250_dw: Rework ->serial_out() LCR write
 retry logic
In-Reply-To: <CAHp75VevfptcsTTkFvCRsJRxuKX6aJ2zQ5LyH0O8wP+aB4xXHw@mail.gmail.com>
Message-ID: <bc54d67-e573-9ecc-1650-7e7fc35f7897@linux.intel.com>
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com> <20220628134234.53771-5-ilpo.jarvinen@linux.intel.com> <CAHp75Vf36sFqX1SL4Sjz6ZgNXP41Nom0Q1s6Psgv9WMFkKtGtg@mail.gmail.com> <29b084c-183b-4a84-2376-2c88eff7d5a@linux.intel.com>
 <CAHp75VevfptcsTTkFvCRsJRxuKX6aJ2zQ5LyH0O8wP+aB4xXHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1893331349-1656495604=:1529"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1893331349-1656495604=:1529
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> On Wed, Jun 29, 2022 at 10:47 AM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Tue, 28 Jun 2022, Andy Shevchenko wrote:
> > > On Tue, Jun 28, 2022 at 3:43 PM Ilpo Järvinen
> > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > >
> > > > Currently dw8250_verify_write() (was dw8250_check_lcr()) nullifies the
> > > > benefit from differentiated ->serial_out() by having big if tree to
> > > > select correct write type.
> > > >
> > > > Rework the logic such that the LCR write can be retried within the
> > > > relevant ->serial_out() handler:
> > > >   1. Move retries counter on the caller level and pass as pointer to
> > > >      dw8250_verify_write()
> > > >   2. Make dw8250_verify_write() return bool
> > > >   3. Retry the write on caller level (if needed)
> > >
> > > I'm wondering if it's possible to utilize one of iopoll.h macro here
> > > instead of copying retries and that not-so-obvious IO poll write.
> >
> > Eh, are you suggesting I should do write as a side-effect inside one of
> > the iopoll.h macros? Because those available seem to only read?
> >
> > Or should I create another macro there which writes too?
> 
> It seems to me that it would be a macro on top of iopoll's one which
> will take an op read and op write arguments depending on the case.

The thing is those iopoll macros don't return until the timeout is 
exhausted so I don't think I can reuse them easily for this task ("on top 
of iopoll's one")? That is, w/o some major side-effect hack (which is 
IMHO a no-go).

-- 
 i.

> Note, for that special case you would need a custom write op instead
> of simple __raw_writeq().
>
> Try and if it looks better, convert, otherwise it would be nice to
> hear why it won't fly in your opinion.

--8323329-1893331349-1656495604=:1529--
