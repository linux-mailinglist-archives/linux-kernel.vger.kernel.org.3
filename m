Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E7556B25F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiGHFp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbiGHFp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:45:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEA02CC8E;
        Thu,  7 Jul 2022 22:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F23F0B824C1;
        Fri,  8 Jul 2022 05:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D39C341C8;
        Fri,  8 Jul 2022 05:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657259152;
        bh=7qC9gsOF6NFJYCvzdCsuZTse6wTpCSAa+LAm1AdIefI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=beYpX+D2ey5f7Lq1Lmv23P4ooH3KGpo4IZzeAMNjwnXBYreclF1pEjfFYZNrVzTSN
         NYku4odIasQ2Bzj0sN3WLZW9hvuDDljFGdXL9/vpWqmJkNjtJ+MMxmx7XYrboDsEUM
         BkYgk/qb63ZTFVCHY6PhSC7h92RtMy5FFl0T3M5WcFB2VZxML5YH8E3Ip6mgcs6ufj
         kKShNqjWx7yyR/VLr1vqjs/JTig2Abrgu2xEwp840kqXqJchVbfR+7AmEddsBnHxpw
         DfQeirmJlIE7tVz7OrWJ5yVEhdSGhMDGi9PqNs3E2G+DjmMmObx6p7ha1MuUIfonae
         /sPczvt1AMsow==
Received: by mail-yb1-f170.google.com with SMTP id r3so36184236ybr.6;
        Thu, 07 Jul 2022 22:45:52 -0700 (PDT)
X-Gm-Message-State: AJIora9HA5ztWz3bOp1yVVWkO8zAgz4PvpL1sbSoQ8xRt9FM6P3ZCGVa
        X92XeVgl9jYLKwoKKQncsdqfcz4yuePRr+MLzfs=
X-Google-Smtp-Source: AGRyM1v1rmjHrz98tDPMJhJXDz9uVINgK9FUfGLHX4jUIRqrx9rp4fJDh4F6AsSGUGTVseF8zzhc5mbrIekxtyujmzk=
X-Received: by 2002:a25:9c09:0:b0:66e:4d5c:8cbc with SMTP id
 c9-20020a259c09000000b0066e4d5c8cbcmr1685559ybo.449.1657259151607; Thu, 07
 Jul 2022 22:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220707191533.293795-1-logang@deltatee.com>
In-Reply-To: <20220707191533.293795-1-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 7 Jul 2022 22:45:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5R=t=k0zKvJsOf3eaQE9MVu6kLEc5i2cN-72WB75SVbg@mail.gmail.com>
Message-ID: <CAPhsuW5R=t=k0zKvJsOf3eaQE9MVu6kLEc5i2cN-72WB75SVbg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Raid5 Bug Fixes
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 12:15 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hey,
>
> Please find two patches with fixes to the raid5 code.
>
> The first patch fixes a bug in my recent commit that causes data
> corruption in very specific circumstances.
>
> The second patch fixes a theoretical issue with nested waits in
> code that was recently cleaned up in the previous series (though the
> issue always existed).
>
> Thanks,

Applied to md-next after fixing a couple typos.

Thanks!
Song

>
> Logan
>
> --
>
> Logan Gunthorpe (2):
>   md/raid5: Fix sectors_to_do bitmap overflow in raid5_make_request()
>   md/raid5: Convert prepare_to_wait() to wait_woken() api
>
>  drivers/md/raid5.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
>
> base-commit: ff4ec5f79108cf82fe7168547c76fe754c4ade0a
> --
> 2.30.2
