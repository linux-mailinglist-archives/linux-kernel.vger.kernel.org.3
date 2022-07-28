Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7DA583851
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 07:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiG1F4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 01:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiG1F4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 01:56:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E7F57267;
        Wed, 27 Jul 2022 22:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 717C1B8229B;
        Thu, 28 Jul 2022 05:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8E3C433D7;
        Thu, 28 Jul 2022 05:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658987761;
        bh=5U82LOFcNwDUA8/kh9KM96VMu6YPACZ2xuM2ixXGbiI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sTZZPAoPUzlf2YGz5otlmpxCLGIm0yJgWlEAPWNQx76ywbCJhQEpT6+Sb/+xMTn73
         Auuoto/S1PKk98izJHpQaqr0oGD804HemMuFQeHBpJ0W/TpHzqgaNHP1rmdXpjergh
         K/jbWNk19DaDI3qzI5a35peKfBUudSfX1uvuxcocGMTcosey5Rol9YthDxJtSpg9GW
         vWXVjvZei/3kMGHf/7adRQE4YuOHgToDdljNpdH4+m8IjUo6w5g5WF1ivmCybiNbU9
         pVHpHbzoCyGbpvNUwgyQaCVKojgtTok1fuDBRQrJd8/ZU1b5ajJug2CkVcwgiSOuQM
         2kWiQH6za0yaA==
Received: by mail-yb1-f177.google.com with SMTP id o15so1661941yba.10;
        Wed, 27 Jul 2022 22:56:01 -0700 (PDT)
X-Gm-Message-State: AJIora/vNscy/O0DV8m8tK0+5f5djOD9wGnHn5O5M4W3i96H9NFw3wzU
        Dk6kGkyMkeBud0y40Ga5bUIcFoVNJloYA0G4aNk=
X-Google-Smtp-Source: AGRyM1udCZvbOsiIVUzq3BLoiUWpMLxeV8CfqP6vQhaYqXcXBJkmAfQxjKSXvpwp9csRtMZb/qqqBQqU5AiAbjmcW7w=
X-Received: by 2002:a25:41d6:0:b0:673:817c:e163 with SMTP id
 o205-20020a2541d6000000b00673817ce163mr2590841yba.561.1658987760160; Wed, 27
 Jul 2022 22:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220727210600.120221-1-logang@deltatee.com>
In-Reply-To: <20220727210600.120221-1-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 27 Jul 2022 22:55:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Ao3hTCjB2QvZcyqFYixSs8WYhWZoCqE3azqsttqDp4A@mail.gmail.com>
Message-ID: <CAPhsuW7Ao3hTCjB2QvZcyqFYixSs8WYhWZoCqE3azqsttqDp4A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Bug fix for recent batching change
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 2:06 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hey,
>
> We hit another bug on my recent batching patch. In this case the
> bug has never been hit with the current md/md-next branch but
> some other patches we were working on changed the timing such
> that we hit this bug. It is theoretically possible to hit in
> the md/md-next batch so this patchset contains a fix.
>
> The fix is the last commit. The first four commits are some
> basic refactoring that makes the final commit a bit easier.
>
> A git repo is here and is based on current md/md-next (7a6f9e9cf1):
>
>    https://github.com/sbates130272/linux-p2pmem raid5_batch_quiesce

Applied to md-next. Thanks!

Song
