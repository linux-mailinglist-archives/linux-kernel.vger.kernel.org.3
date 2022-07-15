Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21C9575D98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbiGOIhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiGOIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:37:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D388148F;
        Fri, 15 Jul 2022 01:37:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bp15so7764195ejb.6;
        Fri, 15 Jul 2022 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=J+9HGyAEN1pJBy/DvkM1mQBg4p/Yv310qvcslrhu09s=;
        b=JC/CN8/YNPAb3xeJKIC11lCCMeEU/VxDQx2T1pDL52lQoM/jzoztfMlEhLRro3Vhlb
         kY60LkLuxx9rha+J+HJZ2973tRFMSnzPvLsTj4waeut50jKWsnppfI+9ZeM90YbcgWZQ
         b+6YTajzdkdwH9xDX7fn4630x2iF7LJ+wSDOd8uIGMPxIRojPS/cW8F06gu/S+QQahAx
         J/Bn6dOyezVJz7uxTxETNKu99SWsYMTZedE3SvqvRJ1kvBWVOoDNNf4bJveeiV9zCVdp
         67DfvfiTKKYrX4eWYHszXNRg9I7MmQwaefT1U323W9km3Tudb2D5w5XomdX/IcbKS/pI
         hKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=J+9HGyAEN1pJBy/DvkM1mQBg4p/Yv310qvcslrhu09s=;
        b=Osy+JyvSLbIXXSmrkd7cQgS+l6WXecDodQzhDQqgSQfID7uF4lO8Oa2aMJOMXhI06G
         C80uw8agVhP1EG/qS4cGZHFTw0Yg+J9YmOwW8c1OQeDzY6AA2Pv23q/W/fEakcSFb+yU
         MCLmRmzW04bqWy9z10lDtMQBEv8fLCoGgetyzEoI8+zVpSy0Gcl8wz4bflzNo7m/8Zpe
         N+T5MklQ0PjbpggkKBaAk98IZ0Cnnj6EDBFNTfxOFsOCn+fzbS5gaGZishBzrJDaOYui
         O56jpdRcpyjSHuAZGWl2YvSvo4wXlNRjlLmjQzrmIR3/bJozqWEFIz3ObYcPpFW1CQEH
         UqMg==
X-Gm-Message-State: AJIora8QnsK4G+J8qtPjklaNDVNyUmjekDl6/WJuw0jgCpOOfKGGvtdY
        M+3ni4Gn/oGuFYfudjDpiHM=
X-Google-Smtp-Source: AGRyM1sOd2xLAIMyNxCPTpgA4BENx/7gDvju2Nyj7biBYkl+P8YLZQvFrPHxlxBgGXTUrPNSDK3JdQ==
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id e8-20020a17090658c800b006fe91d518d2mr12658988ejs.190.1657874270785;
        Fri, 15 Jul 2022 01:37:50 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id p19-20020a056402075300b0043a7cdfac46sm2385948edy.23.2022.07.15.01.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 01:37:50 -0700 (PDT)
Message-ID: <62d1275e.1c69fb81.f16fe.51e0@mx.google.com>
X-Google-Original-Message-ID: <YtDMqUgQ3X4utM6Z@Ansuel-xps.>
Date:   Fri, 15 Jul 2022 04:10:49 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Eric Biggers' <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: lib/arc4 - expose library interface
References: <20220714051221.22525-1-ansuelsmth@gmail.com>
 <YtDLMmwffn6p/rSV@sol.localdomain>
 <872b3792d96946b48236120a057b99bc@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872b3792d96946b48236120a057b99bc@AcuMS.aculab.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 07:39:48AM +0000, David Laight wrote:
> From: Eric Biggers
> > Sent: 15 July 2022 03:05
> > 
> > On Thu, Jul 14, 2022 at 07:12:21AM +0200, Christian Marangi wrote:
> > > Permit to compile the arc4 crypto lib without any user. This is required
> > > by the backports project [1] that require this lib for any wireless
> > > driver.
> > >
> > > [1] https://backports.wiki.kernel.org/index.php/Main_Page
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  lib/crypto/Kconfig | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
> > > index 2082af43d51f..2dfc785a7817 100644
> > > --- a/lib/crypto/Kconfig
> > > +++ b/lib/crypto/Kconfig
> > > @@ -6,7 +6,11 @@ config CRYPTO_LIB_AES
> > >  	tristate
> > >
> > >  config CRYPTO_LIB_ARC4
> > > -	tristate
> > > +	tristate "ARC4 library interface"
> > > +	help
> > > +	  Enable the ARC4 library interface. This interface is mainly
> > > +	  used by wireless drivers and is required by the backports
> > > +	  project.
> > >
> > >  config CRYPTO_ARCH_HAVE_LIB_BLAKE2S
> > >  	bool
> > 
> > I don't think this is appropriate for upstream, as the upstream kernel doesn't
> > support out-of-tree code.  This is also an internal API that can change from one
> > kernel version to the next.
> 
> Out-of-tree code always has to allow for arbitrary changes to
> kernel interfaces between kernel versions.
> So the fact that the API might change isn't relevant.
> The continual API changes keep some of us in a job :-)
> 
> (It has to be said that if I needed RC4 I'd probably add a local copy.)
>

Wonder if I can ask you some advice about the topic... I understand that
this cannot be merged upstream.

So the correct solution would be having a copy of the arc4 lib in
backports?

-- 
	Ansuel
