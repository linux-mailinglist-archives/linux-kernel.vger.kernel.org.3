Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184BA5A5305
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH2RWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiH2RWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:22:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F0274DF8;
        Mon, 29 Aug 2022 10:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93E07B80B8C;
        Mon, 29 Aug 2022 17:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38600C433C1;
        Mon, 29 Aug 2022 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661793715;
        bh=XrplDPQ8UTAXX6VsmmOcv63Bxz1cFoVo/yyz+x0kx0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ogjAob9zUvKKOvxWfsX3D3DSadfpRqW1j6s6iRdf1LoQZhBHkzsrRQ80z6wMjUIJd
         sBiBf0RKTrjUlVaG0CjJ+TRMQIqfGyPY5gaE0J+2+JO7pnXInZDlCiGGsJVrVrYTw6
         4aOAezpv5hb7Iz9DGmj4+Z2KENj6K8LHFfWmEYC273TCu/SMT4aN7kzL0LHAdWoRhB
         W1woaUUUzCZXjPfBxKrLo/eNP03ZxXgmqo+OXwWWNUVjNu83qjSMud5IGYDEtCKtox
         SNVT+wRnkVxH4NVEIoCiVVtY85NA90nZFBw0gbSXoc7F2EMgM+aLiHD46TOWS5SRt+
         iJkHXBM1W+vkw==
Date:   Mon, 29 Aug 2022 17:47:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Regus, Ciprian" <Ciprian.Regus@analog.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/3] drivers: iio: adc: LTC2499 support
Message-ID: <20220829174737.3192f5a7@jic23-huawei>
In-Reply-To: <e13827526235412585f8b7d60257c5a2@analog.com>
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
        <20220822125106.1106798-3-ciprian.regus@analog.com>
        <20220822203731.29c4c33b@jic23-huawei>
        <CAHp75Vft2pvXtxZcpvyV38cR9gOdDxDfCae8g5Uf2q6npWpb+Q@mail.gmail.com>
        <e13827526235412585f8b7d60257c5a2@analog.com>
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

On Mon, 29 Aug 2022 06:30:52 +0000
"Regus, Ciprian" <Ciprian.Regus@analog.com> wrote:

> In reply to one of Andy's questions.
> 
> > On Mon, Aug 22, 2022 at 11:13 PM Jonathan Cameron <jic23@kernel.org>
> > wrote:  
> > > On Mon, 22 Aug 2022 15:51:05 +0300
> > > Ciprian Regus <ciprian.regus@analog.com> wrote:  
> > 
> > In reply to Jonathan's comments to answer his question and add more
> > comments from me.
> > 
> > ...
> >   
> > > > Datasheet: https://www.analog.com/media/en/technical-  
> > documentation/data-sheets/2499fe.pdf  
> > > >
> > > > Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>  
> > 
> > Tag block mustn't have the blank line(s).
> > 
> > ...
> >   
> > > >  #include <linux/iio/iio.h>
> > > >  #include <linux/iio/driver.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/property.h>  
> > > why?  
> > 
> > device_get_match_data() requires it.
> > 
> > But why not sort them?
> >   
> > > >  #include <linux/mod_devicetable.h>  
> > 
> > ...
> >   
> > > > -             *val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);  
> > >
> > > Old code here is less than ideal, should be reading into 3 bytes then using
> > > the be24 accesors. Please fix whilst here.  You will need multiple paths here
> > > depending on size.
> > >  
> > > > +             *val = (be32_to_cpu(st->buf) >> st->sub_lsb) -
> > > > +                     BIT(ddata->chip_info->resolution + 1);  
> > 
> > Shouldn't this use some kind of sign_extend()?  
> The BIT(ddata->chip_info->resolution + 1) subtraction part is already doing the sign extension,
> since that bit (which is the most significant one) will be 0 if the result is < 0, and 1 otherwise.

This wins the award for one of the strangest formats I've yet seen.
The format is normal 2s complement 24 bit, but with a bonus upper bit to allow representation of
ever so slightly more than 24 bits.  Specifically on the postive side the out of range value.
0x7fffff + 1 = 0x800000 (which would normally be considered wrapped around to most negative value.

and on the negative side as well
0x800000 - 1 = 0x7fffff (normally most positive value).
It does this by throwing in an additional bit for sign which only tells us something useful
if in these two edge conditions (which are really an out of range error).
That bit corresponds int his case to
0x1000000 and is set for postive values only.

Thus our VS+ value becomes 0x01800000
and VS- value becomes      0x007fffff 
(extended to 32 bits for reasons that will become clear)
Applying 2's complement subtraction of the magic value above.

0x01800000 - 0x01000000 = 0x00800000   (2^23)
0x007fffff - 0x01000000 = 0xff7fffff   (-(2^23 + 1))

So it is indeed sign extended by the above.

Perhaps a few comments to set people off along the right path to what is
going on here would be useful?

Jonathan


> 
> Regards,
> Ciprian
> >
> > Also with a temporary variable for chip info this line can be single.
> > 
> >    struct ... *ci = ddata->chip_info;
> > 
> >    ...BIT(ci->resolution + 1)
> > 
> > ...
> >   
> > > > +     u32 resolution;  
> > 
> > Keep this in a way that the "longer lines go first".
> > 
> > ...
> >   
> > > > +     resolution = st->common_ddata.chip_info->resolution;
> > > > +     st->sub_lsb = 31 - (resolution + 1);
> > > > +     st->recv_size = resolution / BITS_PER_BYTE + 1;  
> > 
> > BITS_TO_BYTES()
> > 
> > ...
> >   
> > > >  static const struct i2c_device_id ltc2497_id[] = {
> > > > -     { "ltc2497", 0 },
> > > > +     { "ltc2497", TYPE_LTC2497 },
> > > > +     { "ltc2499", TYPE_LTC2499 },  
> > 
> > Use pointers here like you have done for the OF table.
> >   
> > > >       { }
> > > >  };  
> > 
> > ...
> >   
> > > > +enum chip_type {
> > > > +     TYPE_LTC2496,
> > > > +     TYPE_LTC2497,
> > > > +     TYPE_LTC2499  
> > 
> > Keep trailing comma.
> >   
> > > > +};  
> > 
> > --
> > With Best Regards,
> > Andy Shevchenko  

