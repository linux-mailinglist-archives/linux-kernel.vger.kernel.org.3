Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E445ACF34
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiIEJxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiIEJxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:53:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECED340E33
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:53:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v5so8032183plo.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8Ckz0T6YNnRZNu6cs7oBc7l4oyTpQLkMjPQRiuxKr9A=;
        b=VbV7NOz/Y2gcFfjBM3bnmNQCtYFvbrvzA+PXrumrjqjaEUtKilSdW73tUz64K6Af81
         wO02ZsCWC/EQwZma9FCedhKBMXOidF8NB3p3iQ11AwkKsTTg7c9u/eovOWZ+VJcYOVIq
         Ub3diOK3sgT3EAi0vyEgNixzfN0NcK7NAUOtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8Ckz0T6YNnRZNu6cs7oBc7l4oyTpQLkMjPQRiuxKr9A=;
        b=nPDZqrkRnkhDggJXf5gpTrCOWR6Ix8VFkGkgqVh2fhxMZfk/fxZ4vF8sysLm9GWugt
         HTdto4uMpqJy9PhVvXOMtkapXQJC3tZ1rsD/16kmOPtZrxt33PmTQ1avkj7Prr6Zw1EN
         mAidBwTqP03w7QAxSKruq2ahCU96MkP7T0oxaZxScK2icjqIEXi9GgfS9cCmYZzjDb1j
         xdJ8rDRskswne4XJoou9mKmzKNf6K7gE60jA7kPCadCbGZVPiqkoijgnnEVl39RUDxYg
         0eoxQrODGQtFwlca8PEl9AwvMuh3xgKt9Dp6jj1JTimk2oJUJtBF+gEzFBAxdFUhPhn+
         1d9g==
X-Gm-Message-State: ACgBeo285HbN9O3l66MySia4b4hS2Iufe9+bJKoBVv5hWO5NJFAWwIwH
        P1BXVSDhpDeAFtRCFBbWaLRXfg==
X-Google-Smtp-Source: AA6agR7JuqhxfhOtl79bH8xHHuicCKPpy4VEo0nWZu56Y7UpZSZXLWXJiSULunOrGkAW1f7fY7S7ig==
X-Received: by 2002:a17:90a:4805:b0:1f5:39ab:29a9 with SMTP id a5-20020a17090a480500b001f539ab29a9mr18487717pjh.202.1662371610474;
        Mon, 05 Sep 2022 02:53:30 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:5167:aa6c:9829:64dd])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b001755ac7dd0asm2582035plc.290.2022.09.05.02.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 02:53:29 -0700 (PDT)
Date:   Mon, 5 Sep 2022 18:53:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC 4/7] zram: Introduce recompress sysfs knob
Message-ID: <YxXHFZ1PJI3h6BZY@google.com>
References: <20220905081552.2740917-1-senozhatsky@chromium.org>
 <20220905081552.2740917-8-senozhatsky@chromium.org>
 <CAGsJ_4yciyk49cTk9A4di2sM=io-4z5oi4Q7P-SUOG-MGJGcQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yciyk49cTk9A4di2sM=io-4z5oi4Q7P-SUOG-MGJGcQg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/05 21:21), Barry Song wrote:
> > 3) HUGE pages recompression is activated by `huge` mode
> >
> >         echo huge > /sys/block/zram0/recompress
> 
> Thanks for developing this interesting feature. It seems reasonable for cold
> pages. But for a huge page,  do you have some data to show that the hugepage
> is not compressed by lzo/lz4 so we need zstd further? i assume the size of
> the huge page you are talking about is 2MB?

Oh, yeah, this is the lingo we use in zram. We used "huge" object and "huge"
size class in zsmalloc and the term "huge" transitioned to zram, but zram
operates with pages not objects, so huge zsmalloc object is "huge zram page".

> on second thoughts, it seems you mean hugepage is those pages
> whose compressed data is big? if so, can you please avoid using
> "huge page" as it is quite misleading in linux. we are using hugepage
> for pages larger than 4KB.

Yes, you are right. And I wish I could use a different term, but...
this is what zram has been using for many years:
Documentation/admin-guide/blockdev/zram.rst

And we already accept "huge" and "huge pages", and so, in sysfs knobs
(zram device attrs), so the confusing term, unfortunately, is there
forever.
