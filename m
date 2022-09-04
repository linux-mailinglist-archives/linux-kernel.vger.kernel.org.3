Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02005AC507
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiIDPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIDPaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E0E2B63A;
        Sun,  4 Sep 2022 08:30:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B218760FA6;
        Sun,  4 Sep 2022 15:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CF3C433D7;
        Sun,  4 Sep 2022 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662305406;
        bh=hOhC3aj6/CGi+YEG3NgjPbtkba6VrznLEWM20iom+j0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O1fjy5v7OXgDpixpiZk/uDXR9xvfbtknx2OcvAnpfnHnGjJwCVK/9dc2rSX/g0ejj
         /Ag1GRFrsYXKIPAWI8PiqCPltkubLCYZ5HhwAa+Vnh3gItVNHz7bxgBl9x/BziGK33
         PbeI3lUtO9U3b6yggNHRc+UsyX/LodjUo7M/b5INCclvfQQCclJm4CKRk4hFJWJFXI
         R3adzftpsxXqpdqC6FOUUjA43FrCA7pWpKhG9R8zrkRalj9ZLOPTP8qB+ucfhG/0b/
         ULy7ArWxjBAne7Jn9PzoMVyJHB9cuIMxKhpMBS/UoAeZWE+V144O4MeWfJlIXsozOI
         5+i0qLNw6SnWQ==
Date:   Sun, 4 Sep 2022 15:55:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] drivers: iio: adc: LTC2499 support
Message-ID: <20220904155557.33c96d66@jic23-huawei>
In-Reply-To: <CAHp75Vfn_84-xww5w_oHf0zqm4dZxycSU1cDKw7-KQzDyoCHXw@mail.gmail.com>
References: <20220901121700.1325733-1-ciprian.regus@analog.com>
        <20220901121700.1325733-4-ciprian.regus@analog.com>
        <4067432b-b5a6-f3eb-a707-5fa298ba846b@linaro.org>
        <20220902120611.000007a0@huawei.com>
        <CAHp75Vfn_84-xww5w_oHf0zqm4dZxycSU1cDKw7-KQzDyoCHXw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2022 14:37:03 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Sep 2, 2022 at 2:06 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Thu, 1 Sep 2022 16:23:09 +0300
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:  
> > > On 01/09/2022 15:16, Ciprian Regus wrote:  
> 
> ...
> 
> > > > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf  
> > >
> > > Missing blank line. Use standard Git tools for handling your patches or
> > > be sure you produce the same result when using some custom process.  
> >
> > My understanding is Datasheet is a standard tag as part of the main tag block.
> > There should not be a blank line between that and the Sign off.
> >
> > +CC Andy who can probably point to a reference for that...  
> 
> Yes, the idea to have a Datasheet as a formal tag. Which is, by the
> way, somehow established practice (since ca.2020).

We should probably add it to the docs so we have somewhere to point at
beyond fairly common practice.

Hohum.  Anyone want to take that on with associated possible bikeshedding?

Jonathan

> 

