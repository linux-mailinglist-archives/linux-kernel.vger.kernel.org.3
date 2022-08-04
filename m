Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56DA5899D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiHDJWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiHDJWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:22:31 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118FC65653;
        Thu,  4 Aug 2022 02:22:29 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id k26so20075867ejx.5;
        Thu, 04 Aug 2022 02:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KLFS4WUlaqxZbqoy7i8FOJPlIwGNfBkjIWJSYKEP0DM=;
        b=Lu3eMfFMg5YQ95Hxel+uncrI6PQ4kkPR46VScIK4X0f960uTO6qXwxYB25FfB10msO
         fe9CuDl+RGxNh5NoFuQmLEvMEgcXQPXcsnNmHXSDDW5LqG52/pH/TxdAc9Nn/fAPnS0a
         qkRKon5NRh3UfNXxI0RsJ6r0m4VZGVw2yrsJwJ9HAZ3lDLuwDbpDVpKVxzk+VXJxvqo5
         jVeCRCZJaV4hYwTZg2qaLzRh9BfLbGwy8rG9jpadrnbaEQGT80WFCsG4WtRcgl/TIICK
         JTS4+EhetoTWx4ImNC6GMFUN6eo3grpWM7F+8ksysW26vmrUXPGsERMAA93e3l9OcCbL
         otrg==
X-Gm-Message-State: ACgBeo28Gc/F8G8j9AZanhV+vWZU0sMNvTRB8ky5kVf9CZ4IycpeO4I/
        BjOCPsCU6nUOjM1oC0l4yAs4ahFWoISXSg==
X-Google-Smtp-Source: AA6agR7nr7rXhSDs20ISvDf9usQGNbKryjMfX5Glou808Dft/hnakz10xMZehmVM2yJKUeqPtOtHwQ==
X-Received: by 2002:a17:907:b14:b0:730:abbd:e965 with SMTP id h20-20020a1709070b1400b00730abbde965mr711749ejl.245.1659604947641;
        Thu, 04 Aug 2022 02:22:27 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id a17-20020aa7cf11000000b0043cfb6af49asm377023edy.16.2022.08.04.02.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 02:22:27 -0700 (PDT)
Message-ID: <2d4e82f9-e370-bb01-8656-fe0376c22a77@kernel.org>
Date:   Thu, 4 Aug 2022 11:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tty: vt: selection: Add check for valid tiocl_selection
 values
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <000000000000bbdd0405d120c155@google.com>
 <20220729065139.6529-1-khalid.masum.92@gmail.com>
 <eb4a26aa-da30-ceee-7d27-c1e902dd4218@gmx.de> <YuV9PybMPgc83Jis@p100>
 <1eb62346-304b-54d5-8a62-8a35888d51bd@kernel.org>
 <35e860bb-c76c-ca5f-3f48-2bf6cb798689@gmx.de>
 <0fbc2150-b4aa-f2cb-5084-3a9f69b3455d@gmx.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <0fbc2150-b4aa-f2cb-5084-3a9f69b3455d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 08. 22, 10:44, Helge Deller wrote:
> On 8/4/22 09:15, Helge Deller wrote:
>> Hello Jiri,
>>
>> Thanks for looking into this patch!
>>
>> On 8/4/22 07:47, Jiri Slaby wrote:
>>> On 30. 07. 22, 20:49, Helge Deller wrote:
>>>> The line and column numbers for the selection need to start at 1.
>>>> Add the checks to prevent invalid input.
>>>>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>> Reported-by: syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com
>>>>
>>>> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
>>>> index f7755e73696e..58692a9b4097 100644
>>>> --- a/drivers/tty/vt/selection.c
>>>> +++ b/drivers/tty/vt/selection.c
>>>> @@ -326,6 +326,9 @@ static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
>>>>            return 0;
>>>>        }
>>>>
>>>> +    if (!v->xs || !v->ys || !v->xe || !v->ye)
>>>> +        return -EINVAL;
>>>
>>> Hmm, I'm not sure about this. It potentially breaks userspace (by
>>> returning EINVAL now).
>>
>> Right.
>> According to the code below, my interpretation is that all xs/ys/xe/ye values
>> should be > 0. But of course I might be wrong on this, as I didn't find any
>> documentation for TIOCL_SETSEL.
>>
>> And if userspace tries to set an invalid selection (e.g. by selecting row 0),
>> my patch now returns -EINVAL, while it returned success before.
>>
>>> And the code below should handle this just fine, right:
>>>>        v->xs = min_t(u16, v->xs - 1, vc->vc_cols - 1);
>>>>        v->ys = min_t(u16, v->ys - 1, vc->vc_rows - 1);
>>>>        v->xe = min_t(u16, v->xe - 1, vc->vc_cols - 1);
>>
>> It "handles it fine" in the sense that it can cope with the
>> input and will not crash.
>> But it returns (maybe?) unexpected results...
> 
> After some more thinking maybe you are right.
> In case a user provided invalid values in the past, simply an unexpected
> selection was set, but nothing broke.
> Since the patch doesn't fix any critical issue, we could just drop this patch
> and leave it as is.

We can still do a trial and revert it if something breaks... It's just 
that _noone_ knows with all this undocumented stuff ;).

But in fact, 0 currently means full row/column. Isn't it on purpose?

Today, we are out of luck, codesearch.debian.net gives no clue about users:
https://codesearch.debian.net/search?q=%5CbTIOCL_SETSEL%5Cb&literal=0

thanks,
-- 
js
suse labs
