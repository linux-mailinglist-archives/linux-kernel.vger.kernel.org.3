Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD68492E86
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiARTet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbiARTe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:34:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1511EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:34:29 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so294179pja.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40MV7ZI2tGZi+RBScQrhTZKoyeO5b0aBJdwY+wGkH1Y=;
        b=lFjZ7Dwsvh/f8q7mVj1DmtDPHMX9W5RAtybXK2f+6FWm6oXdSYGUpkrkmCQbwc34iw
         shhFwQmavNA4UBmMBREr7gojGZBiab3kBA11j+Xk9H07pVon5rnsk/fBEP8ggWMyeLHq
         rm4IdfVqlUGZLsi0tWs0yk25iNCNpNHlhR1yufzBrqhOsY3+qnfgtebQXQBZRyLGYAxO
         ImwKeN9rU8bxkJLJy7dirHfjmGGYkVJyvGfFPAdhqY/v8Zb9xYxzNaMQBDQ+MCaBRL89
         XaxuR4oiAimjjjUvYRLdeIsAUo36g+YQZxna9WAcUooZBAMI124cPXjLHDXefK/3HkRV
         giOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40MV7ZI2tGZi+RBScQrhTZKoyeO5b0aBJdwY+wGkH1Y=;
        b=lpATK4VPP8ntSuPaxG6lfNMDd9VB4M1UREsRvmVmbnzBNXIWtv2ofBWOP3/DTS0qYJ
         D960L/qaJosNouv4PzkumEDRWOww1IQC2aAdHaRt4nsqOZJr0J84P6FPkUIVBWa5vUgd
         X5WkuZ/WDUqlNRZU5mI7DgtKSJKbSJlj6cZuUMMPZ7kEIuEGp5t8xqu/mcJ3sV9maS2H
         72d8s5JSwnCqTpjRPV0cf4DqdJpSHSJyz8j2800NA0KPQKsZN/IeuaiD0z2N8KdrhnuV
         ODlNkCkvHvjSt9QS6iIzS6PePn75j9bhXo0B+T/RTEiu6/vpShAfEQTPoOsWeQjqRyKs
         cG6g==
X-Gm-Message-State: AOAM533o84btVD7Z7lo5JsY5m6+Dsqhq1Fd6Xf2J0HTprid7EopKQJsl
        dnVxi1XadibhiSu38hXkttE=
X-Google-Smtp-Source: ABdhPJw/rumCUvksSOyguf/QDdyWBBtXkFA5pXyBJirVib31imNTt3X4WukBEBSf1DekNqSl1VXHmA==
X-Received: by 2002:a17:902:70c9:b0:149:76f1:47dc with SMTP id l9-20020a17090270c900b0014976f147dcmr29334321plt.130.1642534468623;
        Tue, 18 Jan 2022 11:34:28 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id c2sm3778204pfv.71.2022.01.18.11.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:34:28 -0800 (PST)
Date:   Wed, 19 Jan 2022 08:34:22 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: pi433: validate max bit_rate based on
 modulation used
Message-ID: <20220118193422.GA3155@mail.google.com>
References: <20220117055849.GA10644@mail.google.com>
 <20220117060220.GA11202@mail.google.com>
 <20220118135902.GH1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118135902.GH1951@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 04:59:02PM +0300, Dan Carpenter wrote:
> At the same time, this is a GCC warning so it will break the build.
> 
> Instead of applying this patch, I wish you would just make a note of it
> in the drivers/staging/pi433/TODO file.  
> 
>     "Change (struct pi433_tx_cfg)->bit_rate to be a u32 so that we can
>      support bit rates up to 300kbps per the spec."

thanks for taking the time to review this patchset.

It makes sense to me. So essentially for this version of the patchset I
would only validate OOK max bit rate as it fits within the u16 boundary
of the current implementation, right?

Something akin to this:

// check input value
if (bit_rate < 1200 || (mod == OOK && bit_rate > 32768)) {
	dev_dbg(&spi->dev, "setBitRate: illegal input param");
	return -EINVAL;
}

> 
> But you're right that it's complicated to fix this because it's part of
> the UAPI.  I think that the UAPI for pi433 is kind of garbage.  No one
> like custom ioctls.  It would be better to use sysfs.  
> ...
> So my idea is that instead of modifying the custom ioctl then we can
> just add a new sysfs file to set the bit_rate and all the other stuff.
> Eventually we will delete the ioctl after all the users have updated to
> the new userspace.
> 

Using sysfs or even possibly configfs was one of the things I had in
mind too. 

I started a similar discussion on how to change/remove ioctl:
https://lore.kernel.org/kernelnewbies/YeVoAlv0ubKrmckV@kroah.com/T/#t

The tldr;:

If there is a userspace tool that interfaces with char
device and we can change it at the same time as the kernel code then we 
can have a bit more flexibility on how to send/retrieve values to/from 
the driver. If not then we would be required to keep the original ioctl
compatibility even if we move to a different approach due to the
impossibility of knowing whether or not someone is relying on that. :(

Everything leads me to believe that there isn't such userspace tool /
lib so I emailed the original author just to be 100% sure that this is
the case.

thanks,

Paulo Almeida
