Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA119470EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345217AbhLJXvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243667AbhLJXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:51:02 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF37FC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:47:26 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id u80so9786377pfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gZ3UUEeR3r2CYMV62vys3lIdUhFL/NSBOP1h/K9fB0k=;
        b=Ye2XQZZxk+QOrSduykDfdBcwrLjg5fqKAtSYEL2r6R1c4UT2lEUt0HOicfrjtPHvCs
         0LxkugibjPZATfZAQziTov6CPfkOsIqazC/PAlfdrAdRUMrBgH1WKcwhwh3mHk/2z6JU
         Dm7vkD6LCEpfttd6EpXQGAKzUb3qyJ2qi/RnlQt1QOZJCRvynxsuYOYNUTACFPvaZjxV
         6ZoStw+XQ02x95ljtEWP/6T9LmH2YAiF4KnYbjJ5g6ShR7lIyqph1/2Ao7LCnOQgJ6QM
         sXYoeLLxPTvoIKaGrMXFDg/LtBEW0CKcM4B4gItHFmL1a3gttwefhgj9yK8iyFPHNdiJ
         /UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gZ3UUEeR3r2CYMV62vys3lIdUhFL/NSBOP1h/K9fB0k=;
        b=MGJfQH8i0Yp4w+ChdF4d6yCoA35iJV9dqn3R8BswZnTMTHyk0MTKLs+RsEdytkJyH1
         jTNbF6Y63XEJR4osUMKKO08sXORjRd5j3ohQpyemyF8ec1R17BSsSyT3orcxx+QuiWNM
         ypUf1kZ017nnvCB7r2Gk5U+D0EJLvjl+lqNKQEfPmmCSjhJBKOBsxZ5FO47NUCHC+kyh
         9Q9xeC/3Bth7flDxxDMHwxWFoTg0Etm6MAud0gb8jCUItfkEdUEdSyjkIfwAa3VQx6MM
         Y6z8BENKNjTY9re4Og4/voOVgjtECkpF9S78QlalBFki/10rImfpBgxsqbRjxDW77PmK
         qEIw==
X-Gm-Message-State: AOAM530w+blGdk4QYeOkC7cJgaMRiJ+/Fgk00+JE15A/xilGY3e52cRH
        60IfwI+i9nDvUdR1myWDidY=
X-Google-Smtp-Source: ABdhPJzaux6lygKeW+lWsSFMZqT7VFZ+JX0aqe1kNwxRlrvcoRsiJoVe6mgQoTzo0GfLPJwuLNk2NQ==
X-Received: by 2002:a65:6458:: with SMTP id s24mr41894683pgv.271.1639180046261;
        Fri, 10 Dec 2021 15:47:26 -0800 (PST)
Received: from google.com ([2620:15c:202:201:749:db5e:6dc8:be24])
        by smtp.gmail.com with ESMTPSA id j36sm3614396pgi.8.2021.12.10.15.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 15:47:25 -0800 (PST)
Date:   Fri, 10 Dec 2021 15:47:22 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: add in-kernel support for decompressing
Message-ID: <YbPnCo8ZZ6vrMASe@google.com>
References: <YbLvDWdyFivlj7pP@google.com>
 <YbPPHTO3URnz+tFy@bombadil.infradead.org>
 <YbPg32ceRfwxIgqK@google.com>
 <YbPkQrg4CRWkESFL@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbPkQrg4CRWkESFL@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:35:30PM -0800, Luis Chamberlain wrote:
> On Fri, Dec 10, 2021 at 03:21:03PM -0800, Dmitry Torokhov wrote:
> > On Fri, Dec 10, 2021 at 02:05:17PM -0800, Luis Chamberlain wrote:
> > > On Thu, Dec 09, 2021 at 10:09:17PM -0800, Dmitry Torokhov wrote:
> > > > +static ssize_t module_xz_decompress(struct load_info *info,
> > > > +				    const void *buf, size_t size)
> > > > +{
> > > > +	static const u8 signature[] = { 0xfd, '7', 'z', 'X', 'Z', 0 };
> > > > +	struct xz_dec *xz_dec;
> > > > +	struct xz_buf xz_buf;
> > > > +	enum xz_ret xz_ret;
> > > > +	size_t new_size = 0;
> > > > +	ssize_t retval;
> > > > +
> > > > +	if (size < sizeof(signature) ||
> > > > +	    memcmp(buf, signature, sizeof(signature))) {
> > > > +		pr_err("not an xz compressed module\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	xz_dec = xz_dec_init(XZ_DYNALLOC, (u32)-1);
> > > > +	if (!xz_dec)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	xz_buf.in_size = size;
> > > > +	xz_buf.in = buf;
> > > > +	xz_buf.in_pos = 0;
> > > > +
> > > > +	do {
> > > > +		struct page *page = module_get_next_page(info);
> > > > +		if (!page) {
> > > > +			retval = -ENOMEM;
> > > > +			goto out;
> > > > +		}
> > > 
> > > This looks very similar to fw_decompress_xz_pages() on
> > > drivers/base/firmware_loader/main.c
> > > 
> > > Is there any sharing possible with decompression between the two?
> > 
> > Ideally we'd get proper crypto API allowing this (page by page)
> > decompression and then we can switch to it in both places and stop
> > calling into particular algorithms directly. Unfortunately this is not
> > something I can sign up for at this time.
> > 
> > As it is I am not sure if it worth to try to split out XZ code and share
> > it between module and firmware loader.
> 
> Got it, makes sense.
> 
> What type of tests have you implemented for this ? kmod has quite a bit
> of tests. Can you add some for this?

OK, will do.

Thanks.

-- 
Dmitry
