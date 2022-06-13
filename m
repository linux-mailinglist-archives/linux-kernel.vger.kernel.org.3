Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128535483AE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbiFMJZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240833AbiFMJZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:25:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DB0193E3;
        Mon, 13 Jun 2022 02:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655112334; x=1686648334;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9W8UBL8GQK1i8P7k7h9skaKJIvKeSxs0mGTdDoAxlas=;
  b=fqMhrCKaoqC18aJhxKIlakXRGms7GbxdKM1A/CwyiOfup9s5DZRKbjBb
   p0si3DRNncvKkKvGcNN5Z+nweA9ptJpBKGKLaAsnvdNF0H5xvztOzLuDD
   hdfEvXCxGjaSo+W4mypSFf5mPCR7COAuLPbF7yJkServD+pT3BHTHvzTL
   nrdWq29LNE5Fj9VPfS4PMH316kI2/RIVhoZqhJJJFwu81gCNq9Eq0OHtt
   qq5PkNWjmQoMsDXLoU0KAk7psxSuw4HFU0ZH54dASNtZ96Y+MbvWvq5Sz
   4ETvIq+gjeMG9R6A/nYT7oGKd7JcR1WsqyTx/3o9CuRNYDrV5Y6VCEbp8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="339898381"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="339898381"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 02:25:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="639635137"
Received: from fnechitx-mobl.ger.corp.intel.com ([10.249.40.115])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 02:25:30 -0700
Date:   Mon, 13 Jun 2022 12:25:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas.wunner@intel.com>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v6 1/6] serial: 8250: make saved LSR larger
In-Reply-To: <670010a1-7727-f2d9-87ad-18ddbeb0cbef@kernel.org>
Message-ID: <cd812b3-393-79be-d7bf-ce79376d9f@linux.intel.com>
References: <20220613075227.10394-1-ilpo.jarvinen@linux.intel.com> <20220613075227.10394-2-ilpo.jarvinen@linux.intel.com> <670010a1-7727-f2d9-87ad-18ddbeb0cbef@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-657426468-1655112332=:2044"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-657426468-1655112332=:2044
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 13 Jun 2022, Jiri Slaby wrote:

> On 13. 06. 22, 9:52, Ilpo Järvinen wrote:
> > DW flags address received as BIT(8) in LSR. In order to not lose that
> > on read, enlarge lsr_saved_flags to u16.
> > 
> > Adjust lsr/status variables and related call chains which used unsigned
> > char type previously to unsigned int. Technically, some of these type
> > conversion would not be needed but it doesn't hurt to be consistent.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ...
> > --- a/include/linux/serial_8250.h
> > +++ b/include/linux/serial_8250.h
> > @@ -119,7 +119,7 @@ struct uart_8250_port {
> >   	 * be immediately processed.
> >   	 */
> >   #define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
> > -	unsigned char		lsr_saved_flags;
> > +	u16			lsr_saved_flags;
> >   #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
> >   	unsigned char		msr_saved_flags;
> >   @@ -170,8 +170,8 @@ extern void serial8250_do_set_divisor(struct uart_port
> > *port, unsigned int baud,
> >   				      unsigned int quot_frac);
> >   extern int fsl8250_handle_irq(struct uart_port *port);
> >   int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
> > -unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char
> > lsr);
> > -void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr);
> > +unsigned int serial8250_rx_chars(struct uart_8250_port *up, unsigned int
> > lsr);
> > +void serial8250_read_char(struct uart_8250_port *up, unsigned int lsr);
> 
> It looks odd to have
>   u16 lsr_saved_flags
> in the struct and
>   unsigned int lsr
> here and there. You wrote:
>   Technically, some of these type conversion would not be needed
>   but it doesn't hurt to be consistent
> But it looks like you actually made them a bit inconsistent.

Those were actually meant to discuss on different things. u16 is the 
oldest part of change and the reason why it is only u16 is that I
didn't need more than that to store the bits used for the mask.

That "consistent" part was written to note that there are case which check 
only e.g. TEMT flag. As TEMT is within first 8 bits, it doesn't absolutely 
need more than unsigned char but I enlarged those types regardless.
I agree with you though the wording doesn't convey meaning exclusive to 
those cases.

> So why not use u16 for everyone?

If that consistency is necessary, I'd be more inclined to make the ones in 
the uart_8250_port unsigned int instead. The reason is that it would then 
align better to read/ignore_status_mask that are already unsigned int. 
Would it be ok or do you still prefer u16?

-- 
 i.

--8323329-657426468-1655112332=:2044--
