Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E80F5ACE13
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiIEIjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbiIEIix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:38:53 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF800FCE;
        Mon,  5 Sep 2022 01:38:52 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r6so5698919qtx.6;
        Mon, 05 Sep 2022 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AuQrh7BfHh8xgiVaDLsEto8fUgQEevMaumO2iYoCDsI=;
        b=X2ZQfF3Rbm5975bNdsmi/GXky6lUFvUmMqeXNvioXUoNKIa//Dus6yxvMcpvUjvEpw
         44YJD5VsjoDVGSyLgfJ+La8KbP2IIY5tpEDj2V57l5K/dlq3IwLG21NeFT8J0wWUGvJ4
         wNS3kxc+hD2eM7SgnYw8TG5UHJR1fjEZ/Y49FN/lmEuucYTeM18hM2zBeWmI0rum4DFT
         9g4XV6USzoIvKhYZ1X6/Xm/1QQdKZ9tSBtdDLAtb4NrdLkGleIparlSbQEom6Q0VoyzH
         EGVLdnNI0/dbUonpQivs9seKlD0JSvBbJAv57xV0KbVaJDMRTrf6YQNTO8ZjUS66XXYG
         h0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AuQrh7BfHh8xgiVaDLsEto8fUgQEevMaumO2iYoCDsI=;
        b=PPzQgbvLchYw8lZi6eM4hTi658Mr5yF/cX3V1z/539KO/iy2ICloJ4uvmS6MJeMF0w
         Yim1QrVSEbHi57kHG5XzZWBobSlvOZliCDw6mGXWaf2KwEaqEHMYanW1A13/BTv5JdSX
         7dugy11FpzJfp8jpEmgc7r/olxRJrTRZ1KLTsIGr7AIu7bc/1B5r8oiofn4vxDF9BjLQ
         fQB1IaGIIfpXW9gTy0goTpL2l012Sz/jUA0fcmSm0SFmityq2/cpgKBW+N46DAo8b/DX
         OredmQhSxJSytROkMZJ9bc0xAEVZiGrVP586gPN88FDsZXMCaCiuL+nWtQJkQugBAc6X
         YMEw==
X-Gm-Message-State: ACgBeo35GYrSt9bImW+3aqa7zTxaoR/tIxZikYFOWHMn0d9Mybm9LQ3u
        hPEFGRwjMq8/Ah73VIg8spd+EUVLQ9RkJTRvv2j5/Cr1t2IYiA==
X-Google-Smtp-Source: AA6agR7jr188dbfoobLWnZN4AuCM2oUT3aLVW/NZvvr8hKLO632FQ62ZbsmtRpslonLyaNz5yMYgbLRM2WRAzkiCQsw=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr38629794qtx.61.1662367131963; Mon, 05
 Sep 2022 01:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
 <20220831100506.3368103-2-vincent.whitchurch@axis.com> <CAHp75Vek8tLnwYWZO91HHr1_i7G_F9tErnRsq-GwfQcpR0FaTw@mail.gmail.com>
 <20220904171559.1bf77d42@jic23-huawei> <YxWzB/UdHYW6of/r@axis.com>
In-Reply-To: <YxWzB/UdHYW6of/r@axis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Sep 2022 11:38:15 +0300
Message-ID: <CAHp75VezEfe_WEN9kuRkA+O07gcyw9NVWYr273QQs4jb5azWyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iio: adc: mcp320x: use callbacks for RX conversion
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel <kernel@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Mon, Sep 5, 2022 at 11:27 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Sun, Sep 04, 2022 at 06:15:59PM +0200, Jonathan Cameron wrote:
> > I'm not keen to push unrelated work onto someone doing good stuff
> > on a driver, but in this particular case it does seem reasonable to
> > tidy all this up given you are moving the code anyway.
>
> Well, even the moving of the code is unrelated to the original goal of
> adding triggered buffered support and isn't necessary for that.  The
> moving of the code was only to eliminate the use of the "device_index",
> which was already used in the existing code.
>
> I'm of course happy to fix problems with the code I'm actually adding,
> but it seems to me that it would really be simpler for everyone if the
> trivial comments (especially the purely cosmetic ones) on the existing,
> unrelated code would be fixed by the people with the opinions about how
> the existing code should look like.

That's what Jonathan basically says, but with one remark that some of
the fixes are affecting the code one is going to add. In any case, you
may look at the "people with the opinions about how the existing code
should look like" at different angle, i.e. that those people may be
way overloaded while doing _a lot_ (and I mean it) of the stuff, so
from their perspective it's easier if somebody who is already working
on the driver can add a few trivial things which takes from her/him a
couple of hours to accomplish. In the collaboration we get the product
(Linux kernel) better!

-- 
With Best Regards,
Andy Shevchenko
