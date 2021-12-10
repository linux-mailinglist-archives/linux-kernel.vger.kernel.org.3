Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712DF470E84
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbhLJXYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345063AbhLJXYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:24:42 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AF8C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:21:06 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v19so7261008plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZvTgagilxvQY/fNJgpBkQPUhA2ElMkn6jUU7j0eNZ+I=;
        b=AFmTG8YEWVnuoIS5mAzCME58UsD2y5ZxlcLJJiP25V0VI6XhY5oDdZXYHkg0Dc2MWa
         iHKM4ShgC0cJ6MYFVCFtWHTbVnd5i+mOUN3KFgJD2Z4jW2FGzdyYbLLMB/uacEKzq19u
         Kw1JTpEg8C0ecH/YP3dt6PcvBOXv/tIr5hdD6VMYotzIyWr0eD+qx/MWQU/IXwsg9aVF
         Tl1zhfRuFHItxNYy0yvK8TT3eSqggEQNVw7F02b/FtFi8lIAq5UatbFMfLJYBVpWPRMx
         KgSwNPt6ZBPRmFD70sI82qsbyRuMW1H6nLU90b491yH1F/G6mR6Lq2G5F9FPW3l7Oo+p
         81zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZvTgagilxvQY/fNJgpBkQPUhA2ElMkn6jUU7j0eNZ+I=;
        b=Ghbo5PtLeifMyPtoRqqSpnBggfWtZ8p9acTLZ0elE23nbnzBPQsAZRU7puM1nrvsLV
         qYG7jfxFyE8JkrSzQC19GOqw9IytoueIM8gTA55LWq/24b5S5FksokvI8jBSlCYp/kEb
         QwYOr7mOBxbq82LsG52RPfwqq/3MEx6YNfid58VMAOvTx0VM7Ru66kF3LR2s1zpI8FLS
         hh19Y1uxNFACYU4bIVxJxgJ9dzjDxmohKKD+FgLFVbWZwYLKWPmEcQQmcg8nwLfoKwcZ
         3tm2LDU31SCYq/Iu/oJynEn9mMRiazMgrizHoMKy3lKrblHJaJWGhem2eoU0gIS871e3
         RmYA==
X-Gm-Message-State: AOAM532Bug9vmFk54DxXHkWKdOcRcJo2xDCi4DzyMWei2HhKuEPvuKBM
        Xc6Ii0+b7MMiuU/qkP5zvLU=
X-Google-Smtp-Source: ABdhPJyk/8v0s3BLrTydZqkTayzrmg9FjBf60o98x9B4aUy9L9cHGnH4w4Hpr8ikLRLZivG9B4Hrog==
X-Received: by 2002:a17:90a:6e41:: with SMTP id s1mr27468861pjm.166.1639178466303;
        Fri, 10 Dec 2021 15:21:06 -0800 (PST)
Received: from google.com ([2620:15c:202:201:749:db5e:6dc8:be24])
        by smtp.gmail.com with ESMTPSA id m16sm4839115pfk.186.2021.12.10.15.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 15:21:05 -0800 (PST)
Date:   Fri, 10 Dec 2021 15:21:03 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: add in-kernel support for decompressing
Message-ID: <YbPg32ceRfwxIgqK@google.com>
References: <YbLvDWdyFivlj7pP@google.com>
 <YbPPHTO3URnz+tFy@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbPPHTO3URnz+tFy@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 02:05:17PM -0800, Luis Chamberlain wrote:
> On Thu, Dec 09, 2021 at 10:09:17PM -0800, Dmitry Torokhov wrote:
> > +static ssize_t module_xz_decompress(struct load_info *info,
> > +				    const void *buf, size_t size)
> > +{
> > +	static const u8 signature[] = { 0xfd, '7', 'z', 'X', 'Z', 0 };
> > +	struct xz_dec *xz_dec;
> > +	struct xz_buf xz_buf;
> > +	enum xz_ret xz_ret;
> > +	size_t new_size = 0;
> > +	ssize_t retval;
> > +
> > +	if (size < sizeof(signature) ||
> > +	    memcmp(buf, signature, sizeof(signature))) {
> > +		pr_err("not an xz compressed module\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	xz_dec = xz_dec_init(XZ_DYNALLOC, (u32)-1);
> > +	if (!xz_dec)
> > +		return -ENOMEM;
> > +
> > +	xz_buf.in_size = size;
> > +	xz_buf.in = buf;
> > +	xz_buf.in_pos = 0;
> > +
> > +	do {
> > +		struct page *page = module_get_next_page(info);
> > +		if (!page) {
> > +			retval = -ENOMEM;
> > +			goto out;
> > +		}
> 
> This looks very similar to fw_decompress_xz_pages() on
> drivers/base/firmware_loader/main.c
> 
> Is there any sharing possible with decompression between the two?

Ideally we'd get proper crypto API allowing this (page by page)
decompression and then we can switch to it in both places and stop
calling into particular algorithms directly. Unfortunately this is not
something I can sign up for at this time.

As it is I am not sure if it worth to try to split out XZ code and share
it between module and firmware loader.

Thanks.

-- 
Dmitry
