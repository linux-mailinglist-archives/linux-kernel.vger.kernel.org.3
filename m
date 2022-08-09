Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7464C58D579
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbiHIIhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiHIIho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:37:44 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B44E1EAFE;
        Tue,  9 Aug 2022 01:37:43 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id e28so176422qts.1;
        Tue, 09 Aug 2022 01:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5wAmAP/0n2nSTjV3vgB4RzL7PV/UfzJLwel1ipxqIUs=;
        b=AJAxzwloNzTJT0yDJAkW5/+xoS3P9cRbuADl2sHhOv6yw5X9QI6ZXDr7GD2KmGXmfx
         jkc3oT4UCArJfztSmx1vRg8FYjMj9hRSrcqtGKHv61JBlfRsxFhXL3IisMBY3wRUU34q
         226Dl5P5qDwo6FBzgAA/0YPdte8+EifuuP//li9r4XxT9DnsU2E1+USMgvEB3G8cSLY8
         AWk26bqoh5ra12u28RRoKFpoqaxYuafq0l4gOMHIdIOG2uIyrB3HOFsb62wWMk/QN40b
         53a0wk3/bR7PQ7IAJYrB/RfnYV2JjpC4D3Jf2mpeVHKCPnxpeDKJC3aw1qlSoaQu7sl9
         K1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5wAmAP/0n2nSTjV3vgB4RzL7PV/UfzJLwel1ipxqIUs=;
        b=U3CjU4DnhrtKbSJgorp3ZNuWNRoZnmsJqCCAAFAX+Meuy1c4T3N7Osn01F470OTrWk
         aAglWRy4nxB0zXtRfa2uPb/tRPOz6mmsURt5udSsZJL3qul7ShZBzyovvx5JM7RHv2wb
         XAWbAAua84ZtkdxXXBn7K4a/Vqw00OMEajZFHokEv1gLy28idJaQ7JFl+RcJQEhUlDSh
         yORDzPB8ZPC+Hmk/qsHzA4B/z6tvPKyeRZ8vT5pFn3l7auFlWbpKXta0XjPa91MWlYre
         oJn5cPtGuapV6PMozTdykpMhqH87y9nobsb0RTrFZcVtNSDU6tq+jqq5VLJuR0kw99mS
         R5MQ==
X-Gm-Message-State: ACgBeo0IiI7AVnj6wA3w3+7MYDY7TVkB6Yaff0N+LnnI8v+F6eaips0o
        UEdmdDBBE0rVoT8828xobCqG1NY/+MVWZ7DTOAU=
X-Google-Smtp-Source: AA6agR4xJCQOrsi1GnCSBL5Yt9nYhadTZlmUQYKq0QLFPrQRHzIijhlMSjxHtwf/1GcGLiOGX2PuX8nSYNlnT0ONDbQ=
X-Received: by 2002:ac8:7fd1:0:b0:31e:e9c0:c071 with SMTP id
 b17-20020ac87fd1000000b0031ee9c0c071mr19362497qtk.481.1660034262645; Tue, 09
 Aug 2022 01:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220809033048.1634583-1-luke@ljones.dev> <20220809033048.1634583-2-luke@ljones.dev>
In-Reply-To: <20220809033048.1634583-2-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Aug 2022 10:37:05 +0200
Message-ID: <CAHp75VdAMTUpWd9d+vq1_4CqyPYyKJy4dYRyDrgVCb5cJtPF5Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] asus-wmi: Adjust tablet/lidflip handling to use enum
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Aug 9, 2022 at 5:30 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Due to multiple types of tablet/lidflip, the existing code for
> handling these events is refactored to use an enum for each type.

...

>  static int asus_wmi_input_init(struct asus_wmi *asus)
>  {
> +       struct device *dev;
>         int err, result;
>
> +       dev = &asus->platform_device->dev;
> +

While the discussed pattern of splitting assignments is a good
practice, for some cases we don't do it when we rely on the guarantee
by the callers that some of the stuff won't be problematic. Here the
device is part of the platform device and can't be NULL, there is no
point to split definition and assignment (and you may find plenty
examples in the kernel), so

  struct device *dev = &asus->platform_device->dev;

is better to have as it's guaranteed not to be NULL and since that we
don't check it in the code anyway.


...

>                         input_report_switch(asus->inputdev, SW_TABLET_MODE,
> -                                           !result);
> +                                               !result);

Irrelevant change.

...

It also seems you switched to dev_err() here for the pr_err() that
aren't related to the change, either split that to a separate patch,
or don't do it right now. I.o.w. use dev_err() only in the lines your
change touches, otherwise it's irrelevant.

-- 
With Best Regards,
Andy Shevchenko
