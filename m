Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD4D4CC4F6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiCCSTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiCCSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:19:18 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1779A15F615
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 10:18:32 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id c18so6806893ioc.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qoi6ItmO2LV8AUzGFrcy7hVeYD1z9lvvPYjP0GHp6Qs=;
        b=MKdL+DwtJZlpBY9IPZzyPWW7YPS7kUVrIxXphWMXykUXqb0MuQG94lCGUMu+M0iNx6
         QQgGdzvrO14SU0yA8tyNzi6910SnuvG2urkHO8CcTDybn31maTD94OhtHQX/CxbRkdEl
         a9xqDaskgXZhC/QjqIZdmrx/yRaHkNRiIgNXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qoi6ItmO2LV8AUzGFrcy7hVeYD1z9lvvPYjP0GHp6Qs=;
        b=2PXkfN61cHJjeZaMyKlF7ZuUiVryNJ7/T1QRLOFur7WJe0bLfR7wBiptNgjkc6htov
         m8s4HkiYUz3eMwH20C3RRJ+pB8cKk+09CqCg8WecAcNA1luFWxUYyjsXvE+trpSPKrhZ
         CHGAwdWRa5AibD9wARIFFwJVRv5gYDfVyNRH07s4o19sCRhhAjIkDVSmtA64EW5QtmLQ
         8L0YSBeFSx0HHIvyVxddq2I53IWgb8vYh6HI+2zZF9kjAli3M6dwfkdlI7bDoz3sZF3U
         jtswb+eRcmSnxIn3OnaGsx5lubzdDQ7qtv9RAazrmjJ0GM9Z7JeNDafp/TXTv7TRf1EW
         rjeg==
X-Gm-Message-State: AOAM531P/10b0lWKpbPZyAg2ctCJIg5q8Ikgx7GNWx/A500FqtHmIF6i
        ii9TM/kZq7nJQBJXizuCmUx+Rw==
X-Google-Smtp-Source: ABdhPJxF7tc/lrJWo3NxoFRUe0jbUT/o6CtvK2W+PyXY5eaMTg9Oeswmgq0pNLka+N6TSaGCC5jlTg==
X-Received: by 2002:a05:6602:2f0b:b0:644:c875:116b with SMTP id q11-20020a0566022f0b00b00644c875116bmr19583051iow.115.1646331511197;
        Thu, 03 Mar 2022 10:18:31 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id m1-20020a0566022ac100b00644bad95365sm2956415iov.39.2022.03.03.10.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 10:18:30 -0800 (PST)
Subject: Re: [PATCH V3] selftests: vm: Add test for Soft-Dirty PTE bit
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, kernelci@groups.io,
        Will Deacon <will@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220224212335.3045905-1-usama.anjum@collabora.com>
 <edf398a7-b1a1-c7c9-5128-f37cfc3a5c95@linuxfoundation.org>
 <52f17759-c7b9-c13b-2c58-f9f2656d26f6@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <537c7ca4-6dde-cbb8-2c44-271acf96666d@linuxfoundation.org>
Date:   Thu, 3 Mar 2022 11:18:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <52f17759-c7b9-c13b-2c58-f9f2656d26f6@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/22 11:55 PM, Muhammad Usama Anjum wrote:
> Hi,
> 
> Andrew had already accepted the patch. I'll send an iteration.
> 
> On 2/26/22 5:35 AM, Shuah Khan wrote:
>>> +#define PAGEMAP_PATH        "/proc/self/pagemap"
>>
>> Why is this names PATH - it is the file name right?
> I'll update the names of the macros.
> 
>>> +
>>> +int clear_refs;
>>> +int pagemap;
>>> +
>>
>> Get rid of these globals and pass these in - please find name
>> that clearly indicates them as fds
>>
> I'll update their names to indicate fds. This is a standalone test
> application. Shouldn't the usage of global variables be fine?
> 

It makes it harder to maintain. Unless there is reason, avoid globals.
I am not seeing a need for globals in this case, other than convenience.

thanks,
-- Shuah
