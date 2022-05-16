Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111BE52861B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbiEPN5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244573AbiEPN44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:56:56 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B40E99;
        Mon, 16 May 2022 06:56:54 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A813C0004;
        Mon, 16 May 2022 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652709412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7SpoWIQY72eSmiR3JfnZLb5PGezpamlWkoq3B0Im97c=;
        b=OB8asnz9ViEfyXVey9yvtRZ28vTTKRL2clDhg7AWJgpkOgjZlQ6PWQBebPRPCzuuUqQ5s3
        K+HdPw/Q+aBcB012sVnLcbbnwmbwYyu0uLN6f/alewfE6OcPrRLQ4ZUjEE2IyZOomgAqXF
        Mh8ioBdGCN3RNHYK8ScbgqjSGBziCDbJdpxmlUC5q7pSDjWpAIMYiLC1WcduK8/h+HhDjc
        lWaQOL5S+TEEt1y/2c3fqhsS3IPDAwFpSGEZ4kCg9+FFsPGt+0YmYQq4yEwkEJ/MD9xpqH
        cj7J5Bh4DKl7Aoq//WNh9BaM3TIVI1xEfKtXPQOF91rL+ekf49DXy5wJ1H7uOg==
Date:   Mon, 16 May 2022 15:56:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, list@opendingux.net,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 3/5] rtc: jz4740: Reset scratchpad register on power loss
Message-ID: <YoJYJIqoflaoEpsQ@mail.local>
References: <20220418184933.13172-1-paul@crapouillou.net>
 <20220418184933.13172-4-paul@crapouillou.net>
 <Yl8PBx5qyvMrwrV/@mail.local>
 <I1RLAR.CF78L45NPJDC1@crapouillou.net>
 <Yl8U4JDSHwjT9nXw@mail.local>
 <T0ULAR.TKXMRCDN7DQ53@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <T0ULAR.TKXMRCDN7DQ53@crapouillou.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2022 21:53:17+0100, Paul Cercueil wrote:
> > >  So what is the best thing to do then?
> > > 
> > 
> > Well, -EINVAL is returned when the time is invalid, this should be
> > enough. I'm not actually sure what is the issue you are trying to fix
> > here.
> 
> htop fails to start and tells me:
> "No btime in /proc/stat: No such file or directory"
> 
> until the date is reset. So I was assuming it was a case of the jz4740
> driver not being correct and breaking userspace.
> 

I guess either /proc/stat or htop needs fixing then ;)

> Cheers,
> -Paul
> 
> 
> > 
> > >  Cheers,
> > >  -Paul
> > > 
> > >  > >  +	}
> > >  > >  +
> > >  > >   	ret = devm_rtc_register_device(rtc->rtc);
> > >  > >   	if (ret)
> > >  > >   		return ret;
> > >  > >  --
> > >  > >  2.35.1
> > >  > >
> > >  >
> > >  > --
> > >  > Alexandre Belloni, co-owner and COO, Bootlin
> > >  > Embedded Linux and Kernel engineering
> > >  > https://bootlin.com
> > > 
> > > 
> > 
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
