Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F21D564B56
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiGDBwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGDBwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:52:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3B5265F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:52:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so8105601pjv.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 18:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=jlzlpgII0GMrAAcd80jEjz8oGoZ5GrnU6PvVA1R8yiU=;
        b=MYYXsp8jAC2jQkXxVBBk2SO7EwRKNcTY7kYo7/skmDGuXmdwyAT0gvwHZWCXje7cAC
         B6nnjFQHlUGvudlJXhvdVlqP6Nsp4Kew/8mAJYyBOc1p+/q7bzbpK4W3il/2Y3+t5S03
         LWyanopNF5HwXVqFtX1qjj6OXrrt3NfD2OCHcUn3dOpz3ZzAvyVRE6zC/hUvbqVgQqVm
         KAVhBRF4DTmKZomm8A2Tm8Q4Rx+U6fkp2PBURN3VITgCS3vNf0D54WbKQiI1bTxc8uFb
         dqaR9Mr57/QaVSxA+/8iLn+UfdF5Z/D2r0LYBEL/Bp7UNVRP+mQPTdDzjL6XgWkMvQWu
         QqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=jlzlpgII0GMrAAcd80jEjz8oGoZ5GrnU6PvVA1R8yiU=;
        b=zYbudyu/sZl07zr3l0yV43WRndsPWM5O7fsIJ7QPFJbh2iQeWKG/GcCy6DIL1vJ1T/
         BnMYM0kWBOfIGwaeXjUW5X9cpRH6FxK6usxTAwBJCsMK9YGSUiw3BnXc/L8g8ez9cvG6
         SiKB2QxapYEh1aM0NgJwPUjkeIVcvrZ/xSOs2PdFQSAxPmmcysakRX2oBn8eHi+qhY93
         5ItA122KtcT2lpCChCfk/4twW/ACn+dCEVmyO5oqFATXiDrVdm5VF3BOLrDxqAHjNyYY
         cbxOvV24Lh9uZJWmFFkBT3kW3HYca9pjZy0cy1tHJAv1N4BMK1mdblvEqJ0PGjvOLiea
         GY7A==
X-Gm-Message-State: AJIora9oJC8MSjbbsQ1+rla8dI4gXKCcwbjdbVpniko3bhfD0rgthUcY
        WFGtqhQaqu1T30kOvdBRGFhqahJ6cimDTQ==
X-Google-Smtp-Source: AGRyM1tRZqWWSoA7w5kCfY6RHZ4HXSesoWpucMZNeORgv0J2Ql9G6MZYfmR/ZucTXPWg8lBczHzA1A==
X-Received: by 2002:a17:90a:db96:b0:1ef:8c86:eb09 with SMTP id h22-20020a17090adb9600b001ef8c86eb09mr735043pjv.22.1656899527674;
        Sun, 03 Jul 2022 18:52:07 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a174e00b001ef8397571asm1609430pjm.35.2022.07.03.18.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     christophe.jaillet@wanadoo.fr
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
In-Reply-To: <7c4d3116ba843fc4a8ae557dd6176352a6cd0985.1656864320.git.christophe.jaillet@wanadoo.fr>
References: <7c4d3116ba843fc4a8ae557dd6176352a6cd0985.1656864320.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] block: null_blk: Use the bitmap API to allocate bitmaps
Message-Id: <165689952697.1306443.9051111172793553499.b4-ty@kernel.dk>
Date:   Sun, 03 Jul 2022 19:52:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2022 18:05:43 +0200, Christophe JAILLET wrote:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> 

Applied, thanks!

[1/1] block: null_blk: Use the bitmap API to allocate bitmaps
      commit: aa516a92584eabad397f0a47597b20754521c876

Best regards,
-- 
Jens Axboe


