Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE02488BE6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiAITF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiAITF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:05:59 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD99C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 11:05:58 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f8so9361079pgf.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 11:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BQ4h91QqsPHm6HjZOcUGZRO8VEa/eScc4Z91WrPb7XI=;
        b=U6gVy720BSs9zO0CrU6qSvI7hrI9jAgUbfPCaMx80LUgYmVUB18PIT9thL9Dg4Yn+O
         umdgL6PwcmgVO1uX5dmQEOm9n1XMbLrZlJnNeA54LlkoUuGeRhfHuS3K4D6j5CITxW+H
         RMMW+095t9Movo9GVvPAky+IeO3nU34ZQqMrUmxFGx03EE7Ku+LOZybpB+J6pCbkuagp
         0opPV+VMlYs3pLZdgkOwwbB5XBgvMDBNV5ls+aiSKSlOX5UyfX1V6YCXSSo3zKAE5LEy
         +yESHq7pohNhqVuUtJcpcgE8ZY85J2GsifYyF5eqOMeXj8GPa1s/L91JLvEV/0QO+MwE
         BErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQ4h91QqsPHm6HjZOcUGZRO8VEa/eScc4Z91WrPb7XI=;
        b=lq9yZdsM6BLLkN6XVtPh7NIknSGsAPsi48OWUzFOqGSfSW5jAR9UYZUOm71p7kLoWb
         yQbVXWWR5fQSJX/0mz7ZJczT49uMcUzQbjq8C7yEf8nQWwvx9+DbAqoZlLk0z3mdDZom
         UTHIWURdHUlbP5CYOtsl42vieBy/e8tn8avNJzP7Ghhar6fYxMMZO1zAmfyDBCrOd5mb
         4S4YXLhVAPT8EQeR3MeA1AebB3CgVkckt0UiAC1aTuAnPV8uF/WLqPvo+zwI9tiBIVnX
         Jz3S0iTztx8Kv4krwmJ3UuuPb5h3JZa64G2H62i5l8sgNtY4WDk2hOOxanBg5GBU7KgO
         daJg==
X-Gm-Message-State: AOAM533xBpiee0jnvtKPAt/xrL+BFn+JFDw+naio2YoD4gWTByxtxQa0
        Ijpae2JB3+wg0IJaiKTlvzU=
X-Google-Smtp-Source: ABdhPJycVV5XiVesKcyfg7S5laH9Rf8gj0gL2w4EiphtUBuCuCmlpnARu9Q8HMynTqOCE0ezmeiWcQ==
X-Received: by 2002:a05:6a00:b90:b0:4ba:c269:eb07 with SMTP id g16-20020a056a000b9000b004bac269eb07mr72971333pfj.71.1641755158166;
        Sun, 09 Jan 2022 11:05:58 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id p186sm4245463pfp.128.2022.01.09.11.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 11:05:57 -0800 (PST)
Date:   Mon, 10 Jan 2022 08:05:52 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: enforce tx_cfg to be set before any
 message can be sent
Message-ID: <20220109190552.GA2928@mail.google.com>
References: <20220108222652.GA11883@mail.google.com>
 <20220109154950.GA27767@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109154950.GA27767@realwakka>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 03:49:50PM +0000, Sidong Yang wrote:
> On Sun, Jan 09, 2022 at 11:26:52AM +1300, Paulo Miguel Almeida wrote:
> 
> Hi, Paulo.
> Thanks for the patch.
> I have some opinion below.

thanks for taking the time to review my patch :)

> > this driver relies on exposing a char device to userspace to tx
> > messages. Every message can be sent using different trasmitter settings
> > such so the tx_cfg must be written before sending any messages.
> > Failing to do so will cause the message to fail silently depending on
> > printk/dynamic_debug settings which makes it hard to troubleshoot.
> > 
> > This patch add a control variable that will get initialized once tx_cfg
> > is set for the fd used when interacting with the char device.
> 
> I don't know that adding flag is good idea. It seems that initializing
> to default is better than this.

the reasons why I thought that the flag was a good approach is because of
these points:

1 - it returns an error to userspace to help the developers 
troubleshooting what is missing/required to make a message to be
successfully tx'ed. Unfortunately, once the message is in the chip
queue, there isn't much that the user can know so, from my humble point
of view, any way we can avoid hard-to-debug problems, we should.

2 - rf69 work with multiple frequencies (315,433,868 and 915MHz) in which
acceptance varies from region to region. Essentially, picking 1 default
frequency may be ideal for one place but not right for another.

Let me know if you agree with my train of thought above and if not,
share with me your point of view.

thanks,

Paulo A.

