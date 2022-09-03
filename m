Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFFC5ABE5D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 12:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiICKAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 06:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiICKAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 06:00:14 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A613357C2;
        Sat,  3 Sep 2022 03:00:12 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c9so3455326qkk.6;
        Sat, 03 Sep 2022 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eIvSaUS74WCbxqQm0wgPs0M7RkM/w20HZGOfg7cVeFk=;
        b=hd3p6+efVudsTYMcznatjZDKB2UTlcameqXBLdQNKEiChBpwpDjjUUo97j9ncaGdb2
         AqgBQHDnDiNCLesO5ANYzzzxg9uLaDSjZuZMdQyxO5+va4gu/u9IAtJfIcVF97eouQh1
         gDrCOJtSmN7RzZmW07ybvdQbMRLNnyY0QcgPOngzEqN7F/wSRYNNMonKPoD8xPgtZfEu
         n0WwR6M13YqdjY3Xhu7y9qGpUOOWa5Kcywh5aNU7NZFyl0hCRX51jHkUcibPBztUD3Uz
         xZ2AXyNShyrfwzNziA3rYf+vOynvCINCWhhRoCr/wZckmDuOYNre1ebNBNIKciwKY7z9
         GlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eIvSaUS74WCbxqQm0wgPs0M7RkM/w20HZGOfg7cVeFk=;
        b=TzvjGvg/e5Fdu7kkxcu6NlWshXQ4K/ORlIUEu27XLkbSvyWr160i1doDnMNekR04BX
         vd+MMWOpVzLC0HRm61/x5p4qY7BCcZf8bFnKiVLiWpZe22478ImBgo5mtUYMKVebpGdD
         jXfYfJLTcvjRZHRd+gu5zYIUR9zK5TVlQuQ3rXLfu8s3uT1phTlcPYkzYtyAEXtnxqPp
         Y8a9wH0eY6gEeUgsx11RXC0kUnJOgLWcMbfrHe36yC6tQgAvrZf9nNRZeTArnzISU3gA
         PfMYTlrMNMi2ly2dCv70KcAKJ6RcT65d7JNNtYTsXwIyaqSsEDpCUrGfW6aa6cL/C2Z0
         Xa/w==
X-Gm-Message-State: ACgBeo1fd2S1ByzXdVWzuIJVS1SwNVgQBXEGwgEpQVvMw2Ee9g3Z5T/x
        uIPGXq0zg43Bap38ztK/wsaXF6swKg3aCXIVm64=
X-Google-Smtp-Source: AA6agR7bc0aNf1qMTLPs6ApPcKggpasv5/RD+VFeZKCP1aSbFPW5yXsOJaJNTFz0drsemN/PZ1mBnK8SevsrbKcvciU=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr26106520qko.383.1662199211678; Sat, 03
 Sep 2022 03:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
In-Reply-To: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Sep 2022 12:59:35 +0300
Message-ID: <CAHp75Vf5Law7suOPRW=LGrBacv=WfFBmhOae+frBdj46dT-KCg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Get rid of devm_fwnode_get_[index_]gpiod_from_child()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 3, 2022 at 3:59 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> This drops the last uses of devm_fwnode_get_[index_]gpiod_from_child()
> from the tree and drops the stubs implementing this API on top of
> devm_fwnode_gpiod_get_index().
>
> Note that the bulk of users were converted in 2019, the couple of LED
> drivers are all that have remained.

Full support and green light from me, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. More of the similar is welcome, if you have any!

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>


-- 
With Best Regards,
Andy Shevchenko
