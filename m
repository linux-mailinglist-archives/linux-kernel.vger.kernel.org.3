Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EF156BD42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbiGHPcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbiGHPcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:32:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2105A5C9FE;
        Fri,  8 Jul 2022 08:32:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h17so17891448wrx.0;
        Fri, 08 Jul 2022 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=7Gr1DIwlquSsFy5gvJ8I7cokiRlnBL/lo0iBO4OC3QI=;
        b=JqyzyFx4yc1hWWomwr6OIKKgym/3owtxy/4LE652WY3EFU0PxFbAKqUAxssvHIlC6Q
         uARvrf07eKwX2RWdUgtuvt2hlpDowP6/5fx7QAkDNQPGFpemSTmdLm/SIGXJmR2IYkk3
         fy6VSjKnTQnN6ciYNvz2Hi3Psb+omTM3iwlMN/Mvt8G+mZg58i2soituPkE6RapuZFGg
         riuSDkbX93/+BdhLzyckUHs/2aLAuwgbBT54vHv7vTMJuTxXqLaBReYfZeUMmyT0bRkr
         1qcHaQstOW0r/dwXZrjrndA3snyGlYzeQ/9dMZV/df7i8RUTTTYEyNodJq45qRTzICxk
         woDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=7Gr1DIwlquSsFy5gvJ8I7cokiRlnBL/lo0iBO4OC3QI=;
        b=uLeU1D4J+EEgSsuTuFwWipcSrB3rOoXv6rCjEUsDxoIeDwWBdm0zJDa7dpl0v8zr9u
         UHmyJCzcp6RA5uhkm5VYWzocRqRxAUM4MHCMBNiL7LToccQtP36ul/cEq9HTTH5JyjXz
         FcOn/D+m1q2bYDY3FZFdReQdWP8CDg4387eHcqDgy3Etg8PQ3zuEyWs5LiNfOt5KDZkj
         jnvnQATtgalKXrlfvb0+1XzLzWF5OkJs1wCGb5mbEMW/GePrRvC/mkO6mD3gy4iUfc6W
         YDuigLKX2WNhFUaunVDWeb1QEHTBc86IuAyyCjE1egbMu+I6X5bLM5tMck0VnXYs4zGz
         CLpw==
X-Gm-Message-State: AJIora/6+aBH0TgBp//DtonXeuupBPG+JJsoMGNSPaNyD82Xa3g3oSWf
        wW6BzrpHsi2DO8iOwrFdggU=
X-Google-Smtp-Source: AGRyM1vgDADaiocyDgtoIhQ8s0fcwP2kLrbv46+a78WOeMjJtNaJzz1ctV9dgn3acFPZmpQgtK1qQA==
X-Received: by 2002:a05:6000:18d:b0:21b:901e:9b27 with SMTP id p13-20020a056000018d00b0021b901e9b27mr3972766wrx.389.1657294368605;
        Fri, 08 Jul 2022 08:32:48 -0700 (PDT)
Received: from localhost (92.40.203.214.threembb.co.uk. [92.40.203.214])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b003973ea7e725sm3452720wmq.0.2022.07.08.08.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 08:32:47 -0700 (PDT)
References: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
 <20220708104304.51415-5-aidanmacdonald.0x0@gmail.com>
 <YsgmkBpk4JBTkjPz@sirena.org.uk>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     paul@crapouillou.net, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] ASoC: jz4740-i2s: Handle independent FIFO
 flush bits
Date:   Fri, 08 Jul 2022 16:30:55 +0100
In-reply-to: <YsgmkBpk4JBTkjPz@sirena.org.uk>
Message-ID: <NuOKvbkZUvbLCcCv2cXfJsp97ioQdiVG@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Brown <broonie@kernel.org> writes:

> On Fri, Jul 08, 2022 at 11:42:57AM +0100, Aidan MacDonald wrote:
>> On the JZ4740, there is a single bit that flushes (empties) both
>> the transmit and receive FIFO. Later SoCs have independent flush
>> bits for each FIFO, which allows us to flush the right FIFO when
>> starting up a stream.
>> 
>> This also fixes a bug: since we were only setting the JZ4740's
>> flush bit, which corresponds to the TX FIFO flush bit on other
>> SoCs, other SoCs were not having their RX FIFO flushed at all.
>> 
>> Fixes: 967beb2e8777 ("ASoC: jz4740: Add jz4780 support")
>
> Fixes should generally be at the start of a patch series so they don't
> end up depending on other patches needlessly.

Okay then, I'll refactor it to allow for easier backporting.
