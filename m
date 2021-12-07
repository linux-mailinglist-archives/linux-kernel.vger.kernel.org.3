Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFC746C408
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbhLGT5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbhLGT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:56:38 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46C3C061574;
        Tue,  7 Dec 2021 11:53:07 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id be32so600345oib.11;
        Tue, 07 Dec 2021 11:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ocpM13shdrzspJtzRbkfnFcsNjtIdLeSrTT2g1ZXEgg=;
        b=KlhSt382SwfpGFCkrH6ZqVbc7kTqq0K5xD0J0TieVmpOk+pQprsi6iF0SYbo7HRDkA
         Llzpz1yPrYAwwR603VeO+MPu4GPF1gSiiudAxC8/AiTkBIyVivzKmX1elT0iuBy0mhiD
         wHjo62yYzw+rwNTwIfXiSJok/pRGyEqamnchkVE3QT7Lo4wTTqg86nse0NhHfeDP/fYw
         EkFbhoXHBeBRsKAIpgehk54LkgtIeryqwpx5s+wBxKC9KQbiUrspQb74kcKhAwGO8+A9
         2+F8UbaIQtQxaITkkD+7iP0EUVg4DIkAINOP2bIT3qTdq+zw1kiuLQhx6AkxGvDvExX2
         lmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ocpM13shdrzspJtzRbkfnFcsNjtIdLeSrTT2g1ZXEgg=;
        b=Jzm6y+lw0o/t377zbiJIcMadk5njTYNx0ZW3CscKSFRtzxBPuiMNQRjcpxKYqGDmq8
         LDorIL1m5K+x3997JB93zPlqm3ACFVpogSlkF4b945aQHMDBT9SSzDtLyo5XhKNEXJ2I
         xFmS+YnMQZh4FItUCjBtfL3sv7ETzrtB3VvVoc3RpplZDrgviBg7I3m4UpyHDSOA56gX
         puGOHVqJDVSN7rG7K3+ydsYNEmA+5Mao5Uwdppp9VX7ZrR2Ix8bC2xGWSlWJhVe4QVMR
         soChu4O+ErlJR5eP+EgwlcSHSw90SLdaEU3Evds/Y0dLjVLSq4FXImNmoCNLMURqqAOy
         Yy8A==
X-Gm-Message-State: AOAM532tx4PHiLu8AeLFxv1ZvUT61mFER+bCVxC7rmETpm9pnoBq3vZQ
        eZmIQgzVBIh6VN/ZJCQLTc5sm1/GK88=
X-Google-Smtp-Source: ABdhPJz9CzLS0f3B265ofV4rL23LMd8YvSPc0WWvZKz7yBSBzmiOhGYjDWJEYa7Vw5nWmyJ8I0tQPQ==
X-Received: by 2002:a05:6808:23d6:: with SMTP id bq22mr7233235oib.71.1638906786835;
        Tue, 07 Dec 2021 11:53:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q22sm103043ots.62.2021.12.07.11.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 11:53:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 1/2] hwmon: (pmbus) Add Delta AHE-50DC fan control
 module driver
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211207071521.543-1-zev@bewilderbeest.net>
 <20211207071521.543-2-zev@bewilderbeest.net>
 <20211207175015.GA772416@roeck-us.net>
 <Ya+0YDWIRBQFnEDb@hatter.bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9ff85af2-f707-ee62-cc32-2dd628e5c63f@roeck-us.net>
Date:   Tue, 7 Dec 2021 11:53:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya+0YDWIRBQFnEDb@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 11:22 AM, Zev Weiss wrote:
> On Tue, Dec 07, 2021 at 09:50:15AM PST, Guenter Roeck wrote:
>> On Mon, Dec 06, 2021 at 11:15:20PM -0800, Zev Weiss wrote:
>>> This device is an integrated module of the Delta AHE-50DC Open19 power
>>> shelf.  For lack of proper documentation, this driver has been developed
>>> referencing an existing (GPL) driver that was included in a code release
>>> from LinkedIn [1].  It provides four fan speeds, four temperatures, and
>>> one voltage reading, as well as a handful of warning and fault
>>> indicators.
>>>
>>> [1] https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-kernel/fancontrol-mod/files/fancontrol.c
>>>
>>
>> Hmm, that reference isn't really accurate anymore. I think it would be
>> better to just say that the device was found to be PMBus compliant.
> 
> Sure, will do.
> 

Makes me wonder: How do you know that the referenced driver is for Delta AHE-50DC ?

Guenter
