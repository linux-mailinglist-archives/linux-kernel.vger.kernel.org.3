Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD744DD818
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiCRKiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiCRKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:38:04 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CF92D88A0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:36:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w27so13434655lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uezAxvrMiMWp05gtOXieDCRlPfIaBrEY9L+wFxAHD0I=;
        b=bNnyZSbzTBSvQFszb6I/F12rQ8T6cQ/10ECH/5aamuFpcWLXuGwqmi2qlA6OiaUIr+
         V8TqpsR+t0/DyCMoEh0CzqowEErBChoYXYtogqepO3/rN15qn5ixhtqXSUnXgP8ImKUd
         dquYpFAmazrx70ftgNlsqJnMu8VXtOfn5Fycx5s4naSptE35kQcC2TBiqr3KKFo+LcV1
         5c8WxdJ3UMCLZsIfegAevCopkngxCuOIeY3nBuQeeddmK2uDHM1mtQLI5y+HsBtwRACr
         XdDNr/3qHzJL/P06ND/wPSbT5RUHQjnOnE3omFv2FjybosKBFQxhzuagXroaERc3iONq
         RREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uezAxvrMiMWp05gtOXieDCRlPfIaBrEY9L+wFxAHD0I=;
        b=ZjP1wW784+uklrznIdCEKTOnqP85qhZA3tAMgCJzPWBJkguNnwUQvdMASICO5zcYbb
         hBG2ymSvvKTSht+We8MAO5PTn7QArrbXmxepN/7Tpfwhvhy9RD2tLV2AG0i6D9qEJ4UZ
         cvp7xVnLZpUnxDyBELbbnGKV1H2dk8jmtTI6i124XzF3ncd9J6BeellW1Tw5wxUc9LTc
         ctowH6OZjKkRW/llhWJWo1QvT+Ut1Rw7xVFn9qCL/guplQw7ykQmFc3x2PSbe8JhGWmf
         4sGTRuuchBbxOgdcyJONxCgi+PQ/zm7ANz43ax/NLs979pEhJyUXQazTcEGgQ7YmZK/d
         LPEw==
X-Gm-Message-State: AOAM532W7MYF+iFwcPUkHfnL7OYg2MTvpipapsqt0fOlh3UnWMJkCN2K
        MEkZUp4zd6YwMJmBg9VHPhO1bQOtHtSriKPXc1x3WPGJsOjTig==
X-Google-Smtp-Source: ABdhPJzLDlZkIjkcjiJPHs6VSkUvvCx84qJ6fCSn3Un08tTkfHEJ5Nvoc5uZ9+oYemtT0HKnjD8/dVaewJpYQqnDfQA=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr5958247lfr.233.1647599801563; Fri, 18
 Mar 2022 03:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220316093740.GA7714@lst.de> <20220316093855.GC7714@lst.de>
 <CAPDyKFrH4L2Y2TOFyWPJ+_rrgvJPixR05XX_HWUU99h0MZhLuA@mail.gmail.com> <20220318091152.GB31758@lst.de>
In-Reply-To: <20220318091152.GB31758@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Mar 2022 11:36:04 +0100
Message-ID: <CAPDyKFohNVnrwcZSCGnv7X++FfQ0a3rdeMx3tvJ0eW-Afr9Tyg@mail.gmail.com>
Subject: Re: [PATCH alternative 2] block: fix the REQ_OP_SECURE_ERASE handling
 to not leak erased data
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, jaegeuk@kernel.org, chao@kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 at 10:11, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Mar 17, 2022 at 10:44:01AM +0100, Ulf Hansson wrote:
> > Stating that it can't work is probably not a correct statement.
> > Certainly it can, but it depends on how "secure" (or clever) the
> > implementation of the FTL is in the flash media. I mean, nothing
> > prevents the FTL from doing a real erase on erase block level and
> > simply let the "secure erase" request wait on that operation to be
> > completed.
>
> Well, that assumes it can find all the previous copied of the data.
> Having worked with various higher end SSDs FTLs I know they can't,
> so if an eMMC device could that would very much surpise me given
> the overhead.

An eMMC is no different from an SSD in this regard, so you are most
definitely correct. BTW, I was one of those guys working with FTLs
myself, but it was a long time ago, when NAND/NOR flashes were less
complicated to manage.

Anyway, to really make things work, one would need some additional low
level partitioning  - or commands to tag the data for special
purposes. eMMCs do have some support for things like this, but whether
it actually works to serve this particular use case (secure erase), I
really can't tell.

Kind regards
Uffe
