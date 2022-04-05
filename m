Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064404F4E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835778AbiDFAdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457542AbiDEQIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:08:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7472608;
        Tue,  5 Apr 2022 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649174800; x=1680710800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SXP53dhhunwY79FP5ds9zXn0k2FcV+iBvoVhtso/RR8=;
  b=NNdmkPyB5ykAqXN5BpdFsW+OigaJ/3NnmvP46mO+8waYsAD35IATHtLu
   ozEsS5PqmHnEfzWbD6IRl8EuesfDuR7O2gLzF/ZJil2vVg4A2xfz4Jq81
   QKkEX6DlO/nu3i9oWDbf9BBGnXfqBmLIoiZqgJYUud5cUCv4lubppx9zE
   iD14BsZgKs8IitIxNe4SY9tMuVKjmQmHE5m9kgnjJsb5c5zY4M7YC6SOz
   mnbO1oZR9FkQVP2Jgbz4IHaNm/YGT030h2Xyx3/8/4wEw8hooOUGLI/x7
   szJq48L1ies08/ryjRqeY3mxl1tsxCcFWKf1bvDhLMLxQ01Z8MGhQTBXD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240723380"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="240723380"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 09:03:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="657994658"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 09:03:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nbleJ-00DSQK-Aw;
        Tue, 05 Apr 2022 19:03:19 +0300
Date:   Tue, 5 Apr 2022 19:03:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2] tty: Add lookahead param to receive_buf
Message-ID: <YkxoR+jA9tDJOqNU@smile.fi.intel.com>
References: <20220405102437.4842-1-ilpo.jarvinen@linux.intel.com>
 <20220405102437.4842-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405102437.4842-2-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:24:36PM +0300, Ilpo Järvinen wrote:
> After lookahead for XON/XOFF characters is added by the next
> patch, the receive side needs to ensure the flow-control
> actions are not retaken later on when those same characters
> get read by TTY.
> 
> Thus, pass lookahead count to receive_buf and skip
> flow-control character actions if already taken for the
> character in question. Lookahead count will become live after
> the next patch.

...

> -static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
> +static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
> +				       bool lookahead_done)
>  {
>  	struct n_tty_data *ldata = tty->disc_data;
>  
>  	if (I_IXON(tty)) {
>  		if (c == START_CHAR(tty)) {
> -			start_tty(tty);
> -			process_echoes(tty);
> +			if (!lookahead_done) {
> +				start_tty(tty);
> +				process_echoes(tty);
> +			}
>  			return;
>  		}
>  		if (c == STOP_CHAR(tty)) {
> -			stop_tty(tty);
> +			if (!lookahead_done)
> +				stop_tty(tty);
>  			return;
>  		}

Wouldn't be cleaner to inside out the conditionals?

>  	}

	if (I_IXON(tty)) {
		if (lookahead_done) {
			// Can be joined, but I think this is better
			if (c == START_CHAR(tty))
				return;
			if (c == STOP_CHAR(tty))
				return;
		} else {
			if (c == START_CHAR(tty)) {
				start_tty(tty);
				process_echoes(tty);
				return;
			}
			if (c == STOP_CHAR(tty)) {
				stop_tty(tty);
				return;
			}
		}
	}

In my opinion this will show exactly what's going on when we have
lookahead_done and when not.

-- 
With Best Regards,
Andy Shevchenko


