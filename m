Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4544B50D9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239249AbiDYHMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiDYHMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:12:41 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485FB13D0A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:09:38 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id b24so17233533edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=sg9feMviCHdG94RDG+nWSdf+6RbZFSQkEE0emSIzP9E=;
        b=uKtdW1FRllrb7mAaguFwj9w+rYS82rEV852QmAPnZ7js1wQKMwWYh5cCOuPycll5yq
         HzLQnyIlnF6CQbqnwc8+yt09PSUrarWmqeMj09z0am08cUtaQd3sQVB6B0xG+ieXiHE3
         siOVYCCXhTN1wOrwIi0sKDafxtMdBEH4WY6eObD19H7wSKcIHTmw5d3rk/Voc6gN/X2u
         Wa/W4RUh1y5E5XECZP5cj5rmULcua73Jl2csapHq+0Z+Pi+diUVTWets4+5L1LAHZDZo
         DAHFX92cjJhMpP39Yt4RZrc7dgqSnxju0KRwpvYIpaK4Vf2NiFoa0ZjpSo89qSWMV/bA
         ctCA==
X-Gm-Message-State: AOAM531GhgTHrPTgyEp+34fIgBnytr+jA+ZAuLzS8QewzeWwUWd2CICd
        fvWiXwisNOHWnKg8ULFthKY=
X-Google-Smtp-Source: ABdhPJxUenNccdhcW9gy2ncnDs0yZ9AYmoeoZp7shE8KbYuVh8zD5cu5muIk2pt5GAMG3j3TJuOWVQ==
X-Received: by 2002:a05:6402:4306:b0:423:e52b:389 with SMTP id m6-20020a056402430600b00423e52b0389mr17492180edc.230.1650870576713;
        Mon, 25 Apr 2022 00:09:36 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id vr7-20020a170906bfe700b006e8325fe130sm3270370ejb.31.2022.04.25.00.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 00:09:36 -0700 (PDT)
Message-ID: <b2363c1a-89e3-0de2-fe2a-3b529c8fb3e4@kernel.org>
Date:   Mon, 25 Apr 2022 09:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] tty: vt: consolemap: Add missing kfree() in
 con_do_clear_unimap()
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     =?UTF-8?B?6IGC5rGf56OK?= <niejianglei2021@163.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220303020630.460257-1-niejianglei2021@163.com>
 <4a7fe3ca.68b6.17f6eacb952.Coremail.niejianglei2021@163.com>
 <71d92931-ac01-be32-a7ef-9f533096ab49@kernel.org>
In-Reply-To: <71d92931-ac01-be32-a7ef-9f533096ab49@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 04. 22, 8:59, Jiri Slaby wrote:
> Hi,
> 
> On 09. 03. 22, 13:34, 聂江磊 wrote:
>> I found this bug by using clang static analyse checkers. I found that 
>> function con_release_unimap() is only called in this 
>> file(drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c). There 
>> are totally 5 times that con_release_unimap() is called
>> (line 430, 466, 522, 599, 673) while con_release_unimap() is not 
>> followed by kfree() only in line 522. So I think it is a bug
>> and make this patch.
>>
>>
>> At 2022-03-03 10:06:30, "Jianglei Nie" <niejianglei2021@163.com> wrote:
>>> We should free p after con_release_unimap(p) like the call points of
>>> con_release_unimap() do in the same file.
> 
> But this one does not free it on purpose, right? See below.
> 
>>> This patch adds the missing kfree() after con_release_unimap(p).
>>>
>>> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
>>> ---
>>> drivers/tty/vt/consolemap.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
>>> index d815ac98b39e..5279c3d27720 100644
>>> --- a/drivers/tty/vt/consolemap.c
>>> +++ b/drivers/tty/vt/consolemap.c
>>> @@ -520,6 +520,7 @@ static int con_do_clear_unimap(struct vc_data *vc)
>>>         p->refcount++;
>>>         p->sum = 0;
>>>         con_release_unimap(p);
>>> +        kfree(p);
> 
> You've just broken con_set_unimap(), or do I miss something?

No, you did not. The interface is terrible and deserves cleanup.

I found this, likely related, syzkaller report in my INBOX:
https://lore.kernel.org/all/000000000000ee58d305bbe9197a@google.com/

Care to test the reproducer both with and without your change? Does your 
patch fixes the issue. And if it does, could you add this to your patch:
   Reported-by: syzbot+bcc922b19ccc64240b42@syzkaller.appspotmail.com
? So that syzbot verifies the patch.

Once you do all this, I will re-review the patch and the code. The code 
is really very hard to follow, so I cannot decide whether your patch is 
correct or not ATM.

And provided the above, I put a note to my TODO list to restructure the 
code, so that people know what's going on there.

thanks,
-- 
js
