Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6664F50F2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiDZHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344282AbiDZHvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:51:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3661A3A4;
        Tue, 26 Apr 2022 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650959325; x=1682495325;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Y3MQhCXobnzYH8jvj04XHW91HYwyje2IP6fIr/XFnpQ=;
  b=gFtCcTDkv5cy+UBKzg9fFu8cr55yq79acsUt7jviszRulIir3rNgg1HO
   H9Yqq27eD0eolje3zcanFihCv0kdOappZyEV7vPFqjwQLYt81sUJ1u0WB
   qwM8pPrYhdX75RmPPHEjVToC4QOsMudkVDSeX7tmCd8rf6a5eVtmIFkFN
   PAr4wsktgX9aLzube7wSKBi16oTT5OLttsvm0iQJSVlZvxVjZch+MKaCO
   4Po9erawKktOHeNIna/TEVhPVDxmypbnBkwJRdwWwuPcxjdpy8UQkT/02
   yJni2qVisgjJI+cHqU865YXNYfwqDf7X8Ctcjn6UO/zTFGqByOppSM0MR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247420048"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="247420048"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:48:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579745009"
Received: from mmilkovx-mobl.amr.corp.intel.com ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:48:42 -0700
Date:   Tue, 26 Apr 2022 10:48:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 3/5] tty: Add lookahead param to receive_buf
In-Reply-To: <d496d544-fe59-5fa7-5d21-ab6ad025fa75@linux.intel.com>
Message-ID: <769b1be-87c3-e1c1-b1f9-d56a74ff549@linux.intel.com>
References: <20220411094859.10894-1-ilpo.jarvinen@linux.intel.com> <20220411094859.10894-4-ilpo.jarvinen@linux.intel.com> <YmK83NfVqEvGg8DW@kroah.com> <d496d544-fe59-5fa7-5d21-ab6ad025fa75@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1967645119-1650900405=:1634"
Content-ID: <d1c0cb3a-7189-c235-6a83-e663903cadf@linux.intel.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1967645119-1650900405=:1634
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <31544f8e-b7f-c1f-9613-4f7778a13b49@linux.intel.com>

On Fri, 22 Apr 2022, Ilpo Järvinen wrote:

> On Fri, 22 Apr 2022, Greg KH wrote:
> 
> > >  /* Returns true if c is consumed as flow-control character */
> > > -static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
> > > +static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c,
> > > +					 bool lookahead_done)
> > >  {
> > >  	if (!n_tty_is_char_flow_ctrl(tty, c))
> > >  		return false;
> > >  
> > > +	if (lookahead_done)
> > > +		return true;
> > 
> > Why would this function be called if this option was true?
> 
> Agreed, it makes sense to move the check before call (and then I also 
> don't need to reorganize this function anymore).

I think I want to renege on this. The reason is that on flow control char, 
two things must occur:
  a) it must not be treated as normal char
  b) if not yet processed, flow control actions need to be taken

When the check is inside, return value of n_tty_receive_char_flow_ctrl 
decides a), and b) is kept internal to n_tty_receive_char_flow_ctrl().

If I more that lookahead_done check into the caller domain, things get 
IMHO a lot more messy. Effectively, I have three options for the calling 
domain to chose from:

	if (I_IXON(tty)) {
		if (!lookahead_done) {
			if (n_tty_receive_char_flow_ctrl(tty, c))
				return;
		} else if (n_tty_is_char_flow_ctrl(tty, c)) {
			return;
		}
	}

or

	if (I_IXON(tty)) {
		if ((!lookahead_done && n_tty_receive_char_flow_ctrl(tty, c)) ||
		    (lookahead_done && n_tty_is_char_flow_ctrl(tty, c))) {
			return;
	}

vs

        if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c, lookahead_done))
                return;

I heavily prefer that last option.

-- 
 i.
--8323329-1967645119-1650900405=:1634--
