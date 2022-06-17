Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97854F6F7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381980AbiFQLse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382020AbiFQLs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:48:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2A66B0B6;
        Fri, 17 Jun 2022 04:48:23 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-92.dynamic.spd-mgts.ru [109.252.136.92])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54683660179A;
        Fri, 17 Jun 2022 12:48:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655466501;
        bh=4OnJ9LkHQ8ZP/4JtbxesRqqZ1hb4x6FRCrAnAmr9L3c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H0Txa8h4uFkIpa0KNjruM/jHtFUz/3rg9QT8hHSr3Dguwy+53Z+3fw7CUKxxoCPFg
         wshZjl6TbqzD3vfejcfJMWRvnLyjS8bKsUoZQDctLCpu511x7LUIZrhH9nbk3GLqlg
         la5uR2QB9fomh44ML1mb4LC4rSo8YCb8BaWbp/odS/SHxoxIlVLsYrN1DHOrH+YhSe
         hi/LcWaCF4IZTcVXz80j0jJDmHgso5TkFqX2ap6P1Ic7IuxrGDP6qRCEK8fjoS8VK7
         pmqTNaVonBqqv2IRvGOIsSsoB5oIchCjwCZT2dU2gKON35k/tieXpldSdL4xFVY0Le
         XCzaej71XQRgA==
Message-ID: <33d5028e-20f9-e133-b41c-9ea789052069@collabora.com>
Date:   Fri, 17 Jun 2022 14:48:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: regression, 5.19.0-rc1 not powering off when hibernated
Content-Language: en-US
To:     Ken Moffat <zarniwhoop@ntlworld.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <YqE22nS9k2+AldI6@llamedos.localdomain>
 <84d01637-febb-f602-2d03-fe1600e85ae3@leemhuis.info>
 <YqTPlGM9KQ0FqHdc@llamedos.localdomain>
 <YqeUDpo+8RLVKH8r@llamedos.localdomain>
 <YqoLjk8P+fChJ04m@llamedos.localdomain>
 <Yqo4ZTrRZXEvxS36@llamedos.localdomain>
 <65fbe95b-241a-c5c5-4eca-d6932e0fd59d@collabora.com>
 <YqtjBdEY59P9JQsx@llamedos.localdomain>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <YqtjBdEY59P9JQsx@llamedos.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 20:06, Ken Moffat wrote:
> On Thu, Jun 16, 2022 at 05:59:10PM +0300, Dmitry Osipenko wrote:
>> Hi,
>>
>> On 6/15/22 22:52, Ken Moffat wrote:
>>> On Wed, Jun 15, 2022 at 05:40:46PM +0100, Ken Moffat wrote:
>>>> On Mon, Jun 13, 2022 at 08:46:22PM +0100, Ken Moffat wrote:
>>>>
>>>>>>>> But with 5.19.0-rc1 the screen is blank throughtout the hibernation,
>>>>>>>> and briefly when restoring (no complaint about that), but when
>>>>>>>> hibernating it no longer powers off and I have to hold the on/off
>>>>>>>> switch to power off.
>>>>>>>>
>>>>>>>> Is this a known problem ?
>>>>>>>
>>> [...]
>>>> Indeed, on the second attempt I've got a much more likely commit to
>>>> blame:
>>>>
>>>> 98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71 is the first bad commit
>>>> commit 98f30d0ecf79da8cf17a171fa4cf6eda7ba4dd71
>>>> Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> Date:   Tue May 10 02:32:30 2022 +0300
>>>>
>>>>     ACPI: power: Switch to sys-off handler API
>>>>     
>>>>     Switch to sys-off API that replaces legacy pm_power_off callbacks,
>>>>     allowing us to remove global pm_* variables and support chaining of
>>>>     all restart and power-off modes consistently.
>>>>     
>>>>     Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> Unsurprisingly, with this reverted 5.19-rc2 fails to build.
>>>>
>>> It occurs to me that maybe I'm missing something in my .config.
>>> Since that is 117K, here is the gzipped config from the version that
>>> git blamed (apart from not powering off, it appears to work ok).
>>
>> The patch below likely should fix the problem, please give it a try on
>> top of the 5.19-rc2.
> 
> Thanks, works like a charm.
> 
> Feel free to add
> 
> Reported-by: Ken Moffat <zarniwhhop@ntlworld.com>
> Tested-by: Ken Moffat <zarniwhoop@ntlworld.com>
> 
> if you wish.

Nice, thank you!

-- 
Best regards,
Dmitry
