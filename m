Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890564F63B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiDFPtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiDFPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:47:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DF1136FD7;
        Wed,  6 Apr 2022 06:05:35 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:ff63:de1f:2a77:5241] (unknown [IPv6:2a01:e0a:120:3210:ff63:de1f:2a77:5241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B83D61F44155;
        Wed,  6 Apr 2022 14:05:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649250334;
        bh=8ZGg2lyWu5RKnQ3rLN2WnQy5xuyBOPkO3yKRiol9ycU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QXe3LgxAeKlxnjsV0YDwzLSqEuWxxSQTFm4c5lDQh7ro0gZ1d7zmkZFifpFQRblU9
         do7GBLvZwEgY+g4qM/a8YIgRzjlTOFLO91XPTliuqqNrSIgLdQGGEsX6cHFnC9yZhw
         RNH18tulbkuqUByzBkSxpE4Zdgv63kYcILwdiK9y5u+jkqOyDXfQHmaAGdm8OSZQNo
         +HE2ZpqMMqq485f8yIUEmTZkqISkUmT+9ty6wwt2vI5ETDU2MaeUJ2RUSplEVEOdHl
         P+Z41DAXsl2y6UfUZaXjavK2cxCk1K1Fb6sjaGjTm5/czRkR6IxLbqn2FkI4W0tLs/
         RtjW5pkGjK2Rg==
Message-ID: <a1069c94-4c3c-ee4d-738a-752bb1d12dac@collabora.com>
Date:   Wed, 6 Apr 2022 15:05:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 00/15] Move HEVC stateless controls out of staging
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Adam Ford <aford173@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mripard@kernel.org, paul.kocialkowski@bootlin.com,
        Chen-Yu Tsai <wens@csie.org>,
        "jernej.skrabec" <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, kernel <kernel@collabora.com>,
        knaerzche@gmail.com, jc@kynesim.co.uk
References: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
 <eefa63b3-2a4d-4470-9a4e-517087ebcfaf@collabora.com>
 <CAHCN7xL2uZTMy30FGfDkDK4Lym6wvfr_MTv7QwtchrkTXMQiuw@mail.gmail.com>
 <79a9c925-d930-ad23-dc53-9ebc16d1328a@collabora.com>
 <3f778844-f655-74a7-0a00-05caa84eca35@collabora.com>
 <CAHCN7xLy2381AFLWhLxk5YuRV7C=OwLX=XPXONX8sbkg-SqMjA@mail.gmail.com>
 <CAHCN7xJWQa-uXb0-+CSvAr1JhFmQYt80Q=uGvaY8uyptNcfbgw@mail.gmail.com>
 <163202bd-ea51-e80a-1481-568fae25b045@collabora.com>
 <CAHCN7x+AwNauiyaVL=NGARkmxWOL9uLS5-AO4TjkvLGNQ=3r+Q@mail.gmail.com>
 <bb462ee8-7bf9-5574-7cc2-098cc66e5ef0@collabora.com>
 <CAHCN7x+DTjeP7zQJYPyqzdz=hXWjz6Br0v1sWh4n1J3TJPb+9g@mail.gmail.com>
 <8d23c99a-4ad0-e65a-0134-12f5d119e8bb@collabora.com>
 <CAHCN7x+YuXFrMe6dYo_VhkG7ey1jcPTpOMCM1=qoTivZO9U2Rw@mail.gmail.com>
 <f495aa2b-81f7-a3cd-a6dd-cc5ae5f0a81f@collabora.com>
 <439e5c67e66dfff8f44f63787e2cdb8379f87446.camel@ndufresne.ca>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <439e5c67e66dfff8f44f63787e2cdb8379f87446.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 06/04/2022 à 15:02, Nicolas Dufresne a écrit :
> Le mercredi 06 avril 2022 à 14:50 +0200, Benjamin Gaignard a écrit :
>>> default=1 value=1
>>> 1: Frame-Based
>>>                    hevc_start_code 0x00a40a96 (menu)   : min=1 max=1
>>> default=1 value=1
>>> 1: Annex B Start Code
>> It is the same so that suggest the issue is coming from GStreamer plugin.
> Can you report the GStreamer commit hash you have building on ? Also please
> validate the creation date of the plugin (libgstv4l2codecs.so) against your
> source update date. Reminder that GStreamer is now mono-repo (just in case).
>
> https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/tree/HEVC_aligned_with_kernel_5.15
> Hash: 54b7c1f98084c85d103446cc3f2edce42ad53b0f
>
> Benjamin, can you confirm you have no local changes and this is the hash you are
> building from ?

Yes that is the hash I'm using without local changes

Benjamin

>
> regards,
> Nicolas
>
