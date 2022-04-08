Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7BD4F9554
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiDHMIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbiDHMIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:08:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA72FFB53;
        Fri,  8 Apr 2022 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649419551; x=1680955551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UcRlRW5b7oJzAdGekoxvGobq0K9KZIlLu2yxSMEnG0E=;
  b=CDj4eHutEQmsl0rKh0k6NpmveisZHBYpbdW0uij0TlOAuB155F6RAtvG
   Zh2Qak9Oc3/ggnuwnsXM57GTzeyP2GHkm+c8mElO4o5VCzRdJCIISOB9i
   suAW5qzDALYncuDrk1D6SErJS2rJUlBLTod3cq1PgNtpQVs4xaCt+r3H6
   /SX2SK6RNqhL5CSZ8yKb2t7xFxU/RzaqrGNvCqt9s2ubAPPjIufT/s+gx
   5AzlGCHZjHdpHBLfdLLj3LktTkZNzKfObwzS3qWYsNsQJQh8VCD1XqUv2
   RF1+4Rd8ptx4qELfDGScIxue7nT3wu2vi2RJyY290r4HkqLe+mBfqE+Vd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261269428"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261269428"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:05:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="659463232"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:05:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ncnJE-000HDJ-3z;
        Fri, 08 Apr 2022 15:01:48 +0300
Date:   Fri, 8 Apr 2022 15:01:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/3] tty: Add functions for handling flow control chars
Message-ID: <YlAkK16xqh3DgY20@smile.fi.intel.com>
References: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com>
 <20220408113954.9749-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220408113954.9749-2-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

On Fri, Apr 08, 2022 at 02:39:52PM +0300, Ilpo Järvinen wrote:
> Move receive path flow control character handling to own function
> and a helper.
> 
> This seems cleanest approach especially once skipping due to lookahead
> is added. Its downside is the duplicated START_CHAR and STOP_CHAR
> checks.
> 
> No functional changes.

But it seems the change. See below.

...

> +static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
> +{
> +	return c == START_CHAR(tty) || c == STOP_CHAR(tty);
> +}
> +
> +/* Returns true if c is consumed as flow-control character */
> +static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
> +{
> +	if (!n_tty_is_char_flow_ctrl(tty, c))
> +		return false;
> +
> +	if (c == START_CHAR(tty)) {
> +		start_tty(tty);
> +		process_echoes(tty);

> +	} else if (c == STOP_CHAR(tty)) {

In the original code no 'else' was present.

Perhaps it's not a functional change, but this detail has to be explained.

> +		stop_tty(tty);
> +	}
> +
> +	return true;
> +}

...

> -	if (I_IXON(tty)) {
> -		if (c == START_CHAR(tty)) {
> -			start_tty(tty);
> -			process_echoes(tty);
> -			return;
> -		}
> -		if (c == STOP_CHAR(tty)) {
> -			stop_tty(tty);
> -			return;
> -		}
> -	}
> +	if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c))
> +		return;

-- 
With Best Regards,
Andy Shevchenko


