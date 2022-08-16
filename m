Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66EE595B41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiHPMGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiHPMFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:05:48 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66623578A7;
        Tue, 16 Aug 2022 04:55:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C35195C01D2;
        Tue, 16 Aug 2022 07:55:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Aug 2022 07:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660650918; x=1660737318; bh=4Ybgh31u0I
        +7D7+hcoMIGJWFz0aze/c+ECeecGK4vmQ=; b=BGohKPFWPDuGkhKTFsvsY31hIJ
        o0Mo+enhrCTvBsuCbgisMT7mP3Htz80+i7X8sbsmACdmXVZPO0LKnNaa17v/JwOi
        so2V8mrNu1MEPb1bbyXoRtvXwb2O11gr5fnnaVj6ISf4MisGgFXPSNVAwWkFgHJM
        qu8ORQWDuQa/Te5x1JSAs7Gy7WCt+CGRpIlv8LrmpLej2ThQaD0JRr1N5ThBCr/T
        2XgTziCW+uCCUydjeUSmFeuf5793zJbU/d71h1Dkw7UbZlieSNvZn3h28zngVYbm
        2rkEh4QvH85L+i9jl6T7XjTYK2PsqtArCFWu6l6llR6Tyj2peNZ4uXFgu4YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660650918; x=1660737318; bh=4Ybgh31u0I+7D7+hcoMIGJWFz0az
        e/c+ECeecGK4vmQ=; b=0Y6F42MdGNPSbYV/D8ydjq+I6dZQ/9k3BE+C3LW0V2QD
        R99Sj3iTqNsdzk+/w0p9suwTzJUaE1YNHuBZsajkXZ/m6POyXqsddVrpTxH48/Fq
        EmwK6ogWk8/AV1L3eOm1sV2u5ixFD5100I/zv8n35rzgpmnZHyfabMcf9yaY0Pn+
        1ZbJY6GQGy+f/qUa1zq45szCH4i8xZXiCKXFHFX3jRUhOmh7ZfoeMy6tQ+Z11d2n
        +0Nv28bvh8a0UwvcdsNwS3bQDHG8XDu+vAI/D4cpxPzpY2U7U2QY0kYFH9qt+++5
        /gn61yi3+Gv5NOKIBXAiMhAeb7kIc2TqerpXWXiIsw==
X-ME-Sender: <xms:poX7YnPXIFD44GWmeBgYyED6dl3iCLdrMBjA21VfYC3HtJiu3U8c6w>
    <xme:poX7Yh8qhz93RbUgPwceHlk6HPZfC76hZpSKnVqX1hDhgVY2Md6yug8qEUKELnYKt
    xpkTOsI2aC2RA>
X-ME-Received: <xmr:poX7YmQhWSpC-qgJ-4kN4CRF8KnYESvfLwL_kYmZlSlGErx2RHkDo2KLtskNev8gmQdKdGFoFYStAAf5HCe90Cz4xsn8w7OP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjefhle
    ffjeekjeehtefgieegkeeuueduvdevkeejkeeugefgvdfhfeetleeggfdvnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:poX7Yrt7BuH2UxyQ7t8K5GdXgZY8Ng0btdtktAaDOoL4mBGTH0foAQ>
    <xmx:poX7Yvd0lBmOm9NRhqFWqHugSluIP0rtEh90YCL5bdkKvEgU24UV5A>
    <xmx:poX7Yn1T5stPzRYGCakkqKwuxsy8dJQr7m11RlIAcSrgPZ-7lJtiwQ>
    <xmx:poX7YgUz7tei6B1wuPdRxJP_--5SN2n7LNDE8xabcfK9w8GnRMUkgw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Aug 2022 07:55:17 -0400 (EDT)
Date:   Tue, 16 Aug 2022 13:55:15 +0200
From:   Greg KH <greg@kroah.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, linux-api@vger.kernel.org,
        f.fainelli@gmail.com
Subject: Re: [PATCH v4] MIPS: Expose prid and globalnumber to sysfs
Message-ID: <YvuFoyUVyjUdJNPf@kroah.com>
References: <20220816091258.9571-1-jiaxun.yang@flygoat.com>
 <YvthfQUfv0TiO/bK@kroah.com>
 <BA886B5F-EE3B-4227-AC3C-E7FBAAA98ECB@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BA886B5F-EE3B-4227-AC3C-E7FBAAA98ECB@flygoat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 12:43:52PM +0100, Jiaxun Yang wrote:

<snip>

Sorry, html email will be rejected by the mailing list, please resend
after fixing up your email client.

thanks,

greg k-h
