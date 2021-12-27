Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C35E47FC9C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhL0M2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:28:49 -0500
Received: from www381.your-server.de ([78.46.137.84]:45668 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbhL0M2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ReMqG0aSoprNCxGEtRVQoNHKSS7YN4tBypa9bk6rjoY=; b=HW6LeGA5IS+ecHGwrVOwTAyqtf
        s0e2BTIChJ8fM8bghbM0eJGOYn5MAppw+VGc7L/ucIhGgQ0WE6EW3B1dwsC0MXFFJD82N7bgDPIaE
        mVAWfpsYzr3XrAcuHgMbggl3uJsoBYmtrNkg+KRcnAvaplHNRiTRIn52GptITKZYXNqApxgzohkO9
        QJYHxL+zr0fHJrjAsYEfq0ZcmWDNqibqT8sUscjiENy342RIo+l8CqQHU7uKMGmJgaJdxykm5asXj
        qMZrL/joiQV0iMEKNgCaI6LA3OyyNUFTPJ2Jho5Ccu/j4ywcRhT/FD5lZOSASVw5uEkKCkGyMMbNl
        eKIqbjmQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1n1p7L-000C0R-6t; Mon, 27 Dec 2021 13:28:43 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1n1p7L-000O6l-0Y; Mon, 27 Dec 2021 13:28:43 +0100
Subject: Re: [PATCH v2 04/23] counter: Provide a wrapper to access device
 private data
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-5-u.kleine-koenig@pengutronix.de>
 <YcmdNr8Y1jcMCwQQ@kroah.com>
 <cb583f3f-2cf9-2de5-8beb-da7c11ff1481@metafoo.de>
 <YcmpG78dI2nT/N8z@kroah.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <93232592-f8df-2413-25c4-da697493eb84@metafoo.de>
Date:   Mon, 27 Dec 2021 13:28:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcmpG78dI2nT/N8z@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26404/Mon Dec 27 10:34:40 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 12:52 PM, Greg Kroah-Hartman wrote:
> On Mon, Dec 27, 2021 at 12:34:28PM +0100, Lars-Peter Clausen wrote:
>> On 12/27/21 12:02 PM, Greg Kroah-Hartman wrote:
>>> On Mon, Dec 27, 2021 at 10:45:07AM +0100, Uwe Kleine-König wrote:
>>>> For now this just wraps accessing struct counter_device::priv. However
>>>> this is about to change and converting drivers to this helper
>>>> individually makes fixing device lifetime issues result in easier to
>>>> review patches.
>>>>
>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>>> ---
>>>>    drivers/counter/counter-core.c | 12 ++++++++++++
>>>>    include/linux/counter.h        |  2 ++
>>>>    2 files changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
>>>> index f053a43c6c04..00c41f28c101 100644
>>>> --- a/drivers/counter/counter-core.c
>>>> +++ b/drivers/counter/counter-core.c
>>>> @@ -45,6 +45,18 @@ static struct bus_type counter_bus_type = {
>>>>    static dev_t counter_devt;
>>>> +/**
>>>> + * counter_priv - access counter device private data
>>>> + * @counter: counter device
>>>> + *
>>>> + * Get the counter device private data
>>>> + */
>>>> +void *counter_priv(const struct counter_device *const counter)
>>>> +{
>>>> +	return counter->priv;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(counter_priv);
>>> Shouldn't this be usin gdev_get_drvdata() and using the private data
>>> pointer that is already on the struct device structure itself?  The void
>>> *priv; should be dropped from struct counter_device entirely.
>>>
>>> Oh ick, I just now looked at 'struct counter_device', there are other
>>> reference counting issues in there (hint, struct cdev has a reference
>>> count...)  But that's independent of this patch series...
>> This is not a problem. The struct cdev holds a reference to the struct dev.
>> This allows them to use the same allocation. As long as there is a reference
>> to the cdev there will be a reference to the dev and the memory will be kept
>> alive.
> Ick, a cdev shouldn't be doing stuff like that, but I see how people
> like to use it that way :(
>
Can you explain why cdev shouldn't be doing that? This commit has some 
backstory why this is done 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=233ed09d7fdacf592ee91e6c97ce5f4364fbe7c0


