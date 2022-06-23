Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFD0558612
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiFWSHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiFWSGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:06:18 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF4EDA5;
        Thu, 23 Jun 2022 10:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=TGE5JNxKMzOY+twQ6t/ggEoZZmn0rKO8MkEsEl3K3GA=; b=XqLEFa8uXRGl7xk0sbFLSCsx5B
        eRC2cYkqiK7rxv6P+gT78b7WFTJgs9CDKOy7EmP/mjfq2HvYNK1jQeHkMLxUNCUuVAE8QnWMzGMN2
        Ua3BTzZkr/X4y7lOWzdy+Oa8nR2fFoEuXK3pL/xU/HKV1km6RdHIzz+gnpRVwnBsQO55Y8GD4huuq
        7my+4fZOYjPjAuXWzmtCtDA9qta2IEGYnwf+Sp/AGOfBCAB5aR8fbRjUkiyLaVq1PuRaUKYKt1rQG
        9wIrdK7hR9/QxaYvzbqjRHpvtt7x2NbGA7beFIM0JOPaeW/sbRaKkST4Sk4232EJXiMLCZDWU7UAq
        uzbbwbuw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1o4QTd-00F5TU-9V; Thu, 23 Jun 2022 11:18:46 -0600
Message-ID: <09153aee-f05e-22ae-dcf5-0fbfb3b9823c@deltatee.com>
Date:   Thu, 23 Jun 2022 11:18:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To:     Song Liu <song@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20220623165552.38645-1-logang@deltatee.com>
 <CAPhsuW50vG=M6JhBEe3qwef10GQt84cg9p_ji5tqyRnMA1-xRQ@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAPhsuW50vG=M6JhBEe3qwef10GQt84cg9p_ji5tqyRnMA1-xRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: song@kernel.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, lkp@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] md/raid5: Fix divide type in raid5_make_request()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-06-23 11:15, Song Liu wrote:
> On Thu, Jun 23, 2022 at 9:56 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>> 0day reports a build failure on the hexagon architecture:
>>
>>   ld.lld: error: undefined symbol: __hexagon_udivdi3
>>      referenced by raid5.c
>>         md/raid5.o:(raid5_make_request) in archive drivers/built-in.a
>>      referenced by raid5.c
>>         md/raid5.o:(raid5_make_request) in archive drivers/built-in.a
>>      did you mean: __hexagon_udivsi3
>>         defined in: arch/hexagon/built-in.a(lib/udivsi3.o)
>>
>> This is caused by using DIV_ROUND_UP on a sector_t type.
>>
>> The actual value is known to be less than 256 so a wide 64bit divide
>> here is not desirable. Thus cast the argument to an int to ensure it
>> uses a 32bit divide.
> 
> I force pushed an update that uses DIV_ROUND_UP_SECTOR_T instead.
> I guess that should also work?

Ah, yes, that'll also fix the bug. I chose to cast to minimize the
performance impact of an unnecessarily wide divide. But I don't have any
strong basis to suggest the performance will be worse with the wider
division. So fix it whichever way you think is best.

Logan
