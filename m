Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35AE465DB2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 06:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbhLBFRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 00:17:51 -0500
Received: from marcansoft.com ([212.63.210.85]:48452 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhLBFRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 00:17:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BBE9241F5F;
        Thu,  2 Dec 2021 05:14:23 +0000 (UTC)
Subject: Re: [PATCH 2/2] watchdog: Add Apple SoC watchdog driver
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211113094732.73889-1-sven@svenpeter.dev>
 <20211113094732.73889-2-sven@svenpeter.dev> <YY/YnlCxLqdw/zAo@sunset>
 <95dea968-f452-4ba0-9b66-c9bc4269a52c@www.fastmail.com>
 <YZEMmH49D+GZEewi@sunset>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <ca52e4ee-b5f3-b892-1ba5-7c5656e45fdd@marcan.st>
Date:   Thu, 2 Dec 2021 14:14:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZEMmH49D+GZEewi@sunset>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2021 22.18, Alyssa Rosenzweig wrote:
>>>> + * This HW block has three separate watchdogs. WD0 resets the machine
>>>> + * to recovery mode and is not very useful for us. WD1 and WD2 trigger a normal
>>>> + * machine reset. WD0 additionally supports a configurable interrupt.
>>>
>>> Do we have any idea what the difference between WD1 and WD2 is?
>>
>> I've never seen macOS write to WD2 when running in our hypervisor and only
>> found that one when I was looking at the rest of the MMIO region.
>> >From what I can tell it works exactly like WD1.
> 
> Makes sense, thanks.
> 

Are any of these watchdogs active when we boot, and are we leaving them 
like that? I'm pretty sure at least some of the coprocessors have their 
own watchdog (SMC...), which might be one of these. We should make sure 
we don't clobber that.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
