Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E6B4B9957
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiBQGlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:41:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbiBQGlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:41:05 -0500
X-Greylist: delayed 438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Feb 2022 22:40:52 PST
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D612A520E;
        Wed, 16 Feb 2022 22:40:52 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id E55DF2B000CC;
        Thu, 17 Feb 2022 01:33:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 17 Feb 2022 01:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=bScFzG/9Q+cvU4qTsd2N9JV5iBRYrTzK32M9S+
        WSUno=; b=dNpR7rJSEng1YnYyzUAFQclOnlGpMpQhgSuD2dQlOQDcro6NZzDrHA
        gOlXig0esP9AIvJGDhwkAWOHpg/N6B+rqGLPNOXC8RAzZp4z8tu9s+DCmidkrldb
        9l1TPlH34WQ/C79QuxQNO5OXSAcb6Mj72sADxy/IoPAqtGTx1OkTRDMk40woGsr3
        veHUnNnptlBkHP0zb4gwFGp600JmVN0QqLukkW2zS5N5tNB2VGX2U/iX7xSr8lhw
        +pmIIyJvljMP91p8MtxKlavssumPseDP2Wv3MBHnvXs/Jh2niUwuKICWJWwAqy/G
        qmYpXK/j6y4fDJkAZF4y/ULahA51UwAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=bScFzG/9Q+cvU4qTs
        d2N9JV5iBRYrTzK32M9S+WSUno=; b=AE6OdSDHp7UVdsK9ejK4lM1VOrA1yhkMa
        TEF8rTiwik6Pcz5IZ9c1hIoHXekHHU3QNKwQIJrSIthHFst2ILwcnxdGn1hFA9qo
        ALVUf0MssJyTihBLy+qe2grX55VjD4V2qOqC9LtRouqpkqS8qgWKJXO2BZjXwbZ7
        z3Y6u+ZLN5ylx9+AUnVxfEl8WIRxt7+EyXfm1oNasY+tVWd0gR0c+86EaNNp/sRZ
        5p3dGnVLpJ+JaqLzpny4u65uTe/ym0Dt3YutmvkEOvSTWd3hi0nSddaWaDB4AWbj
        CfS7u9u+lZvHUaeZWYSsf8vp8ptFxqMhwxoZXGOkMplVfgS5PhS+w==
X-ME-Sender: <xms:O-wNYnb6EByCWVxBYBMx7R2hAkwmdIxrLP09QOBIhPfWbGWaL3hy3w>
    <xme:O-wNYmbE_rRSAF_RpbEsPmyD9Ivg3JpsyWpEiuzmL7hu7595F_KQTbmd5KxmxDjzA
    HuFUnb5UopIjQ>
X-ME-Received: <xmr:O-wNYp-bVW60RkMLDC4FbQjyPn3850WcgfHJ2GZKudi4zEIZz5iYmTGez4IxiP0qarq7tLETfNXSJpKPv5eHzsMc3KvBkz0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeejgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:O-wNYtqIu4HICIEzvxWIpR7MEJNpm0V07zqOc2_7TXKOrtYhpEm36A>
    <xmx:O-wNYirlCCvv_DIzl63CwMFPYXID2qCRJqzdg6dFYhNGs04Y3NHA2A>
    <xmx:O-wNYjTrS4BAuihdupdDu6mn61M-wrn3Yv4ADCezZmTm-7OdxIztFA>
    <xmx:POwNYvgVeyZlVtnYRSrR3X6tugIZhn3pEVD86fRjzplf-PhawB0mYureDmU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 01:33:31 -0500 (EST)
Date:   Thu, 17 Feb 2022 07:33:28 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: linux-next: manual merge of the staging tree with the
 kspp-gustavo tree
Message-ID: <Yg3sOIChxwSuI8aU@kroah.com>
References: <20220217141603.7a0ef4ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217141603.7a0ef4ed@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 02:16:03PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/r8188eu/include/ieee80211.h
> 
> between commit:
> 
>   fbe9ccfe809d ("treewide: Replace zero-length arrays with flexible-array members")
> 
> from the kspp-gustavo tree and commit:
> 
>   6c36bcbfcef7 ("staging: r8188eu: remove unused structs from ieee80211.h")
> 
> from the staging tree.
> 
> I fixed it up (the latter removed the structs updated by the former) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

The merge sounds correct, thanks.

greg k-h
