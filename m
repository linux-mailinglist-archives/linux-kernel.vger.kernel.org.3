Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76394F95E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbiDHMgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiDHMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:36:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28151344181;
        Fri,  8 Apr 2022 05:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649421272; x=1680957272;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RZ8r0XaBrcR4p4yR7/Tctmr9u64HN1HhO0whIRV1fbY=;
  b=ZmLg5xp3i2wlIfEX+xHcQi+hrueymYNOHtBYS0UMHPTRJLJb2nCOK06I
   ProU+YzhF+75GKo5+y8BQC962s6lilGS2N5D5eeH+ElTjIWpYi9nfT3yI
   w9e8/Tc5oq2MxjXlhoj9Oxr1ABgps9t/VL2AeqY7WLUXAIXtZ0OT2nG2M
   u2pi3u3oZ0IfaC9FKpf3h7xP9CwvE0WB5DKXXHlwFW8QOztIm6uf+CaF7
   OpEB5LNQSDD4+LHjCuogYG1Ec67vurSS/XJf9XqB4YSd8fj5KlyuG7vJj
   eTBsA0rbt97sdyvACNbP2hBNfKm1ENM6arlwKhF/v8WpKrO87noYxSMlF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="243713908"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="243713908"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:34:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="571476279"
Received: from aecajiao-mobl.amr.corp.intel.com ([10.252.48.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:34:29 -0700
Date:   Fri, 8 Apr 2022 15:34:27 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/3] tty: Add lookahead param to receive_buf
In-Reply-To: <YlAjfAab+Oh3HcCR@smile.fi.intel.com>
Message-ID: <42fc2746-6a7c-9b44-87a5-32f219c1231@linux.intel.com>
References: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com> <20220408113954.9749-3-ilpo.jarvinen@linux.intel.com> <YlAjfAab+Oh3HcCR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-262000026-1649421271=:1643"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-262000026-1649421271=:1643
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 8 Apr 2022, Andy Shevchenko wrote:

> On Fri, Apr 08, 2022 at 02:39:53PM +0300, Ilpo Järvinen wrote:
> > After lookahead for XON/XOFF characters is added by the next
> > patch, the receive side needs to ensure the flow-control
> > actions are not retaken later on when those same characters
> > get read by TTY.
> > 
> > Thus, pass lookahead count to receive_buf and skip
> > flow-control character actions if already taken for the
> > character in question. Lookahead count will become live after
> > the next patch.
> 
> ...
> 
> > +		if (c == STOP_CHAR(tty)) {
> > +			if (!lookahead_done)
> 
> But now it can be as below
> 
> 		if (c == STOP_CHAR(tty) && !lookahead_done)
> 
> > +				stop_tty(tty);
> > +		} else if ((c == START_CHAR(tty) && !lookahead_done) ||
> >  			 (tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
> >  			  c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
> >  			  c != SUSP_CHAR(tty))) {

Are you sure about this? ...If I make that change to the first if, the 
second part of the else if's condition get a chance it didn't have 
previously.

What I'd like to do here is to take advantage of the function that was 
added:

		if (!n_tty_receive_char_flow_ctrl(tty, c) &&
		    tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
        	    c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
	            c != SUSP_CHAR(tty))) {
			start_tty(tty);
			process_echoes(tty);
		}
...but it will change STOP_CHAR vs START_CHAR precedence for the case 
where they're the same characters. I don't know if it matters.

-- 
 i.

--8323329-262000026-1649421271=:1643--
