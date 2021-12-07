Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22A346B2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhLGG2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhLGG2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:28:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC20C061746;
        Mon,  6 Dec 2021 22:24:52 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y7so8759514plp.0;
        Mon, 06 Dec 2021 22:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqgniE7yhBdC3a/zZm7vuiVRgb+iOJ+XrnEthf5XuaI=;
        b=n9KuB99Q6cQTR0wVyqfGthPj/cR9v1ycsfGZuquiMLnJ51IVgpcmbapo/yXZBdbMQZ
         8F6dF4dYarkeWe8I6ixroyqR1GTVrdDzajnn7x7iUttUlzWQw9WMB1YLYF/5VLPpSJEx
         aKNI0G7Y+NpVsZcrR/8iZ2LNDc9cB0fUTNsUGeoqJw1xnjcKr2YftHpwJf1iQuFW+bSW
         kIjLEOzLIRJE18hRm9gQwkSRPvKsh7m1NhQES5O6ZESqNQrJrJJKV51lJKQ1rzHqZ06N
         NdyJ/oIXpZD0+87SkUPKWDeICMJNd4UdjEivzCsad3oI5Bs5FNNSRh4rlTBqP7Fa5vsh
         3U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqgniE7yhBdC3a/zZm7vuiVRgb+iOJ+XrnEthf5XuaI=;
        b=nDafW60EgHLdoIZS/StYL1VIXqTekGrrlrs/nLQqXsE1cyrsvYltEmBBRzpIYuMX7y
         JI3eBlv6heKGqPtoreCLJ5A8LiI4o/Qb3kKYju0Plfq9eyi0JTFLw4c6gyVGhlHdrdQ/
         x5utEpWwsD6IsL3yMqlQUWL6UJ6tdsSnb0adJJ5s0QPNxE0QabvXWCrHsgpNaw92miqI
         1HQ8uxZLl6VlO4XgoULGtACN7eS2OZN72cQ4M9Ni6wSq17XQWj7wnk0Bk5wtRG4mCHTd
         BlbxQNwisbW+k5tz3sCzGiCu2ioqsugRedzosTkT4TV6EOm01NfGcxVy141ZwZTang1D
         wvIw==
X-Gm-Message-State: AOAM533p4xHAkBGxJu93pHv+mOJOKoaDfIs2PDD8Lu/BaxASNqOXEImb
        ycBaVlw6F+FMAAR/r2ZW72k=
X-Google-Smtp-Source: ABdhPJxETFEN/8WlMPuNkHvbtxRztZGO19gU4hV3L9vphwMehRZ1kaaxN3J0F7US+l3D03tFkzyXDA==
X-Received: by 2002:a17:903:1c7:b0:141:e630:130c with SMTP id e7-20020a17090301c700b00141e630130cmr49457134plh.80.1638858291547;
        Mon, 06 Dec 2021 22:24:51 -0800 (PST)
Received: from google.com ([2620:15c:202:201:25b0:d110:b844:ea00])
        by smtp.gmail.com with ESMTPSA id f3sm14237289pfg.167.2021.12.06.22.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 22:24:50 -0800 (PST)
Date:   Mon, 6 Dec 2021 22:24:47 -0800
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
Message-ID: <Ya7+L33dFnm0q+jm@google.com>
References: <CAGXu5j+dPqpJZbO_AuGsNqJzq7XGcB2deXA5RELWv1-Ywi5QOA@mail.gmail.com>
 <20180808025319.32d57wtjpyyapwo5@gondor.apana.org.au>
 <202112011529.699092F@keescook>
 <20211202015820.GB8138@gondor.apana.org.au>
 <202112011947.7FA0A587C@keescook>
 <20211202035727.GC8138@gondor.apana.org.au>
 <202112012304.973C04859C@keescook>
 <20211203022821.GA16082@gondor.apana.org.au>
 <YaqC1mkcyzO2WrI/@google.com>
 <20211207052029.GA12141@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207052029.GA12141@gondor.apana.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:20:29PM +1100, Herbert Xu wrote:
> On Fri, Dec 03, 2021 at 12:49:26PM -0800, Dmitry Torokhov wrote:
> >
> > I must be getting lost in terminology, and it feels to me that what is
> > discussed here is most likely of no interest to a lot of potential
> > users, especially ones that do compression/decompression. In majority of
> > cases they want to simply compress or decompress data, and they just
> > want to do it quickly and with minimal amount of memory consumed. They
> > do not particularly care if the task is being offloaded or executed on
> > the main CPU, either on separate thread or on the same thread, so the
> > discussion about scomp/acomp/etc is of no interest to them. From their
> > perspective they'd be totally fine with a wrapper that would do:
> > 
> > int decompress(...) {
> > 	prepare_request()
> > 	send_request()
> > 	wait_for_request()
> > }
> > 
> > and from their perspective this would be a synchronous API they are
> > happy with.
> 
> You can certainly do that as a Crypto API user.  And we do have
> some users who do exactly this (for example, testmgr does that
> when testing async algorithms).  However, this can't be a part of
> the API itself since many of our users execute in atomic contexts.

That is what I am confused about: why can't it be a part of API? Users
that are running in atomic contexts would not be able to use it, but we
have a lot of precedents for it. See for example spi_sync() vs
spi_async(). Callers have a choice as to which one to use, based on
their needs.

Thanks.

-- 
Dmitry
