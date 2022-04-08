Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E96B4F961B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbiDHMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbiDHMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:50:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33463F4635;
        Fri,  8 Apr 2022 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649422127; x=1680958127;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+2co3pbOey6O4BPUsyTyPLrNSjY26SKEpDrTpyTJrvU=;
  b=CfjAuFLA2b3KItYKgViedTNsq1Uy0Y2U8lffSiaokdN1cqr1jDp2IiYT
   t37rZf20bqlOni+NLOOulkxUGcvfluGW41z/Gv+qW6zVMxwhIPs74KYnR
   aoCdZaoKBrkf3u+D/mpjNcWPh4FI+1HHIBXV3Lhm+mk/pgyx/43CBnSlR
   mCOygjDQ38S8fN564dFPWSn+X/ZLHpC5J4Hcj0/nVz87LjcTzuRqZQkP5
   LSnbR4xyzfNDCtoRJPy1SEtz0L6RZ+RqiAiwRKEChSmXQ1s4AOmLTkPwt
   nsYSVY/QpxTxY0uROIg5R7dRMItIDSfjfUMXtHpqaqMYEQ1YtefzO5I7a
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261577099"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261577099"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:48:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="571478804"
Received: from aecajiao-mobl.amr.corp.intel.com ([10.252.48.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:48:44 -0700
Date:   Fri, 8 Apr 2022 15:48:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/3] tty: Add lookahead param to receive_buf
In-Reply-To: <42fc2746-6a7c-9b44-87a5-32f219c1231@linux.intel.com>
Message-ID: <9cc674e-ac5e-f4cb-9522-717754374711@linux.intel.com>
References: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com> <20220408113954.9749-3-ilpo.jarvinen@linux.intel.com> <YlAjfAab+Oh3HcCR@smile.fi.intel.com> <42fc2746-6a7c-9b44-87a5-32f219c1231@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-759246872-1649422126=:1643"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-759246872-1649422126=:1643
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 8 Apr 2022, Ilpo Järvinen wrote:

> On Fri, 8 Apr 2022, Andy Shevchenko wrote:
> 
> > On Fri, Apr 08, 2022 at 02:39:53PM +0300, Ilpo Järvinen wrote:
> > > After lookahead for XON/XOFF characters is added by the next
> > > patch, the receive side needs to ensure the flow-control
> > > actions are not retaken later on when those same characters
> > > get read by TTY.
> > > 
> > > Thus, pass lookahead count to receive_buf and skip
> > > flow-control character actions if already taken for the
> > > character in question. Lookahead count will become live after
> > > the next patch.
> > 
> > ...
> > 
> > > +		if (c == STOP_CHAR(tty)) {
> > > +			if (!lookahead_done)
> > 
> > But now it can be as below
> > 
> > 		if (c == STOP_CHAR(tty) && !lookahead_done)
> > 
> > > +				stop_tty(tty);
> > > +		} else if ((c == START_CHAR(tty) && !lookahead_done) ||
> > >  			 (tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
> > >  			  c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
> > >  			  c != SUSP_CHAR(tty))) {
> 
> Are you sure about this? ...If I make that change to the first if, the 
> second part of the else if's condition get a chance it didn't have 
> previously.
> 
> What I'd like to do here is to take advantage of the function that was 
> added:
> 
> 		if (!n_tty_receive_char_flow_ctrl(tty, c) &&

Correcting myself.

		if (!n_tty_receive_char_flow_ctrl(tty, c, lookahead_done) &&
is the correct form as this is already 2/3, not 1/3 form of that
function.

> 		    tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
>         	    c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
> 	            c != SUSP_CHAR(tty))) {
> 			start_tty(tty);
> 			process_echoes(tty);
> 		}
> ...but it will change STOP_CHAR vs START_CHAR precedence for the case 
> where they're the same characters. I don't know if it matters.
> 
> 

-- 
 i.

--8323329-759246872-1649422126=:1643--
