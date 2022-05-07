Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDB451E88F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442548AbiEGQnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbiEGQnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:43:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CCFDFB2;
        Sat,  7 May 2022 09:39:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C1C2B80AE4;
        Sat,  7 May 2022 16:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7670C385A5;
        Sat,  7 May 2022 16:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651941559;
        bh=FJdOwT69X41GLePtbzqNFP3tJgjdvaLGZc3c8OeOsuE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kmkA2u3hRqXbr4cJjFfCqMV1zYOd/Ll83YNcSA1pMSa9qQuhXnHldLmUrznXgN91H
         /pc5ZtMqgSB0N9gM+KXeKWmj5xwVhlN7G+BARXg8cV9PHR9t3SFwuuyqEsCwC8k3wT
         gHZcl7X56815UqVonYA1YSilK5bWDNP7B036DrPxh55GATVHNRmF5XJAniFIljTwpN
         DPrCqvD0jV8TPo+BjxUXI5keQmnfg7VaZMXKJhEVhqgEGN6yhiuhN/LlnGrXjBjnRc
         r/fHkMSEehgG2x1Mtxzt8aTZEhJUhLvTGHoJK7D7MolGfiWzaWH1Sad9YNNsR0Okx5
         diU1oOIRRXsnQ==
Date:   Sat, 7 May 2022 17:47:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krzk@kernel.org, krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com
Subject: Re: [PATCH v3 3/3] iio: light: Add support for ltrf216a sensor
Message-ID: <20220507174745.70666eeb@jic23-huawei>
In-Reply-To: <8916313f-0974-0d2d-091b-17e5765c0304@collabora.com>
References: <20220503144354.75438-1-shreeya.patel@collabora.com>
        <20220503144354.75438-4-shreeya.patel@collabora.com>
        <8916313f-0974-0d2d-091b-17e5765c0304@collabora.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2022 22:37:49 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> Hi Jonathan,
> 

Hi Shreeya,

> 
> Just one comment inline related to your previous review.
> 
> On 03/05/22 20:13, Shreeya Patel wrote:
> > From: Zhigang Shi <Zhigang.Shi@liteon.com>
> >
> > Add initial support for ltrf216a ambient light sensor.
> >
> > Datasheet: gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTRF216A.pdf
> > Co-developed-by: Shreeya Patel <shreeya.patel@collabora.com>
> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> > Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>
> > ---
> >

...

> > +struct ltrf216a_data {
> > +	struct i2c_client *client;
> > +	u32 int_time;
> > +	u16 int_time_fac;
> > +	u8 als_gain_fac;
> > +	struct mutex mutex; /* Protect read and write operations */  
> 
> I wasn't really sure about your comment related to the lock description 
> here.
> I see we are using these locks in read_raw and write_raw functions only and
> hence I've added the above comment.
A lock should always ensure consistency of data (either in software or in
hardware registers) so that we don't end up with odd results due to race
conditions between multiple writers / readers.

The comment for a lock should call out what 'data' is being protected.

In this particular case I'm not sure what that is. 

Take the *_get_lux() call in read_raw()

That performs a pair of calls to _read_data(). The _read_data() calls
just check for valid data and then read the channels.  The i2c accesses will
be protected by the underlying bus locks and I can't otherwise see anything
in those calls that needs protecting with locks (all the data is local).

Finally we have some maths done with data->als_gain_fac and data->int_time_fac

als_gain_fac is currently a constant in the driver (it's set only in probe I think).

int_time_fac is more interesting.
That is set alongside a register write in _set_int_time().

So I 'think' the entire purpose of the lock is to ensure that the
value of integration time doesn't not change whilst a reading is progress
(so we can do the right maths).

Hence the comment should be something along the lines of

/*
 * Ensure cached value of integration time is consistent with hardware setting
 * and remains constant during a measurement of Lux.
 */

This extra detail makes it easy to tell where the lock must be taken which
is very useful for anyone modifying the driver in the future.

If they expand the scope of the lock, then they should also update the
documentation to match.
  
> 
> 
> 
> Thanks,
> Shreeya Patel

