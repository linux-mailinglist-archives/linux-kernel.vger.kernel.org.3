Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACC15A9DCA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiIARJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiIARJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:09:30 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FE399B75;
        Thu,  1 Sep 2022 10:09:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f24so14908598plr.1;
        Thu, 01 Sep 2022 10:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=XgF6M+PesVCHLnmf4Eb7PhlD2u/USZTKAxq3q69SaJU=;
        b=bUs4FdCTWSx5vGjXpm6LgmxaZOlRC/tQydw2BeeYM+xctCYyL+czt6AtjIpG53REJy
         nyewjQo8axtQXv9ri4O1QBvpwbrxzVMJQVRdSpL4n+gkWOu2tbV4YpUsyJCZJfEhrCoa
         /R9K9jyAN/gwOcR+0umcoo8IQHdh9T8/nJxYfb/5wTF+eUdkj7tS0jCGB9GWibfUhS62
         2oguby9g4snfiHGUC3kS+Q1UA+1m4YoRcZrN+2vyjKFCMWUl8C6ebEHeu3RvgvmPBOFi
         YUOgnt4ulbW3oFSc9ZxW86PoTVIvacKoyaHDGc5/9RWQ/Hl0DNrtQKFwV4G7zHIo8N/D
         Tz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=XgF6M+PesVCHLnmf4Eb7PhlD2u/USZTKAxq3q69SaJU=;
        b=CwTV1W44eU5k42cdEXq2rLU5JwHjS2q63HGDJaS4XPfLezVXaX7HsfDOyfFbVDBLiZ
         VvRIw/egfhN5p7fZTDfnGLzgZhRxtpS7wHlqQ9lIxVKx2JstWZp4cH2enYHVV+H+BQj4
         8uSGzmba0E/I7DTyuzbqCsZPiFNi1sZ6EJJLzbhJaSKcqL1ikdY7JebD533hZgpk+DVf
         1lS0jB/kqI7+9jtnx9wbwNChKiQEgk0OoaU6k957etjQobXNQpjgIhfNyh6OsKm/8Ri+
         5/3PUp78CijPYJSN2+B+4WSsrjW1gYWtvRuQbmGvp/LX3ICWfUhUn6Stq2M/ELgjX28O
         3rOw==
X-Gm-Message-State: ACgBeo2HuSfovfYQfCq6FgDib93QW3KQJOHABIeqy43YGTk192gJmOMg
        PsZZAKM1Q4LbMB48piXaBds=
X-Google-Smtp-Source: AA6agR4e6SNoTLmIBA9axTSFeTDJ7og8kmTIYzM4AhFbrB9ucFhLLgA/Jt5KVFl8sfZpx7Or349LfA==
X-Received: by 2002:a17:90b:4a8e:b0:1fe:1df3:bb11 with SMTP id lp14-20020a17090b4a8e00b001fe1df3bb11mr162994pjb.22.1662052169238;
        Thu, 01 Sep 2022 10:09:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y187-20020a6232c4000000b00537daf64e8esm12244277pfy.188.2022.09.01.10.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 10:09:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4337076c-9585-9650-5646-ee3f90bd5787@roeck-us.net>
Date:   Thu, 1 Sep 2022 10:09:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 19/19] hwmon: (mr75203) fix coding style space errors
Content-Language: en-US
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>, jdelvare@suse.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dkl@amazon.com
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-20-farbere@amazon.com>
 <Yw9Q5krebHnb73vC@smile.fi.intel.com>
 <0074475d-04bc-153a-2df8-dd5f7d014c97@amazon.com>
 <20220901144633.GC3477025@roeck-us.net>
 <2d907196-02c5-ea25-4438-04de77282e75@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2d907196-02c5-ea25-4438-04de77282e75@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 08:31, Farber, Eliav wrote:
> On 9/1/2022 5:46 PM, Guenter Roeck wrote:
>> On Thu, Sep 01, 2022 at 05:21:43PM +0300, Farber, Eliav wrote:
>>> On 8/31/2022 3:15 PM, Andy Shevchenko wrote:
>>> > On Tue, Aug 30, 2022 at 07:22:12PM +0000, Eliav Farber wrote:
>>> > > Fix: "ERROR: space required before the open parenthesis '('"
>>> >
>>> > This patch may have other fixes like adding new blank lines (noted in one
>>> > of the patches in the series), etc.
>>> This patch fixed a specific space error which existed before my changes
>>> and repeated many time.
>>> I fixed the blank line I added a previous patch (but is it isn’t an error
>>> reported by checkpatch).
>>
>> That should really be fixed where it was introduced, not be introduced
>> and fixed here.
> 
> 
> So what do you suggest?
> I can drop the patch from this series and ignore it or move it to be the
> first patch in the series, or publish it separately later on.
> I had it because it was annoying seeing existing checkpatch errors when
> I came to check my change.
> 

Sorry, you lost me. I referred to "I fixed the blank line I added
a previous patch". That should not be fixed in this patch but be dropped
from the patch where you introduced it. Did I misunderstand your comment ?

Guenter
