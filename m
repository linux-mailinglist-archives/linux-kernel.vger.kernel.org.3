Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766684E68B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352646AbiCXSdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbiCXSdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:33:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E777AF1D2;
        Thu, 24 Mar 2022 11:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0CA5ECE23A9;
        Thu, 24 Mar 2022 18:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0AFC340F0;
        Thu, 24 Mar 2022 18:31:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gwP1uU2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1648146683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=04jnsrH/k5FGISNyxH5afqVngH3wf0OI2j533NgQ5yM=;
        b=gwP1uU2g2TJPCCB646TQ2kPBRVevypIeu3F/lInNCav4gMyn/KEc3kxOZMju0qio4i+695
        q8p68XZFsueGJo3j0EUHY421Lh+b3VzgaqUCiZtP1k3qezKNVQQT9luBU58U6F87UJDZ9t
        3E6EeTI9Be6Tr90X7mXty+oLpOlmLvM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 88971558 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 24 Mar 2022 18:31:23 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id j2so10045642ybu.0;
        Thu, 24 Mar 2022 11:31:23 -0700 (PDT)
X-Gm-Message-State: AOAM530WmBXq9WHCTIdnWiVbuftEsEON0OjIVOLC4L3kPkffa8Wavd7m
        s1dMmm0ZQQnEj+X1lkQ/hhVAsoI7inOITGQDYQQ=
X-Google-Smtp-Source: ABdhPJwCDBYq48ICgIxKeXLyUOIHAxOaeNumwB8J4JMlYFW+RqNY7q8fP4fukuZuJnwe9VNmX0vJGBxFaM4viis+CAA=
X-Received: by 2002:a25:ad83:0:b0:633:abf6:5f69 with SMTP id
 z3-20020a25ad83000000b00633abf65f69mr5772660ybi.382.1648146681826; Thu, 24
 Mar 2022 11:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220322191436.110963-1-Jason@zx2c4.com> <1648009787.fah6dos6ya.none@localhost>
 <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
 <CAHmME9ovJpdcuuZhNKrOTUc8XvKDDdC+axhAmOD9iESnRR7JqA@mail.gmail.com> <Yjy38Nl2wYf0L1eY@gmail.com>
In-Reply-To: <Yjy38Nl2wYf0L1eY@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 24 Mar 2022 12:31:10 -0600
X-Gmail-Original-Message-ID: <CAHmME9oMeBqEa_GtGXDDVrVe+N=nJH8zB9APDb-mUxx+3_zouw@mail.gmail.com>
Message-ID: <CAHmME9oMeBqEa_GtGXDDVrVe+N=nJH8zB9APDb-mUxx+3_zouw@mail.gmail.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast init
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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

Hi Eric,

On Thu, Mar 24, 2022 at 12:27 PM Eric Biggers <ebiggers@kernel.org> wrote:
> The example in random(4) needs to be fixed too, right?
>
> https://man7.org/linux/man-pages/man4/random.4.html

Yes, that's always been wrong, at least for all of 2.6.... There are a
number of issues with the man page that I plan on addressing all at
once with a series.

Jason
