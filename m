Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6765138F4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349600AbiD1PsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiD1PsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:48:14 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B27B82FF;
        Thu, 28 Apr 2022 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=gvJz6sqFlaEQGD6lcXzp69sVdGtInkBQvjRmlLbR5ak=; b=qixCMonDiIRsFDEpSRl3891/1+
        tT/M5WDnhgOwXTofaaBSbmdRZkWUZwhxQt7z7IDqZJGYA99f38sgg8P2Is/MdpUYmjEKkIU/9F86G
        tMJdqmvH5U60F+heJPUJGBVT2y5SsbDYGZRkjELobUZBkmD1Omz84wWQRvXldlJKn1hh46AiNwUOg
        Uk0gI2cCDuVjKiwZNTY5A6cinBUmW+lwvZxALpaKsLQiBaz6YX4jpwaOopZKI6kXqMe3lw9bf6ijb
        WYjNp6k8jPTVEk7y2+aq7EfskukWBDCSgzKofs0k22wOFZaS5Kw/s8Ou7im/cPkS4iMouxx+lHsvn
        Mm2JMvlw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nk6K6-001693-Ci; Thu, 28 Apr 2022 09:44:56 -0600
Message-ID: <78a6ffae-7701-e0dd-3130-a9a95473d16b@deltatee.com>
Date:   Thu, 28 Apr 2022 09:44:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-CA
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-2-logang@deltatee.com>
 <2a6d5554-4f71-6476-6d14-031da52005f5@linux.dev>
 <fe7f6d8a-8c66-3e90-1c52-140fe9d4cf1a@deltatee.com>
 <19d88098-7e52-38de-ceb7-a68debfbbd10@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <19d88098-7e52-38de-ceb7-a68debfbbd10@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: guoqing.jiang@linux.dev, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 01/12] md/raid5: Factor out ahead_of_reshape() function
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 2022-04-27 19:49, Guoqing Jiang wrote:
> 
> 
> On 4/28/22 12:07 AM, Logan Gunthorpe wrote:
>>
>> On 2022-04-26 19:28, Guoqing Jiang wrote:
>>>>    +static bool ahead_of_reshape(struct mddev *mddev, sector_t sector,
>>>> +                 sector_t reshape_sector)
>>>> +{
>>>> +    if (mddev->reshape_backwards)
>>>> +        return sector < reshape_sector;
>>>> +    else
>>>> +        return sector >= reshape_sector;
>>>> +}
>>> I think it can be an inline function.
>> Marking static functions in C files as inline is not recommended. GCC
>> will inline it, if it is appropriate.
>>
>> https://yarchive.net/comp/linux/inline.html
>> https://www.kernel.org/doc/local/inline.html
> 
> Thanks for the link, then I suppose those can be deleted

> linux> grep "static inline" drivers/md/md.h -r

It's standard practice to annotate small functions in headers with
"static inline". Without the inline annotation, any C file that includes
the header and doesn't use the function will emit a "defined but not
used warning".

Functions in headers also should, by definition, be small and
specifically inline-able (ie they are used as a type-safe macro).

static functions in C files (not headers) should not have the inline
keyword as GCC can optimize them and inline them as it sees fit and the
inline keyword doesn't actually do anything.

Logan
