Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24610547F84
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiFMGcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiFMGcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:32:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F78DAC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:32:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso3983286wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wmuWffwYI5wQkMEQNcTP/vfzVD9gd23o8xCkm8CaTjg=;
        b=Fp5rK1MfFr7t7OWhGPFj6PXfZ+1zTyGLy1BZhb0jhOjOPTihMoY3qlO6w6ojQuKSbX
         u06H+hw0P8U2HYiDN3hkg8H/96iWaNEmnvU6udFIcNRtaKc9D1sVLnomQiUY8PcQTdoI
         E3hH8Sc0yqhqPxVv5Lm/X2wt2dM6a40fgT1dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wmuWffwYI5wQkMEQNcTP/vfzVD9gd23o8xCkm8CaTjg=;
        b=fnOKZXaizd+PRZFQyNccjn5cXo6ff3OIXNXmubYOs5zIajvu06YgcA8wv9BTwF0Utw
         3haiGa4VJnKg+3cHDw4qgh2Tvaw0RPtx+Jgygxd8gUVJVqrbU8D5c0NwiKfQXQOQotK5
         S+Jkt6Gzb/Cx3kO4h3J1H2AzK889JZ3bhtVvulBRknWmvKj1G7Tr9MLlS9b5i4G3VKZc
         svhePCNyPwt6MrhzMWiruzlr3vGjNPalJVlN5rTJrjRaQJmIFYVBLCFEYINtcQjwHC97
         ieZ+8obhJqz9BqLOcyQGTfSBovlvp4gBxapGeSpr5bKxnyRfAa5JzyU8PLCICHiAzOHE
         SCAg==
X-Gm-Message-State: AOAM531Wi8ldKbt1x7IMag6zA/gUEheuyzQeqGw2/OLlAI4fJCZ38d15
        NC7ETig3rZjOuonAlFq4patP2aX+aMsPkA==
X-Google-Smtp-Source: ABdhPJxnbCML04H6Wh1jIDAbrmR72n0h39YxvD6001UZVAuPgPR2tMVsG6fJ9pb6KvNk9zJHsz6NEA==
X-Received: by 2002:a05:600c:4010:b0:39c:481c:c5bd with SMTP id i16-20020a05600c401000b0039c481cc5bdmr12834033wmm.139.1655101961108;
        Sun, 12 Jun 2022 23:32:41 -0700 (PDT)
Received: from fastly.com ([178.130.153.185])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c424800b0039740903c39sm8038933wmm.7.2022.06.12.23.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 23:32:40 -0700 (PDT)
Date:   Sun, 12 Jun 2022 23:32:38 -0700
From:   Joe Damato <jdamato@fastly.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC,iov_iter v2 3/8] iov_iter: add copyin_iovec helper
Message-ID: <20220613063237.GA24325@fastly.com>
References: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
 <1655024280-23827-4-git-send-email-jdamato@fastly.com>
 <Yqa8Q7O0Fmnex8Ev@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqa8Q7O0Fmnex8Ev@zeniv-ca.linux.org.uk>
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

On Mon, Jun 13, 2022 at 04:25:39AM +0000, Al Viro wrote:
> On Sun, Jun 12, 2022 at 01:57:52AM -0700, Joe Damato wrote:
> > copyin_iovec is a helper which wraps copyin and selects the right copy
> > method based on the iter_copy_type.
> > 
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
> Just a sanity check - your testing is *not* with KASAN/KCSAN, right?

Yes, that is correct.

> And BTW, why is that only on the userland side?  If you are doing
> that at all, it would make sense to cover the memcpy() side as
> well...

I assume here you mean the memcpy() in the splice() path? I do have a
separate change I've been testing which does this, but I thought that can
be sent separately.

This RFC basically takes an existing kernel feature (tx-nocache-copy) and
makes it applicable to more protocols and more fine grained so that it does
not need to be enabled interface-wide. The memcpy() change you mention is,
in my mind, a separate change which adds a new feature and can be sent if
this change is accepted upstream.

Let me know if that makes sense and if there are any issues you think I
should address before I send a v1 for consideration.

Thanks for taking a look!
