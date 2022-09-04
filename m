Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFC65AC63C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiIDTuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDTuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:50:12 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B04823167;
        Sun,  4 Sep 2022 12:50:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c20so4976149qtw.8;
        Sun, 04 Sep 2022 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PPfkQm8NNB1xxEVgujz8sY2zHs93/Mg3JVXZu2/nhoE=;
        b=fLW5rs1cND7l8wMp30gWpEONB1/oIBWF1Wg4hZcr88lQdtKeW48E6Y6mLqEmZvV0ia
         tupES7bDnhezg7s2S6XDddcHfdTTC/ex7jrZCPxmtOGS2/E1+iMJgE36DrH8M11vTmtL
         0t7mT150I0QO5XOxQkd++h7Z/b5/0TANjC+RZVxmjQerzDKo85+49y5vPovQtbisrbPq
         i0fEjq3mTnx431o72RGg0u3mO6lAAtiM7LGQAD7HfbGG5w572ardCj3oC89obc2sP3a6
         zAtsbFTtrzEw8Y8VmKOtP7sujzuXRTJ9FplSP42eQbV9LPjQLclFf3GH9IZ0NJ8WX5Hl
         R6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PPfkQm8NNB1xxEVgujz8sY2zHs93/Mg3JVXZu2/nhoE=;
        b=dz2CT3aK+gDJ8ktVm6ucRm193ghDGwOa4CZ0zVoWT0Mi7fc5roDqVaursaa26mnb6O
         1NLX2d1LjgQHkFM6Y36BWv9en0E3oeuCXu46Uf0gW0Hx/i8N9jZaTH8oSdBFE9GMKcr2
         82Y3JIC0jmNnHoNGWSTrQ68mMCS2gZwn+12+WlHaxleNB/PXfzAo1nUkvFhWCIgD9EAK
         ihQadsFZ5Rd0NPqc2WyaZKw1+MU3DpvgHGYiWzbSTB2yov9SV8Xixy5yz68TTPFssQu9
         33Xk5l/reOXFnmZghOe4Xe4T1F+LbOM8tuEusWzaHjAVBjrn5DRV3Y165GqzYOvVx9HW
         Fkcw==
X-Gm-Message-State: ACgBeo1BLbv3QTsPh/NjCorTFrE6tZnAc9nYVxlTZDDNj/Sj8VgqFOGX
        CcsqyWFCQiAwg/iY12Qj+j5pVrdoKmRx1atzmgc=
X-Google-Smtp-Source: AA6agR4hc/rPnQNNG62T1S7K2jmYKFLKYzreXh9EChGqDaIJOmq1fH1rfD8sM5NjynE8Y26XXgbgy/kmTrdB6Y5diLY=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr37068281qtx.61.1662321009265; Sun, 04
 Sep 2022 12:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220831133021.215625-1-ramona.bolboaca@analog.com>
 <20220831133021.215625-2-ramona.bolboaca@analog.com> <20220904165003.192d5030@jic23-huawei>
 <20220904165145.39cb4f75@jic23-huawei>
In-Reply-To: <20220904165145.39cb4f75@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 4 Sep 2022 22:49:33 +0300
Message-ID: <CAHp75VcszDjWXhjX+E7Xe0a=1_2tVpLNk8UWaAP7p=dKGMCUdw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: add max11205 adc driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Sun, Sep 4, 2022 at 7:31 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 4 Sep 2022 16:50:03 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Wed, 31 Aug 2022 16:30:21 +0300
> > Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

...

> > Given the requested changes below and those from Andy and Kryzstof are minor, I'll just
> > tweak them whilst applying.
>
> On that note, applied to the togreg branch of iio.git (with changes as noted)
> and pushed out as testing for 0-day to see if it can find anything we missed.

If you are not too lazy and have time to tweak one completely minor
thingy, see below.

...

> > @@ -81,12 +81,12 @@ static const struct iio_chan_spec max11205_channels[] = {
> >                         .endianness = IIO_BE

+ A comma here :-)


> >                 },
> >                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > -               BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > -               BIT(IIO_CHAN_INFO_SCALE),
> > +                                     BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > +                                     BIT(IIO_CHAN_INFO_SCALE),
> >         },

-- 
With Best Regards,
Andy Shevchenko
