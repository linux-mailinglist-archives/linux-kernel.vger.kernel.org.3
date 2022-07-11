Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF14656D490
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiGKGTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKGTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:19:51 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E0167CD;
        Sun, 10 Jul 2022 23:19:50 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A0B5E32002E2;
        Mon, 11 Jul 2022 02:19:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 11 Jul 2022 02:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1657520387; x=1657606787; bh=cke7VlkD3Z
        0wfy4TquShZ7jeheL8b+jrFjA6tQY/p48=; b=HRnDSy6WYVcYJJrRSOuNPPcmyb
        vaaJ/SBCw12iJpwG5hmA/VhcPD1XGOi1qWKi3LVhamoB0To/icewHK7UrYEcqXo1
        qX5R72aAIXWKUhrV2JWFduVFI7JjVfFh04XiPAGZBJ1S/3sW/xeQxRWbDR0gvhgg
        afOgaYItUYsZrZ3G3Be/6bE1A2iFP/4nIXIWvczLv3hnG82hskFYzeU5dA9iuRXD
        /w/tDXBR8mV/VDQG/cw2bkp8ay9u6XYLCgeQpmsqIgiHRyGZVI7iLJiZQBsyrvIS
        6KbaE68WTihUDxKyLuQE6xEAYOQkM4OltYBNlAUSgjDps/d9rV0dyCV6RMAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657520387; x=1657606787; bh=cke7VlkD3Z0wfy4TquShZ7jeheL8
        b+jrFjA6tQY/p48=; b=QUNjAuaXJXtaM6JVIXjcnnNhbmkpTtUqkjgz4I9PDjUb
        9UkzPXXvRasT3MYSI7xCrOul5hu+pEpW7v4zxM1/W7IWRvmNIIfrxOL/VJEzIxMm
        YZQk4Tqn3X6XkQFLBRYUVXWfejjUW65A9kjR3wdGg2zBMUToB+cEQYSSrbqHR0Fc
        KC//MQemutVj7bFxwHIKJi4gQXuvuHYedvcJUoUYbSFQUjMm38eCyVs1F6Hr5Rog
        JdyDx894CGCOazmRC7Kjin57D/Q/GNF8XSxMFWJ2GCN3IMOBUV+D8KdO75lo/gzH
        xjYJnGPQP1alawBQ0DTTgTSsod1TvVkvJ9ODaas6eA==
X-ME-Sender: <xms:AsHLYjAyVYH3GTAOAtSgDp8DuwxrRWZYCWr1mdGreCTgnKesRXCaBQ>
    <xme:AsHLYpiak8ghQYcEM6zeuM84mqURzXkUY-CdBHcWII_bIBtjmSTFNjrbe_Fte9qYs
    xyXwM3igd-Caw>
X-ME-Received: <xmr:AsHLYum6PU-f_QI6ETEVtPKFXywVsv_WfO9Qw2LGCCKrHYhwZ_gw5Ntr1R8Oj02_pEns4To-bGPB7HvyBVA82_I5DLsGgUF6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejvddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:AsHLYlxX5dRSddJ0pkZLPU7yZFQUHvcZxRO691sJYcauY2KlMAXELQ>
    <xmx:AsHLYoSeNj-fmEWHA7ojfv7jRt_lPnf4j0Az4auZibQoDvLhx0l7MA>
    <xmx:AsHLYoayQhfDqqsKdS-SaVbHSAq80aoRdzfU-n1XQsh3VXKJFxfVHQ>
    <xmx:A8HLYtLZUV5q4ZPjw5yew1xqCheoHsk2PY05uP99fRRYdjnlUkZopw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Jul 2022 02:19:45 -0400 (EDT)
Date:   Mon, 11 Jul 2022 08:19:41 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Zhang <william.zhang@broadcom.com>
Subject: Re: linux-next: manual merge of the broadcom tree with the spdx tree
Message-ID: <YsvA/c/Ji9f/O/tw@kroah.com>
References: <20220711095520.4fad4c97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711095520.4fad4c97@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 09:55:20AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the broadcom tree got a conflict in:
> 
>   arch/arm/mach-bcm/bcm63xx.c
> 
> between commit:
> 
>   52e6676ef56f ("treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_30.RULE (part 1)")
> 
> from the spdx tree and commit:
> 
>   889390f83d4e ("arm: bcmbca: Move BCM63138 ARCH_BCM_63XX to ARCH_BCMBCA")
> 
> from the broadcom tree.
> 
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Removing is fine, thanks.

greg k-h
