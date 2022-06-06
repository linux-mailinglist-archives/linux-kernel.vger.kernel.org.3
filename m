Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9019353ECE0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiFFRRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiFFRRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:17:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5FC213;
        Mon,  6 Jun 2022 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654535589; x=1686071589;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RIIF6gQd50znOWXgHgd/G+ztiqR6/zdKxtaDENKnjZA=;
  b=eCzjQtr9bw57DQLcUrF5TZ/IHrzC5W6TogZcGdmDtUU3CrenzS4K/KOf
   AnLdbjwC6jpVlr6Hf6XXEAuk0gFQsdn7UWYhMsKdAFqONOjbJ02ec7ryj
   sfncFT7KShn1zn70fRmmNY1yAGOns5Pys1rWLwTY5Mx2kd7zVA9NaLeIG
   JKa68fTB9RlJQHxWesAHBAYeozZeFnK0IwEv5pjR5erlq0NHXFdlaBAwR
   jDUd0FhLSI5/BwNihI5w1oGB+aVc6MTQYxlnf1sbOwfaYRrQVQ5in1vug
   /3lz3E/Khl1Xh/t7s/qwS6dVBziFkJRm847XL4OtHiKKlxxpg0JnPXOr+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277060677"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="277060677"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 09:52:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="825912993"
Received: from amkossek-mobl1.ger.corp.intel.com ([10.252.57.11])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 09:52:21 -0700
Date:   Mon, 6 Jun 2022 19:52:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/6] serial: 8250: Store to lsr_save_flags after lsr
 read
In-Reply-To: <CAHp75Ve4t1aF4wDpXPOcOX3MXbn_DaaNWG4S9Ft1jpZ0dGSXzw@mail.gmail.com>
Message-ID: <97e83f-8011-37fb-d958-2d881fcdbd3@linux.intel.com>
References: <20220606131124.53394-1-ilpo.jarvinen@linux.intel.com> <20220606131124.53394-2-ilpo.jarvinen@linux.intel.com> <fb32bda5-ea44-da8d-493a-a043b8619022@linux.intel.com> <CAHp75Ve4t1aF4wDpXPOcOX3MXbn_DaaNWG4S9Ft1jpZ0dGSXzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-455783549-1654534344=:1547"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-455783549-1654534344=:1547
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 6 Jun 2022, Andy Shevchenko wrote:

> On Mon, Jun 6, 2022 at 3:55 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Mon, 6 Jun 2022, Ilpo Järvinen wrote:
> 
> ...
> 
> > > Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
> > > Link: https://lore.kernel.org/all/1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com/T/#m1737eef986bd20cf19593e344cebd7b0244945fc
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > Acked-by: Uwe Kleine-König <u.kleine-koenig@penugtronix.de>
> >
> > It seems that Uwe managed to mistype his email for the A-by which I just
> > happily copy-pasted.
> >
> > Greg, please let me know if you want me to resend the series (or if you
> > will just change it on the fly while applying).
> 
> I believe Greg doesn't handle patches on the fly, hence resend.
> But more importantly I do not see the reason for the Acked-by tag when
> SoB of the same person is present.

I just repeated what Uwe gave me. Maybe he didn't notice he was already 
there as SoB.

This situation is anyway a bit more complex than usual. The line I took 
was part of Uwe's much larger patch initially (which was fully reverted) 
so his SoB was carried over to preserve the authorship. As I made a 
non-trivial modification to his original patch by removing almost all of 
it, I added my SoB too. Given this situation, I kind of thought he Acked 
(approved) the post-modification version of it.

-- 
 i.

--8323329-455783549-1654534344=:1547--
