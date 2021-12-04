Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D66468729
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 20:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346919AbhLDTEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 14:04:01 -0500
Received: from mail.mutex.one ([62.77.152.124]:59774 "EHLO mail.mutex.one"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234141AbhLDTEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 14:04:00 -0500
X-Greylist: delayed 1057 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Dec 2021 14:04:00 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 4698416C27F2;
        Sat,  4 Dec 2021 20:42:56 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oKVK5PS9LakU; Sat,  4 Dec 2021 20:42:55 +0200 (EET)
Received:  [127.0.0.1] (localhost [127.0.0.1])nknown [79.112.88.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mutex.one (Postfix) with ESMTPSA id D422416C08F2;
        Sat,  4 Dec 2021 20:42:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1638643375; bh=52k49UyMB40olKhbEBwyV83YUbOTAqmTQKzOI/7iBGY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iywXr+OwfC+udFJqLZoJcQVQ41y/OuLapkTtmZqhzmGniQMrbGLltI8gDMjufrwbv
         9YU2eZcCnh+4XyRrmhrvtKYrdWzpde+m+BpuLYR6SN4091IOwMinpw5Yv+qmu2p/m3
         uYQJTPngbrh+0Y1pB1lwuwaf5MTzMG/AzpBZTcn4=
From:   Marian Postevca <posteuca@mutex.one>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_ether: fix race in setting MAC address
 in setup phase
In-Reply-To: <YaoSkbMBk90zr3N7@kroah.com>
References: <20211129221229.31845-1-posteuca@mutex.one>
 <YaoSkbMBk90zr3N7@kroah.com>
Date:   Sat, 04 Dec 2021 20:42:52 +0200
Message-ID: <87ee6sxlcj.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Nov 30, 2021 at 12:12:29AM +0200, Marian Postevca wrote:
>> When listening for notifications through netlink of a new interface being
>> registered, sporadically, it is possible for the MAC to be read as zero.
>> The zero MAC address lasts a short period of time and then switches to a
>> valid random MAC address.
>> 
>> This causes problems for netd in Android, which assumes that the interface
>> is malfunctioning and will not use it.
>> 
>> In the good case we get this log:
>> InterfaceController::getCfg() ifName usb0
>>  hwAddr 92:a8:f0:73:79:5b ipv4Addr 0.0.0.0 flags 0x1002
>> 
>> In the error case we get these logs:
>> InterfaceController::getCfg() ifName usb0
>>  hwAddr 00:00:00:00:00:00 ipv4Addr 0.0.0.0 flags 0x1002
>> 
>> netd : interfaceGetCfg("usb0")
>> netd : interfaceSetCfg() -> ServiceSpecificException
>>  (99, "[Cannot assign requested address] : ioctl() failed")
>> 
>> The reason for the issue is the order in which the interface is setup,
>> it is first registered through register_netdev() and after the MAC
>> address is set.
>> 
>> Fixed by first setting the MAC address of the net_device and after that
>> calling register_netdev().
>> 
>> Signed-off-by: Marian Postevca <posteuca@mutex.one>
>> ---
>>  drivers/usb/gadget/function/u_ether.c | 16 ++++++----------
>>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> What commit does this fix?  Should it go to stable kernel releases?
>
> thanks,
>
> greg k-h

This fixes bcd4a1c40bee885e ("usb: gadget: u_ether: construct with
default values and add setters/getters").

I think it should go to stable kernel releases.

Should I send a second version of the patch with a Fixes tag?

Thanks
