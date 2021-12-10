Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3362470ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbhLJXjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbhLJXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:39:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF07C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bUkVBxgf9t/u8za+hE5Wtzsahjs9Fh0SXzJbdcb7qmM=; b=J5MRyvwt9WHum4t/fRCBGRcufl
        mkc3KgOlZSdEJuAVQoT9feHRY+D1Xmnp1npOSoKKzknacJvJyHZsVOnpi0RzobSQw8Dp6k6xmxtP5
        lZ+eUvD+5NRn8OMznLUTsL7EjzToahVJkj5xCMz7k8NhyxaWMoXJPS6LCjlnY3ft6tF7FIanIEM7F
        TbN2h8da1g7pTtV4cGA+GThItG6pfFJ41QxgJfrygEn3S3UV4W1Y4yB0MV0MYgi247/S/OdbOhyH7
        spaiFTk0o6sxenEN7b0QLhB1jSj75JtP2ubr/RUvMkO84G9j2amLVu53Jh1yY4DbgNR4A4G2HFhCz
        UNuroHPg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvpQI-004HPf-L6; Fri, 10 Dec 2021 23:35:30 +0000
Date:   Fri, 10 Dec 2021 15:35:30 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: add in-kernel support for decompressing
Message-ID: <YbPkQrg4CRWkESFL@bombadil.infradead.org>
References: <YbLvDWdyFivlj7pP@google.com>
 <YbPPHTO3URnz+tFy@bombadil.infradead.org>
 <YbPg32ceRfwxIgqK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbPg32ceRfwxIgqK@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:21:03PM -0800, Dmitry Torokhov wrote:
> On Fri, Dec 10, 2021 at 02:05:17PM -0800, Luis Chamberlain wrote:
> > On Thu, Dec 09, 2021 at 10:09:17PM -0800, Dmitry Torokhov wrote:
> > > +static ssize_t module_xz_decompress(struct load_info *info,
> > > +				    const void *buf, size_t size)
> > > +{
> > > +	static const u8 signature[] = { 0xfd, '7', 'z', 'X', 'Z', 0 };
> > > +	struct xz_dec *xz_dec;
> > > +	struct xz_buf xz_buf;
> > > +	enum xz_ret xz_ret;
> > > +	size_t new_size = 0;
> > > +	ssize_t retval;
> > > +
> > > +	if (size < sizeof(signature) ||
> > > +	    memcmp(buf, signature, sizeof(signature))) {
> > > +		pr_err("not an xz compressed module\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	xz_dec = xz_dec_init(XZ_DYNALLOC, (u32)-1);
> > > +	if (!xz_dec)
> > > +		return -ENOMEM;
> > > +
> > > +	xz_buf.in_size = size;
> > > +	xz_buf.in = buf;
> > > +	xz_buf.in_pos = 0;
> > > +
> > > +	do {
> > > +		struct page *page = module_get_next_page(info);
> > > +		if (!page) {
> > > +			retval = -ENOMEM;
> > > +			goto out;
> > > +		}
> > 
> > This looks very similar to fw_decompress_xz_pages() on
> > drivers/base/firmware_loader/main.c
> > 
> > Is there any sharing possible with decompression between the two?
> 
> Ideally we'd get proper crypto API allowing this (page by page)
> decompression and then we can switch to it in both places and stop
> calling into particular algorithms directly. Unfortunately this is not
> something I can sign up for at this time.
> 
> As it is I am not sure if it worth to try to split out XZ code and share
> it between module and firmware loader.

Got it, makes sense.

What type of tests have you implemented for this ? kmod has quite a bit
of tests. Can you add some for this?

  Luis
