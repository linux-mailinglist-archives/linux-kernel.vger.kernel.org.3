Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2792E5A0FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbiHYMEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbiHYMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:04:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA70394EC7;
        Thu, 25 Aug 2022 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661429038; x=1692965038;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=h/PlntZ4xv6wpyrxDWzn5g+aY7NJLT8egTd5Kr2Rgi0=;
  b=Ty2XI6JqhJ9J0ipS7G6P0slxbiGReLi2ZV/NFa+CzG6Zu/QbzobMbbGz
   M9TMxABmEulb+9gfEGFgLnq84i8TPbSfalsPqDrdguOJ05okhngGXw+Zc
   pmTQTgYtZtwueRrOGYGlQy40a/Y5wGt1zG1jK1BycVuyG2Kz828LfXp9F
   PjP7J+05PSBb0R7G0RUrM32qlyzOgxBq4ejEpq+m6scMrSUwI9OWk9wq7
   JIDRaayf9zYeHUUyqsZCJdRwp506T2j+LTCc7Z/UOnKHH6H/gQceqHQ8u
   B1+n0o13kR/0kZpRHuz8m/iGdGEpWKhoOjUOEV0l1xCdTpPe2hj30lJLB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="292963262"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="292963262"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 05:03:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="670952561"
Received: from mblazque-mobl1.ger.corp.intel.com ([10.249.44.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 05:03:56 -0700
Date:   Thu, 25 Aug 2022 15:03:51 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] serial: dz: Replace DZ_XMIT_SIZE with
 UART_XMIT_SIZE
In-Reply-To: <alpine.DEB.2.21.2208251219120.26998@angie.orcam.me.uk>
Message-ID: <89359013-85fe-76e1-a425-fabdfa3572f9@linux.intel.com>
References: <20220825091918.8398-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2208251219120.26998@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1082596925-1661428582=:1738"
Content-ID: <b87639ee-64c-735-c254-a9e74f66e184@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1082596925-1661428582=:1738
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <d9db7580-f9f9-bd8f-2c54-7f6ad7b6c2@linux.intel.com>

On Thu, 25 Aug 2022, Maciej W. Rozycki wrote:

> On Thu, 25 Aug 2022, Ilpo Järvinen wrote:
> 
> > Use the normal UART_XMIT_SIZE directly.
> 
>  I gather this is to fix a potential inconsistency with the size of the 
> buffer allocated by the serial core (though in reality this driver will 
> only be used with 4KiB-page systems), right?  If so, then please state it 
> in the change description.

No idea, but I guess it has to be true because nobody has complained about 
the missing characters such an inconsistency would cause. It could 
seemingly also cause infinite bogus tx as tail cannot never reach head 
when head is about 4k (uart_circ_empty & uart_circ_chars_pending would 
return bogus values).

>  Also I'd rather:
> 
> #define DZ_WAKEUP_CHARS      UART_XMIT_SIZE
> 
> and there's no need to include <linux/serial_core.h> in dz.h as the driver 
> itself already does that (and dz.h is an auxiliary private header).
> 
>  Thanks for your submission.

I have started to becomes more inclined into the direction of dropping 
DZ_WAKEUP_CHARS entirely and use WAKEUP_CHARS like most of the drivers do
after staring now at WAKEUP_CHARS & uart_write_wakeup() lines just now.

There is just a handful of exceptions, rest of the drivers all use 256 as 
WAKEUP_CHARS. dz uses 1024 (4k/4) and rest of the exceptions use 
uart_circ_empty() but I suspect they should also be just converted to 
use WAKEUP_CHARS.

-- 
 i.
--8323329-1082596925-1661428582=:1738--
