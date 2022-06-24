Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B634355A24D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiFXUAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXUA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:00:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24F1823B0;
        Fri, 24 Jun 2022 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656100828; x=1687636828;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aPeFMT2xLIQ7Nk30nxXxTOVKrUtn7QWE8ufSym4FWP4=;
  b=Jfr+zA2Zi+S6r861UZJbOj+bH7MuRgSGignG6tHCcP8/+Noy0ARcyitk
   4FXV13wtRyUB9+T5xE9WQyrCB8s9Veo5Ljv1wpOSEXHqkMMvBWyIfQH1o
   zAzVKwj784ejMcOkDdfxEydUJx8Hz/D2YglnKAnVqC26t25brcVfFcVy3
   CShItkdTUY9uaJW5vKhUxblSXxMDj+ywI+WPJntwMkq+00wSVyjs2PGGy
   fsSXFlYFkvxo4JQpHQKuFuVxCJ3KLEDNYQxVYpoBY1/77ltpc2qmDEmnj
   +vRWEnkd5WRV6lzMkcXhFFstLGmi4tTZeCeZhKAL/nXRhYvYWcU8sYDne
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="264122718"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="264122718"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:00:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="645421660"
Received: from vhavel-mobl.ger.corp.intel.com ([10.251.216.91])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:00:22 -0700
Date:   Fri, 24 Jun 2022 23:00:13 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-unisoc@lists.infradead.org
Subject: Re: [PATCH v2 5/6] serial: Use UART_XMIT_SIZE
In-Reply-To: <e864ffbc-5885-f648-01c4-68a598f942b9@kernel.org>
Message-ID: <6fb33489-946f-ad92-df35-7f608420bc7@linux.intel.com>
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com> <20220621124958.3342-6-ilpo.jarvinen@linux.intel.com> <e864ffbc-5885-f648-01c4-68a598f942b9@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-120668389-1656100826=:2099"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-120668389-1656100826=:2099
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 23 Jun 2022, Jiri Slaby wrote:

> On 21. 06. 22, 14:49, Ilpo Järvinen wrote:
> > --- a/include/linux/serial.h
> > +++ b/include/linux/serial.h
> > @@ -9,7 +9,6 @@
> >   #ifndef _LINUX_SERIAL_H
> >   #define _LINUX_SERIAL_H
> >   -#include <asm/page.h>
> >   #include <uapi/linux/serial.h>
> >     /* Helper for dealing with UART_LCR_WLEN* defines */
> > @@ -25,11 +24,6 @@ struct async_icount {
> >   	__u32	buf_overrun;
> >   };
> >   -/*
> > - * The size of the serial xmit buffer is 1 page, or 4096 bytes
> > - */
> > -#define SERIAL_XMIT_SIZE PAGE_SIZE
> > -
> >   #include <linux/compiler.h>
> >     #endif /* _LINUX_SERIAL_H */
> > diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > index 5518b70177b3..1767dee98021 100644
> > --- a/include/linux/serial_core.h
> > +++ b/include/linux/serial_core.h
> > @@ -296,6 +296,7 @@ struct uart_state {
> >   	struct uart_port	*uart_port;
> >   };
> >   +/* The size of the serial xmit buffer is 1 page, or 4096 bytes */
> 
> That is not completely true, I'd remove the "or" part. Hmm, but then the
> comment is somehow superfluous as it says what we can see below. So maybe
> don't add it at all?
> 
> >   #define UART_XMIT_SIZE	PAGE_SIZE

Yeah, the comment is probably not that useful. I managed to get into  
an "autopilot mode" with a sole goal to preserve the comment rather than 
thinking/reading it through whether it's worth preserving.

-- 
 i.

--8323329-120668389-1656100826=:2099--
