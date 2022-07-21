Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF13357C248
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiGUCca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGUCc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:32:29 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8BE77492;
        Wed, 20 Jul 2022 19:32:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AFD985C0107;
        Wed, 20 Jul 2022 22:32:27 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 20 Jul 2022 22:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658370747; x=1658457147; bh=qPsgyAh6vx
        AcBku0AGKtaalP35Gfzz6TVkglhgzTCfo=; b=TfCDlmwwH47WJTR9fRjEPFs/LX
        oWzD52plhrTUCrP7AQ/UM6vTfFGDjuKAuxrW9x+TNDo0ZkukRQdkcw+425pr00EV
        86+NkGWkiqH76S67jny06tOsTtm/Na/+C7qJfGB3K8tbzUbqgGqx/byIT2A2j5wI
        cOy/GZhq8XMbFDmNiXsD5Zfu9Ktxnf9qNzqJ5w4K5So5L/cu0v9Xk6kknKObK9eb
        9tdh943e4MCYLBR8CBG9q+FGPnhdE7I7TuVV0Voj/ycDwqGZZ8LNQ6bKLEWEO+Xy
        estid6hZkiWOgOY0SCfhwu0KRhExpc9NNBFPYMOzsr3x3op6W0KRow2p35yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658370747; x=1658457147; bh=qPsgyAh6vxAcBku0AGKtaalP35Gf
        zz6TVkglhgzTCfo=; b=Sp0DjLmpb9Oq2hMYd3sius2kGoePd7rsI8aH7QFr1g4g
        38IhewqNg32T1005sAgg3GRdB7txvF3XOT9nFogl3ciPZw7m2WvOxoDjRRq+wL7N
        ZnV4rQZIHLMSZl0ZzYFMGMKDimrBD0LZBdY2BnWoRHm41+oRd6B5/Rq2lpUaYhhk
        G32omOLFHT7k5N/CSCC9fuQATnaqTjxaG5XJTR9IvXeC5tSxHzdkWTdbLIx3do/j
        ZyQaM3aGwv8N05Lk/R+0RlwRWfL+idTM3JJOShxsBc+K1lsdNG4iiWEKBqYTypz4
        md4Am+JATq/mfwANGDM9sFTyIbXz1T4EzdkTwnxnTQ==
X-ME-Sender: <xms:u7rYYkMFMFswSPH8jgZXh65mQGIcstAKOkxizLUcsOS5F1CZ9ZjVGw>
    <xme:u7rYYq-L5jPXUsfCQTfwLa5jnoq_Koa6MEWV0_dN4ptG4ZgCWCrVlTB0WQfN9eVF7
    D-fCNWfLY31TK0L9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudelfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:u7rYYrQLXbkkUAAuHaLNkHLtK-baYgtT0QAyBCyygHfeN64sX5AVIw>
    <xmx:u7rYYssf9auu4KaFrNQtw5AxUmXTVq5tkl6uyYjwW_a2F3wDo_klhQ>
    <xmx:u7rYYsevVgcF_0ztZcPFGep45FZc3GXWaV7y4nuO6gCA2g6MMz9opA>
    <xmx:u7rYYkRBBbXX-kbfFpWoubFwBzv1XbLW0DhBrtqPRTSdTT78itGh3A>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7B764170007E; Wed, 20 Jul 2022 22:32:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <04383a64-be4e-46f9-b996-3db28244b3a8@www.fastmail.com>
In-Reply-To: <20220611095828.1090-3-aladyshev22@gmail.com>
References: <20220611095828.1090-1-aladyshev22@gmail.com>
 <20220611095828.1090-3-aladyshev22@gmail.com>
Date:   Thu, 21 Jul 2022 12:02:07 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Konstantin Aladyshev" <aladyshev22@gmail.com>
Cc:     "Supreeth Venkatesh" <supreeth.venkatesh@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: dts: aspeed: ethanolx: Configure RTS/CTS for UART1
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Jun 2022, at 19:28, Konstantin Aladyshev wrote:
> UART1 is used for connection to the main EPYC CPU. Besides the main
> TX/RX signals this connection has flow control signals RTS/CTS,
> therefore configure this pins on the BMC side.
>
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
