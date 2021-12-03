Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF1D467EF5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383136AbhLCUw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhLCUwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:52:54 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A70C061751;
        Fri,  3 Dec 2021 12:49:30 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p18so2889252plf.13;
        Fri, 03 Dec 2021 12:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fBo4MZHV4uF1eWpsPa3kggPcjinOj4dYetsnTVJHI9I=;
        b=WZrdxBC/Kvx/uA/sH5Nhk7Qt9WAzJtbG27U4Vd+O1qwSSuoDXpHx5fCCHPdywzvwWV
         JGpdmBhUkTfTvqK3oBuFSJF3RM4drYtSQV1fBysQOHEyPVAm5x25QE6hS6JT3jJxdS9o
         Cn+Xnn/zdvE0DM/8UkYiQ9SA98QeR+NqOohbY5sbVd1aqut/UqbW9vIdiXixci7kx022
         CqxkSZ+8qnPR6KbOXsQck1vgWxvN2oCzT8EwLugU9HhDV4lyD2aPTFjF18vvqjRwZv9e
         KW550bcdk+CoGbfd+IkMGQmCsANt9FHAkigdjfeK6uHUu6joIotutQOsYb3i8lGooc1y
         0/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fBo4MZHV4uF1eWpsPa3kggPcjinOj4dYetsnTVJHI9I=;
        b=Y97yzK1AALD5yZJMrXHfs6tdmSFMBTg5qqLLdsohjyHIulY0gP/hLxiPvFJe+T8u6I
         KZMmCgyXoC75OcLepLCmP8RUX+7IKExsdTVfko4v8r+ObO7J3LaIxREkNkMQD7z4DZyq
         t8P4HpCJh7XsWFU6NdS/PvGCZuhUwMDPub0HvbYwSDPZZoXTTWpJcTpUfedfOGfw2W2+
         QpAYKqOq5kZNMLudf3sPv+mA7yiXnmzm0c5kzOEnbWHGxfrBhbLQBMuTkRWb9jJtyDwA
         VoO3OwsxmUVbqsI7U1BiK4ZZAoYalX6pET04+ZqjaIBImYLOEBEhIvE/rz7HWWFyCntL
         WDsg==
X-Gm-Message-State: AOAM532v8zjB33wis0vjqs10PraWTX+nbrzP3HK5ri/iUt0SwGGHnYKS
        35Ln+f51TwsKkVus2mjKBKE=
X-Google-Smtp-Source: ABdhPJwdq2d47Sxc1INNMgwC22079wVYP6+3MqVe54rkOvOUHXm9vGppdFuIKeJEfFua4Dl9+1AZsA==
X-Received: by 2002:a17:902:c943:b0:142:1758:8ee7 with SMTP id i3-20020a170902c94300b0014217588ee7mr25340080pla.58.1638564569592;
        Fri, 03 Dec 2021 12:49:29 -0800 (PST)
Received: from google.com ([2620:15c:202:201:e637:aa31:c488:b6c0])
        by smtp.gmail.com with ESMTPSA id e6sm3188675pgc.33.2021.12.03.12.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 12:49:28 -0800 (PST)
Date:   Fri, 3 Dec 2021 12:49:26 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Haren Myneni <haren@us.ibm.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] crypto: add zbufsize() interface
Message-ID: <YaqC1mkcyzO2WrI/@google.com>
References: <20180802215118.17752-2-keescook@chromium.org>
 <20180807094513.vstt5dhbb7n6kvds@gondor.apana.org.au>
 <CAGXu5j+dPqpJZbO_AuGsNqJzq7XGcB2deXA5RELWv1-Ywi5QOA@mail.gmail.com>
 <20180808025319.32d57wtjpyyapwo5@gondor.apana.org.au>
 <202112011529.699092F@keescook>
 <20211202015820.GB8138@gondor.apana.org.au>
 <202112011947.7FA0A587C@keescook>
 <20211202035727.GC8138@gondor.apana.org.au>
 <202112012304.973C04859C@keescook>
 <20211203022821.GA16082@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203022821.GA16082@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 01:28:21PM +1100, Herbert Xu wrote:
> On Thu, Dec 02, 2021 at 12:10:13AM -0800, Kees Cook wrote:
> >
> > I'd rather just have a simple API that hid all the async (or sync) details
> > and would work with whatever was the "best" implementation. Neither pstore
> > nor the module loader has anything else to do while decompression happens.
> 
> Well that's exactly what the acomp interface is supposed to be.
> It supports any algorithm, whether sync or async.  However, for
> obvious reasons this interface has to be async.
> 
> > > Typically this would only make sense if you process a very small
> > > amount of data, but this seems counter-intuitive with compression
> > > (it does make sense with hashing where we often hash just 16 bytes).
> > 
> > pstore works on usually a handful of small buffers. (One of the largest
> > I've seen is used by Chrome OS: 6 128K buffers.) Speed is not important
> > (done at most 6 times at boot, and 1 time on panic), and, in fact,
> > offload is probably a bad idea just to keep the machinery needed to
> > store a panic log as small as possible.
> 
> In that case creating an scomp user interface is probably the best
> course of action.
> 
> > Why can't crypto_comp_*() be refactored to wrap crypto_acomp_*() (and
> > crypto_scomp_*())? I can see so many other places that would benefit from
> > this. Here are just some of the places that appear to be hand-rolling
> > compression/decompression routines that might benefit from this kind of
> > code re-use and compression alg agnosticism:
> 
> We cannot provide async hardware through a sync-only interface
> because that may lead to dead-lock.  For your use-cases you should
> avoid using any async implementations.
> 
> The scomp interface is meant to be pretty much identical to the
> legacy comp interface except that it supports integration with
> acomp.
> 
> Because nobody has had a need for scomp we have not added an
> interface for it so it only exists as part of the low-level API.
> You're most welcome to expose it if you don't need the async
> support part of acomp.

I must be getting lost in terminology, and it feels to me that what is
discussed here is most likely of no interest to a lot of potential
users, especially ones that do compression/decompression. In majority of
cases they want to simply compress or decompress data, and they just
want to do it quickly and with minimal amount of memory consumed. They
do not particularly care if the task is being offloaded or executed on
the main CPU, either on separate thread or on the same thread, so the
discussion about scomp/acomp/etc is of no interest to them. From their
perspective they'd be totally fine with a wrapper that would do:

int decompress(...) {
	prepare_request()
	send_request()
	wait_for_request()
}

and from their perspective this would be a synchronous API they are
happy with.

So from POV of such users what is actually missing is streaming mode of
compressing/decompressing where core would allow supplying additonal
data on demand and allow consuming output as it is being produced, and I
do not see anything like that in either scomp or acomp.

Thanks.

-- 
Dmitry
