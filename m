Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135AC50C1B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiDVV5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiDVV4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:56:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7351D2A4CB4;
        Fri, 22 Apr 2022 13:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650659956; x=1682195956;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=itPL4SDhaJNbtUUlmV3x5Gcrnw+9kVzEXPvSZciorvU=;
  b=I74K3tUGWZeqJjHA0axRe+ueDzJX78bVscWLOHcAiRPdZiM+QLk5DxNJ
   3fEKdLX6V1/AIrF2FtXb5bX1C6Oxp+nrEML781rix6jDQMYOtJ/T0/1Ib
   F0e/fyDcclhoKX3aXh6jcfUIYgbRx1BkWwAU4WVte64fV8bcVsXzwbmhs
   v1l8vh5JFUa619PNZX2kRm4DEnI4GcPKTH71zBphEilGmsu5NhjchRlna
   ayl7mHPxgJrDWzoVIPxsgPH4tRLTzjwl5N9F+963xkwDwcDLnqDYkIflx
   TWVe8FgR7xwfubVnWn3zAXqiR5FDdMRjG1EqjDHWF9Efrlib/ROhN+LeI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244699982"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="244699982"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:09:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="578075082"
Received: from assenmac-mobl.ger.corp.intel.com ([10.251.216.136])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:09:10 -0700
Date:   Fri, 22 Apr 2022 23:09:07 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 3/5] tty: Add lookahead param to receive_buf
In-Reply-To: <YmK83NfVqEvGg8DW@kroah.com>
Message-ID: <d496d544-fe59-5fa7-5d21-ab6ad025fa75@linux.intel.com>
References: <20220411094859.10894-1-ilpo.jarvinen@linux.intel.com> <20220411094859.10894-4-ilpo.jarvinen@linux.intel.com> <YmK83NfVqEvGg8DW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022, Greg KH wrote:

> > diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
> > index 08cf8a17754b..b33536eea1d3 100644
> > --- a/drivers/accessibility/speakup/spk_ttyio.c
> > +++ b/drivers/accessibility/speakup/spk_ttyio.c
> > @@ -73,7 +73,7 @@ static void spk_ttyio_ldisc_close(struct tty_struct *tty)
> >  
> >  static int spk_ttyio_receive_buf2(struct tty_struct *tty,
> >  				  const unsigned char *cp,
> > -				  const char *fp, int count)
> > +				  const char *fp, int count, unsigned int lookahead_count)
> 
> Ick, adding yet-another-parameter to a function is a mess as it's hard
> to know what to do with this and what it means just by looking at when
> it is called.

To be honest, I didn't like it either but just couldn't find another 
way... That is, not until now that you pushed.

I think I can add lookahead_count into n_tty_data, then both layers 
(n_tty and tty_buffer) that depend on it will indepedently keep track of 
it rather than passing it through the whole callchain.

> >  /* Returns true if c is consumed as flow-control character */
> > -static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
> > +static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c,
> > +					 bool lookahead_done)
> >  {
> >  	if (!n_tty_is_char_flow_ctrl(tty, c))
> >  		return false;
> >  
> > +	if (lookahead_done)
> > +		return true;
> 
> Why would this function be called if this option was true?

Agreed, it makes sense to move the check before call (and then I also 
don't need to reorganize this function anymore).

> the overall idea is good, this implementation isn't quite there yet.

Thanks for taking a look.


-- 
 i.

