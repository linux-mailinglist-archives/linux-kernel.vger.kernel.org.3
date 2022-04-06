Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780DD4F5CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiDFLtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiDFLt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:49:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5987C588352;
        Wed,  6 Apr 2022 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649234827; x=1680770827;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=D6uurLf636+ymW4i3C9iuhVPW35WF/OF/XxWwpCTNQY=;
  b=P00h3mdCL+LDy1FiXqWgP8f61D+PmiZPUTCivSqWpzc9cShcNtFpf/I4
   0jxqOhJqbp9vRMMCxpbfWkUH+AKJp71m+jnbw1eJ7JzT8IoYWKeUR4Ds1
   8D8/3y3Izf0ZkEpjGlXR0DKJ/3HwpLrqeClCLQ+qunmKB9fKV4dQKJQKr
   GQ9wQJCmifv4Cl2AuOovGzDR0l6F3ag6cCl7lQ4yVlC34f9Ju3XlOizbh
   KsF+JLe+EPEwJsPn0NHZ9luIsrwLe9ChA0ExAvpBhOkts1xavWaN2wVZx
   jeUPETeaLXASWfpBDHcmqXPKHYmgcbFZI1MDE0sl+Alezcze4Yyk9GUuu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="259822970"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="259822970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 01:47:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="570417321"
Received: from hott-mobl.ger.corp.intel.com ([10.249.44.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 01:47:04 -0700
Date:   Wed, 6 Apr 2022 11:46:57 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] tty: Add lookahead param to receive_buf
In-Reply-To: <7cb1cc42-ef98-cbbe-1779-107602747d07@kernel.org>
Message-ID: <10263812-e52-9d8d-f9f0-75e5f0c85f60@linux.intel.com>
References: <20220405102437.4842-1-ilpo.jarvinen@linux.intel.com> <20220405102437.4842-2-ilpo.jarvinen@linux.intel.com> <7cb1cc42-ef98-cbbe-1779-107602747d07@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1236514060-1649234826=:1612"
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

--8323329-1236514060-1649234826=:1612
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 6 Apr 2022, Jiri Slaby wrote:

> On 05. 04. 22, 12:24, Ilpo Järvinen wrote:
> > After lookahead for XON/XOFF characters is added by the next
> > patch, the receive side needs to ensure the flow-control
> > actions are not retaken later on when those same characters
> > get read by TTY.
> > 
> > Thus, pass lookahead count to receive_buf and skip
> > flow-control character actions if already taken for the
> > character in question. Lookahead count will become live after
> > the next patch.
> ...
> > --- a/include/linux/tty_ldisc.h
> > +++ b/include/linux/tty_ldisc.h
> > @@ -224,11 +224,11 @@ struct tty_ldisc_ops {
> >   	 * The following routines are called from below.
> >   	 */
> >   	void	(*receive_buf)(struct tty_struct *tty, const unsigned char
> > *cp,
> > -			       const char *fp, int count);
> > +			       const char *fp, int count, int
> > lookahead_count);
> >   	void	(*write_wakeup)(struct tty_struct *tty);
> >   	void	(*dcd_change)(struct tty_struct *tty, unsigned int status);
> >   	int	(*receive_buf2)(struct tty_struct *tty, const unsigned char
> > *cp,
> > -				const char *fp, int count);
> > +				const char *fp, int count, int
> > lookahead_count);
> 
> Please always use unsigned if you don't expect negative numbers. count should
> be changed to unsigned in long term too.

Ok. I had just used the same types as there were previously. The types are 
a big mess, int and size_t conversions being done back and forth within 
that callchain for count. And now that you mentioned unsigned it 
seems that fp (flag ptr) is also inconsistent.

> > diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
> > index 58e9619116b7..1871a6a9cb00 100644
> > --- a/include/linux/tty_port.h
> > +++ b/include/linux/tty_port.h
> > @@ -39,7 +39,7 @@ struct tty_port_operations {
> >   };
> >     struct tty_port_client_operations {
> > -	int (*receive_buf)(struct tty_port *port, const unsigned char *, const
> > unsigned char *, size_t);
> > +	int (*receive_buf)(struct tty_port *port, const unsigned char *, const
> > unsigned char *, size_t, size_t);
> 
> Good, here it is unsigned and even of size_t size (I don't immediately see
> why, but OK).

You mean that the flag ptr is now unsigned char * (which I didn't even 
touch)?

Your comment leaves me to wonder though, what you now want for the 
lookahead count (the last arg), size_t or unsigned int? Lookahead count 
cannot be negative, and AFAICT, count neither because that would mean tty 
has to return some characters back :-).

...Maybe I'll do another patch post these fix ones to match/correct the 
types.

-- 
 i.

--8323329-1236514060-1649234826=:1612--
