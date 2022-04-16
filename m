Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB11150373D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiDPPCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 11:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiDPPCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 11:02:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CC33982A;
        Sat, 16 Apr 2022 07:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1536B80022;
        Sat, 16 Apr 2022 14:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A48C385A1;
        Sat, 16 Apr 2022 14:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650121169;
        bh=coBVcfYih5I6hNLMXKgpnXIwmxAmuuAnGjxElFDCC5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L9X/6vJ0A+BCzGCKNnz5PM6lwcEJk7+//9QuwSyN/94PKlN2Gujo83fcwl3mG0DKP
         OSVpNLT7H/yRzaZxxA4YxjFprW/+G0a3ciAO83tuOzpwYP6Mk+oB0buiepDmQ9y6jP
         hBzE3r97sHzMXzhwxi3WKsrwvILduESMHzBIog0IOzRDbxQQtYSmVFfsbSPH9jNY24
         R4HLNaTvcAGVy4zhbcvMZudjn455bxhtkNUlrB7TDG8+gVgrw4uEq9cFFk39p4zlfZ
         OG4baSddFuIe5HXQrgj32tzEwirME3zoq9p4QByBQ9Fk54dyXeHOF6ZsCNWb4Kwnbz
         A/Y3ex3klYt7Q==
Date:   Sat, 16 Apr 2022 16:07:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v1 3/3] iio: adc: ad4130: add AD4130 driver
Message-ID: <20220416160725.51f0b8f0@jic23-huawei>
In-Reply-To: <CAHp75VeYX_ZWZPEUwpfaSGUGCayCaMapS-5MHhgT1r17Fqqoeg@mail.gmail.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
        <20220413094011.185269-3-cosmin.tanislav@analog.com>
        <CAHp75VfzX8u45J3634yN5p-QTeT7w0Bos27OxeWOsb3MQ2VRVw@mail.gmail.com>
        <80196942-4c33-7625-3945-86ce5b7b347f@gmail.com>
        <CAHp75VfAjvJz2KHYfDM+-8D+hSBtdKJm521EBY3VgCfUsAgt8Q@mail.gmail.com>
        <0823cf19-60b5-3050-0e26-04b87a7ce5c0@gmail.com>
        <CAHp75VeYX_ZWZPEUwpfaSGUGCayCaMapS-5MHhgT1r17Fqqoeg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

> ...
> 
> > >>>> + out:  
> > >>>
> > >>> out_unlock: ?
> > >>> Ditto for similar cases.  
> > >>
> > >> There's a single label in the function, and there's a mutex being
> > >> taken, and, logically, the mutex must be released on the exit path.
> > >> It's clear what the label is for to me.  
> > >
> > > Wasn't clear to me until I went to the end of each of them (who
> > > guarantees that's the case for all of them?).  
> >
> > Let's hope other people looking at that code will be able to figure out
> > what that label does then.  
> 
> OK. Let the maintainer decide.

Slight preference for giving the extra info of out_unlock, but not critical.
(note I haven't read the code yet so might change my mind :)
