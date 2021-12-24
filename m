Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB1347EE8F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 12:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352568AbhLXL2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 06:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbhLXL2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 06:28:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B817AC061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:28:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y13so32305880edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 03:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MBXXgPzp1aLWOzuWai3CTOo0xznoopWMsr8l2TBVg94=;
        b=eXrrB526ee8Lq5qqJ15Y78ua1OHokgF80/1jYrgtOnnt4mkjanyt2THjgsweqYC9gh
         dkmcMtmzFsyrddu1e7ITyxtXVNObyuHc2a+dUSq9bz4vJYcgZOW6ZO+7BAcRgqI2j30c
         yTBs5ywGFv4aawywBzyszqoDJiTC8q27yScbt6UCW+l3QV6cMLah56K6sO1YXrX2apdH
         3pwILSFCGh/CWAjsE5g1o6O3GCMK9ESVQ3v0qq8GGF38HuQK5ntyy8SZex8GfNlk9qEI
         tBy9O36ziEtN8lme8Ia2ye5LK8EyriXpRTVqZCvlyWUIPHV16vkjEWkmcp3eFTOIXBAR
         hYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MBXXgPzp1aLWOzuWai3CTOo0xznoopWMsr8l2TBVg94=;
        b=O3AitEE49/kffX8DI1TlmU0pwgjNKq8abXyKfGrLgDtDjPzrCFWzLmY2gkpiax5mW6
         fIlMWEsCSm3diwQVDZh/MZMACDaZEfx2aBMA6MLqOsOcl6WOv00xRSkiEDEKZYRPCb6M
         1m9Sa6tF6ulaLL/H75zKDjzJWhBIKvYLLthmv+ovG+3UgKtZ+KidAecRDVvuXUaIrcGd
         LS1k4/+j4FovBo+oPdXokv7Au1i53OjMiutz29ZBs5VmvQBTL/5Am63mAmqNO2xRc2CF
         tnUZgGIGFmSyscYUdOeGjwEhf/LaAathyKoeE6hCMJagZmDhAHBU3FQq+nEyAyTv1cIk
         gOyw==
X-Gm-Message-State: AOAM531qyZg74McMIIGzY/IJOg1jbb7t8C6S/FG3pPyK/yzPKVqOFbIR
        04ohjshzve/Ayub0Nf0zrq0P3GbmQ9x5zNzJH2n2EV2q
X-Google-Smtp-Source: ABdhPJzXY9DO74b0WQch4op0O2W25jrLAUic7PM4B2ItUWmNUxELt8hNO4OmjXbLVNBI3nFCnRNJ3QqOhCKohPGwpU8=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr4903494ejc.269.1640345298344;
 Fri, 24 Dec 2021 03:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20211220084756.955307-1-wangborong@cdjrlc.com>
In-Reply-To: <20211220084756.955307-1-wangborong@cdjrlc.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 24 Dec 2021 03:28:07 -0800
Message-ID: <CAMo8BfLnPFWwOZTpycKfRuGvYV2wumtPxv9n2UjkM0s3LBB-9w@mail.gmail.com>
Subject: Re: [PATCH] xtensa: use strscpy to copy strings
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Chris Zankel <chris@zankel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:50 AM Jason Wang <wangborong@cdjrlc.com> wrote:
>
> The strlcpy should not be used because it doesn't limit the source
> length. So that it will lead some potential bugs.
>
> But the strscpy doesn't require reading memory from the src string
> beyond the specified "count" bytes, and since the return value is
> easier to error-check than strlcpy()'s. In addition, the implementation
> is robust to the string changing out from underneath it, unlike the
> current strlcpy() implementation.
>
> Thus, replace strlcpy with strscpy.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/xtensa/kernel/setup.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to my xtensa tree. Thanks.

-- Max
