Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E247D577EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiGRJfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiGRJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:35:04 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB2EE3E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:35:03 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31c86fe1dddso100878257b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qieC8+PNypjqU9XCrVZh9wTINnwJ/hl/d0JbF/ThDU=;
        b=GvJ19lxGvUR1vGRIjLP+cCJQ0m1HzwU4Xus7giM634RQ7bkA5GWKrLDBmLelmYOpqy
         5y3LrVpaxLNhM+Ah3loYZ0wcAMa3ecTVc807JBdjaWk/wIEsy1x2j75hllOBrXBNjsR1
         bTzFrANw9wwg9RGSoAAlxgJcn1qWwY/SjoaXxfY9IgQARPb8Np+eT2Dh/jmKrPfBbPz0
         vAC+js4xhimO8rBtIdXQA3uD0FiSsUHTzY+ebt3Rq0Ti930r8JgGHvkpWveui8NapwXf
         loX2+xmUACEU5ZTSU+mwoLtmIX3JGkpxm5h9PBQjWTZtaK9B48d1eNEW5Mye215h2QB0
         94EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qieC8+PNypjqU9XCrVZh9wTINnwJ/hl/d0JbF/ThDU=;
        b=G+MPUwLsiOcfITnQKcNw7pJrUkS7IIrqa91pQCKtEQL0V3CjwFnLx2cx6g1Bd6OkCu
         /lI/e7gbrwUyvjZ2A0dGH+mHk4Cc6gnbAa6/GVDi204p+bcbxCgROqwqZ3pq+8wTX47q
         l83TpIuIRJJQJ8PGulJrIrEIun7xMNFlssWFeXOdWojRktESwxk1n5Nu8g/kVJUxp2ZJ
         aiZxtRcbj6jwegOBiEyFSUj8+v4rN4nX65JWxRPDaxUO+WsgMm0gMlhbzRClB1TamDnj
         HyOxFb0te7SHbV5owLmugReJVAObYl2iJGVDhZMBw1Gs312Ro9I6Ypy8RaDmkgsfafTZ
         3fHA==
X-Gm-Message-State: AJIora9gdY8QMBriWyY1fA0Lq8IVRhh2G+kiE9H8U6YUx5KB1E6L10IW
        frfy6TRhRdp+5CMpSQmNwKpyWlmMXsgC6a8leGaxNQ==
X-Google-Smtp-Source: AGRyM1uHqnvIJBxT4WotSCiTKf4QgOwgX9iTtGWVCm8zxYBwAdFQ6zLSKghUSJtFA1K3vvl4KLaxsaGyT3iHiJHDlL8=
X-Received: by 2002:a81:7341:0:b0:31c:c547:ce02 with SMTP id
 o62-20020a817341000000b0031cc547ce02mr28948230ywc.108.1658136902849; Mon, 18
 Jul 2022 02:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220714020319.72952-1-warthog618@gmail.com> <20220714020319.72952-7-warthog618@gmail.com>
In-Reply-To: <20220714020319.72952-7-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:34:51 +0200
Message-ID: <CACRpkdansQBsda6E447Whv1MCcZcw85ySNsEt-noW28RMSdE-g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] gpiolib: cdev: compile out HTE unless CONFIG_HTE selected
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, dipenp@nvidia.com, andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 4:04 AM Kent Gibson <warthog618@gmail.com> wrote:

> The majority of builds do not include HTE, so compile out hte
> functionality unless CONFIG_HTE is selected.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

That's helpful.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
