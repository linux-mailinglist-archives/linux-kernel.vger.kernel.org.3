Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8959AD93
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343944AbiHTLis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbiHTLin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:38:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF02871C;
        Sat, 20 Aug 2022 04:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BA86611B9;
        Sat, 20 Aug 2022 11:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5BCC433D6;
        Sat, 20 Aug 2022 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660995519;
        bh=bbIuWX9FCmBU5zm1BMbNPSQGHmgBuPYgOyeviySP8Ng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QSAG70IaZuT42LuF6WAEbBfOmcMgfg/1cxbkPFlqS/tx5gwjsDYgnwoVYlI45qnBK
         wCDzrPPfhfZXQGlbizTIdIlx7IKDbPP26hBFpbXbARyz4yEwcKEzvfa4PnYwwxPz8j
         vzu0FqVbscYgvqPd5g1RJUuvEEEDOMdc0QFL8yc29hABiASGqtdBVINcqUZU4GY7cS
         qeMl9e8liIf57Hb8iPOEw9LVJpX3+46S1troomkP1IM5Y68ZqkuuV9s4jIY1S/3KL1
         1qWMQ9ftlW6RGtf5VCykp3XTAqSXpJ46zbOITwZBiS3aUTy3PpzJLYsO7w8BpTkAWg
         2urdTVmXcyUMw==
Date:   Sat, 20 Aug 2022 12:49:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v4 1/2] iio: pressure: dps310: Refactor startup
 procedure
Message-ID: <20220820124915.5dd5b745@jic23-huawei>
In-Reply-To: <CAHp75VfU26QZ7Z1ApzRcFPudgsQc7zWF5g0kwn7Jzk1htXaWng@mail.gmail.com>
References: <20220809211246.251006-1-eajames@linux.ibm.com>
        <20220809211246.251006-2-eajames@linux.ibm.com>
        <CAHp75Vf5wcabm_-oKGN2m7z=L2xu1D6wtzKLhu6n19Uhq8yijQ@mail.gmail.com>
        <e35b595f-572e-a539-c550-831cdd02dbd3@linux.ibm.com>
        <CAHp75VfU26QZ7Z1ApzRcFPudgsQc7zWF5g0kwn7Jzk1htXaWng@mail.gmail.com>
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

On Fri, 19 Aug 2022 12:42:00 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 15, 2022 at 4:42 PM Eddie James <eajames@linux.ibm.com> wrote:
> > On 8/12/22 17:03, Andy Shevchenko wrote:  
> > > On Wed, Aug 10, 2022 at 12:12 AM Eddie James <eajames@linux.ibm.com> wrote:  
> 
> ...
> 
> > >> +       rc = regmap_write(data->regmap, 0x0e, 0xA5);
> > >> +       if (rc)
> > >> +               return rc;
> > >> +
> > >> +       rc = regmap_write(data->regmap, 0x0f, 0x96);
> > >> +       if (rc)
> > >> +               return rc;  
> > > This code already exists, but still want to ask, is it really
> > > byte-registers here and not be16/le16 one? In such a case perhaps bulk
> > > write can be used to reflect it better?  
> >
> > The temperature and pressure regs are 24 bits big endian, and all the
> > rest are 8 bits. I think the existing approach is best.  
> 
> It doesn't look like you got what I was meaning... Or I misunderstood
> what you said.
> 
> The code above writes two byte values to two sequential registers
> which make me think that they are 16-bit registers at offset 0x0e.

Given they are undocumented, this is guessing territory.
Probably best to just leave them as is.
You could do a bulk write on an array though as that implies
nothing about what's in the registers -just that they happen
to be next to each other.

> 
> ...
> 
> > >> +       rc = regmap_write(data->regmap, 0x0e, 0x00);
> > >> +       if (rc)
> > >> +               return rc;
> > >> +
> > >> +       return regmap_write(data->regmap, 0x0f, 0x00);  
> 
> Ditto.
> 

