Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D710E570CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiGKVk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiGKVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:40:32 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF17B82476;
        Mon, 11 Jul 2022 14:40:31 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p129so10903211yba.7;
        Mon, 11 Jul 2022 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WXGVf+2tuAj3uofTzTDl9Nu+93xLPaAii5ahlG7W0MA=;
        b=POOCRfsPZxxYrEViLeDA3lxLejG8T/bs8vjtPZthkQH8g7i0/vwFTdNeXzQ7QifY/C
         5Gr7R2TyHHlggPgBbsaXQRvuPiKg/T1/HaAINI0L3+s6/nMaZBtdnszD4QImEZOjB5BE
         HJflEKUh6+wGJbn1VYqbIVNyDWxMTf1TOtouoQvjzFm0mMhrHc2jKIm9rA7ZzKScFlXx
         LnWUaxDy8ZB+QIZxugEI5PSw9xUXa9mnNTbWxkrn4LxQghXlvzzLCq1MFtsgrRQVN1lb
         bNTrcoAdGBcfsQz+J7Sr89Ce676ejI2rw1a2q6FcxdQHZTo2dY7AVNEA6F4mgLKjPkRP
         iD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WXGVf+2tuAj3uofTzTDl9Nu+93xLPaAii5ahlG7W0MA=;
        b=XQSK2Zba4xUM8Vw/e6leXz/YAa9vnM1ihLLRQgs7n1YLfUzVxtzq+WYMgf3MpKYej8
         M+vsgjMQ8KuMIpmfhVHSaBOxEozrb30fuk22CREcMcFFzWZf3buF5C4XgBFrIWniDEQe
         DskLO7PQ7bmsjc8pf/lRYw55kK5JkzWynNpCX00qIBGAc9LoxjXrFYcnxQOtrHH9KsBM
         na6O1ZxoGqfXOnF5x5nVme/rblwjqFu0Sdgsj+FXHVuPbTzO6zMWki/wdjInFyP97/tq
         0iwzThGiqGtdR7sRWmQ5ZIZou1mIMHf5lMwqFEi1/JikzMaLEL56IMwlWlnAnwta1s+m
         TFZA==
X-Gm-Message-State: AJIora92x07Z9Td2mcCnoHTPIOGCH4HjkJ/f40GOvD8CyWjv2yl6zPjJ
        UHGet1ZDRHlnrL3gNn+gk8yPtCwvhyHB18aq4BHaijh0hvpWRw==
X-Google-Smtp-Source: AGRyM1vqQ2c8wQbiYnP03ocIErTPk6rkg1tXEoDd7teFxTeS8GknWfw/k0AXbeIbhow9sIlKjeb5s+zx2rD60GED7rQ=
X-Received: by 2002:a05:6902:1143:b0:66e:eb08:4c23 with SMTP id
 p3-20020a056902114300b0066eeb084c23mr13930705ybu.570.1657575630059; Mon, 11
 Jul 2022 14:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220705163136.2278662-1-vincent.knecht@mailoo.org>
 <CAHp75VfwoSqLZVbsN3DduP=SEKvr=tSfmxF1MTnYma0zh-JsXQ@mail.gmail.com> <e17913649e255d91bc357d3ab3e70957d05493e6.camel@mailoo.org>
In-Reply-To: <e17913649e255d91bc357d3ab3e70957d05493e6.camel@mailoo.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 23:39:53 +0200
Message-ID: <CAHp75VdcT4TRZU_w-cntTt3jYTnwADcUo055vWLM8xrkWTXChg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] leds: Fix/Add is31fl319{0,1,3} support
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 9, 2022 at 11:51 AM Vincent Knecht
<vincent.knecht@mailoo.org> wrote:
> Le mardi 05 juillet 2022 =C3=A0 20:57 +0200, Andy Shevchenko a =C3=A9crit=
 :
> > On Tue, Jul 5, 2022 at 6:32 PM Vincent Knecht <vincent.knecht@mailoo.or=
g> wrote:
> > >
> > > v3:
> > > - pick up Rob's R-b for patches 1 and 2
> > > - reinstate bindings docs license and maintainer
> > >   changes with Nikolaus agreement
> > > - took Andy's comments on patch 4 into account
> >
> > Thanks for the update. Nothing serious, but a few comments.
> >
> > Also a question here. Do you have plans to convert it to use device pro=
perties?
>
> Hi Andy, and thank you for the reviews.
> Just sent a v4:
> https://lore.kernel.org/linux-leds/20220709094642.4078222-1-vincent.knech=
t@mailoo.org/
>
> As for converting to device properties, it will take me some more time
> since I'm not too familiar with the concepts and how to do it exactly.

I just sent a series [1] which is based on the top of yours. You can
rebase it (it fixes a couple of subtle bugs: 1) GPIO error messaging
during error probe, and 2) mutex destruction is out of order) or
handle it together with yours. It seems you possess hardware, so I
assume you at least can test it.

> Got some hints from git history, will look into that.
> Also I'd like to add blink support...

--=20
With Best Regards,
Andy Shevchenko
