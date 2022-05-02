Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897F8517320
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbiEBPr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiEBPrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:47:47 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2EFB92
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:44:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A2BA581420;
        Mon,  2 May 2022 15:44:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a256.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7687F80EAE;
        Mon,  2 May 2022 15:44:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651506249; a=rsa-sha256;
        cv=none;
        b=AUyKsLyIulI6A+RrAleC9bQFM8KSE/rNRH6UFQwL4ceQ4hf3y+lI1GRQzh+w+aa1blj13t
        s55eE/ybqMAyQHgRrzqz7K0f7PQ/F75+Sd4fsnJYFjSPWzyFcT8yq5w4yAETftE02y3qmW
        5kLEu1yy/Q/IAr/LXGM1HOp4scd6pg+Buk12WJCRy2c5bUC+MxfES3Ph26wqA1PObhx9Vg
        B4ZBNeDnr3KXIoB8B+w1o0QbCKCv7qlHt3ok61XpRn9Pzu+X6ziuQ6Dyv7BHZWAguow5LO
        N2xbRf8vDW1XO9SIi1xo82LXk4m1E9QK1GvPfz5xFmmIqUAmXTTosPFvpCG3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651506249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=DkkNoiMLnVInXzgUkNe6nyHj/tovdEiyha32sZWWqmk=;
        b=newsTZguUDOcKrehNA2BezEuPGnY9xuG0F1bArXt8LpUhidgkX4iLMjO1afQ3CR2WJw8NZ
        G19tSVKLbmfKVLzGWEw2WP5XjRj8qOArY5LQFOElpyqJYJ6MRyLmQzEbbzkHRBnFS85U2N
        fdH4R96ihudS02L83HFq/DSJrMpBN+wp/5t+UE9rTbEeAyh3p1U42N4EXJBuJ0TXnDaiv9
        jA2aUgIQjPPs3sOX/Amnt+UdT0qSklI1LZq9vxhyF1N8b6pny/XqE6l0muNqOOxhDme0AE
        1IZXJQQ00hNzVDVR+hgf9Ld67vjIg4GScxhvnjC05mdKTVvFCOse8t0JlDP4Yg==
ARC-Authentication-Results: i=1;
        rspamd-847dd8955c-6489d;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Language: 2cac419402377a6f_1651506250135_1661352001
X-MC-Loop-Signature: 1651506250135:2295873110
X-MC-Ingress-Time: 1651506250135
Received: from pdx1-sub0-mail-a256.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.106.76 (trex/6.7.1);
        Mon, 02 May 2022 15:44:10 +0000
Received: from fedora (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a256.dreamhost.com (Postfix) with ESMTPSA id 4KsS7W0pS0z1fC;
        Mon,  2 May 2022 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1651506248;
        bh=DkkNoiMLnVInXzgUkNe6nyHj/tovdEiyha32sZWWqmk=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=RelqvMKrLPKmvxXgVjKMzXSD/ttT9x/slpwkXqdlBHX3DFYX/xSumWYHtIJ0d3Og2
         +VfI+YsUG8wTiG3pf+IDq/sX7TeNhWZSifZ9Jj21nYUdUgJo2ewJefRt84RXJjIUMl
         E0RhCfK9OOBImqnpoJnvGI50Owqnio895fcXaZsl5P/t/o9xZjoOrPTind8rFzR3op
         vljg2vWCTVmOz0MrjNhf+LH7hms4XohVuNYvnE+NiIJeExPrjWymUncqt3kiEhknYr
         Sz8TazASWfXKjJLWpQ4Vc8e4kr/Ri9x1xoT8fDy8qxcx71DrjcaJK3KkPFxRE7tL+X
         zmqdPNXVEUXEQ==
Date:   Mon, 2 May 2022 11:44:05 -0400
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 4/4] staging: media: zoran: replace dprintk with new
 debugging macros
Message-ID: <Ym/8RQy0HyCZ9KRx@fedora>
References: <20220425144110.133316-1-ian@linux.cowan.aero>
 <3270dd49-0d68-5b60-d766-940b39aa463e@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3270dd49-0d68-5b60-d766-940b39aa463e@xs4all.nl>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 10:15:03AM +0200, Hans Verkuil wrote:
> Hi Ian,
> 
> On 25/04/2022 16:41, Ian Cowan wrote:
> > This replaces all of the dprintk() macro calls to the zrdev_dbg(),
> > zrdev_info(), or zrdev_err() calls as appropriate. This allows for the
> > removal of the dprintk() macro from each file it is defined in, along
> > with removal of the module params that track the debugging level.
> > 
> > In the case that a debugging level was used in a comparison, this has
> > been replaced with checking the console level debugging and making a
> > decision from there. If the console debugging level is at least the
> > KERN_ debugging level equivalent, then the comparison will evaluate as
> > true.
> > 
> > There are a few instances where pr_debug() must be used over the
> > zrdev_dbg(). These occur in the module cleanup functions because there
> > should be no devices defined once we get to those modules, so we have no
> > devices to pass to zrdev_dbg().
> 
> When I compiled this patch series with smatch I got these warnings:
> 
> zoran/videocodec.c:45 videocodec_attach() warn: variable dereferenced before check 'master' (see line 40)
> zoran/videocodec.c:115 videocodec_detach() warn: variable dereferenced before check 'codec' (see line 111)
> zoran/videocodec.c:168 videocodec_register() warn: variable dereferenced before check 'codec' (see line 166)
> zoran/videocodec.c:200 videocodec_unregister() warn: variable dereferenced before check 'codec' (see line 198)
> 
> And I also got this warning when checking the kerneldoc:
> 
> zoran/zoran.h:307: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Can you fix this and post a v3?
> 
> Thanks!
> 
> 	Hans

I will go through and fix these later today. Thanks!

Ian
