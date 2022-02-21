Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1155A4BE41A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378593AbiBUO55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:57:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378589AbiBUO5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:57:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B65CE9E;
        Mon, 21 Feb 2022 06:57:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA3D7B811BB;
        Mon, 21 Feb 2022 14:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FAAC340E9;
        Mon, 21 Feb 2022 14:57:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lSIETL2b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645455444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w1dYxGGlAk7oSg4VWIgvCkMkLUjlbhh57JEWSqOr12E=;
        b=lSIETL2bQn3QNaiOHaact6B7Gr93MDQ+R7sLPeBKKpFVBbk9Y4K3mWWVVpQHG/KpWZdPMe
        dC///8VIylVNmiLeF68Oij/6+LpxxM1bCb7zaLNrcWpk6MdVwlGAufPqoVWbPlk6chsCz/
        WS9/YqKe2fcCTPcWwqxBT37F+gtCxaU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e60c24e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 21 Feb 2022 14:57:24 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id b35so7136532ybi.13;
        Mon, 21 Feb 2022 06:57:23 -0800 (PST)
X-Gm-Message-State: AOAM532bCsfh7RhWzoWY1iBsT3U8C7NLsAsXdyWEdO7erCkJpArxHlvK
        fjkay0R085j3fg6EnX2jqrWUiIZ7y96GPaW0gI4=
X-Google-Smtp-Source: ABdhPJyedvueidxl7Ut4gzsMJfO+JuBbjpJ5//8X8pqsmwDdVK+Rq6mCXO5pVXOwvh7K5E5BB34xOlKzEUkdQSgyApY=
X-Received: by 2002:a5b:d11:0:b0:623:fbda:40f4 with SMTP id
 y17-20020a5b0d11000000b00623fbda40f4mr19309542ybp.398.1645455443231; Mon, 21
 Feb 2022 06:57:23 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qMRO0YFwQRUZfuUjTy2=C0QYkNLZSK5YgVD0xpcP2qbQ@mail.gmail.com>
 <20220215211333.244383-1-Jason@zx2c4.com> <YhL9QNsMSHZvuR0u@sol.localdomain>
In-Reply-To: <YhL9QNsMSHZvuR0u@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 15:57:11 +0100
X-Gmail-Original-Message-ID: <CAHmME9pCGHuhZW-HQD==2h0=YRk=Man0KU6+RAGiT0QD-PCNpg@mail.gmail.com>
Message-ID: <CAHmME9pCGHuhZW-HQD==2h0=YRk=Man0KU6+RAGiT0QD-PCNpg@mail.gmail.com>
Subject: Re: [PATCH v3] random: absorb fast pool into input pool after fast load
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

On Mon, Feb 21, 2022 at 3:47 AM Eric Biggers <ebiggers@kernel.org> wrote:
> This looks fine, though it's unfortunate that it has to be a trylock so this
> isn't guaranteed.  Also, the commit message is a bit misleading because it talks
> about "overwriting" the primary_crng key, but at this point in the series the
> extracted entropy is still being XOR'd with the primary_crng key.  It's not
> until the next patch that the key is simply overwritten.

I'll fix up the commit message.
