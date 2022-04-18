Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9857505ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 22:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbiDRUEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 16:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiDRUEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 16:04:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44E42CE1C;
        Mon, 18 Apr 2022 13:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BD0AB80EC4;
        Mon, 18 Apr 2022 20:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8587FC385A1;
        Mon, 18 Apr 2022 20:01:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pG8Ndra0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650312079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CYZ+Z9Ozm/sOwtZ7bRzsoS0NjGviFOdZGjMdd7k2zp4=;
        b=pG8Ndra0z0iGnbTwvyh0c5fIJp5TgAIfis8b7H9oHt54ec0yKu2NzFGSoUzIVDFZBqj1o4
        xL6jqQnH6tQjSpfvPEelQeSMgnAycr/YDMr69hJA0H5/uXBLXsNDw5Cpk2NxXdKup2GFFY
        hQf2AycSYk2J8byiqhC7JokdEWO2Npc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 569098aa (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 18 Apr 2022 20:01:19 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id p65so27356488ybp.9;
        Mon, 18 Apr 2022 13:01:19 -0700 (PDT)
X-Gm-Message-State: AOAM5330TUfWTXqFvluWtN/asYMhfxZYy8XNAEcw0pX+IDGVqRHf42A6
        XA8uDYWo8g/UxKd+AxykwYDm3lWp9HKnE/Q6GGQ=
X-Google-Smtp-Source: ABdhPJyQG4SVtnDxvZIbdMCVQf1kqzah1Ej4aSHVIAcjRXiJ8kMZwymqsOddAOMe3UxzVZcneYz4UMRbJRO4FphKrUs=
X-Received: by 2002:a25:bd8e:0:b0:644:d8dc:1198 with SMTP id
 f14-20020a25bd8e000000b00644d8dc1198mr9077422ybh.398.1650312078851; Mon, 18
 Apr 2022 13:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220418192344.1510712-1-Jason@zx2c4.com> <Yl2+YfuFNQzhFVbP@sol.localdomain>
In-Reply-To: <Yl2+YfuFNQzhFVbP@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 18 Apr 2022 22:01:08 +0200
X-Gmail-Original-Message-ID: <CAHmME9ouyHTxZKBAg7SNDmUVCh2Z9sAirYPBgyBDQXktctE4Nw@mail.gmail.com>
Message-ID: <CAHmME9ouyHTxZKBAg7SNDmUVCh2Z9sAirYPBgyBDQXktctE4Nw@mail.gmail.com>
Subject: Re: [PATCH] random: document crng_fast_key_erasure() destination possibility
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Apr 18, 2022 at 9:39 PM Eric Biggers <ebiggers@kernel.org> wrote:
> "that state" => "this state" or "the state" in the two places above, otherwise
> the first sentence can be misparsed (as "So that, state" rather than "So, that
> state").

Will do.

Jason
