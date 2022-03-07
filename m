Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFB94CF554
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiCGJZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiCGJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:23:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83AA41F95;
        Mon,  7 Mar 2022 01:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646644960; x=1678180960;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vSoHg7P7RzMmNdIR6BzHpRebOwVwB1J20xCgeUpckYs=;
  b=JQAGDNlaxPTKTysQgoOpWxPsnvu6EFyFDtsxxabPWu9aTga3EF0P33MM
   SHMLxhry3s8nQA1of/FEM86ykzb1ZIjR61q4nQRV7Spo8rOlArzg0fGuK
   xA5NjPYekxNoB6cxjy2n/1yvurASGzy34uQTxoEU+j326NN4iLgOPHE/P
   +9SPeHnkvGQYU++iRkq6Jg5zDtLdE4D0kGLtXSsLLRycKSh5tullv23Ks
   C5Xrac6W7IrrW+roA6Mgj5XMZliJptAHAw3zNj5pEHPB9YktjNuujmCSW
   HwxBngXxFkapImUc5ejBYpQfq3Y/BO6xWzR42AXG3u1JoTMXpDtJiBxl6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="251920343"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="251920343"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:22:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="553081017"
Received: from rabl-mobl2.ger.corp.intel.com ([10.252.54.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:22:37 -0800
Date:   Mon, 7 Mar 2022 11:22:35 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH 2/7] serial: 8250_dwlib: RS485 HW full duplex support
In-Reply-To: <20220306185149.GB19394@wunner.de>
Message-ID: <801197e8-7cc4-93fe-d3fe-8cee8c153c97@linux.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com> <20220302095606.14818-3-ilpo.jarvinen@linux.intel.com> <20220306185149.GB19394@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1449773282-1646644959=:1677"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1449773282-1646644959=:1677
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Sun, 6 Mar 2022, Lukas Wunner wrote:

> On Wed, Mar 02, 2022 at 11:56:01AM +0200, Ilpo Järvinen wrote:
> > @@ -110,9 +110,14 @@ static int dw8250_rs485_config(struct uart_port *p, struct serial_rs485 *rs485)
> >  
> >  	if (rs485->flags & SER_RS485_ENABLED) {
> >  		/* Clearing unsupported flags. */
> > -		rs485->flags &= SER_RS485_ENABLED;
> > -
> > -		tcr |= DW_UART_TCR_RS485_EN | DW_UART_TCR_XFER_MODE_DE_OR_RE;
> > +		rs485->flags &= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX;
> > +		tcr |= DW_UART_TCR_RS485_EN;
> > +
> > +		if (rs485->flags & SER_RS485_RX_DURING_TX) {
> > +			tcr |= DW_UART_TCR_XFER_MODE_DE_DURING_RE;
> > +		} else {
> > +			tcr |= DW_UART_TCR_XFER_MODE_DE_OR_RE;
> > +		}
> 
> This patch deletes lines introduced by the preceding patch.
> I'd just squash the two together, I don't see much value in
> introducing full duplex support in a separate patch.

Sure, I can merge them.

-- 
 i.

--8323329-1449773282-1646644959=:1677--
