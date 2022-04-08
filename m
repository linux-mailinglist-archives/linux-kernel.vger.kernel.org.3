Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160EC4F9507
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiDHMEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiDHMEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:04:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285BD38D86;
        Fri,  8 Apr 2022 05:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649419357; x=1680955357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sCFFIRundsiEG0F87Pt8A6xGTYeOaxx52Lkkg4+BAsM=;
  b=TePv2hPqYJeST5BTdG1IspynPezj4pjnObkXvHREvJmbDOuOYHL2NKLQ
   37+4RwAcqInqKGD45zgNUtavOs2HLNyyPG40OW4+bxPrvRIBmBUnWtMIM
   ehjL0dFoWTa0pz7DrF5ikopzqku1uXYYoV7KaqqE0TZbjXZaIEEP8Zow2
   GKq9elNxKINf246xXgt2yyCa0iA4uThfRC3QS4FGxLC7Q0jcGJ00KBvh+
   wvW2nsAn2Cy2zMpN0Q7XJsZCgNzY90hzRo8kTEwas1S+3xZzEVYdmV6kC
   4Yk4vgFhaGGFx1ibe831yTQWnsa51HmSmFBs0DVc35wdnKgn8DrU+89CK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261570346"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261570346"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:02:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="609731615"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:02:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ncnGP-000HBY-3f;
        Fri, 08 Apr 2022 14:58:53 +0300
Date:   Fri, 8 Apr 2022 14:58:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/3] tty: Add lookahead param to receive_buf
Message-ID: <YlAjfAab+Oh3HcCR@smile.fi.intel.com>
References: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com>
 <20220408113954.9749-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220408113954.9749-3-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 02:39:53PM +0300, Ilpo Järvinen wrote:
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

> +		if (c == STOP_CHAR(tty)) {
> +			if (!lookahead_done)

But now it can be as below

		if (c == STOP_CHAR(tty) && !lookahead_done)

> +				stop_tty(tty);
> +		} else if ((c == START_CHAR(tty) && !lookahead_done) ||
>  			 (tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
>  			  c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
>  			  c != SUSP_CHAR(tty))) {


-- 
With Best Regards,
Andy Shevchenko


