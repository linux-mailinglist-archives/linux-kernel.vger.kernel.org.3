Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D371599561
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346361AbiHSGgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiHSGga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:36:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE199D87E4;
        Thu, 18 Aug 2022 23:36:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CDFF83200344;
        Fri, 19 Aug 2022 02:36:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 19 Aug 2022 02:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660890985; x=1660977385; bh=pBeaj2V8t6
        P6bolCHrfvXg9D/W9MzEWG+IPlbO8Nh9E=; b=LmO6mbb053d74ialFpg+AUcGlA
        5sJ8GMsLi2B6uqzfsj8MweB2M6qe7jz1ViFH58duNQj1qMqcHqQAjyzk7uyf2wPf
        iGdGo+HPWqc+aIHgHva0gfH3JGu3VJKa0hcWyGMkXvbIlA8OZW0uE6LiP6pZolxp
        6UlhRrsKKgxAA3RLZuxQAsIZ6x0p35Y+LcN+lAaii06OjEx9phISE351+xLUx/Bj
        vK0+cS8MjAoSJfFdPSLXYTivgbF9b3HwDRkl4lm54i5IoWTEfs+ZSSNoHhQyLetI
        JtcUyRZlYG9i/xvcTUtjWugaEJU/zmTXvxD2t+SP5/S/SltpASiHVILpj0zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660890985; x=1660977385; bh=pBeaj2V8t6P6bolCHrfvXg9D/W9M
        zEWG+IPlbO8Nh9E=; b=Q5Vk6MDCGVydPBD6Efm3Ot1YVPqdDBrQ//yrb/l85OWN
        2cipyAFKCzFF+bMBk2zAUyoxAHl+ZOJUiUUVQ9Z3Geb226DcmT/KVUc/9vcEOnyH
        NVlUxyc1oZ85cqUqYrwc4WnSu3YAesltk6L4Y12gMEvH0BgZAKyYDMSLFdnLJHie
        900pB9D+pgczn7Yo4n7v+6rsL0R8D/oDWQSGzIjPTumU6czvPk0fp9RC5fXZKl/N
        fDlpZoM6f2ZbbUkYW7ExPto0LNyFs/qiPFzxPE6Km3vL3ZxzY+8uHWLHWetUlkGd
        G4JutDqq9Lmgy6U+TSm0kZ+tMH1t6BxQKT9cLdv2ow==
X-ME-Sender: <xms:aC__YsfpYqv_GWl61ECZq0wQjEwy_pGX10fjNJre5sd6N_isJ2Rz0Q>
    <xme:aC__YuNvkDQlK7AZ2FlB30WfNRvqNj2QT0nLwKk_gvpKelThPWaPvc8RuAHjsVKow
    tP7cTs2QAtuMg>
X-ME-Received: <xmr:aC__YtjtqRwZTWZ4-Ovmi07L5ktzAD0UALS1ZeAiwZAt-w81ig7MWBg05kOmX85M0JLvsxkYeKZdFtobK0tcvWDRyDSz24t6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeitddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:aC__Yh_BDbgrPNGynMGP_hWqYLgb0I4c6IiAfqk77cVVxQfYtjqQCw>
    <xmx:aC__YovYNODedOs6rDaSWBUmkY1Oc2FQDzYulbbLMUFsQhWSFuX3rg>
    <xmx:aC__YoGxF5xC9N_5OoF818RdARckXYOUjVTu6UI95D1BIJq5iAXdKg>
    <xmx:aS__Ypmjfia4nRhyxizbaIaEglPxQjnZldEEVX2VMYtCaaCQ5WqloQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Aug 2022 02:36:24 -0400 (EDT)
Date:   Fri, 19 Aug 2022 08:36:21 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc.current tree with the
 mm-hotfixes tree
Message-ID: <Yv8vZQB25NE0r/uN@kroah.com>
References: <20220819082714.5313827d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819082714.5313827d@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 08:28:18AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the char-misc.current tree got a conflict in:
> 
>   drivers/android/binder_alloc.c
> 
> between commit:
> 
>   b3bb668f3dc6 ("binder_alloc: add missing mmap_lock calls when using the VMA")
> 
> from the mm-hotfixes tree and commit:
> 
>   d6f35446d076 ("binder_alloc: Add missing mmap_lock calls when using the VMA")
> 
> from the char-misc.current tree.
> 
> I fixed it up (I used the latter as it was committed later even though
> the author times were the same) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

These should be identical, if not, something went wrong :(

thanks,

greg k-h
