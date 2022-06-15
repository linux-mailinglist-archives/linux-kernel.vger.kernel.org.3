Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D3654C626
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347932AbiFOKap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347864AbiFOK3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:29:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104CC3F8B6;
        Wed, 15 Jun 2022 03:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655288985; x=1686824985;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B3HRyq3qTHNb4tOuEr2xYpA5FWGlCwF43+Ok4jDMhA0=;
  b=go+WmZYQ6SbBE1Ajvaf+VJy1qAQHfX9cpnhVrEI6iFhwsx+rItVLCxPc
   PkFsnOPT1SVTWG7G6HoJpXV9coBhzgPytjDA3lG/l2L0ZReVbDIgUXJVD
   v3ougsqy1zTveI9Tcc6aYZooExBs6uPrzs6MyUTN0+O5Ilb4ztauXx0Ds
   amGXmlbFPajh+p70VQZkgCVyeucma5SJlfmGi42haI35A5yOwvBehtxa4
   ekf7JBTbCU5BexNvuXq3TjbZl9p/w7lZ1XEoQhpfANG9fTIZ2kThh63ta
   aJBV1NMjkr7QaEw5LsO6IM591YcD/7MMrhTb3u3KU//nhkWo+edyBFmsg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="276484468"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="276484468"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 03:29:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640918415"
Received: from mgrymel-mobl1.ger.corp.intel.com ([10.249.41.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 03:29:43 -0700
Date:   Wed, 15 Jun 2022 13:29:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] serial: 8250_dw: Take port lock while accessing
 LSR
In-Reply-To: <YqmvTrV3o9CfgBbx@smile.fi.intel.com>
Message-ID: <66df725d-be75-a0df-2118-a99c71be6c41@linux.intel.com>
References: <20220615090651.15340-1-ilpo.jarvinen@linux.intel.com> <20220615090651.15340-3-ilpo.jarvinen@linux.intel.com> <YqmvTrV3o9CfgBbx@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1062549791-1655288984=:1642"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1062549791-1655288984=:1642
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 15 Jun 2022, Andy Shevchenko wrote:

> On Wed, Jun 15, 2022 at 12:06:50PM +0300, Ilpo Järvinen wrote:
> > Accessing LSR requires port lock because it mutates lsr_saved_flags
> > in serial_lsr_in().
> 
> I got this as patch 2/3, where are the 1/3 and 3/3?

That's probably because get_maintainer.pl didn't pick you up for the other 
patches and I didn't explicitly send them to you. Here they are:

https://lore.kernel.org/linux-serial/20220615090651.15340-1-ilpo.jarvinen@linux.intel.com/T/#t

> > @@ -266,7 +266,10 @@ static int dw8250_handle_irq(struct uart_port *p)
> >  
> >  	/* Manually stop the Rx DMA transfer when acting as flow controller */
> >  	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
> > +		spin_lock_irqsave(&p->lock, flags);
> >  		status = serial_lsr_in(up);
> > +		spin_unlock_irqrestore(&p->lock, flags);
> 
> This reminds me the question, why do we need to save flags here? Aren't we in
> IRQ context already? (Perhaps another patch might be issued.)

Currently serial8250_handle_irq() reads from LSR again. I guess it would 
be possible to read LSR only once and pass it as a parameter. It would 
require some rework though.

-- 
 i.

--8323329-1062549791-1655288984=:1642--
