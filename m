Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CEA534194
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245479AbiEYQff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241078AbiEYQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:35:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A637A35;
        Wed, 25 May 2022 09:35:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rs12so31033146ejb.13;
        Wed, 25 May 2022 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CSaLCMHU9sgoW8Hv8FFo1g5ngLtMXqOmuV80kMnlXc=;
        b=HTFNx4OJRGTFhDTPcjrOXX23geTvBk+k789ME/QYQN8pz0Y1A9KH3UfhClU8O0Bewz
         socUuY2mg6e7g3ctcbEHZXSeHLAoB9iV2R34B+EJNvw5+8P+o3GHfQqD3gX2dhXj8TGI
         u95dHLM8+RcZRi4v7I9wire/pLMdjtHjd5jXGWKsalaiOTU2JmhD69s5c4vCGbpDGH9/
         CA2Kex7i/ungkqJy7i7sjgMzCYlhrDX1BbENBCvInRaaLHygnUheMYJABHmwSVhnJWah
         cOpRbD+g/KKdkcCSNNUxhHf8UP8S/6tz20YEuS25ifa/lKLqR58U5eaQliXdG4JZZRVe
         caFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CSaLCMHU9sgoW8Hv8FFo1g5ngLtMXqOmuV80kMnlXc=;
        b=sr4pBGOENQD/aG69q8nuwk/OUgauHr6H2xGg/JG01pdt1NwqmLn/wi3O6i2l+iBUG6
         RojOuoS1Aa6kpUlvGQ7Tvvu3kH+w8Dc79UAYWRGo1lz5ITnB3P1OWa4goi7xIeJRqmL5
         QbtkKcakPZabj2BZhOKM5spr5VJXF4dsXg1FV4TgZCwhRE6f6bZGJD+y1ZlRNXHr7RpS
         Mc6W91Z4INu7+1GdFxkkqifVW4hZCkFvj6bjU3Vuj2bd4waGlE3VYZOLleGm0aKnb1PI
         cmjT3tEPdoEfKWvD2NJ4gTxULT4vQaKK+VRvWJBDdApW9xQOqFxq8acTxYV2bmlW76HW
         HIew==
X-Gm-Message-State: AOAM530ZBsbzyxg799lJ2HT86KJjf0cI5CNmhu73Xx5rlJ3J7jcoGZHd
        BxSI5kkbH6iJople7yVHNheILWW3ukRmHMAzToU=
X-Google-Smtp-Source: ABdhPJz2oFhmLbXI7q4YttO3d+hj4nHWqo0xTlRmZ81PvoipASKXCjDuKaobeLkcabb+hC8IYgphCG96+ZG6A6C6xCc=
X-Received: by 2002:a17:907:2ce3:b0:6ff:1447:d3a4 with SMTP id
 hz3-20020a1709072ce300b006ff1447d3a4mr3221141ejc.497.1653496530907; Wed, 25
 May 2022 09:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220524201729.39503-1-eajames@linux.ibm.com> <20220524201729.39503-2-eajames@linux.ibm.com>
In-Reply-To: <20220524201729.39503-2-eajames@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 May 2022 18:34:55 +0200
Message-ID: <CAHp75VdmDWgCMDZMywhF0nSsR7HjYZj56jPtXw=43epBkniroA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: pressure: dps310: Refactor startup procedure
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Joel Stanley <joel@jms.id.au>
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

On Tue, May 24, 2022 at 10:35 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> Move the startup procedure into a function, and correct a missing
> check on the return code for writing the PRS_CFG register.

...

> +/*
> + * Some verions of chip will read temperatures in the ~60C range when

versions
of the chip(s)

> + * its actually ~20C. This is the manufacturer recommended workaround

it's

> + * to correct the issue. The registers used below are undocumented.
> + */

Yes, they are in the original code, but you may just fix while at it.

...

> +       rc = dps310_temp_workaround(data);
> +       if (rc < 0)

These ' < 0' parts are cargo cult, I believe.
That's why this makes code longer and confusing by "what is the
meaning of the positive values here?"

> +               return rc;
> +
> +       return 0;

That said,

  return dps310_temp_workaround(data);

should suffice.

-- 
With Best Regards,
Andy Shevchenko
