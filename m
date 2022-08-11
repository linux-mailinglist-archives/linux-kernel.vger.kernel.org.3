Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CB590617
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiHKRqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiHKRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF77A025B;
        Thu, 11 Aug 2022 10:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A87F161746;
        Thu, 11 Aug 2022 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A6EC4347C;
        Thu, 11 Aug 2022 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660239995;
        bh=ERpZlEJSnT2eqU2XoItuClL1ABvHKuD1I/5qTQERD9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RBLDVeVA+dt+2L+u5iby39SqxlFaqE82Ch8xUqSvUOY5SvkKe9juEfwHAj/QmsYWI
         5Fh363TEuu+p36FUmkpELZvX5i4EEWFzyxWyRpLR5/ONy9qaKdpCQYrb0dJlgvXFgA
         iPyEjcFP0PL7AGP8jmV09luibvXZfXP2SEH/puyUuzIri9r79mh51savEToIpQNiXY
         a0XSI6UYv1hzETkhrDc3ciZ4LdWWxvVVjjTGJwcYrIPadOELXd6K3hXQqyx/AaVSef
         mIZuPN3y73PYa6ws5hhvUbBEKmgcu/NdHMa3HoXwzSsN+dWFe4G2aNZxKGCS7M5h5V
         Wr0T5ZBA8Ff+A==
Received: by mail-yb1-f181.google.com with SMTP id 7so29430682ybw.0;
        Thu, 11 Aug 2022 10:46:35 -0700 (PDT)
X-Gm-Message-State: ACgBeo2hHVsv9P3/DtIDe9BynG/uf7qPykurRKFZ0XJtNsokMeJCZ7zV
        FnSM56uZxPk8YVtn/HVZwMSPjEsbVMeRSeSNDeg=
X-Google-Smtp-Source: AA6agR4ZCEdl4tiVg2UOwg7/4Gz0jhe16HiQ1xftAjdC5QyxW8bGm2zu3wSIiXdd14XUgyywP9FeO0UipMyOZjUntyk=
X-Received: by 2002:a25:2d5b:0:b0:67d:e14:7daa with SMTP id
 s27-20020a252d5b000000b0067d0e147daamr350929ybe.561.1660239994038; Thu, 11
 Aug 2022 10:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220811171417.147697-1-logang@deltatee.com> <20220811171417.147697-2-logang@deltatee.com>
In-Reply-To: <20220811171417.147697-2-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 11 Aug 2022 10:46:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW66hmkAE=iWHt=F8PfFus_Q5_zB_nqPdZMKr=N2Ddfesg@mail.gmail.com>
Message-ID: <CAPhsuW66hmkAE=iWHt=F8PfFus_Q5_zB_nqPdZMKr=N2Ddfesg@mail.gmail.com>
Subject: Re: [PATCH 1/5] md: Flush workqueue md_rdev_misc_wq in md_alloc()
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:14 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> From: David Sloan <david.sloan@eideticom.com>
>
> A race condition still exists when removing and re-creating md devices
> in test cases. However, it is only seen on some setups.
>
> The race condition was tracked down to a reference still being held
> to the kobject by the rdev in the md_rdev_misc_wq which will be released
> in rdev_delayed_delete().
>
> md_alloc() waits for previous deletions by waiting on the md_misc_wq,
> but the md_rdev_misc_wq may still be holding a reference to a recently
> removed device.
>
> To fix this, also flush the md_rdev_misc_wq in md_alloc().
>
> Signed-off-by: David Sloan <david.sloan@eideticom.com>
> [logang@deltatee.com: rewrote commit message]
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Applied 1/5 to md-fixes.

Thanks!
Song
