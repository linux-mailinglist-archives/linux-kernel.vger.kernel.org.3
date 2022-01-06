Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5748A486A04
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbiAFSgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:36:05 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:52079 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbiAFSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:36:04 -0500
Received: from [192.168.1.18] ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5XcCn6oLyBazo5XcDn2y4b; Thu, 06 Jan 2022 19:36:03 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 06 Jan 2022 19:36:03 +0100
X-ME-IP: 90.11.185.88
Message-ID: <edd19014-3b99-fa0b-912b-e058c14401d8@wanadoo.fr>
Date:   Thu, 6 Jan 2022 19:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] fsi: Aspeed: Fix a potential double free
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        alistair@popple.id.au, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <2cafa0607ca171ebd00ac6c7e073b46808e24f00.1640537669.git.christophe.jaillet@wanadoo.fr>
 <YcldM9sgYdjMYMtH@kroah.com> <20220106081418.GH7674@kadam>
 <f2ba50fd-5c6b-e905-17ed-541dcc98c6c1@roeck-us.net>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <f2ba50fd-5c6b-e905-17ed-541dcc98c6c1@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/01/2022 à 18:25, Guenter Roeck a écrit :
> On 1/6/22 12:14 AM, Dan Carpenter wrote:
>> On Mon, Dec 27, 2021 at 07:29:07AM +0100, Greg KH wrote:
>>> On Sun, Dec 26, 2021 at 05:56:02PM +0100, Christophe JAILLET wrote:
>>>> 'aspeed' is a devm_alloc'ed, so there is no need to free it 
>>>> explicitly or
>>>> there will be a double free().
>>>
>>> A struct device can never be devm_alloced for obvious reasons.  Perhaps
>>> that is the real problem here?
>>>
>>
>> I don't understand how "aspeed" is a struct device.
>>
> 
> -static void aspeed_master_release(struct device *dev)
> -{
> -    struct fsi_master_aspeed *aspeed =
> -        to_fsi_master_aspeed(dev_to_fsi_master(dev));
> -
> -    kfree(aspeed);
> -}
> 
> So "dev" is embedded in struct fsi_master, and struct fsi_master is 
> embedded
> in struct fsi_master_aspeed. Since "struct device" is embedded, the data
> structure embedding it must be released with the release function, as is 
> done
> here. The problem is indeed that the data structure is allocated with
> devm_kzalloc(), which as Greg points out must not be devm_ allocated
> (because its lifetime does not match the lifetime of devm_ allocated
> memory).

Thanks a lot for the detailed explanation.
Crystal clear for me now.

Do you want me to send a patch to remove the devm_ or will you?

CJ

> 
>> I've been working on understanding device managed memory recently for
>> Smatch.  It's really complicated.  There are a bunch of rules/heuristics
>> that I'm slowly creating to generate new warnings but I'm a long way
>> from understanding it well myself.
>>
> 
> A data structure embedding struct device must not be devm_ allocated,
> and it must be released with the release callback. Maybe there is
> a means to flag that somehow ?
> 
> Guenter
> 

