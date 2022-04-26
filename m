Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D5E50FB43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbiDZKrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345505AbiDZKqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:46:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCC2D7F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:37:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gh6so11097617ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgFp2WaCcF7mJ1vuNaXuB9bhKVjzq7HvUAGwhn7dW2o=;
        b=fAg0bCxf7dUlqfw5lBDqk66wvXl2LyGt4wv17ktbe9wE9VjbHd1aUmSjjwgRzPp3rV
         HxvrSKcKT6itUQ5UuyaH71DEH/zndcazsb5c6ZWGWmougIKmqGh1o7EozzsIRb1uPsep
         wJPMh0fP+9qKAevhN/lSB1TrRqJbLl/+aPs54CEN+kzWBXjtGrH6DMmaWd0HNSpyLOvP
         /x2j4B4qzAdTm6GzbmU4kSDCoQkBU6QgAxpdWpTKDDAXIFKvPCHV98D7eCsP4T93osNh
         pjnDRVnQmnRRSo2diigglbw0dw/yT7IrR7fyMLoNBh8L7VsbxZePW8dRmN4zOeLTL2Gn
         +Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgFp2WaCcF7mJ1vuNaXuB9bhKVjzq7HvUAGwhn7dW2o=;
        b=ox0reIK/vDyi/okqEAwL+OThr1kxCyajnEveqx+N6vWq6D3VY+hCTPy9xQPM6z91D1
         rwbels+G7HfcdGnmBMY9ix3jyOwZk19/+FMsTR0MhsgIalCGbgaDvpevXxqaktR4ReLU
         dKaqlH102cg132kiiVoAfQfT1H3rjw65TAORCD8QzZFdl7Dlc2aLVzQgN79991F9RBH3
         rJmfXgf1MD5mhCQHpYihKg84OpR7/LFsMi2TwZOBNPmbit8V7znEBTA/UF/fiQ2g/UEq
         hpB/x3AHeHADfTUFhIECtb89OdTdy/jfVDybYKcyCDnAo/8I9pxqk530A61YEMJhtKaf
         0Ppg==
X-Gm-Message-State: AOAM530ujYmpSt43iaLIH8yFTheuA/etw6wfOrBR6edg5+GD4nOq3FWu
        nOG3pBJiKfZPzpWX3lYSH7v71SR/W/HtGN845VXIioH7m7yxTqXc
X-Google-Smtp-Source: ABdhPJzTXvRlV+WIN8e2ogRFUwOeqfmDUolzB484W3uEbhLAan9KK8JsmvmFWYbjQlPmMaJHh9L5HNPj0TKEDcszNlo=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr20352022ejc.132.1650969467772; Tue, 26
 Apr 2022 03:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2204241643030.17244@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2204241643030.17244@file01.intranet.prod.int.rdu2.redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Apr 2022 12:37:08 +0200
Message-ID: <CAHp75VdHnvv6FH1BKcs8WgGF3nJpj77TsrmsQGBSpsAQU_S-bw@mail.gmail.com>
Subject: Re: [PATCH] hex2bin: fix access beyond string end
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        device-mapper development <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Snitzer <msnitzer@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 10:48 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> If we pass too short string to "hex2bin" (and the string size without the
> terminating NUL character is even), "hex2bin" reads one byte after the
> terminating NUL character. This patch fixes it.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org

You need to provide a Fixes tag.

...

>         while (count--) {
> -               int hi = hex_to_bin(*src++);
> -               int lo = hex_to_bin(*src++);
> +               int hi, lo;
>
> -               if ((hi < 0) || (lo < 0))
> +               hi = hex_to_bin(*src++);
> +               if (hi < 0)
> +                       return -EINVAL;

return hi;

> +               lo = hex_to_bin(*src++);
> +               if (lo < 0)
>                         return -EINVAL;

return lo;

>                 *dst++ = (hi << 4) | lo;

And on top of that it would be nice to understand if we need to
support half-bytes, but in any case it's not a scope of the patch
right now.

-- 
With Best Regards,
Andy Shevchenko
