Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2647F3E9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 17:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhLYQvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 11:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhLYQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 11:51:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C12C061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 08:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wsaEp8FpOrsMR7hdUijn/Ayn2hbvWW5sOKNhHYvyCvk=; b=Mvhu9beqMWArSZTHRpd9TzYmai
        ldhOIcmJgcKbjVGepTMAteS3afzz+4QqScOLkTHxb5kBRLJp2S707Gr5tAt12Ti21y7xUaB2pWDd/
        7fb53r2wAdTI5XjoWHtyP9VSx6T+mHoZP34+0+hWPkbI0QcKEm1QnpSbuYBzNI5LPgoBx0TKxpWiQ
        6VqOnx5CbtaULetWSlge/GQfkZ8alchJ/83NeNu9AMNjM6QL6hOs3Yau78vzsQow9kQHVsvyL1zgJ
        yiAf8ZxDStKM5u8PjBUStMFt7Ff0QjmfLgGFOjmWX22tcY16CYHP/v8u/PnLGImg0smsHhKgO2hya
        SIYcgYUg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n1AFv-005w3e-9X; Sat, 25 Dec 2021 16:50:52 +0000
Message-ID: <b6b7f31c-fe98-3129-d8a4-68ac050b570a@infradead.org>
Date:   Sat, 25 Dec 2021 08:50:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] driver core: platform: Fix wrong comment
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211223025346.1236195-1-jiasheng@iscas.ac.cn>
 <CAHp75Vdh9x0Xj5zQN0WhZxDjusWi5ow4s3m6Vrg6_e8ngaEuxA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHp75Vdh9x0Xj5zQN0WhZxDjusWi5ow4s3m6Vrg6_e8ngaEuxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/25/21 08:47, Andy Shevchenko wrote:
> On Sat, Dec 25, 2021 at 2:02 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>>
>> I notice that there is a 'WARN(ret == 0, "0 is an invalid IRQ
>> number\n");' before 'return ret;', which means that it is possible to
>> return 0 if fails.
>> Therefore, it might be better to correct the wrong comment.
>> And also there is reply sent by Damien Le Moal because I submitted a
>> patch to remove the non-zero check of the platform_get_irq() previously.
>> Damien Le Moal said that the comment for platform_get_irq() is wrond
>> because it can actually return 0.
>> Moreover, platform_get_irq() returns platform_get_irq_optional().
>> As a conclusion, the comments of the platform_get_irq() and
>> platform_get_irq_optional() should be fixed.
>> Not only that, the comments of platform_get_irq_byname() and
>> platform_get_irq_byname_optional() have the same error.
>> This time I only submit one as an example.
>> If the patch is right, I will submit another version to fix all.
>> But, I also notice that the 'return 0' is removed intentionally in the
>> fixed tag.
>> I am not sure which one is right.
>> Anyway, the success IRQ number should be 'postive' other than
>> 'non-zero'.
>> So the comment should be corrected.
>> Here is the mail from Damien Le Moal.
> 
> ...
> 
>> Fixes: c2f3f755f5c7 ("Revert "driver core: platform: Make platform_get_irq_optional() optional"")
> 
> How can it be a Revert?

That's the "title" of that commit:


commit c2f3f755f5c7
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed Apr 7 11:47:56 2021 +0200

    Revert "driver core: platform: Make platform_get_irq_optional() optional"

-- 
~Randy
