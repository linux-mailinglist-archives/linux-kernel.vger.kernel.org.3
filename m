Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B104F9583
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiDHMWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiDHMWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:22:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C2B33D0D3;
        Fri,  8 Apr 2022 05:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649420412; x=1680956412;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=WPsslrFd0S6sXmVgTxDUoYEL32FPotRMU+1lqBKb5iU=;
  b=bgjvTtW0I20mqkt5dHcgUItHH17Z+qewfQNWHsJwcYIE3w+aGwLZ4STF
   ejqn1xjXsVg8sYoLKQTTD5Wi3q4Js8/dwuxL1myXeNKERhmThSDxq6dUM
   O/UqoM7ppRmEz8SenT/hhbBFlHbSKN5BblCHrcbH3qhs7uFjVgEdDsQyw
   kG7GW0s4U5eEcZ3nXEnBZHXKw2flmIEiCS7I3TfWEsazLoN9XOCRYmq83
   Dm6weIKJDMs7ATVLEDSgmWJG74k/VrS2JhbheaJdhPyaiY0fORzLlnesi
   UIAqEQ9jCJg2nLCV2fu4mf7Hsg1OmEvPxyGtCrFQ+BKEpadUcaGIcV3bk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="249110195"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="249110195"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:20:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="571473128"
Received: from aecajiao-mobl.amr.corp.intel.com ([10.252.48.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:20:09 -0700
Date:   Fri, 8 Apr 2022 15:20:07 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/3] tty: Add functions for handling flow control
 chars
In-Reply-To: <YlAkK16xqh3DgY20@smile.fi.intel.com>
Message-ID: <d79c4c20-1cfd-a3a1-516b-b6b51360527c@linux.intel.com>
References: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com> <20220408113954.9749-2-ilpo.jarvinen@linux.intel.com> <YlAkK16xqh3DgY20@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-865545589-1649420348=:1643"
Content-ID: <d3d8d4fb-baab-977-cbb3-46e5455dab@linux.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-865545589-1649420348=:1643
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <aed6b5c-6a20-30e9-96ef-1532ea8b2e1@linux.intel.com>

On Fri, 8 Apr 2022, Andy Shevchenko wrote:

> On Fri, Apr 08, 2022 at 02:39:52PM +0300, Ilpo Järvinen wrote:
> > Move receive path flow control character handling to own function
> > and a helper.
> > 
> > This seems cleanest approach especially once skipping due to lookahead
> > is added. Its downside is the duplicated START_CHAR and STOP_CHAR
> > checks.
> > 
> > No functional changes.
> 
> But it seems the change. See below.
> 
> ...
> 
> > +static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
> > +{
> > +	return c == START_CHAR(tty) || c == STOP_CHAR(tty);
> > +}
> > +
> > +/* Returns true if c is consumed as flow-control character */
> > +static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
> > +{
> > +	if (!n_tty_is_char_flow_ctrl(tty, c))
> > +		return false;
> > +
> > +	if (c == START_CHAR(tty)) {
> > +		start_tty(tty);
> > +		process_echoes(tty);
> 
> > +	} else if (c == STOP_CHAR(tty)) {
> 
> In the original code no 'else' was present.
>
> Perhaps it's not a functional change, but this detail has to be explained.

Correct that the previous code didn't have else, however, there was return 
with the same effect. Adding this else here was no accident from my part 
but it is intentionally there to have no functional change for the 
START_CHAR == STOP_CHAR case!

> > +		stop_tty(tty);
> > +	}
> > +
> > +	return true;
> > +}
> 
> ...
> 
> > -	if (I_IXON(tty)) {
> > -		if (c == START_CHAR(tty)) {
> > -			start_tty(tty);
> > -			process_echoes(tty);
> > -			return;
> > -		}
> > -		if (c == STOP_CHAR(tty)) {
> > -			stop_tty(tty);
> > -			return;
> > -		}
> > -	}
> > +	if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c))
> > +		return;
> 
> 

-- 
 i.
--8323329-865545589-1649420348=:1643--
