Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32D5166D8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354201AbiEASFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 14:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353631AbiEASE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 14:04:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0CD369E3;
        Sun,  1 May 2022 11:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6437CB80E9F;
        Sun,  1 May 2022 18:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655F6C385AA;
        Sun,  1 May 2022 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651428089;
        bh=mQ5z/2/gMvNxLbhWmeTsQypZp/LJsH4r9iPhByXwQo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e64OFrHSq/TLL5FsVHn4J/HK5UCqexybkALjKeKHqOAy9cObzQZkzi3vmm5whsgrt
         3fjnxwJQ5aH49QMA5C237irX8B739kR9IP6B41gdkfd5MrmQwvDTYM4KaKoCmpWBEn
         tijPgGYy8ehuEb6vXPiRb2XwjYpdPiJ/4mPc3Uv4cMWmBtTLDjq8jlk61L3vsX3D+N
         lX4im5rQGDZ41qhg0xQxgTat9kVBwrYlNHxZmUM5icNVqV26cEii9CJYMNwioFEfLl
         Y72SCgYGgDBFeiBYqBKTI9GH8LH8IhZjkNAqZho6ox0+G8cgqpTbdWEzeXcLQgHmfU
         hHY9x9XV6g22A==
Date:   Sun, 1 May 2022 19:09:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Jose Cazarin <joseespiriki@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: linux-next: manual merge of the iio tree with the
 char-misc.current tree
Message-ID: <20220501190943.28ec3d4c@jic23-huawei>
In-Reply-To: <20220429144721.63ae260f@canb.auug.org.au>
References: <20220429143517.75be9c04@canb.auug.org.au>
        <20220429144721.63ae260f@canb.auug.org.au>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Fri, 29 Apr 2022 14:47:21 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Fri, 29 Apr 2022 14:35:17 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > diff --cc drivers/iio/dac/ti-dac5571.c
> > index 0b775f943db3,96b86e2dcc6b..000000000000
> > --- a/drivers/iio/dac/ti-dac5571.c
> > +++ b/drivers/iio/dac/ti-dac5571.c
> > @@@ -393,15 -386,16 +394,16 @@@ static int dac5571_remove(struct i2c_cl
> >   }
> >   
> >   static const struct of_device_id dac5571_of_id[] = {
> >  -	{.compatible = "ti,dac5571"},
> >  -	{.compatible = "ti,dac6571"},
> >  -	{.compatible = "ti,dac7571"},
> >  -	{.compatible = "ti,dac5574"},
> >  -	{.compatible = "ti,dac6574"},
> >  -	{.compatible = "ti,dac7574"},
> >  -	{.compatible = "ti,dac5573"},
> >  -	{.compatible = "ti,dac6573"},
> >  -	{.compatible = "ti,dac7573"},
> >  -	{.compatible = "ti,dac121c081"},
> >  +	{.compatible = "ti,dac5571", .data = (void *)single_8bit},
> >  +	{.compatible = "ti,dac6571", .data = (void *)single_10bit},
> >  +	{.compatible = "ti,dac7571", .data = (void *)single_12bit},
> >  +	{.compatible = "ti,dac5574", .data = (void *)quad_8bit},
> >  +	{.compatible = "ti,dac6574", .data = (void *)quad_10bit},
> >  +	{.compatible = "ti,dac7574", .data = (void *)quad_12bit},
> >  +	{.compatible = "ti,dac5573", .data = (void *)quad_8bit},
> >  +	{.compatible = "ti,dac6573", .data = (void *)quad_10bit},
> >  +	{.compatible = "ti,dac7573", .data = (void *)quad_12bit},
> > ++	{.compatible = "ti,dac121c081", data = (void *)single_12bit},  
>                                         ^
> I fixed up the missing '.'
> 

Thanks Stephen and sorry I missed this one locally! Trying to sneak
a last few patches in at the end of the day is always a bad idea -
particularly my memory of what is going through my various branches is
clearly less than perfect!

I've decided to back the series out for now and resolve it once the
fix in char-misc fix filters back to my tree.

Thanks as ever for your hard work!

Jonathan
