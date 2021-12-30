Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6448186A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 03:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhL3CPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 21:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhL3CPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 21:15:14 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4BBC061574;
        Wed, 29 Dec 2021 18:15:13 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i8so11674015pgt.13;
        Wed, 29 Dec 2021 18:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xpvE1IguZ73rofYZc01aCygHY7BN+tTWzJIv0Gtd82E=;
        b=GrI9HoeRHdZp8AdKRUqZP+QPD7/9avC3/bRchOOjd9BgCllh5mbfmP0haO2l0EE5jv
         GIBXKlwoDj5cahZqFPuMD/rrLIl9tx45qMh3e+5740qDCQWTpMkE1/McbDkH0nZGyH5L
         1YWof/gEbyz90jz8iXjWBiB8UyH+kD0phY9FYqBPZiU4VM6n+yAE+D4ZsSqIEgMce/af
         OKNV+FRYaR3oK867yoCfKNLuJ84CGDHvi7zCxxaVDCwlbmpQYvQ9NAi41LHEL5Fjp65j
         s4dHV/I1c9/CcXQ8WkpHU0UgMeWclPcVl2IAJY3OJYHq/bSfItABzuNKfzX7nupNH/cf
         Yxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xpvE1IguZ73rofYZc01aCygHY7BN+tTWzJIv0Gtd82E=;
        b=YX2UQLzY7tDu6YbUFGMW68234onBMrPv0Y5Bz1w157C9mt4KJ4ELoOhhdVRhEqmZam
         lN65kmAiqaes2ap+jcaqxFotsR26jH2pkvLLCz84L/isH95Up5Rp9sp1EgcEV5iKsO1c
         D7iUO8pEwLoc2KYZTucEmivNrMunyGNJDcpVLn5AfFY8/vDNmlIeNRxR7yu4oeAShIcI
         4Yy592lkrmaymwt3+N2RfVeJxXc+cckbGAWhLTHqd1GLauP8Dd/WSYV7xOwA0wa9F1U4
         NY/p6p1tnAqoo/p/1fGRQ2QF6XVPCm7KzCK2rtcGflbd/jXUTf+xdCOX7A4XpKjcBsjo
         fPQw==
X-Gm-Message-State: AOAM531hFXE0ADIhfTtGwu/Bv+0IMq5tZ4o9LroG+z33fGhZ4k75cKiz
        vnMYv8PwKWD7pAF5zXRIWFRMUKK/s0m3Fze9/4E=
X-Google-Smtp-Source: ABdhPJzVrSBoQSYWKWynnfHjgdsdnTVrUhoKk15ZISolD0ziaZdbCtqCRXlUIR7nilGABbcZYZcUzw==
X-Received: by 2002:aa7:910e:0:b0:4bb:8470:249b with SMTP id 14-20020aa7910e000000b004bb8470249bmr28316802pfh.23.1640830513315;
        Wed, 29 Dec 2021 18:15:13 -0800 (PST)
Received: from [0.0.0.0] (ec2-54-176-189-104.us-west-1.compute.amazonaws.com. [54.176.189.104])
        by smtp.gmail.com with ESMTPSA id x33sm26609030pfh.212.2021.12.29.18.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 18:15:13 -0800 (PST)
Subject: Re: [PATCH] usb: gadget: use after free in dev_config
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        dan.carpenter@oracle.com, jj251510319013@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211228092126.29510-1-hbh25y@gmail.com>
 <YczPGL/1Er/vh+X6@rowland.harvard.edu>
From:   Hangyu Hua <hbh25y@gmail.com>
Message-ID: <dc9d169f-deae-e0a1-4509-a105898f45c0@gmail.com>
Date:   Thu, 30 Dec 2021 10:15:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YczPGL/1Er/vh+X6@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank for your suggesions. I will break this up into two separate 
patches later. And i think it's necessary to clear up dev->config and
dev->hs_config and dev->dev. For example, dev->hs_config is used in
ep0_read() which may lead a UAF.

Thanks.

On 2021/12/30 上午5:11, Alan Stern wrote:
> On Tue, Dec 28, 2021 at 05:21:26PM +0800, Hangyu Hua wrote:
>> There are two bugs:
> 
> You should break this up into two separate patches, one for each bug.
> 
>> dev->buf does not need to be released if it already exists before
>> executing dev_config.
> 
> That's right.  The call to dev_config should fail without changing any
> of the stored values.
> 
>> dev->config and dev->hs_config and dev->dev need to be cleaned if
>> dev_config fails to avoid UAF.
> 
> Do they really need to be cleared?  I think if dev_config fails then
> those pointers never get used, so it doesn't matter what they contain.
> 
> Of course, clearing them doesn't hurt, but it would be best to clear
> all of them in the "fail:" part of the routine.  And then you would
> want to change the pathway where usb_gadget_probe_driver fails, to make
> it go to "fail:" also.
> 
> Alan Stern
> 
