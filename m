Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5E755A8C8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiFYJrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiFYJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:47:22 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3413236B66
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:47:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DF9D25C00CF;
        Sat, 25 Jun 2022 05:47:16 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Sat, 25 Jun 2022 05:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656150436; x=1656236836; bh=qj
        f20KoyChVLktnw9DywcXDnz700MXbIf9pHL6t8wng=; b=AOAsWZuUQVsGNsqkzV
        5GmH2M8o3ozzKQlk5S90/7WbA/QhaemvRUBX7cRTtTqE+1gUjbkXg+5QLaOwY1tP
        gTjZUK8QrjB1zRpGRQGlnS97TvxVGBbhX0NC9GpEyLlp+ghVgdSz9FaDhmMafNss
        n5y0aMs1MdFPKYBTfEXxUvuZ1S2ZNyS/rirwOHW4ZC+3yeiPSI4wfHfXKyYqIiIj
        C6nTKTJ7H7BKiy0n3nOxUOYeMZSEaOd16/eSY2y8ffSbcQ/A6edvPsHN9aGu4R0W
        Nxhrea+96r1APOglxU5wZeFx7NgM206KJOm1q0Klv01WMJhzyMciW2oume7E+8aj
        +Wxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656150436; x=1656236836; bh=qjf20KoyChVLktnw9DywcXDnz700
        MXbIf9pHL6t8wng=; b=fKt0XlHHI3O4pxz++cesW88EhBHhocPc9pxSnPjHoBty
        8Utkb6sa26hm62OZahjRPGr04uS3GFEoj+rZu2T35ZcjcT5rZ/T4Qri4ujj4dPsk
        n/N87r7AX2+PrZp5QIs3MbWabsv7ytYjOXo15qJCVvWy/9JTr2Be11vsjQn4R4UH
        rw5oO+kb1oman8j2XR/k+amLh9vfwPG6X8+IoqtYNPgfupqXloKhqYTtsvHVz+kh
        JPcuHt4/MbfYksPYqila2UEFS7RbuC/zOTLCVGO1afnyQ27bDzhqy5iyN0bfkEj6
        A3gf8QSixsUwak6jZay7tiVonhxDMqBcXNd7e3uTVw==
X-ME-Sender: <xms:o9m2YkL6zr7Z2ma3bXLXQkdQmE0bOEZytF0BDtMAD7vL-MIshIxaaA>
    <xme:o9m2YkL2xWsgi_i8vI7S_LhxqLRDVAyhNljJe4_twPcxz0OPHewsnWtYz8FplncBl
    rhCTKKAqXEltj6rd5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeguddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:o9m2Ykt-wfYS8NNRzdeelhL-glIEjlBW17MKO3HuIIcHQvdYMW8gmA>
    <xmx:o9m2YhaU4aMG4aY71yl12baOEaLGkRTqmmuXNik1qjV3VAOLbTmNnA>
    <xmx:o9m2YraVo0absSBgOWmv0ehiNdpCwv04K-LDgJZlUFmtXRSzJxA6XQ>
    <xmx:pNm2YnFOzr3PpkuJX4e5H2IPWE39Q0mh8qBSReXOvh4qvmd_IlY-1g>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DA783A6007C; Sat, 25 Jun 2022 05:47:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-713-g1f035dc716-fm-20220617.001-g1f035dc7
Mime-Version: 1.0
Message-Id: <e874d1f9-912e-487e-bd8c-e227067c00ca@www.fastmail.com>
In-Reply-To: <20220625075950.GA22592@lst.de>
References: <202206251551.PTd0wn6d-lkp@intel.com>
 <20220625075950.GA22592@lst.de>
Date:   Sat, 25 Jun 2022 11:46:55 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "hch@lst.de" <hch@lst.de>, "kernel test robot" <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>, "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [asahilinux:bits/050-nvme 6/9] drivers/nvme/host/apple.c:291:19: sparse:
 sparse: incorrect type in assignment (different base types)
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022, at 09:59, Christoph Hellwig wrote:
> Sven, can you send a patch to use the proper __le types?  We really
> prefer the nvme code to no have any sparse warnings.

Arnd already fixed this with 7ad7ab90368 after the commits hit the soc tree
(and before I even had a chance to look at it).
This mail just came from our downstream tree that's still stuck at 5.18.


Sven
 
