Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA154C573
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbiFOKHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbiFOKHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:07:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD044990E;
        Wed, 15 Jun 2022 03:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655287635; x=1686823635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AaMqg0rAFHspjKNV4jWW9B28vU9PTysq0QQ+uybVcOU=;
  b=btX+ZS2EELbJ7Fj81GZh1fAvc5Wy5kcNnJPoO9s8PCGVpwwBuIOu2wG0
   EKCuqq8tjorbdOioUMoJRsHgip1H4yqdezh/HBPqQw06ytN2Q7blVeAup
   EqmvnouYRs0NA7UgxhkgmMQGDVh1N3YCO/HfQplR2C8I1Cw0ft+Be+fEn
   sXo1ox/5zdGks9ZoCODeQLxTEDjqghXHDb3gzQKacP9Vdt5DNyBYcuNZQ
   YHK9XUhM/CbCa3Uu6Wahbuwha37aLYUwKrcaHL29s5j4ZXpKwTe5x3z70
   e/baIOrq4aL5ar4f4gP//suvzJRxWEA64IeDMExDjMRX3BRVRQKo6MqQu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="304335137"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="304335137"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 03:07:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="652577067"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 03:07:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o1Pvb-000dHg-2E;
        Wed, 15 Jun 2022 13:07:11 +0300
Date:   Wed, 15 Jun 2022 13:07:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] serial: 8250_dw: Take port lock while accessing LSR
Message-ID: <YqmvTrV3o9CfgBbx@smile.fi.intel.com>
References: <20220615090651.15340-1-ilpo.jarvinen@linux.intel.com>
 <20220615090651.15340-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615090651.15340-3-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 12:06:50PM +0300, Ilpo Järvinen wrote:
> Accessing LSR requires port lock because it mutates lsr_saved_flags
> in serial_lsr_in().

I got this as patch 2/3, where are the 1/3 and 3/3?

...

> @@ -266,7 +266,10 @@ static int dw8250_handle_irq(struct uart_port *p)
>  
>  	/* Manually stop the Rx DMA transfer when acting as flow controller */
>  	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
> +		spin_lock_irqsave(&p->lock, flags);
>  		status = serial_lsr_in(up);
> +		spin_unlock_irqrestore(&p->lock, flags);

This reminds me the question, why do we need to save flags here? Aren't we in
IRQ context already? (Perhaps another patch might be issued.)

-- 
With Best Regards,
Andy Shevchenko


