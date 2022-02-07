Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601BB4AB71C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350847AbiBGJBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349688AbiBGJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:00:49 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5AFC043181;
        Mon,  7 Feb 2022 01:00:48 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2345F58017F;
        Mon,  7 Feb 2022 04:00:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 07 Feb 2022 04:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=2BOoXvMYl2mcjW
        EBrIXuByf9re5XSaROTg95FlpiOQ8=; b=Gq442Dy4ZCrXH4pLR4bqGY1rjHoufE
        GWOBeQVEelHllCsCrtri8zHZL3z8VLZYSjkAurnz4GowNWL8Y5ytyp7Ap2HdY3Dc
        ib/k2qKgGnp4tT5b61qUXRryje4bCjN9/TxlwUT7lv2yN7EABNc7djZsa0SIupoW
        mPMvAvABMEw5LVMhDu2AgMMV9IAlnU+6eLtxa9Bhf41/k0hXXunr8twzLxaR4N82
        gXGHP1Z1k3FDTYPWcoUZj/XYMspPix7KXdHmjbCyZ5Xz1v6sVxMAM2aZMXSBUct5
        YLlwmHvW4k2q1xEBdBU93bMAjLZuEcH+pFVp+m3NwU9CHybNhPezq7RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=2BOoXvMYl2mcjWEBrIXuByf9re5XSaROTg95FlpiO
        Q8=; b=SEWlVmdvPJAek5xcE3kDbci+n8EiVm/6fJNQWJdz8xVkeqmSfwDjQdnM5
        vP8jyyZ8css3TqTD0Qez2B+HKghTzRl+6sjBclfQcfG1bpdXCVDZytHtcScTo4cz
        2DayqRstnKHndUaozzgsY28S6t+Mv2UlF9x2oc1ESq3EaKNjSqDk5EIbDednU2XP
        7M8TsqywEDvg10tRRKu4Kotv7m55wTrQ1PTcT/NtKHYKGJgpSne9mcv7W61D4QVa
        OYkUyLXsytrwvrXqFjMcz7SupBMKh4G3wDtPZsCNuRIptpIx2gp6eeQuvk/iZYu0
        fLyjtGhb/SLJaSn+Yi8dvGrMWvHNg==
X-ME-Sender: <xms:v98AYhviMxEfoLy6EepMCrjRfDz30xPGI1Gae1V_zVWmiAmDVJq5Iw>
    <xme:v98AYqejFROSkMQpyczIhnjungeMZtuf77P92LiJdGXFHcARUCJUZ4FDm_sijUPED
    PNL3pfhTZAuhkn6EvE>
X-ME-Received: <xmr:v98AYkwQkzgSMCkPluTkVImKK22RMyOjbCIZ34rE1vg2DJi4CgNrO02Q51yZFe6Rs20BM14hYbpAJx-FsFokViQ38QSl-_jVeFkUSeY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheeggdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:v98AYoOkNWqjDW_OXKbytvj1uUvqYre-ZSGnUmd9H9zujt0HnBPwOA>
    <xmx:v98AYh-CrOni91c3oapjGZoJL01Tyer2TlvzJPltxGeJvLqjSzi_iQ>
    <xmx:v98AYoXd1dL0MRtWf1YKD6ZxM6zt9-XpkIICq1NhWeCtI1I5dQjEXw>
    <xmx:wN8AYlXTZosoGIHfTB1HZyrsO8QCavcdZU3rb-YCqfNVZdKFp-e6GA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 04:00:47 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: (subset) [PATCH v3 4/6] clk: sunxi-ng: mux: Allow muxes to have keys
Date:   Mon,  7 Feb 2022 10:00:44 +0100
Message-Id: <164422443570.21572.2174959931752418423.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203021736.13434-5-samuel@sholland.org>
References: <20220203021736.13434-1-samuel@sholland.org> <20220203021736.13434-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 20:17:34 -0600, Samuel Holland wrote:
> The muxes in the RTC can only be updated when setting a key field to a
> specific value. Add a feature flag to denote muxes with this property.
> 
> Since so far the key value is always the same, it does not need to be
> provided separately for each mux.
> 
> 
> [...]

Applied to local tree (sunxi/clk-for-5.18).

Thanks!
Maxime
