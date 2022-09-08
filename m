Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF885B1694
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiIHINB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiIHIMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:12:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7694FDAB97
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:12:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 29so18051146edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CsfLF9evkjLMWhZzbrS1cueTNnTYWxzmyf1KcBcwPJY=;
        b=YVwlNQvyhCelbiE1ndTP9itm1PgEu1I4mLf5jDtXzgOlwCvy2MLWSEDYYWr2Gy6Uq7
         u4awXYI98ftADXwkYE03yV1XCVXFQNO4ThcU3N23O7CZ/gr3NAateb/hGOhjFC8B6/+x
         UBeNieHXcKfM5UAYZxa5I/ua2+ZbD5cbtnZk19OPRehwKA58kZLGsh3cfIRMsYWVvKZq
         f6+vJhEQtb1MEAk/U5yFagPatlaXbTideDeoSmdhIxxntr3yl5fu4vg1/YtTbNmcm4Ne
         6m6aeNHS3Vkbr1IeA347uA13wemsdXSkiEiVmrHI+LNAG8WHqw34n12N9BRU6weF6nEO
         hI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CsfLF9evkjLMWhZzbrS1cueTNnTYWxzmyf1KcBcwPJY=;
        b=lrCvxP+EKfUMXpnpICl8A07IkmIQrbVvOlQ8VhviU5UiK+7EkxZf4So3/Wkkb/dLn7
         XDg0OMfxqI7QdqaE3sKi4Zg9Ygp3xKqTKzEwm4ccn8Xw36mZWgDhbbJal12J77vIrKro
         3YziR5OJDB6FmNC1gE09dceDIazcQHr/yO+bSM2vWASpjpiz0cdgm6BDiMEz2Mn/7YlC
         zerLYeZoDPKtO8jrBXaX8UwlyNLODtMyrD7416AeiRY/eSzJ+gDiP0GqqJ5Q2UZ3TdXr
         Y6EyK/hcW3N3x7dXl5AyhoMWjsS0wVmznWoZkfNND3hb8vRI8P0sqzZtaXEnVUIUaKdf
         MPmA==
X-Gm-Message-State: ACgBeo2fUG7l73o8LmUksmmD7JjJRTWixeIJHeQh4DAClaD+IvkFSogq
        5JiiSiDfnKSealaWXwC71tdmB+Dia50eLW5+YO247Q==
X-Google-Smtp-Source: AA6agR6kg0wMenXTo0aj9ChZKdkYWULOi4m/7fUqfh/BdsmVb2bNbAqHgKqED0NA0TgTW0WakKx8AewS4OJyCfI1xSI=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr6087320edb.133.1662624720431; Thu, 08
 Sep 2022 01:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220905185102.74056-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220905185102.74056-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 10:11:49 +0200
Message-ID: <CACRpkdbFZu1Jkj8dyPwbnHRCmOsoMLZ2ZR=RrbzC+YOjMq9b5g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: ingenic: Switch to use fwnode instead of of_node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Sep 5, 2022 at 8:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied.

With all these patches I will probably just apply them and see what
happens, it's low-risk stuff so I don't foresee much problems.

Yours,
Linus Walleij
