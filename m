Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6586659A530
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350172AbiHSSEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349807AbiHSSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A53F63F2E;
        Fri, 19 Aug 2022 10:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA4876186D;
        Fri, 19 Aug 2022 17:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C1EC433D6;
        Fri, 19 Aug 2022 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660931392;
        bh=XMlk3D/uGMkXZBaYH68xGUpyRvK9o5OVs002Yxl4T9I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YNIqkyrR2+wWSotUwuIYnIk4n45l9lpznKwr8ZqiJyDNHO/OcsQy6hx2H2o7XTNao
         eJ+5fB6AgAxiRLRBfc8Co78SwJo7yEYSK166pzRK/crcVcQnbEJa7QZ92pFp0drhFF
         6LxrgTpIwf1fAJGy6eyRvnGIoTykSm7gqb/4ABiUTibXIfwOLUNyeGWnD4S1SacmqH
         pXM/yIHzGzykuL9cTqb5qKoZILio69MZIXNQy8oNyuxI3kaoemU9j1meqEYEWbkSfA
         PCJgIBLYNiHMlxy1JIUVM95/elpq5lworGqlKLawK1oBlGBWWhbDGLvImOXu/KZ4Bk
         vrHHbyczlLCUg==
Date:   Fri, 19 Aug 2022 19:00:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/4] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220819190025.7702573b@jic23-huawei>
In-Reply-To: <20220819125818.37qc66akgercd6zb@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220816191842.14020-1-ddrokosov@sberdevices.ru>
        <20220816191842.14020-4-ddrokosov@sberdevices.ru>
        <CAHp75VewJ1taLhsCb4_yEQHpw4VDXRhkxpL0jzdu-JsajfF6oA@mail.gmail.com>
        <20220819125818.37qc66akgercd6zb@CAB-WSD-L081021.sigma.sbrf.ru>
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

On Fri, 19 Aug 2022 12:57:54 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> On Fri, Aug 19, 2022 at 11:41:55AM +0300, Andy Shevchenko wrote:
> 
> [...]
> 
> > > Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf  
> > 
> > Have you ever seen such a tag?
> > We have the Datasheet that is more or less established for this kind of links.  
> 
> As I mentioned before, if I use Datasheet tag, line length limit will be
> exceeded. If it's okay, I don't mind.
Fine to go long.  If someone can't see the remaining chars of a link on their 80
character wide terminal - they can scroll sideways :)



> >   
> > > +static inline int msa311_set_odr(struct msa311_priv *msa311, unsigned int odr)  
> > 
> > Why inline?
> >   
> 
> Why not? :) It's short function which is good to be inline, I think.

Let the compiler decide that. Generally in kernel code, inline is reserved for
the few places it's necessary or where compilers have been shown to get it wrong.

> 
> > > +{
> > > +       struct device *dev = msa311->dev;
> > > +       unsigned int pwr_mode;  
> >   
> > > +       bool good_odr = false;  
> > 
