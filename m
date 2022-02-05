Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392194AA7B5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 09:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379515AbiBEIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 03:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347634AbiBEIfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 03:35:13 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F2C061346
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 00:35:12 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e16so7032311pgn.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 00:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fkTkvIP1ksf7uTo0WnrI6Zk5yqUnR9qRAK3kp+P4vDY=;
        b=fqqbL8yWOsB5S0NTjUYHVzDu7PhUUHegmjtvvDjiaYvMfTU3zZQr/614rjpSeXFbft
         AS+xTziB6ewRkCK+rBFa+gF+cWjcgddMKVhGA+n0pjFZnCDRlmzIDeM/wODugoOQu5LA
         opknqAI0tqtX1TmFVYs/uNhjxKhKUCHNAjGDnwpifTVWys4fy5Tq/yX8jMxRPmqpKESW
         w7NgShoRNevZUoeud2rcs6mfmGDm1wjO6vQfEMcZ5oWfzrTdgOycKZ8Cf50+NIy9b5AZ
         /lQeiij9jeCnbMZgHTJzPWVfc2XZ8IDfYmFs9PeZAud0Uaa9rkYwkLkJpMsbdioUsvtQ
         hPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fkTkvIP1ksf7uTo0WnrI6Zk5yqUnR9qRAK3kp+P4vDY=;
        b=m5KPCnaW0/92a7tESs5kX874TpoK4J0eezj2VCxLOuQX8tfXaILxEBzoDzshokV8d+
         h4LNNpAyuIf1hdA2WLWedCKn6IE5Y/iHOU+78QdxdMv0wF+paWhALzmil5IvEk4JUE3R
         mKQ+UtCoeXCOa/qsBhIs/E3Sr7xs+QhrT7SugSffUuaZLae37FZglxYRSdg+01zq0ME2
         uiLGkvCehqlgcwu6Ch9Ope8INnLMHPWwDxLcZWMrboMdRr2aPCD19EgAOjWFFnwnypsT
         RpSLgx82liy3zlB4gp3dglo5gJKqaFrJKm3z8g3ZoADKjK4r9hrry6VAruk0BJS6ilcj
         A5SQ==
X-Gm-Message-State: AOAM533LPa0M+gBLX3jeWjMPzRpRfKW6FtgRga8A6WWicnGsbz98YgNq
        W0wqBxty6DKr7MwSEdNT/NdB2tRu1Lw=
X-Google-Smtp-Source: ABdhPJy4ozOluUsw3pYt4DEbQwtRPlGsYNOpKrCYISePCyXP9c62YLMDcZebemo/Y2YW0KO5JY2WWA==
X-Received: by 2002:a05:6a00:728:: with SMTP id 8mr6969207pfm.27.1644050111634;
        Sat, 05 Feb 2022 00:35:11 -0800 (PST)
Received: from [192.168.1.100] ([166.111.139.99])
        by smtp.gmail.com with ESMTPSA id x18sm4845251pfc.123.2022.02.05.00.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Feb 2022 00:35:10 -0800 (PST)
Subject: Re: [BUG] staging: wfx: possible deadlock in wfx_conf_tx() and
 wfx_add_interface()
To:     Hillf Danton <hdanton@sina.com>
Cc:     jerome.pouiller@silabs.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <6f489bf2-bac0-8030-7ea5-6f5c12daa568@gmail.com>
 <20220201113303.3883-1-hdanton@sina.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <77de47d2-3dfb-e329-5a86-74a115de9fcd@gmail.com>
Date:   Sat, 5 Feb 2022 16:34:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20220201113303.3883-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/1 19:33, Hillf Danton wrote:
> On Tue, 1 Feb 2022 15:09:34 +0800 Jia-Ju Bai wrote:
>> Hello,
>>
>> My static analysis tool reports a possible deadlock in the wfx driver in
>> Linux 5.16:
>>
>> wfx_conf_tx()
>>     mutex_lock(&wdev->conf_mutex); --> Line 225 (Lock A)
>>     wfx_update_pm()
>>       wait_for_completion_timeout(&wvif->set_pm_mode_complete, ...); -->
>> Line 3019 (Wait X)
>>
>> wfx_add_interface()
>>     mutex_lock(&wdev->conf_mutex); --> Line 737 (Lock A)
>>     complete(&wvif->set_pm_mode_complete); --> Line 758 (Wake X)
>>
>> When wfx_conf_tx() is executed, "Wait X" is performed by holding "Lock
>> A". If wfx_add_interface() is executed at this time, "Wake X" cannot be
>> performed to wake up "Wait X" in wfx_conf_tx(), because "Lock A" has
>> been already hold by wfx_conf_tx(), causing a possible deadlock.
>> I find that "Wait X" is performed with a timeout, to relieve the
>> possible deadlock; but I think this timeout can cause inefficient execution.
>>
>> I am not quite sure whether this possible problem is real and how to fix
>> it if it is real.
>> Any feedback would be appreciated, thanks :)
>>
>>
>> Best wishes,
>> Jia-Ju Bai
> Hey Jia-Ju
>
> Thank you for reporting it.
>
> Given the init_completion() prior to complete() in wfx_add_interface(),
> no waiter is waken up by the complete(), so it has nothing to do with
> the waiter in the conf path.

Hi Hillf,

Thanks for your reply and detailed explanation :)

>
> BTW if the unusual wfx init is a real use case then we can add a new helper.
>
> Mind introducing your toy to LKML? How much time have you been put in it?
> Its current status and future works?

Do you mean my static analysis tool that generated the report?
In fact, I spent 3-4 months of my part time on implementing this tool, 
which can detect deadlocks caused by locking cycles and improper 
waiting/waking operations.
This tool still reports some false positives, due to missing some 
special patterns in the kernel code, such as "init_completion() prior to 
complete()" in this false bug.
Thus, I am improving the tool to reduce false positives now.
Any suggestion on deadlock detection or the tool would be appreciated, 
thanks :)


Best wishes,
Jia-Ju Bai
