Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A855E922
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346966AbiF1Obj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346593AbiF1ObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:31:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7071313B6;
        Tue, 28 Jun 2022 07:31:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l68so2438512wml.3;
        Tue, 28 Jun 2022 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3FrRSzola/6d2s6+3NlNmyXpbzz7fjJBWvTI0zjpR0=;
        b=O1qKfkWq5p1z37oLP77kUFCk/yIJ+czZuO+4mUY0shUQ051DSmC17ZpjeVds0c1seT
         p235CruZHRx2eRHoqDSRE/BnByFShu4WqCOY30xUyvyEj57Zz9ueMDyvWjBwePP1uLId
         pKkAiuiBbYk9RGNq1E1cUHhtr6Pn6TZcanrbhMzGXfYgpfalVnpqLpBMIyg6lb2iOe6G
         mzTKPtwAIDL1Lpfe0U4nUnSkJlDwnpIStANsiTIadNEMZSg43wsZ0F1vk+xked7CFy2o
         C9x9StjsxQqpB9i8K0CDQnJGSXwpbvkkO5OoBHaFxXT55nThcpz9eA2dR53DglEzbgYu
         LQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3FrRSzola/6d2s6+3NlNmyXpbzz7fjJBWvTI0zjpR0=;
        b=4qkk09iNIyMrMPJapKm0D98jw6xbqgrhrRrJcJy5svbQgmH448m+Dl/9rJuG8TN9uf
         9ab3DRIk+pFmrPZ6HCj4Q5SQHpm30H5+qjaCJPoMysvmzMcJDkZ6WrRJQJlKNsi0s3tV
         fRi/P5Rl7a+v7wJtcAgw9RDAsgSKGRTOFA7OHmQUzNob7hsAYTR8cvz7HMdIIxQQ+/8o
         eSvbh6v1fURYITRurcRsm5y/Sg1JqlBvQrBzjTX7IpWCQJiOzvswQNvdldQvdJxlveqa
         AX41FaxBCU1iST/HS8IELkF1s/DLfzL4sAsvJs2PcLWddPv0+4cQFSJnsC1WAD1EumU0
         iJEw==
X-Gm-Message-State: AJIora8T9xSUfYzl/dF64Vuc9L7zw3rObEaRGx3zxugQIt4Bo4sM7568
        EPFl8zPqCndioFXq0HdWV4bZKrlAHy/DjJrqK/kOHqXsLKo=
X-Google-Smtp-Source: AGRyM1vsJ8HpmSLep3t0IGNy7NGpKsYYvqVtWm7n6bCarsKMWPn7TkA/FN5szzoslotKf/U+eQXaUEGUuzTYFJUIFn4=
X-Received: by 2002:a1c:4c13:0:b0:39c:5a6b:8540 with SMTP id
 z19-20020a1c4c13000000b0039c5a6b8540mr26840109wmf.106.1656426669377; Tue, 28
 Jun 2022 07:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220628054539.33187-1-schspa@gmail.com> <c230ccdc-b20d-32a6-c3cb-715698d06945@roeck-us.net>
In-Reply-To: <c230ccdc-b20d-32a6-c3cb-715698d06945@roeck-us.net>
From:   Schspa Shi <schspa@gmail.com>
Date:   Tue, 28 Jun 2022 22:30:57 +0800
Message-ID: <CAMA88Tr=TXiT7zCMbnKKp+B-O-us103rsTurEcpwtsqHPXOJTg@mail.gmail.com>
Subject: Re: [PATCH] watchdog: dw_wdt: Fix buffer overflow when get timeout
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> On 6/27/22 22:45, Schspa Shi wrote:
>> The top_val can be obtained from device-tree, if it is not configured
>> correctly, there will be buffer overflow.
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>>   drivers/watchdog/dw_wdt.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
>> index cd578843277e..1f8605c0d712 100644
>> --- a/drivers/watchdog/dw_wdt.c
>> +++ b/drivers/watchdog/dw_wdt.c
>> @@ -155,6 +155,9 @@ static unsigned int dw_wdt_get_min_timeout(struct dw_wdt *dw_wdt)
>>                      break;
>>      }
>>   +  if (WARN_ON_ONCE(idx == DW_WDT_NUM_TOPS))
>> +            idx = DW_WDT_NUM_TOPS - 1;
>> +
> dw_wdt_get_min_timeout() returns the lowest non-0 configurable timeout.
> The  last entry in the timeout array must not be 0, meaning there must
> be at least one entry in the array where the timeout is not 0. Therefore
> this situation can not happen.
>

Yes, I have seen this, you are correct, sorry for the bad patch.

>>      return dw_wdt->timeouts[idx].sec;
>>   }
>>   @@ -178,6 +181,9 @@ static unsigned int dw_wdt_get_timeout(struct dw_wdt
>> *dw_wdt)
>>                      break;
>>      }
>>   +  if (WARN_ON_ONCE(idx == DW_WDT_NUM_TOPS))
>> +            idx = DW_WDT_NUM_TOPS - 1;
>> +
>
> idx is derived from a top_val value written into WDOG_TIMEOUT_RANGE_REG_OFFSET,
> and the value written is derived from an entry in the timeouts array.
> This array contains an entry for each possible top_val. While the array is not
> sorted by top_val, dw_wdt_handle_tops() still guarantees that an entry exists.
>
> I do not see how bad devicetree data can circumvent that. If it does, please
> provide an example and explain.
>

My bad, there is no problem.

> Thanks,
> Guenter


-- 
BRs
Schspa Shi
