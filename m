Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606814AA86B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 12:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354290AbiBELoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 06:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiBELn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 06:43:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF0C061346;
        Sat,  5 Feb 2022 03:43:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1E3060C7F;
        Sat,  5 Feb 2022 11:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00ADBC340F1;
        Sat,  5 Feb 2022 11:43:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="abjzsRNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644061434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vvphuGRlV1QXeCQbEHdvP7bgask7Y7u7hJLzcrQwl20=;
        b=abjzsRNgS533YDXP+Qb27G7TwVcMRu3t3nqlH9r2dYUcuEXDIaqz4ASoQwkldjZD2oHXr+
        1c6pOQ2aL35wTwIMwrhKyHLx0R1Lr5sy2S4wRM5FTsvl3lM58qrRE16JNfW/6X1TcYInlB
        ExN8I/IAjnwsL/eds0CLE5mPmwNQ+Tg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5343d4db (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 5 Feb 2022 11:43:54 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id z62so14107572ybc.11;
        Sat, 05 Feb 2022 03:43:53 -0800 (PST)
X-Gm-Message-State: AOAM531A6Z8PQjknQKedsSg3ACJ7RueVVIUDeaPbfWE8HJwA37odMBlZ
        efB2w+dUncXsAxjKpS1etegMQSvw7ciwnAiPveM=
X-Google-Smtp-Source: ABdhPJwXVOpO+5A9zMTmDMyRgMZSUPTtyWK2QBIhZZRSOFltYCetUU/mPk5NVhzvuD00WYe+kbcRNq8aXeGjgkiF3oE=
X-Received: by 2002:a81:1084:: with SMTP id 126mr3115409ywq.231.1644061433231;
 Sat, 05 Feb 2022 03:43:53 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:6254:b0:129:4164:158b with HTTP; Sat, 5 Feb 2022
 03:43:52 -0800 (PST)
In-Reply-To: <CAHmME9pTDCUb7pAMeCMnU=jiAQd=ctrWN4K7s=8DqCtiOqbkrg@mail.gmail.com>
References: <20220204135325.8327-1-Jason@zx2c4.com> <20220204135325.8327-2-Jason@zx2c4.com>
 <Yf4z+Rc+69siZ0/N@owl.dominikbrodowski.net> <CAHmME9pTDCUb7pAMeCMnU=jiAQd=ctrWN4K7s=8DqCtiOqbkrg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 5 Feb 2022 12:43:52 +0100
X-Gmail-Original-Message-ID: <CAHmME9q-hfSRegD0azEX0Z+5uNGCyS3N4VhMPqp206zP+WjZtg@mail.gmail.com>
Message-ID: <CAHmME9q-hfSRegD0azEX0Z+5uNGCyS3N4VhMPqp206zP+WjZtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] random: use computational hash for entropy extraction
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
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

On 2/5/22, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Nowadays it's only called once every 5 minutes (per numa

Period, not per node.
