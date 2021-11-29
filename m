Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7245461404
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbhK2Lp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:45:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34450 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhK2Lnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:43:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CCACB80ED0;
        Mon, 29 Nov 2021 11:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FDDC004E1;
        Mon, 29 Nov 2021 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638186029;
        bh=n+pTQw/BCa3IBVkxZCQt663ROWCmgz8ezH0i6qWNGJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MUD4HMSH5oEc0UmxxL2esec50P9hY3A0wpRvE8EdRyhUUvQeBC1GxLQccdT98YHpt
         UGbMctBp2jMceX0TMKrpL0AiYoXaVQrMURrOfg1xyr+P8zoNtrysYgC7x2TijGAt6l
         VKDaiBa+bRX9Vrh9IX1pjySo2u7ySDaj8MRa7tL07H69VHgrenZE9jJWFGtv3EnA9Z
         z5a7H9x3+X8WfuVnO7LhtY16B/S6URIMMbO098oXGfgEY+UUesl2QvY9fLxCvLnWqa
         4NmVrAZJgheBmbrB8DkVK3ZWYyXCzXqleA5R9rihpbpqUBX7XUa/ABbYQNNuiZoEHF
         pxMj0U2c0NVJg==
Date:   Mon, 29 Nov 2021 12:40:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 09/20] media: si470x: fix printk warnings with clang
Message-ID: <20211129124024.5cd16580@coco.lan>
In-Reply-To: <a22c082a661df0b548511f282fcc519a11bb3340.camel@perches.com>
References: <cover.1638179135.git.mchehab+huawei@kernel.org>
        <442df11dd08158df88e95a457175a65f20dc8369.1638179135.git.mchehab+huawei@kernel.org>
        <a22c082a661df0b548511f282fcc519a11bb3340.camel@perches.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 29 Nov 2021 02:10:14 -0800
Joe Perches <joe@perches.com> escreveu:

> On Mon, 2021-11-29 at 10:47 +0100, Mauro Carvalho Chehab wrote:
> > Clang doesn't like "%hu" on macros:
> > 
> > 	drivers/media/radio/si470x/radio-si470x-i2c.c:414:4: error: format specifies type 'unsigned short' but the argument has type 'int' [-Werror,-Wformat]
> > 	drivers/media/radio/si470x/radio-si470x-i2c.c:417:4: error: format specifies type 'unsigned short' but the argument has type 'int' [-Werror,-Wformat]
> > 
> > Besides that, changeset cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")
> > dropped recomendation of using %h.
> > 
> > So, just replace them with "%u".  
> 
> And perhaps change these to single dev_warn calls instead of multiple calls.
> 
> > diff --git a/drivers/media/radio/si470x/radio-si470x-i2c.c b/drivers/media/radio/si470x/radio-si470x-i2c.c  
> []
> > @@ -410,10 +410,10 @@ static int si470x_i2c_probe(struct i2c_client *client)
> >  			radio->registers[DEVICEID], radio->registers[SI_CHIPID]);
> >  	if ((radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE) < RADIO_FW_VERSION) {
> >  		dev_warn(&client->dev,
> > -			"This driver is known to work with firmware version %hu,\n",
> > +			"This driver is known to work with firmware version %u,\n",
> >  			RADIO_FW_VERSION);
> >  		dev_warn(&client->dev,
> > -			"but the device has firmware version %hu.\n",
> > +			"but the device has firmware version %u.\n",
> >  			radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE);  
> 
> 		dev_warn(&client->dev,
> 			"This driver is known to work with firmware version %u, but the device has firmware version %u\n",
> 			RADIO_FW_VERSION, radio->registers[SI_CHIPID] & SI_CHIPID_FIRMWARE);
> 
> etc...
> 
> 

Good idea. As this will touch on other things, I'll submit it on a
separate patch.

Regards,
Mauro



Thanks,
Mauro
