Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB73048686C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbiAFRZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiAFRZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:25:26 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC6BC061245;
        Thu,  6 Jan 2022 09:25:25 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id t23so4693061oiw.3;
        Thu, 06 Jan 2022 09:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TozlrHGra5XodYQFqCtDs+94E5DctxLnj7llPHao5XY=;
        b=ShaVbv1mLd0t/CMtcyvNeH+MVOScPrT2gNMh1L9O+mbMwJJEzoCnU5bOVvLFTFbx29
         CIW3P5q5QyTpy6pyT4EBsYGYXOSQLWhxqlXSWfnWtyEM+kiCOhVqB0YrvaAr2Pk9qUfa
         VgIycswwxuc31jd4f9ZqkD2jM3fV2euzyj67EIHLT7Ll2jMm9UUjf1fkvMygD61A+3Ic
         t45RWPwOVlul4HkRHH39SgCXbeZoXSxQa0AQHbwXUAVYIAbixIN8mkdNtQK1Q99yR8Sh
         xuQXgPXx9dG3G2WLjltBRGzGRstCVw7RH6mR7QyEn/GVsqzMACOU0P65oBDvCJ0+V0EC
         H+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TozlrHGra5XodYQFqCtDs+94E5DctxLnj7llPHao5XY=;
        b=w5Wdw74Xjjr/8Vj0OILSOTpeVr+oss1HNZFbTwJHvkB0mL3hRyjX7VYWNFh7zg49Yl
         51BFaJoKO5U8CNPUz8V6pCzSSncxHP7DUV1wkKf8po65G+HoVHPHGrA+io9CqCw/T8BR
         k7zZ1HXIOAIYMj0GsIg3H4QQ4ek/+itmrlcgD+Aj76QanOZPzpXEAM5BmH4w5MZcA5kp
         Q+AUJU3uHSYNGdUAhA+5ArI/KHB7/u7hGDMVtTrzmwORT92cNthN7GvWwG7/o/GnTPE+
         zqfbCt+ObSHcjyZ5GEQmlNyyuhA1ge6GbNpH6xbnV6Pmzerw7vWQBWBsPb7MPqFa5j5M
         /Sdw==
X-Gm-Message-State: AOAM5330DvnZ6tSfsW9EmTvvcFxlTMdg9a89jvOeNXCHzEytney2JqdN
        PlIgzFClFSRjvmHol2dTzDw=
X-Google-Smtp-Source: ABdhPJwaVLxSFBfd3Dmpfs7ev1L4qtYx6bsFTZlvyEcxN0rHUzXDQWgkZ5ORNW5g6GbEH+1WZr5Ezw==
X-Received: by 2002:aca:ad57:: with SMTP id w84mr6597267oie.69.1641489925201;
        Thu, 06 Jan 2022 09:25:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bi20sm513287oib.29.2022.01.06.09.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 09:25:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        alistair@popple.id.au, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsi@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <2cafa0607ca171ebd00ac6c7e073b46808e24f00.1640537669.git.christophe.jaillet@wanadoo.fr>
 <YcldM9sgYdjMYMtH@kroah.com> <20220106081418.GH7674@kadam>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] fsi: Aspeed: Fix a potential double free
Message-ID: <f2ba50fd-5c6b-e905-17ed-541dcc98c6c1@roeck-us.net>
Date:   Thu, 6 Jan 2022 09:25:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106081418.GH7674@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/22 12:14 AM, Dan Carpenter wrote:
> On Mon, Dec 27, 2021 at 07:29:07AM +0100, Greg KH wrote:
>> On Sun, Dec 26, 2021 at 05:56:02PM +0100, Christophe JAILLET wrote:
>>> 'aspeed' is a devm_alloc'ed, so there is no need to free it explicitly or
>>> there will be a double free().
>>
>> A struct device can never be devm_alloced for obvious reasons.  Perhaps
>> that is the real problem here?
>>
> 
> I don't understand how "aspeed" is a struct device.
> 

-static void aspeed_master_release(struct device *dev)
-{
-	struct fsi_master_aspeed *aspeed =
-		to_fsi_master_aspeed(dev_to_fsi_master(dev));
-
-	kfree(aspeed);
-}

So "dev" is embedded in struct fsi_master, and struct fsi_master is embedded
in struct fsi_master_aspeed. Since "struct device" is embedded, the data
structure embedding it must be released with the release function, as is done
here. The problem is indeed that the data structure is allocated with
devm_kzalloc(), which as Greg points out must not be devm_ allocated
(because its lifetime does not match the lifetime of devm_ allocated
memory).

> I've been working on understanding device managed memory recently for
> Smatch.  It's really complicated.  There are a bunch of rules/heuristics
> that I'm slowly creating to generate new warnings but I'm a long way
> from understanding it well myself.
> 

A data structure embedding struct device must not be devm_ allocated,
and it must be released with the release callback. Maybe there is
a means to flag that somehow ?

Guenter
