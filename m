Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D116507C32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357611AbiDSV4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbiDSV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:56:34 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55EC3E0E1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:53:50 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2f16645872fso86656917b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMSaAwxjrjiNU3osIbQVVRSLlzO7/jouyNe34lSDVJw=;
        b=kAI9LaEhHQzB9C8LRXYvLx7AzwTC1CilCLFWUwNhegBjdSI8VYhgrRl31FAore9MBR
         LiPei2LuFfF1nxtcKoA0sB30YxgVacMITMOSyt913xPd2wxQDHwgM7sZiaYqMN012h+h
         jaOAKXIeDCd7KSe6iElTB+sOKWIfLBlgC9NG4C9fJjNNpGNqKfuWqEu7L7V/9lcVcXDH
         CcLelVAuzR4syJmPg8n7RtliwnJ8XrnCkoYG+6u7rlAkXKi+rzFVE5lIe7pr7vQv+0Yf
         IvYb7qb38BZvsas9+N9fo5pV2MvtcdJeHBMvpu+r01JEzoyrsj3l9xqeXjxM1ow15U3Q
         /o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMSaAwxjrjiNU3osIbQVVRSLlzO7/jouyNe34lSDVJw=;
        b=CUU/it1l1cZzujteU2SbyZWLeUWQgz3KN6oQpc13Y+uiDoOhUbxF4auFdmdRc8CNTh
         EGGIg/3t1yHjgXMqbJY54q/cu/QANEeQVcKGVzm7gkbADVgqjKh7/K0bJOQlHr51EE+9
         KNYbK8ADtZuXmh0kVHTHpGO/K0tofOkmcpbWV4YfkcSsHDCtdDOkOQLs6OJjEyzFZwu2
         QlOtbygPpxxS2tzAk0jW7MehgY5zESeK51saW9jF9aYN8HhVSDxzh6VDB/kFawE5Jn/U
         Nxs9PXtohZPl3PKzNqt6XIkHlc6PvMwBTcnWq7t3BTtiiYqBXzd3SlD9lWv+6WmoV4IA
         yssQ==
X-Gm-Message-State: AOAM5337l3jMo0EOvQAtvqqiancKHGzywvMXoE2uvSmop52WRpYZjnxH
        6iaI8l4tv/jBmbICCrRlkJdCiw7Z4utUgGtRLHfJDA==
X-Google-Smtp-Source: ABdhPJxLUQfrNE4OV5ZCsc+xOfrP2lvSC3nJxjsNYdmZ2zSGKKW1xN1z0ZGL1QAijqAvI8A4GYTYH2KxI6CSUWgAyAY=
X-Received: by 2002:a0d:ea46:0:b0:2ed:62f4:e23c with SMTP id
 t67-20020a0dea46000000b002ed62f4e23cmr17946391ywe.437.1650405230087; Tue, 19
 Apr 2022 14:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220415070710.220785-1-andrei.lalaev@emlid.com>
In-Reply-To: <20220415070710.220785-1-andrei.lalaev@emlid.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Apr 2022 23:53:38 +0200
Message-ID: <CACRpkdYYA1CtSz_w8aioBC7FLgkEjO_Wk_XuL-LwLmpCouNfeQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: of: fix bounds check for 'gpio-reserved-ranges'
To:     Andrei Lalaev <andrei.lalaev@emlid.com>
Cc:     brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 9:09 AM Andrei Lalaev <andrei.lalaev@emlid.com> wrote:

> Gpiolib interprets the elements of "gpio-reserved-ranges" as "start,size"
> because it clears "size" bits starting from the "start" bit in the according
> bitmap. So it has to use "greater" instead of "greater or equal" when performs
> bounds check to make sure that GPIOs are in the available range.
> Previous implementation skipped ranges that include the last GPIO in
> the range.
>
> Fixes: 726cb3ba4969 ("gpiolib: Support 'gpio-reserved-ranges' property")
> Signed-off-by: Andrei Lalaev <andrei.lalaev@emlid.com>

Nice patch!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
