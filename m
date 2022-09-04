Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7E45AC57E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiIDQuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiIDQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:50:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1028140B0;
        Sun,  4 Sep 2022 09:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 20BC7CE0B97;
        Sun,  4 Sep 2022 16:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11AFC433D6;
        Sun,  4 Sep 2022 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662310207;
        bh=jcxJce531SFVVxvZzrqQFD0MFmKdV7Jnsc1mjlOBdH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J7czZ7K90dD5MorIwSTBO+HK60CbLbXiKx1GZyAWq9Itc2mhUkkD0Ui+aaetC4M3g
         AATQWY9uDA6I6apWKBQ4Udz5ZDh09uD3gRHQdq0FOZeWdY6GdDlf7NHIH6pKfvLMCQ
         rX+5ru+meCvjfSvONQlsu5xEUD6ssnow2nFvuEYjLlDTGi6/jcUH26Fe9YJiRYTt8a
         gfMLBfEtWR6+KWVvSDDdKfZ9CvcPcym1HaeKh84HqlYdgJUWRla3/POpBJaxSY66e9
         ccSHzFJ5358YaNPv4qqPHegA/qgbSPB9arqdFcTPM7hqyHC+z3C2BWg9LWfeyRNshM
         z2+hWWGxVJFdg==
Date:   Sun, 4 Sep 2022 17:15:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        kernel <kernel@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] iio: adc: mcp320x: use callbacks for RX
 conversion
Message-ID: <20220904171559.1bf77d42@jic23-huawei>
In-Reply-To: <CAHp75Vek8tLnwYWZO91HHr1_i7G_F9tErnRsq-GwfQcpR0FaTw@mail.gmail.com>
References: <20220831100506.3368103-1-vincent.whitchurch@axis.com>
        <20220831100506.3368103-2-vincent.whitchurch@axis.com>
        <CAHp75Vek8tLnwYWZO91HHr1_i7G_F9tErnRsq-GwfQcpR0FaTw@mail.gmail.com>
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

On Wed, 31 Aug 2022 15:40:49 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Aug 31, 2022 at 1:05 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > Replace the device_index switch with callbacks from the chip_info
> > structure, so that the latter has all the information needed to handle
> > the variants.  
> 
> Below are for the further patches, as I see the original code has the
> same disadvantages.
> 
> ...
> 
> >  struct mcp320x_chip_info {
> >         const struct iio_chan_spec *channels;
> >         unsigned int num_channels;
> >         unsigned int resolution;  
> 
> >         unsigned int conv_time; /* usec */  
> 
> Instead of a comment, I would rename it to conv_time_us.
> 
> > +       int (*convert_rx)(struct mcp320x *adc);
> >  };  
> 
> ...
> 
> > +       return adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3;  
> 
> > +       return adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6;  
> 
> > +       return adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1;  
> 
> > +       return adc->rx_buf[0] << 4 | adc->rx_buf[1] >> 4;  
> 
> > +       return sign_extend32((adc->rx_buf[0] & 0x1f) << 8 | adc->rx_buf[1], 12);  
> 
> All above should really use
> 
> u16 buf = be16_to_cpu(&adc->rx_buf[0]);
> 
> return buf >> 3 /* 6, 1, 4 (respectively) */;

This made me look a bit closer at the code.  
rx_buf isn't necessarily aligned...
This may be a good usecase for an anonymous union.

Which would be fine except one of the callbacks (and original
code) uses be32_to_cpup() which is not unaligned safe.

I'm not keen to push unrelated work onto someone doing good stuff
on a driver, but in this particular case it does seem reasonable to
tidy all this up given you are moving the code anyway.

Jonathan

> 
> ...
> 
> > +       if (raw & BIT(22) && raw & BIT(23))  
> 
> > +               return -EIO; /* cannot have overrange AND underrange */
> > +       else if (raw & BIT(22))  
> 
> Redundant  'else'.
> 
> > +               raw &= ~BIT(22); /* overrange */
> > +       else if (raw & BIT(23) || raw & BIT(21))  
> 
> if (raw & (BIT(23) | BIT(21))) ?
> 
> > +               raw |= GENMASK(31, 22); /* underrange or negative */  
> 
> ...
> 
> >         [mcp3201] = {
> >                 .channels = mcp3201_channels,
> >                 .num_channels = ARRAY_SIZE(mcp3201_channels),
> > +               .convert_rx = mcp3201_convert_rx,  
> 
> >                 .resolution = 12  
> 
> + Comma in such lines.
> 
> >         },  
> 

