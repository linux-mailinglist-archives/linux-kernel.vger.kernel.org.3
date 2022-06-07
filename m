Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9AB54033C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344691AbiFGQAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344874AbiFGQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:00:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FFAB8BC9;
        Tue,  7 Jun 2022 09:00:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9EA0D5C0211;
        Tue,  7 Jun 2022 12:00:37 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Tue, 07 Jun 2022 12:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1654617637; x=1654704037; bh=Ff
        6e/dqI0fSDW23eseMba0aeJUA9DeTZ9JjgyeGwyuY=; b=UrfpmeBgfU5s4Ap0P0
        tnTV4+V5xTSfQW0ZQNo9je8ioCmPf5Al7xIs0tka4tY0g4QPxkhvgvx26U8Si5AN
        VojnAGad5jZJDSezcU0YqQLYOcGRk55sRjaGrj5NU0HxDyureIA6WD1ca+0U0dd4
        yjeUlxZjrRkx+A5Z6Lmp+VTqm37cCgkf2XtecMlZHudWJi6M1Fgmg9zKziMFC8FZ
        dIAa8VQnnfs3Fb1FjO71l98hFzsqhyFKO4Cng5Raau+eKsus/cN1zfg/f4adj3fA
        kTen1NgaBpA1ESnD1EhcG0dKF9AVwXoOhcuuZvtZT9AiUIH9DhFIe8O0FKQXe7pE
        2aKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654617637; x=1654704037; bh=Ff6e/dqI0fSDW23eseMba0aeJUA9
        DeTZ9JjgyeGwyuY=; b=Mv5ZoVwjHHz5OfeXfutmFGjBC0mezFJo3zV/Qxat0Yll
        3oyBs8lR0RmCKPzNNNTnaQXMSDRr6DO4NY6rxJy/ldEdHp+xvWVK1O5qORw4otXI
        0GIUucfmBSPguf7nQfBXHW+BLbebq2aI/BqjmgFZTaOSV7+3fPnCLj5gk7pWjUnV
        5CRBvNTHh9v2EOcBdYWJ0XuANSTzxa2395Iap5JRIgvr51b/Y4RH87zO7V9CeApR
        7VWkoaMAuD65nn8+LTw6Q2a/qKOO9TT1jqNUF5p6kuU/KJU0NrhFJjwCFQrdyPlB
        fWfJCugveCV/Rqj9hnCBncSlvuKxutK6RPnbmO4olg==
X-ME-Sender: <xms:JHafYpaoE8SVZiOCunCp7iJ7vmt2I6DVBBWALlPCtlUFPy2KnQU9LA>
    <xme:JHafYgaoE-wyjZM5Hr8pNnCEwvX2GWjnM84I8eLYuVXTO5DK4KpPnFqQ1auIxv733
    fmCbqeusesDo2M1Kek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:JHafYr9GPD67vVvs_lV2RX-3BETMFUVB8TbfDMaROOzBPW8huvnyzg>
    <xmx:JHafYnolMcbbvej20IRRKUduC7s3YpprNbrHe2t5ACQdq-K0Z0k-6Q>
    <xmx:JHafYkpVVB_Owy2uHGy0nAIHBB8HUbhCDatMdTTVVRlbMr3BrDRmbw>
    <xmx:JXafYtkpz_zIVZVcLHdLswDU4gXWxcm8E5LHTj7ZCECOPZIvfH7ORQ>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A684FA6007E; Tue,  7 Jun 2022 12:00:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-592-g7095c13f5a-fm-20220603.004-g7095c13f
Mime-Version: 1.0
Message-Id: <6fc94e84-a94e-49a0-9cce-2478e08b63fd@www.fastmail.com>
In-Reply-To: <20220606212230.1360617-1-robh@kernel.org>
References: <20220606212230.1360617-1-robh@kernel.org>
Date:   Tue, 07 Jun 2022 18:00:36 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh@kernel.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvme: apple,nvme-ans: Drop 'maxItems' from
 'apple,sart'
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

On Mon, Jun 6, 2022, at 23:22, Rob Herring wrote:
> A 'phandle' type is always a single cell, so 'maxItems: 1' is redundant.
>
> Fixes: 82b96552f15a ("dt-bindings: nvme: Add Apple ANS NVMe")
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Sven Peter <sven@svenpeter.dev>
