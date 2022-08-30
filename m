Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D325A5E72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiH3IpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiH3IpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:45:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB5BC2C;
        Tue, 30 Aug 2022 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661849109; x=1693385109;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Td5i70jCRkECHM6VGo1f2VVW8QLL7NTNnHGfBf6NaC4=;
  b=BXI7PJABRzqBeRYQpOnut8Na5NM/qYmLjxlC0u/fu/3I/CV5K0v5HBui
   igJf6K+zgcRlrYIBOQZkw/ydzQLSDFqRagPk+Abd5c1+JHiIkyGHHJuxw
   OG0Um4kAfpkXo9Vuyk5yk3FAI3DA5uruEvghXrDpOl36Sq9rRO3CknQrK
   XMShlV7IQHL/YoMFwO6yeeu6RazW27OQwYvzhwzTGAbAWglvjr7+TB9i/
   MEZBgsbu+KW98gpgcqVNDKOCTFDJC8wkMoWqiIkjXQw5RU15/qY04kZ0S
   Y9p3VlS1zNSUD+y0C3lbe5+SuCcGs1/XgYFd6sJKjMMseX3lonJ2RdvAM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="293865500"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="293865500"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:45:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672760099"
Received: from arnesgom-mobl.ger.corp.intel.com ([10.252.54.235])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:45:00 -0700
Date:   Tue, 30 Aug 2022 11:44:59 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH v2 4/4] serial: Add kserial_rs485 to avoid wasted space
 due to .padding
In-Reply-To: <1068ad37-d80c-6e63-6cd9-6ecf6c256d46@kernel.org>
Message-ID: <eb2ba117-6b94-16dd-8e28-9e66f23e8dea@linux.intel.com>
References: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com> <20220830072956.3630-5-ilpo.jarvinen@linux.intel.com> <1068ad37-d80c-6e63-6cd9-6ecf6c256d46@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1910140727-1661849107=:1864"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1910140727-1661849107=:1864
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 30 Aug 2022, Jiri Slaby wrote:

> On 30. 08. 22, 9:29, Ilpo Järvinen wrote:
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -31,6 +31,29 @@ struct serial_struct;
> ...
> > + * Must match with struct serial_rs485 in include/uapi/linux/serial.h
> > excluding
> > + * the padding.
> 
> Have you considered BUILD_BUG_ON() checks with few offset_of()s to enforce the
> above?

It's all enforced at the end of serial_core.c already. Would you perhaps 
prefer I'd put them elsewhere or is it fine as is?

/*
 * Compile-time asserts for struct kserial_rs485 and struct serial_rs485 equality
 * (except padding).
 */
static_assert(offsetof(struct kserial_rs485, flags) ==
              offsetof(struct serial_rs485, flags));
static_assert(offsetof(struct kserial_rs485, delay_rts_before_send) ==
              offsetof(struct serial_rs485, delay_rts_before_send));
static_assert(offsetof(struct kserial_rs485, delay_rts_after_send) ==
              offsetof(struct serial_rs485, delay_rts_after_send));
static_assert(offsetof(struct kserial_rs485, addr_recv) ==
              offsetof(struct serial_rs485, addr_recv));
static_assert(offsetof(struct kserial_rs485, addr_dest) ==
              offsetof(struct serial_rs485, addr_dest));
static_assert(sizeof(struct kserial_rs485) <= sizeof(struct serial_rs485));


-- 
 i.

> > +struct kserial_rs485 {
> > +	__u32	flags;
> > +	__u32	delay_rts_before_send;
> > +	__u32	delay_rts_after_send;
> > +	struct {
> > +		__u8    addr_recv;
> > +		__u8    addr_dest;
> > +	};
> > +};

--8323329-1910140727-1661849107=:1864--
