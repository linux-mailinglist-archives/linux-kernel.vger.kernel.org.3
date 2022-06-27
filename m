Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2850E55D344
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbiF0UA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbiF0UAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:00:23 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2870D1C919
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:00:23 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id u20so10715840iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PmCKzNT4RC0cnhUtaHaQ03s7DAWtzdqqPOrOyNCaBG4=;
        b=Lt+YE31WcR2166d1SPefS3gly61tzJRoFn0vjHM7iUytsQWmwywyNP1NhELFviJYJg
         z0yK8zqzfS6guP+e0ELetZxZop9Da7wzGBAYCsqVaQfxTnumc17G9lIZt69fr37cvpD8
         O81in/LREwcQ83rDdRe+gnb+QaVaEnmCak8yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PmCKzNT4RC0cnhUtaHaQ03s7DAWtzdqqPOrOyNCaBG4=;
        b=4rbLlk4BTqqmhk6ybty3yuslzBfklZz7qWZv5bYTWIwViKDGXLcmKFb4B6arCSQR8L
         t3R0nzYs0/Ylf3z/QEfmTDoxUSqlHdiExRQ+IwvT86FfUge3cnaE291roHenUKzOQbgS
         1IFHfUuIsh+zRpfZyZA1poDFMkqjfhMp38qJKitTI4DwoeO4rexkwKJJf/RXQJBP5ImH
         aWcZwC7tBggXl8RXoFFuxau8zGu4gOZ+rh68Dgdwn4Ol0EV+gYYin0gk3J3tFQGF7u7J
         9/xuw3t/kWMA+78CrirBTWMSbEepmO5QV3e1ecomxt0oaurrL+W28NELEkoowV7K1dHC
         m+NQ==
X-Gm-Message-State: AJIora9eJQOLirOYm4KQmB6lWZd1qcwCSrhfOv9KHwD62CvCyBVrf+wZ
        sIJGY01tBa0x7MVkDnEPHd7Lew==
X-Google-Smtp-Source: AGRyM1sxkFZ/FihbfEp2fsnz9ta8t0G6W1fz3wAwi7f1Z8Fj4gM/2esUWtYgHvBxcSjeadYfKWjDOQ==
X-Received: by 2002:a05:6602:2c4e:b0:657:4115:d9e4 with SMTP id x14-20020a0566022c4e00b006574115d9e4mr7259526iov.91.1656360022577;
        Mon, 27 Jun 2022 13:00:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r16-20020a02b110000000b0032e271a558csm5039190jah.168.2022.06.27.13.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 13:00:22 -0700 (PDT)
Subject: Re: [PATCH v12 3/4] trace/objtrace: Add testcases for objtrace
To:     Jeff Xie <xiehuan09@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220606160943.663180-1-xiehuan09@gmail.com>
 <20220606160943.663180-4-xiehuan09@gmail.com>
 <20220626010331.f2be529cfb52706d58bbdc2f@kernel.org>
 <CAEr6+EB2_nfpZW00_4pDcvhqpO9abEPZNA5m8pU6DmNWPRKjEQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <55f53474-a2c8-dd56-a473-8cec8d2f9e8e@linuxfoundation.org>
Date:   Mon, 27 Jun 2022 14:00:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAEr6+EB2_nfpZW00_4pDcvhqpO9abEPZNA5m8pU6DmNWPRKjEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/22 11:05 AM, Jeff Xie wrote:
> Hi Masami,
> 
> On Sun, Jun 26, 2022 at 12:03 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>> Hi,
>>
>> This looks good to me (and I tested).
>>
>> Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> BTW, please use 'selftests/ftrace:' tag instead of (or in addition to)
>> 'trace/objtrace:' for the ftracetest patch. And please Cc to
>> linux-kselftest@vger.kernel.org and Shuah Khan.
> 
> Thanks for the reminder, I will do it like this in my next version.
> 

Yes. Please. It isn't my Inbox or patchwork ... Send v2 with Masami's
Tested-by and Ack so I can pull this in.

thanks,
-- Shuah
