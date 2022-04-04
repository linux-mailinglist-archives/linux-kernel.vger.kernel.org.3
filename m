Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC93A4F1E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354967AbiDDVx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379586AbiDDRjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:39:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B2B7F1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06785B818BF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 17:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4610DC2BBE4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 17:37:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YGT7BojP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649093851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yZVI1KAOo1mIBeRHAVz7zVPMeySuOMMLVutZjfFGwmA=;
        b=YGT7BojP7UhaK1QBT/H6nRsBMWzPvvoguKJvfMepZsZCWsexGttYt41qXsW74j6M/EfrQx
        WjjcPSZMzDixI5TaOZRpbmw8sxljUct9zUjh1rmFWUb030gyTNn5r0NZvPL2eVl1h+fiRl
        +L67bEbKJTiPQGi1qDslrH2tG/FHiu8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f3643630 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 4 Apr 2022 17:37:31 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2db2add4516so108651807b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:37:31 -0700 (PDT)
X-Gm-Message-State: AOAM5331MfzYd5HVNIT4VqF0hhm0LQSgG5rS6//ZqFZ+4BRr2PgfUJZ5
        wDMBDJdxlUbEs+63R5DETGY24q6Xc1Uo5tRC21o=
X-Google-Smtp-Source: ABdhPJxMSD0Fg//duXs1NqBFDgEau1qxkscj0IJ/Sh+Bs2C+0BqS3hWuh/BOXZms4G7YRDAg+ztp17SRwMOCaeHwP/Q=
X-Received: by 2002:a81:f00c:0:b0:2e9:d949:c189 with SMTP id
 p12-20020a81f00c000000b002e9d949c189mr1023301ywm.2.1649093850853; Mon, 04 Apr
 2022 10:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220404162039.961926-1-jan.varho@gmail.com> <20220404164230.968514-1-jan.varho@gmail.com>
In-Reply-To: <20220404164230.968514-1-jan.varho@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 4 Apr 2022 19:37:19 +0200
X-Gmail-Original-Message-ID: <CAHmME9o9JE4TA8_h0AKPCHStE4Sy7XxLc4wUwA=BjHsjRjeOkg@mail.gmail.com>
Message-ID: <CAHmME9o9JE4TA8_h0AKPCHStE4Sy7XxLc4wUwA=BjHsjRjeOkg@mail.gmail.com>
Subject: Re: [PATCH v3] random: fix add_hwgenerator_randomness entropy accounting
To:     Jan Varho <jan.varho@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
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

Hi Jan,

On Mon, Apr 4, 2022 at 6:43 PM Jan Varho <jan.varho@gmail.com> wrote:
>
> add_hwgenerator_randomness tries to only use the required amound of input
> for fast init, but credits all the entropy if even a byte was left over.
>
> Fix by not crediting entropy when using the input for fast init.

Looks good, thanks. Applied as
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=527a9867

Jason
