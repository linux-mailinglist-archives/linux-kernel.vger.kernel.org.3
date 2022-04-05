Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A84F4E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353355AbiDFAMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457608AbiDEQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:16:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA8719018;
        Tue,  5 Apr 2022 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649175241; x=1680711241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ur19xDOlDI9/rWRs+TqnfwNVLI1D8qVYS/itVUtgTbs=;
  b=jFvFqMmaNz/WWa5pevdVc4G5pOvCnX2Jah2FBst1sLrf6l3hiAOWyoao
   ww6Ee/J+I5WNy43gmffTR9dIq4CFtI6fRU5wkZ5bOA+/LN23tJVMhMAAj
   eAgOVhLDZtP7GWk8CYp8kTdtLxElFoRVzm4Ea1d3FMoNPASw3boETImk6
   kthX6k06Bzl5Ye5sw8bDD+cxEyEVVhIgTsCA3/ZEorZIhH4ixBykOJXoe
   YeduQ3TNPJPxrvpIJFJBQ1H+q67O7kUSTn87ZdnhkNLmVaWA2XgzPdN42
   ot5udIAxb/pve3xN+aFbArqRF1S9dTdedP+e3eTFvbrDtJuDNZsegMKUd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="258375370"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="258375370"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 09:11:37 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="524055940"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 09:11:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nbllo-00DSdK-94;
        Tue, 05 Apr 2022 19:11:04 +0300
Date:   Tue, 5 Apr 2022 19:11:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] tty: Implement lookahead to process XON/XOFF timely
Message-ID: <YkxqGDsURPpkDM5W@smile.fi.intel.com>
References: <20220405102437.4842-1-ilpo.jarvinen@linux.intel.com>
 <20220405102437.4842-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405102437.4842-3-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:24:37PM +0300, Ilpo Järvinen wrote:
> When tty is not read from, XON/XOFF may get stuck into an
> intermediate buffer. As those characters are there to do software
> flow-control, it is not very useful. In the case where neither end
> reads from ttys, the receiving ends might not be able receive the
> XOFF characters and just keep sending more data to the opposite
> direction. This problem is almost guaranteed to occur with DMA
> which sends data in large chunks.
> 
> If TTY is slow to process characters, that is, eats less than given
> amount in receive_buf, invoke lookahead for the rest of the chars
> to process potential XON/XOFF characters.
> 
> The guards necessary for ensuring the XON/XOFF character are
> processed only once were added by the previous patch. All this patch
> needs to do on that front is to pass the lookahead count (that can
> now be non-zero) into port->client_ops->receive_buf().

...

> +static bool __n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
> +					 bool lookahead_done)
> +{
> +	if (!I_IXON(tty))
> +		return false;
> +
> +	if (c == START_CHAR(tty)) {
> +		if (!lookahead_done) {
> +			start_tty(tty);
> +			process_echoes(tty);
> +		}
> +		return true;
> +	}
> +	if (c == STOP_CHAR(tty)) {
> +		if (!lookahead_done)
> +			stop_tty(tty);
> +		return true;
> +	}
> +	return false;
> +}

Looking into this I would first make a preparatory patch that splits out
current code into something like

static bool __n_tty_receive_char_special_no_lookahead(struct tty_struct *tty, unsigned char c)
{
	...current code...
}

Then in the patch 1 you add

static bool __n_tty_receive_char_special_lookahead(struct tty_struct *tty, unsigned char c)
{
	...
}

static bool __n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
					 bool lookahead_done)
{
	if (!I_IXON(tty))
		return false;

	if (lookahead_done)
		return _lookahead();

	return _no_lookahead();
}

?

...

/*
 * Also start multi-line comments with
 * capital letter and finish with
 * grammar period.
 */

-- 
With Best Regards,
Andy Shevchenko


