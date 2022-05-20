Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1924052F3A8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353168AbiETTIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbiETTIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:08:20 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B1519669A;
        Fri, 20 May 2022 12:08:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DFE7B5C016A;
        Fri, 20 May 2022 15:08:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 20 May 2022 15:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1653073697; x=1653160097; bh=fI8NrSEa2V
        /LQ+RtZc+UGGY9Ev/Xm4uci6IiTsPxdm0=; b=mVuXap/RdqY0CvhUGgMfElVx0T
        U9LM1li5Mg5dC5OM8Mt+9VWghQqzlOMLZ7cT1e3KVprX+OpRKD7a0V3Q1ZlkTisR
        TW7Vy0SkARKo4v4l7gpGFdHRbNqRJnhDBvgQw57hE71vKUwPm8XpQ8Yz7QRtAS3K
        tzkNsq1BYNa8WdnAlOWZG93eiOkbddYSBMjZAc0NgdOKx+uh1Zy2bElCWhj01lM9
        Bu7Fj5W8oXAjn/+vlnXiC1ZhSpQ/NqzJef168MN6tFODcMNIFeJKXy/K3x0W0GEy
        IHG8VELdzHdMndDFA0zsEspnrNGuWnYpOEO2/JDYTmhEd9gQ16wJmQUcchmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653073697; x=1653160097; bh=fI8NrSEa2V/LQ+RtZc+UGGY9Ev/X
        m4uci6IiTsPxdm0=; b=K75/26GGy9haXDqF17xfsWj9ns3399+u3gZd5HQLxrA8
        XHRYOEp8JOYP9zbnv0KVIzRDWcoZtEPTF98fmATkp8sSB5kItXzhv+ak5WU9zN8t
        O7uQKGGujTWmcqv2g5KE9/m2u00CY1sFHqgn4Y1KwG3IK/XKZOoD65stdszoCvFD
        BZBD7PIgeG8o3RHbT21oJi8HdNji/LtkIQA4fAFDtcovcSVJ7Bl0ZjfimaPFVCK5
        4PI/Qw9o9sy/w3e1kNPITFzsLknIk1PTRgtIPlpkC9A9b5dbuYbQjNaSWin9fU3m
        S0pVw2OOCKH7qVb2G1/pwVP/p5usIVw772Nge/aB2w==
X-ME-Sender: <xms:IeeHYro-TUUodLyLv9VS8vYxb2mNdgy3Jnp4aBvtlEy1UfWaSbVMdg>
    <xme:IeeHYlrtrE-XtgNqQGzXYFGXwCVN3FjAMSX9CNg0BYmi6QlR2rVcr8uKutB6bn9Ab
    vtt98hhVmvGkA>
X-ME-Received: <xmr:IeeHYoNDOBy2QrfUEXu5qzd4GUdBOEJ6jdZ9RT8tmxcghAjWGCk7Fs2mMsV-rmOmhLSsJFiPulhbGW7s2pivwHEsA-kJz1E2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrieefgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:IeeHYu7cQ6ykwawDcKZE-fmkCajyFv7AF5D1olUQMDVeHU0AcMSMgA>
    <xmx:IeeHYq6pDp1ryo-i1GpFkO2TqqVZBkVtrpvYNr4c2hgvVfe9bi-XNA>
    <xmx:IeeHYmgv_9wW4u5sulX4GID-60xztjPDR2BatiogiPbb-qHep7UHag>
    <xmx:IeeHYssS24m3zGQTaOOUWEZiB2B7qEk5xFIr4dS7SY43-KoLx96aVA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 May 2022 15:08:16 -0400 (EDT)
Date:   Fri, 20 May 2022 21:08:13 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the char-misc tree
Message-ID: <YofnHcOa5AkhXnbX@kroah.com>
References: <20220520194637.03824f7f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520194637.03824f7f@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 07:46:37PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the soundwire tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> make[4]: *** Deleting file 'drivers/accessibility/speakup/mapdata.h'
> can't open ./include/linux/input.h
> make[4]: *** [/home/sfr/next/next/drivers/accessibility/speakup/Makefile:46: drivers/accessibility/speakup/mapdata.h] Error 1
> make[3]: *** [/home/sfr/next/next/scripts/Makefile.build:542: drivers/accessibility/speakup] Error 2
> 
> Caused by commit
> 
>   6646b95aab5f ("speakup: Generate speakupmap.h automatically")
> 
> I have used the char-misc tree from next-20220519 for today.

Ugh, odd, this worked for me.  I'll go revert this.  Samuel, can you
rework this again?

thanks,

greg k-h
