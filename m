Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C837347C137
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbhLUOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:12:21 -0500
Received: from www381.your-server.de ([78.46.137.84]:60726 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhLUOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=8p7ecK45hVMn5gLDPgo9VsNqGb2KdV/HRhC09pdrmXQ=; b=auQvbmMR1lTu3+4B8lLJSfCCri
        jztKfEm+WOTER+y7KhwgBnlpRm2QYYXRlqr1SkrvZ7TFaZILqUl3Gokrjj/L1yjQUkWvGTCT5rhkw
        NMugzh36V7+wYIIucohNF+O22YE2RZkk2RZB+vd3A648gPXQSNwZw1+6ZTE+g2+EIsVQaEKlL8s7A
        3BDXMLIcpaEgLntQPQBqGN0bd7kDy9RZnkOvlpS2XQ0g28xywVGyudp9lxDjQnPrTlpKGl1B9QAAy
        iPd7Rr3ZbwWkZf1201pumlFkbn5Hqx5rY1TjHZK7mYNsX3OfullOvzRDiUIzepbsNY8PxlmAIa/gV
        QiVKHiCA==;
Received: from [78.46.152.42] (helo=sslproxy04.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mzfs7-000CA8-6D; Tue, 21 Dec 2021 15:12:07 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mzfs6-000PVb-PF; Tue, 21 Dec 2021 15:12:06 +0100
Subject: Re: [PATCH 0/8] counter: Remove struct counter_device::priv
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20211221104546.214066-1-u.kleine-koenig@pengutronix.de>
 <dadb79b2-ac21-1899-48b9-1c6723afb1b4@metafoo.de>
 <20211221113542.rl4aburbzzrgs3km@pengutronix.de>
 <65009237-7e61-21aa-60cd-b7f7e0bb2f91@metafoo.de>
 <20211221132258.472t537373vto7bz@pengutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9d5788ab-4576-08c3-e347-9348aba3804a@metafoo.de>
Date:   Tue, 21 Dec 2021 15:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221132258.472t537373vto7bz@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26395/Tue Dec 21 10:18:41 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 2:22 PM, Uwe Kleine-König wrote:
> On Tue, Dec 21, 2021 at 01:04:50PM +0100, Lars-Peter Clausen wrote:
>> On 12/21/21 12:35 PM, Uwe Kleine-König wrote:
>>> On Tue, Dec 21, 2021 at 12:12:12PM +0100, Lars-Peter Clausen wrote:
>>>> On 12/21/21 11:45 AM, Uwe Kleine-König wrote:
>>>>> similar to patch
>>>>> https://lore.kernel.org/r/4bde7cbd9e43a5909208102094444219d3154466.1640072891.git.vilhelm.gray@gmail.com
>>>>> the usage of struct counter_device::priv can be replaced by
>>>>> container_of which improves type safety and code size.
>>>>>
>>>>> This series depends on above patch, converts the remaining drivers and
>>>>> finally drops struct counter_device::priv.
>>>> Not sure if this is such a good idea. struct counter_device should not be
>>>> embedded in the drivers state struct in the first place.
>>> Just to mention it: My patch series didn't change this, this was already
>>> broken before.
>> I know, but this series has to be reverted when the framework is fixed.
> All drivers have to be touched. With my patch series you have to modify
> one function in each driver, without my patch you have touch nearly
> every function.
>
I'm not so sure. I don't see how you have to modify every function. 
You'd keep using priv to get a pointer to the state struct.

That said having a centralized function in each driver to get the state 
struct from the counter device doesn't hurt either.


