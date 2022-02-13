Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56B04B3AF9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 11:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiBMK5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 05:57:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiBMK5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 05:57:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95855DE76
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 02:57:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15709CE0B61
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AC0C340F1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:56:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CLRRCzld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644749816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPMav3pKOgzb0bGOlDVduDnJ+LZlzKseV0cRWyVoQWM=;
        b=CLRRCzldx+34PYCqpW4VSoS9gMePYDHMNyc6iTFlBN2IDGRL+Su6x63adU+eZWN4bMLs8J
        oPoHhW6l+2On/VejliYkE+lIgZjWc3N/LIw6Ao6d9AYCDZqUvpdwcwGLT/oh+h7vzSovST
        XFE2E33ZKWZ9m8qVhIMi4Qgshldp66E=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 66218c4d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 13 Feb 2022 10:56:55 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id y129so37963765ybe.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 02:56:55 -0800 (PST)
X-Gm-Message-State: AOAM532hX1ZnFBb1ND3j/pYOyU2c4flRBIeQH558jB8W8EWDHp2zaQdt
        vGKVzZjjGaFKIXx/9gu+X4QqO9qdqxIW8PUX5Rg=
X-Google-Smtp-Source: ABdhPJyiXETV0ReGmXXALJLqbrCMhimfsKfaknxnzvT1c8boTlBwtp1YUImKZiPP73c/PWc7nxxsOFmAxKCLEunduvI=
X-Received: by 2002:a25:c006:: with SMTP id c6mr7899916ybf.457.1644749814816;
 Sun, 13 Feb 2022 02:56:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:888:b0:14e:cd6d:454f with HTTP; Sun, 13 Feb 2022
 02:56:54 -0800 (PST)
In-Reply-To: <YgirWF8p24lW7+gp@owl.dominikbrodowski.net>
References: <20220212231022.679926-1-Jason@zx2c4.com> <20220212231022.679926-2-Jason@zx2c4.com>
 <YgirWF8p24lW7+gp@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 13 Feb 2022 11:56:54 +0100
X-Gmail-Original-Message-ID: <CAHmME9prXV8VMcAG=YpdrrSxe1+YUq3mAtak7K50J_5tbGcHfA@mail.gmail.com>
Message-ID: <CAHmME9prXV8VMcAG=YpdrrSxe1+YUq3mAtak7K50J_5tbGcHfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] random: unify early init crng load accounting
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/22, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> Am Sun, Feb 13, 2022 at 12:10:20AM +0100 schrieb Jason A. Donenfeld:
>> crng_fast_load() and crng_slow_load() have different semantics:
>>
>> - crng_fast_load() xors and accounts with crng_init_cnt.
>> - crng_slow_load() hashes and doesn't account.
>>
>> However add_hwgenerator_randomness() can afford to hash (it's called
>> from a kthread), and it should account. Additionally, ones that can
>> afford to hash don't need to take a trylock but can take a normal lock.
>> So, we combine these into one function, crng_pre_init_inject(), which
>> allows us to control these in a uniform way. This will make it simpler
>> later to simplify this all down when the time comes for that.
>
> I thought the call to crng_fast_load() from add_input_randomness() is on
> its
> way out?

It might be. In that case, this commit is preparation work to make the
sunsetting there more clear, and so we can really see what that change
is like. Or maybe we won't do that, in which case this is an
improvement. I'll be looking at that next week.

Jason
