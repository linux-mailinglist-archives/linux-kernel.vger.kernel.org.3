Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70541561363
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiF3Hkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiF3Hkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:40:53 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EC13AA78
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:40:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4007C320092B;
        Thu, 30 Jun 2022 03:40:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 30 Jun 2022 03:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1656574848; x=
        1656661248; bh=AMvqDQ8f+OjeHfV9rASJ/W+awq7Gaq8IEdTb5e5lnYA=; b=J
        tqPGw0kK0k/k6kLUHOreCuK2c8IiJc9fvB5psBRTIS8JfF1CAYlD8o7YASBgkSGi
        O4AKe1hiLZe4hOd041AwY1lT4j4POgpwVSo9ZzSjCdRjhTJhE1fj8iXo8L4W+KzZ
        MOEwOyw8SPaXY/pHckY5Y9PIzFD6QeNpR1UIK/wamPO4jw8LM4DBk8nRw7ANM22A
        nWdB4qutJ+njH/peOszaajBhGOO5Nl0J4qkybaRi/lCIn7d/hY0oBZTtc2D44Q6J
        M6K2C1Q0eNAtSuirkJ8TzphlzJL3SymJLhvbHA7hLyWqes99hMYMGkNjOUV7fxda
        W11Lq3XdR2QsII3I2f1Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656574848; x=
        1656661248; bh=AMvqDQ8f+OjeHfV9rASJ/W+awq7Gaq8IEdTb5e5lnYA=; b=y
        JMCFR76FABuyL85Tu84bAosN+u7Lkasv6Sj9y92Z3OU1pl8xwX53Ckg4RTGjkB4a
        LXDbRJzzMKHibBxMU8/Lb2blyJvxCQnn0yYEG146w/3kemx2EAt5RcTGr423f3yj
        VMxnbVyEEBPgo07sXyW1xX05j69AEb9g++Pte++smKYV5GOCLYBoxvqA95HnjkRA
        g4w4+nqb9RpqkivWzNcdBwEeYhgO+oeZ14x1dDGL7s9aUxdUN7qAS3WePNvgYuDr
        GhPsFTp/EwZGvzKzGKqs9Ho6gqBPCLUQeHN4++1i58dd7CnBPwQfd1znovualTjp
        MIM1jMOTn46ZbhkxtP4SA==
X-ME-Sender: <xms:gFO9Ygt30HP7y56s1PqRJdcOw_Y8wuG2UfFyreb-PeUfNlSEIg9-kQ>
    <xme:gFO9Ytet0CrOj-4QRI67c5Bt7-iHRaCq8EEvXBLip8ECucflU7Uh8mETYtaVVrp8K
    wgo1c4rG9imwZPchAc>
X-ME-Received: <xmr:gFO9YryGnWLvguxg5JORxfUoHoRRWU_sGBvqaK-JKV-IjtQrYFw4atc3YNrAtl-y5gIIpGGGX1HFwl3ez-0YQpFOMOZcXBRls4Z4drM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehtddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgv
    segtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepueeigefghfffffeifeehud
    eiuedvteegueefffevgfetvdffheehkeffvedufeeinecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:gFO9YjOyUgab31j3HFcrw2dhHhEULQemZPjW93nuwCvS8f77isEg9g>
    <xmx:gFO9Yg92l7ruYvIj_uHn5kSWg1XLU1-l3vOk5PWdUkRRjMDMH0tFwA>
    <xmx:gFO9YrVaSd_cYPeUxKNoPFyqxmFp-jJuFxS1CD5Buiqj3OIXw-QGlQ>
    <xmx:gFO9YtNbLdioDSNQXmkKoO9s9AEVnkco6d1IDhKs-sasN4ydKQ5FYw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jun 2022 03:40:48 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dave.stevenson@raspberrypi.com, daniel@ffwll.ch, trix@redhat.com,
        airlied@linux.ie, emma@anholt.net, mripard@kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH] drm/vc4: change vc4_dma_range_matches from a global to static
Date:   Thu, 30 Jun 2022 09:40:45 +0200
Message-Id: <165657484374.261230.9959051107234808555.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629200101.498138-1-trix@redhat.com>
References: <20220629200101.498138-1-trix@redhat.com>
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

On Wed, 29 Jun 2022 16:01:01 -0400, Tom Rix wrote:
> sparse reports
> drivers/gpu/drm/vc4/vc4_drv.c:270:27: warning: symbol 'vc4_dma_range_matches' was not declared. Should it be static?
> 
> vc4_dma_range_matches is only used in vc4_drv.c, so it's storage class specifier
> should be static.
> 
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
