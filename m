Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16615A3237
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiHZWtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345399AbiHZWtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:49:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01215E97F1;
        Fri, 26 Aug 2022 15:48:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 74E6A5C0409;
        Fri, 26 Aug 2022 18:48:56 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Fri, 26 Aug 2022 18:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1661554136; x=1661640536; bh=MXga4g9UYI
        TGqOF8D51W6gwR+kSZb+o+/avVdF0bauo=; b=anAbeX55M56dKH5uYg6lr2OFEL
        w7OIXcCwkDsm3MAdxfwMOttNRNXrRYhUACedHx7oTJqHVCCcuEK10faDpBvvnGwX
        D076ttjNYA0+jQghEu4BOTEvUuVhvWAiKV5oGluCcXoOb1lb5E+DQQQDH7PQUYIz
        H/KVRtxGbyfsJla0ZpOTI04qb90u+QB2YOBcFTmjaOC3RZr8+TjBJqX9fd1peDA3
        +HlGZoZsgv7xvAQXXCrLUUkZnnDOSsKynSKlKXLUhM/JaO2FMZRo/5k5kvGwPIZ3
        X1GWI+GJJv7lHk2syfecqUiTBR3xOYXIlLQ8Wg4DwL9WUZVqt3bQjf+A3/Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661554136; x=1661640536; bh=MXga4g9UYITGqOF8D51W6gwR+kSZ
        b+o+/avVdF0bauo=; b=pQWpLtvfa+h486WRDspso+lUE0LI4uWo8V2FCsRUx3Si
        Vqh9/Ft52xt5lvvEOrW62MROjzajE3Pmbe2KxMEmjGC7xpqVQCc7Z1cuDPzeKIIG
        QgIdacZYbGOxR3W5Gz1uYCvdPkMFQzv93rqR3JnuaqtMon+sECuRQtxf7IR0Mipb
        NV7rX2Kt/aHqPKpkhXp4CTBy9cKcMkULzp1IIEdgzbAIlj2DzzUv4vzlRm4dEeDi
        tbu3dX1IgzbES6cVr7gBX9go5Ms8QFw1M8Hr8mBvmCzq6kLI/Mncd5vTkvR4qKwm
        oF1jMfH782ww9nMCD9Un/XSSAQt8y6BlpijF0wgmOw==
X-ME-Sender: <xms:100JY0lFb400hCxXGyMblEcv_YVOrwddDaU8y7-X6IZNpmFkCyUlhw>
    <xme:100JYz0y4qVohGmvFuHjjieFuyF4aIHHULNlWE_36m0yMTtmlvQaOCCtprB0jf95Z
    uE2b6qRKpitRF6Kvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:100JYyqKDggMGLrUJ8mVCsfhNBH8cdOKtyC7fR3z9hPR9JZaLHhJBw>
    <xmx:100JYwn87Y0OJ4W9t1_ei72_EVxwT5gKId2ldDIC0-62AF0vQ-oJjQ>
    <xmx:100JYy0qVKF8Lcm3iqrxYP9LrgcfIqmWKzprwxedoKQf6YnSSwMLBQ>
    <xmx:2E0JY-_-45oRT2uedeVW_GVQbiOkBuX3h4I3qs6IYccjRlwC2p8Nqw>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 07F971700083; Fri, 26 Aug 2022 18:48:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com>
In-Reply-To: <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com>
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com>
Date:   Sat, 27 Aug 2022 08:18:33 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Billy Tsai" <billy_tsai@aspeedtech.com>
Cc:     "Joel Stanley" <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: aspeed: Force to disable the function's signal
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Aug 2022, at 07:26, Linus Walleij wrote:
> On Thu, Aug 18, 2022 at 12:18 PM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
>> When the driver want to disable the signal of the function, it doesn't
>> need to query the state of the mux function's signal on a pin. The
>> condition below will miss the disable of the signal:
>> Ball | Default | P0 Signal | P0 Expression               | Other
>> -----+---------+-----------+-----------------------------+----------
>>  E21   GPIOG0    SD2CLK      SCU4B4[16]=1 & SCU450[1]=1    GPIOG0
>> -----+---------+-----------+-----------------------------+----------
>>  B22   GPIOG1    SD2CMD      SCU4B4[17]=1 & SCU450[1]=1    GPIOG1
>> -----+---------+-----------+-----------------------------+----------
>> Assume the register status like below:
>> SCU4B4[16] == 1 & SCU4B4[17] == 1 & SCU450[1]==1
>> After the driver set the Ball E21 to the GPIOG0:
>> SCU4B4[16] == 0 & SCU4B4[17] == 1 & SCU450[1]==0
>> When the driver want to set the Ball B22 to the GPIOG1, the condition of
>> the SD2CMD will be false causing SCU4B4[17] not to be cleared.
>>
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>
> I can't see the verdict for this patch? Will there be a new
> version, or are we in the middle of a discussion?
> I'd really like Andrew's ACK on the result before merging.

Apologies, it's been a bit of A Week :)

Given the approach has been discussed with the IP designer and solves a bug I'm okay for it to be merged. If we run into issues it is easy enough to back it out.

Acked-by: Andrew Jeffery <andrew@aj.id.au>

>
> Yours,
> Linus Walleij
