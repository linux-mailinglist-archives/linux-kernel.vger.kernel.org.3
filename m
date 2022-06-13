Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DB3549958
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240781AbiFMQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbiFMQzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:55:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0A1FBF41
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:42:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso3238664wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4akf6xAeEiDNjRf0JScpXKKSBtHxsVRKodRNZRz5EDY=;
        b=R2WnXSyJngnsQ+NbG7DzfsJjV5QDqtdWcY1C0rqi0/Bhr3GvQ0EHgW9Zc7uMoYf8tt
         RRHPPA+wYE525krSzi2wZ7lSsafbJtlCWuyA3JWW8c/RKS70+5pPKpeyobYlu8N7mKaV
         lYG0CDicCSmRkHSAG5601Rn2/euMz1aFdr6fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4akf6xAeEiDNjRf0JScpXKKSBtHxsVRKodRNZRz5EDY=;
        b=qeWxSuy670Bl9jZhSFSLqZ/Okws8qOZWsfLGvBwSTnMUum1Z8ndMRnSw2Oy1rLccqo
         C1jh4mM72q4ZLNNb0Pq4Gm0a0NklGYpRgjqcox9XzDtJRUJ8OjxFhN+yhPXbwv0CdRJJ
         jkGMx+aGVIeJlEhTtDx50IPe1i9NxDY2wqRnnq5zT4GGKhik3GTl2673bRiTgWYyu7pu
         xifo2F6FJqvA49XMphUrnMo9QVTyBwPt+0fHdnyMbyYztDftApXEc1TJMeTx0e+dAO3E
         ref/B9vCyZ8Q/MUUK057ySes0cVwHmSlZklgJfzvbO7Ra5U5Etz2fbgMAr9SSWvYSeGg
         IuJw==
X-Gm-Message-State: AOAM532QYPvR411KO+ZWtMs2fXZwUT2EZQb3aE+lgwjgi6TL3cqH3z2x
        BXq83HHzfMOdtGqht4JWeLVaYA==
X-Google-Smtp-Source: ABdhPJx6xngD3camuVYIgxpYorAMd/3Laxs4bbbGX1nJePdn2jj1GVyU0vVwhfD1Xyzsu9DGPVoWSA==
X-Received: by 2002:a05:600c:1906:b0:39c:7f82:3090 with SMTP id j6-20020a05600c190600b0039c7f823090mr15046232wmq.152.1655131368874;
        Mon, 13 Jun 2022 07:42:48 -0700 (PDT)
Received: from fastly.com ([178.130.153.185])
        by smtp.gmail.com with ESMTPSA id t18-20020a7bc3d2000000b0039bc95cf4b2sm9728838wmj.11.2022.06.13.07.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2022 07:42:47 -0700 (PDT)
Date:   Mon, 13 Jun 2022 07:42:45 -0700
From:   Joe Damato <jdamato@fastly.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC,iov_iter v2 3/8] iov_iter: add copyin_iovec helper
Message-ID: <20220613144244.GA77534@fastly.com>
References: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
 <1655024280-23827-4-git-send-email-jdamato@fastly.com>
 <8f6771a01fe74cde86641e780d31a2ce@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6771a01fe74cde86641e780d31a2ce@AcuMS.aculab.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 07:53:19AM +0000, David Laight wrote:
> From: Joe Damato
> > Sent: 12 June 2022 09:58
> > 
> > copyin_iovec is a helper which wraps copyin and selects the right copy
> > method based on the iter_copy_type.
> 
> A pretty bad description.

Thanks, David. I'll be sure to fix the commit description in the next
revision.

> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  lib/iov_iter.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > index d32d7e5..6720cb2 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -168,6 +168,15 @@ static int copyin(void *to, const void __user *from, size_t n)
> >  	return n;
> >  }
> > 
> > +static int copyin_iovec(void *to, const void __user *from, size_t n,
> > +			struct iov_iter *i)
> > +{
> > +	if (unlikely(iov_iter_copy_is_nt(i)))
> > +		return __copy_from_user_nocache(to, from, n);
> > +	else
> > +		return copyin(to, from, n);
> > +}
> 
> Isn't this extra conditional going to have a measurable impact
> on all the normal copy paths?

The kernel already does a conditional for tx-nocache-copy on TCP sockets
when copying skbs to check for the NETIF_F_NOCACHE_COPY bit, but I hear
what you are saying.

I suppose I could push the NT copy check logic out of iov_iter, but to do
that I think I'd probably have to significantly refactor the iov code to
break apart copy_page_from_iter_iovec.

I'll spend a bit more time thinking through this, but I'm open to
suggestions if you have one; the benefit of supporting non-temporal copies
in this path is pretty significant, so I hope a path forward can be found.

> The additional costs of all the 'iovec' types is bad enough
> already.

Do you have data you can share on this?

Thanks for taking a look!
