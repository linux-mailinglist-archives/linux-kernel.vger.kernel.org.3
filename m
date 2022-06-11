Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18F2547244
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 07:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiFKFpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 01:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349671AbiFKFpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 01:45:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9998F53A73
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 22:45:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso4114566pjl.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 22:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=od9l76oQ8DL8EoiejiBxOXajLVr0/4+4fjatyVkpp6g=;
        b=YRtfAgPbLwhtyA9nLkuQDEiGBG+C1/ZO+2dc9gmcq9v7JLPGUJIQjSKqOieBJFjw9I
         neO0QOLc0/YfYHCKMnxjcB9kJhHxM8oEW2tEQIWE1HGoKOQ5BMA7Og9ETS/hIgm2yJTM
         5F6b9/5fvitpWA1U6AGifWDBzG0ngbBMiezx3ar2dhLxlDS/J4tnsZye6VvLNUte7MxG
         Rw6HsUOcfwkTgngIQvfm+ycTHKEQj9Kfc9eopEbIoFSYDSqXGvtj/TesPNYF+XMzykkQ
         aFmgrT9B13AMUSVvA372OmVjUxXyWdYcoCVOWV+wbwcvCuAavwbFszKO+BDxm/Os+UL3
         Xkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=od9l76oQ8DL8EoiejiBxOXajLVr0/4+4fjatyVkpp6g=;
        b=DxyQt1DWxmFQkWpNt1U0/fovTX/qyigVHbU/ngNon8hVhzVheu5lYbUVNh4aMLD3CQ
         wqUbb38FdrmlUG/rl9ztwI3/dKYEiGVkMR7G3CvifJEvixhSbjBnWnPtvaUgsnpCrTmd
         sKZH9eKLI8smCJQnvcllrolsRDHB+toZ0lXZ6LJEX8z9gd44BPR3yatUi+kzkjptTNJD
         h31USKElyW8uKO9Te3XTxt7gbDvWkUCJWxN2KkcoSbap7wPHqnLgi1JhyQx/tUl2z6Q6
         k0qQDrlYddAWj6to3qqOR4nkWHbZg3Ty8ICbhrh7kAcazyFNvC2I0fR1G5j0bV1ABHV9
         Jbyg==
X-Gm-Message-State: AOAM530m0Ll+5RPtvJ37aE9MnyNAqgTzf4MD+1yQr1EuSKoR3Tae1/gX
        bpdCwkYw3kgEzQw8abcapyw=
X-Google-Smtp-Source: ABdhPJygpOz7s8zNtu2+/Q/RyAj+8BoZGAbvpDl6wgDt9+9aGW/NOTMD+H1B+BBiNlkhzswc64461w==
X-Received: by 2002:a17:902:e804:b0:164:164c:5a44 with SMTP id u4-20020a170902e80400b00164164c5a44mr49379877plg.85.1654926330014;
        Fri, 10 Jun 2022 22:45:30 -0700 (PDT)
Received: from [192.168.0.103] ([106.51.241.182])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b001676dac529asm676803pla.146.2022.06.10.22.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 22:45:29 -0700 (PDT)
Message-ID: <554b5c77-12ba-7b85-a65a-f1fefa5b6a51@gmail.com>
Date:   Sat, 11 Jun 2022 11:15:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] char: lp: ensure that index has not exceeded LP_NO
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Shreenidhi Shedi <sshedi@vmware.com>
References: <20220603130040.601673-1-sshedi@vmware.com>
 <YqNG5H+JbNJMeOWq@kroah.com> <a7fea025-1919-b2d7-e69e-136983c2e386@gmail.com>
 <YqNVcppyBXU8mQ/Z@kroah.com>
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <YqNVcppyBXU8mQ/Z@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/22 8:00 pm, Greg KH wrote:
> On Fri, Jun 10, 2022 at 07:12:02PM +0530, Shreenidhi Shedi wrote:
>> On 10/06/22 6:58 pm, Greg KH wrote:
>>> On Fri, Jun 03, 2022 at 06:30:39PM +0530, Shreenidhi Shedi wrote:
>>>> From: Shreenidhi Shedi <sshedi@vmware.com>
>>>>
>>>> After finishing the loop, index value can be equal to LP_NO and lp_table
>>>> array is of size LP_NO, so this can end up in accessing an out of bound
>>>> address in lp_register function.
>>>>
>>>> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
>>>> ---
>>>>  drivers/char/lp.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/char/lp.c b/drivers/char/lp.c
>>>> index 0e22e3b0a..d474d02b6 100644
>>>> --- a/drivers/char/lp.c
>>>> +++ b/drivers/char/lp.c
>>>> @@ -972,7 +972,7 @@ static void lp_attach(struct parport *port)
>>>>  			if (port_num[i] == -1)
>>>>  				break;
>>>>
>>>> -		if (!lp_register(i, port))
>>>> +		if (i < LP_NO && !lp_register(i, port))
>>>>  			lp_count++;
>>>
>>> How can this ever be needed?  Look at the check further up for the check
>>> of lp_count which prevents this from every going too large.
>>>
>>> So how can an address be accessed out of bound here?
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Thanks for the review. Assume lp_count is less than LP_NO now and we enter the for loop
>> and for some reason for loop exits after i reaching the value LP_NO
> 
> Wait, how can that happen?  That's what I am saying, the loop will never
> reach that value from what I can tell.
> 
> Yes, this whole thing should be moved to something more sane like an
> idr structure, but as-is, it seems correct to me.
> 
> Have you tested the code with that many devices to see if it really can
> overflow?
> 
> thanks,
> 
> greg k-h

No, I did not actually test it with real hardware but I ran a 
static analyzer check on this file and it also thinks the same.

```
Checking drivers/char/lp.c ...
drivers/char/lp.c:926:10: error: inconclusive: Array 'lp_table[8]' accessed at index 8, which is out of bounds. [arrayIndexOutOfBounds]
 lp_table[nr].dev = parport_register_dev_model(port, "lp",
         ^
drivers/char/lp.c:971:17: note: Assuming that condition 'i<8' is not redundant
  for (i = 0; i < LP_NO; i++)
                ^
drivers/char/lp.c:975:20: note: Calling function 'lp_register', 1st argument 'i' value is 8
  if (!lp_register(i, port))
                   ^
drivers/char/lp.c:926:10: note: Array index out of bounds
 lp_table[nr].dev = parport_register_dev_model(port, "lp",
         ^
drivers/char/lp.c:928:14: error: inconclusive: Array 'lp_table[8]' accessed at index 8, which is out of bounds. [arrayIndexOutOfBounds]
 if (lp_table[nr].dev == NULL)
             ^
drivers/char/lp.c:971:17: note: Assuming that condition 'i<8' is not redundant
  for (i = 0; i < LP_NO; i++)
                ^
drivers/char/lp.c:975:20: note: Calling function 'lp_register', 1st argument 'i' value is 8
  if (!lp_register(i, port))
                   ^
drivers/char/lp.c:928:14: note: Array index out of bounds
 if (lp_table[nr].dev == NULL)
```

-- 
Shedi
