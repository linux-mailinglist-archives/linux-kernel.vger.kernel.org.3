Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8174548D577
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiAMKMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:12:13 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.170]:62589 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiAMKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:12:12 -0500
X-KPN-MessageId: 173f36dd-7459-11ec-8a6e-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 173f36dd-7459-11ec-8a6e-005056ab378f;
        Thu, 13 Jan 2022 11:10:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=U4vp44AnZ5Sm4wjIdEGf82gj0OyXN7SX1daLEDooE8w=;
        b=joqhXv0b9zZ88VA3bDNivTti3agum1tqgxO10Pot4mvJRpuL1EiMXUYMACeKndLa005tI68ht67Rk
         mVp/vYhWCyY0EnAjMrESP9WBqSk4hUvUvk2OGqWUxYz2dJAEIqOW1n/PNx0e86cvFZRxih9zaKrO72
         YEHgw5OEzG/DDTu8WGkxXHNsqPpe6A3I4hWGVtF0v4xykjdFiMFpuL8xFjPB5fTPmvVJXncxGKG9lj
         ZAkWjj84tBgG8RFt79rnkGexkBMtuwMOZAjRRx1+uWmVZymjUI+tmNHSawiteCg7zBRdwLyAgul59f
         MQjlkupsamOrM2kYr6Okf2dQEaHOsJw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|abRklbXazyZSqBtA3RCEWPUMD2yK4vme8R/T/X2A/lFkVJo427P3OuijCCvGPZl
 7ZSb7HOm8+qSmaygSzKA30A==
X-Originating-IP: 193.91.129.219
Received: from [192.168.2.10] (cdb815bc1.dhcp.as2116.net [193.91.129.219])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 453a3cb8-7459-11ec-94d2-005056abf0db;
        Thu, 13 Jan 2022 11:12:11 +0100 (CET)
Message-ID: <209cbcc3-6e4a-54d7-2340-8566a6d248f1@xs4all.nl>
Date:   Thu, 13 Jan 2022 11:12:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.1
Subject: Re: [PATCH] media: vidtv: Check for null return of vzalloc
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, dwlsalmeida@gmail.com,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220112020720.692110-1-jiasheng@iscas.ac.cn>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220112020720.692110-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2022 03:07, Jiasheng Jiang wrote:
> On Tue, Jan 11, 2022 at 05:58:10PM +0800, Hans Verkuil wrote:
>> This doesn't free e->name!
>>
>> Actually, the same issue is also present later in this function:
>>
>> ctx = kzalloc(priv_sz, GFP_KERNEL);
>>        if (!ctx) {
>> 	        kfree(e);
>> 	        return NULL;
>> 	}
> 
>>> +		kfree(e);
>>> +		return NULL;
>>> +	}
> 
> Thanks for your reminder.
> I have sent a v2 to fix it.
> And also I have sent a patch to fix the 'ctx' with
> 'Reported-by: Hans Verkuil <hverkuil@xs4all.nl>',
> since they are two different things.

Actually no. It's all the same thing: not correctly freeing allocated memory
in a function.

Please combine it all in a single patch.

Perhaps this should use the 'goto' method of cleaning up after errors instead
of duplicating kfree()s in two places. A bit borderline what works best here.

Regards,

	Hans

> 
> Sincerely thanks,
> Jiang
> 

