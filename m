Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58EC4FBB04
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244437AbiDKLen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiDKLek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:34:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A744550F;
        Mon, 11 Apr 2022 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649676747; x=1681212747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TYy9NxpTkSA66TQfkmpTqBo09yMyp2M0WmZn0CW2F1A=;
  b=kQ+YQsCg6G/4xCsXFjzLezWgd2rQavHB+BeNX4WZk5QEKds1Fr/ROoJX
   Y4kqL7Yi8t5j+8mFeHlsaJGmEasqFHZ7Dzv35p/XvFKCt2TbaCck05BUU
   BG1zL/T/rbI8WWarGTE+5h+WKQld/bwJLThZ9O4ixzhQBQI+2vC4QfBn1
   jjzADhXwt/6h1oIat1f7QJEN0wxUKXHhhp9DsC31qHonWeoSw9IAiUWt6
   y6th+uM/bFhQ13rY57IA+iFApzc1yE4d13Rqu4JDBRSJ1cH7ZbKBgcaqa
   sNu9Gui3RrkSdElcC5EMifGkM79BT7qvViLZzzJduuaypQJuGs/RV48bq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="259689278"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="259689278"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:32:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="589846699"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 04:32:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ndsDt-001C3i-1e;
        Mon, 11 Apr 2022 14:28:45 +0300
Date:   Mon, 11 Apr 2022 14:28:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 5/5] tty: Use flow-control char function on closing
 path
Message-ID: <YlQQ7MYBiK98n5XK@smile.fi.intel.com>
References: <20220411094859.10894-1-ilpo.jarvinen@linux.intel.com>
 <20220411094859.10894-6-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411094859.10894-6-ilpo.jarvinen@linux.intel.com>
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

On Mon, Apr 11, 2022 at 12:48:59PM +0300, Ilpo Järvinen wrote:
> Use n_tty_receive_char_flow_ctrl also on the closing path. This makes
> the code cleaner and consistent.
> 
> However, there a small change of regression!
> 
> The earlier closing path has a small difference compared with the
> normal receive path. If START_CHAR and STOP_CHAR are equal, their
> precedence is different depending on which path a character is
> processed. I don't know whether this difference was intentional or
> not, and if equal START_CHAR and STOP_CHAR is actually used anywhere.
> But it feels not so useful corner case.
> 
> While this change would logically belong to those earlier changes,
> having a separate patch for this is useful. If this regresses, bisect
> can pinpoint this change rather than the large patch. Also, this
> change is not necessary to minimal fix for the issue addressed in
> the previous patch.

This is nice, if it flies!
FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/n_tty.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index fede29ed8daf..e6f47858f98f 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1414,15 +1414,10 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c,
>  		c = tolower(c);
>  
>  	if (I_IXON(tty)) {
> -		if (c == STOP_CHAR(tty)) {
> -			if (!lookahead_done)
> -				stop_tty(tty);
> -		} else if (c == START_CHAR(tty) && lookahead_done) {
> -			return;
> -		} else if (c == START_CHAR(tty) ||
> -			 (tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
> -			  c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
> -			  c != SUSP_CHAR(tty))) {
> +		if (!n_tty_receive_char_flow_ctrl(tty, c, lookahead_done) &&
> +		    tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
> +		    c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
> +		    c != SUSP_CHAR(tty)) {
>  			start_tty(tty);
>  			process_echoes(tty);
>  		}
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


