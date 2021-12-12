Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D9471E4A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 23:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhLLWjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 17:39:37 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12259 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLLWjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 17:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639348776; x=1670884776;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N9pfuJsD2sXsBVWX5kv0j2sW3te9hJZuRm8LW7X5qgM=;
  b=IgmUXzQQk07AhxNgOhS/hNrenIIHJ8DKH+XuMyNUnJIhG+Oq1sSBxMSO
   zTeQd/ddeVIyWa0gw6G3cM+oXjGr8louVoeEGjeYalkYwdRg9I7Qga7bv
   Fc+jj+WeUUnRqY0ckr1CQcgvFxuh46aZGgtHrfWnFWdqKuOPVF+d3xXcj
   ZH5Fl7AbGmWySxqnGYbLaEBmpnxuDGkH4+DiR+7aiIxxyTHkhgb7ZnxiM
   hE18Qr4CCISb80yAIQdOIy0SHra2MEtnql9xDPeq0rc7Nwz16hv/Beoou
   QoJrYQ9Y0ARm8EOyev21s3DM77e3DKyiQyjrTHfBjqj/DuyznvUbgk7wK
   w==;
X-IronPort-AV: E=Sophos;i="5.88,200,1635177600"; 
   d="scan'208";a="299911559"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2021 06:39:36 +0800
IronPort-SDR: FlBwZLluKOeMdaeUC9++/MiCqoqlBNSeGv+RclVqWCkfXJlSzauZ2PgJ3LdfsfmWqc9BwknvBp
 FIzTXLsz1g3B65ZvkSbOvsaYTMvw2tHXyCO17QFgZqCqrAb2zDJiNN+qDCXBlFdQgp6G/S8KTw
 5UD/sW0KPXWtVUiDwHL4GyHtd+akVTYzT71lyEGUGLJ9hct3VMdPv5wicMJNder7wnybzzhFPw
 on+m6stqIkoK/NXFyhuw/dlIAskPBSfpuhPPKAh5JLiZiXphM4L7uvDChbpTkZbMhnE42m/gdy
 ZxMYZ5k/FzL8XHtsKkt9Ljh6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 14:12:35 -0800
IronPort-SDR: gHQk8NEDpkv4h4psElhb8hPxmhlHvgKr2DNCupSnIA1Dyn0Ok41htIX4+SKbNjvQFq5k8wIQ7C
 ggQVmElABAMgE0D49m7C5Ac5JcGWb6aftKho5tce0o/32eV1Uwr3ZYgo4iP0sRTs+uBpRmuga4
 5EeWA7upfMOB+fEaT8D2NenZi7OL4vW5vr0/N5rI1+1aEStAsheUwaDvKsfvwEzrdLwKGIUwGu
 N3QL58PvNgA4V05hC6Xm1DiwnZ3SO0uuGfRKC7GStN2m8/7AEERW+38fZ/DB1tXuph/5oUkKiK
 DQs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 14:39:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JC01z6DYSz1Rwnx
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 14:39:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639348774; x=1641940775; bh=N9pfuJsD2sXsBVWX5kv0j2sW3te9hJZuRm8
        LW7X5qgM=; b=j3INgkJ1z8LAoIZ2CRc6oyX99spcHIkqdDwzCsRtplgng5qp19v
        UNSfhIaZEK+IflgRgMNvLtUzNdElzNnktBT0T7W1b1Lx1jgIN6vKpRvDBgK7IGPK
        XDnkeAv0KRf7ufqxXhsSsx6nv/h6mV/d1Pd8IznJaxNsUrPX4h2csheF6L9Uxduh
        ynVCfIeQlgX5u2d4Bak0ykOvrARPaoJLBjPHhIn22Zns9+6jNsIK7poMn84tFtUS
        ozYvsJPGWp1RwgOIP61kUndCqz7L8MQxcd7v0fngMfXXWhtAW93Dp+SMMhXaJHSE
        pPS6OX9LiiYeg3JmiujQS+UUE/DPzvAKMvw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u9fSQOvZQckT for <linux-kernel@vger.kernel.org>;
        Sun, 12 Dec 2021 14:39:34 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JC01x42H7z1RtVG;
        Sun, 12 Dec 2021 14:39:33 -0800 (PST)
Message-ID: <de3dc434-8b87-5d9d-7fe8-bd44ff2bcbfb@opensource.wdc.com>
Date:   Mon, 13 Dec 2021 07:39:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
 <549c1825-56e6-de9e-e109-77f0d06cfd0f@opensource.wdc.com>
 <5322dafd-86ad-a293-6005-29384cb96cc8@omp.ru>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <5322dafd-86ad-a293-6005-29384cb96cc8@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/11 19:25, Sergey Shtylyov wrote:
> Hello!
> 
> On 11.12.2021 2:45, Damien Le Moal wrote:
> 
> [...]
>>>>> platform_get_irq() will print a message when it fails.
>>>>> No need to repeat this.
>>>>>
>>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
>>>>> out a big WARN() in such case.
>>>>
>>>> The reason you should be able to remove the "if (!irq)" test is that
>>>> platform_get_irq() never returns 0. At least, that is what the function kdoc
>>>> says. But looking at platform_get_irq_optional(), which is called by
>>>> platform_get_irq(), the out label is:
>>>>
>>>> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
>>>> 	return ret;
>>>>
>>>> So 0 will be returned as-is. That is rather weird. That should be fixed to
>>>> return -ENXIO:
>>>>
>>>> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
>>>> 		return -ENXIO;
>>>> 	return ret;
>>>
>>>     My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
>>> but returns -EINVAL instead.
>>
>> Thinking more about this, shouldn't this change go into platform_get_irq()
>> instead of platform_get_irq_optional() ?
> 
>     Why? platform_get_irq() currently just calls platform_get_irq_optional()...
> 
>> The way I see it, I think that the intended behavior for
>> platform_get_irq_optional() is:
>> 1) If have IRQ, return it, always > 0
>> 2) If no IRQ, return 0
> 
>     That does include the IRQ0 case, right?

IRQ 0 being invalid, I think that case should be dealt with internally within
platform_get_irq_optional() and warn/error return. IRQ 0 showing up would thus
be case (3), an error.

> 
>> 3) If error, return < 0
>> no ?
> 
>    I completely agree, I (after thinking a bit) have no issues with that...
> 
>> And for platform_get_irq(), case (2) becomes an error.
>> Is this the intended semantic ?
> 
>     I don't see how it's different from the current behavior. But we can do 
> that as well, I just don't see whether it's really better...

The problem I see is that the current behavior is unclear: what does
platform_get_irq_optional() returning 0 mean ? IRQ == 0 ? or "no IRQ" ? I think
it should be the latter rather than the former. Note that the function could
return ENOENT (or similar) for the "no IRQ" case. With that, case (2) goes away,
but then I do not see any difference between platform_get_irq_optional() and
platform_get_irq().

If the preferred API semantic is to allow returning IRQ 0 with a warning, then
the kdoc comments of platform_get_irq_optional() and platform_get_irq() are
totally broken, and the code for many drivers is probably wrong too.

> 
>> I am really not sure here as the functions kdoc description and the code do not
>> match. Which one is correct ?
> 
>     It seems both are wrong. :-)
> 
> [...]
> 
> MBR, Sergey


-- 
Damien Le Moal
Western Digital Research
