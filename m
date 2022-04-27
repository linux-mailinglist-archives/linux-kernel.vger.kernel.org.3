Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A86512301
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiD0Tql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiD0TqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:46:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E945925F3;
        Wed, 27 Apr 2022 12:40:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a21so3149835edb.1;
        Wed, 27 Apr 2022 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cf6DY0z5fWdN2FcWBrgkx/oCnyUhI8bOaMl8/d5zams=;
        b=b20SaBAHJK45GUw0GjvX6yh0h5tOIe7UOx7AS4eSl1248VvPyb4yLIE1L5fFdBcmH8
         NNYJ9ZcfBVm9HBjda1bpUgAplRnc/E26I3ohmK/ZJj8ltDM7BTOnXENIGp1URN8H/c3W
         E+Skp3lUj+VnGP1o2GnPBqPT7KcNnwmzEOWFsE8B9HaclFebPXX/iDsryidnEN5Oz8JA
         reN+We0/8DNRgkhwcp5S63Ah2HrSWpDqG5/C99ljaPslV6kqYGHnIcLVlhP9Cs9anMCh
         JUwrQ+9vThdk1Po+3YzSH0K7DFnA3Inn0MCGlJ/wkiaqUB8X1HJIjF1jDpCGvnGqR4dm
         bA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cf6DY0z5fWdN2FcWBrgkx/oCnyUhI8bOaMl8/d5zams=;
        b=xH6JaJiJUxbHjgnJZqvmjNFSlrG40KabjKGY7O842K1kpKZIhEubHUCHdFdZBczUi5
         LA2u/Ry7ZG0QmOS/GjkUnwx0eGM/sc/zxWWKvnFaPGTwKPe1BJMnkY4yie53bxpqRv44
         FfVeoLck9eOYfTVyoC900bKgX1chXgFCM5owWOgFn7T0BazNyDXTxQcb395gYbqrNTzL
         p1x/z174SXY+H/kohLHLWWPKHiwKhAzA1k4mPrWYGb820ihvlgEv68ZQX8huIPRJp9xl
         57eK15IXTcrgFyjwdScH9lJBMCliaXdRyiPtSZrE47milgNg29Wt4x1uI+gTcT066g44
         g3Yw==
X-Gm-Message-State: AOAM533QAZKysricUeltdsTh/B8smZPWd6DC0PP8Xfemnqtul4+edevx
        u33BXRlJigDRAH1NAi4zQBbI9p0KjvHzag==
X-Google-Smtp-Source: ABdhPJzBV9Ifb66PflKPmXLKNT3tNSgVCyI+Tn2Y1+FXeq86/gyTtVGk5f1BwyB1N6dXa+lNS/zmTA==
X-Received: by 2002:a05:6402:1cc1:b0:413:2cfb:b6ca with SMTP id ds1-20020a0564021cc100b004132cfbb6camr31200177edb.265.1651088442508;
        Wed, 27 Apr 2022 12:40:42 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id cy19-20020a0564021c9300b0042617ba6386sm90975edb.16.2022.04.27.12.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:40:42 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 32/45] media: sun6i-csi: Configure registers from format tables
Date:   Wed, 27 Apr 2022 21:40:40 +0200
Message-ID: <2366269.jE0xQCEvom@jernej-laptop>
In-Reply-To: <20220415152811.636419-33-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-33-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 15. april 2022 ob 17:27:58 CEST je Paul Kocialkowski napisal(a):
> Switch over to using the static format table descriptions to configure
> registers. Rework the hardware configuration helpers to leverage
> information from the format structures and benefit from their logic.
> Remove the previous dedicated helpers.
> 
> The intention is to make the interaction between the different formats
> and the hardware side more visible and clear.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


