Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12C74F091A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 13:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357029AbiDCLns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 07:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiDCLnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 07:43:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAB93968F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 04:41:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ot30so4655546ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JCkFQmR3J8LZjOOyCd1t2e0OGoSs7KtLyKUoW26knHs=;
        b=lRGsbEamAiM8kcLuqp0FhVR3ULvkFzZMKSlIlCQknQKBo9GbFh0c/bj5SPRofOytLK
         8/DgXds35Tf+liTuhQJsOY1+H6A85bsRWMSuLDL30SPK0se/eQPxUjClUpnOGtI7cu2Y
         ybtlW5PzXRKqnXuR5FNwsZyd5L7on060woH8fphzB9FCBTYZpXxASY+FSGgaxkZmIpwd
         wmNAtSo1mJ10h+50NtwiZyKAFrhZASu2+DXBFPi8OAawt/Vhjx7I/bsjk1DV14aaRktf
         6E1H47gokJB7ZNIgwteaHWLVsxfGuw21dM5V6t3tRBgRFbX6EmwSQWQBOawY0LOAJ2PT
         p0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JCkFQmR3J8LZjOOyCd1t2e0OGoSs7KtLyKUoW26knHs=;
        b=gf4k4kdyUK3c2xC1Wc2w7CAxhBAZWBYbbuvev3zTGotMHIK3d/oyj5C9MKa1rxJc2K
         sDy22Ohp0EmmasuV9mcZYnqxAWrBSOAdFIYDlWL6lGNl4XqOkgr2NzEnjV3WGiAFAU+j
         YdIKGEnXTZjGzH1xHx14wpvkw6vCkmpzHjUJXiQxGxw6PJuaJdDvdvigBmTB7MV1FOO8
         K2i/i8vwjcNQ2FWPk950DUZBCkqktkKCckZpzdIppn4XMnMx+dqFWHAr3E9zYUmMbym+
         PTtQqEXp4dE7HyUWu1tlcyk2Zy37w6oMVOdvUb2aj9mFVscgSYjVfzy9pU2ahTyZ7OBC
         Zfwg==
X-Gm-Message-State: AOAM531gL7dpbeVwQ2ffqGeOFYNt5fIBHe3+nkhmSZU5rwu10xHmgjGf
        Ymu7RnVnpEYOzMiAfm52Ock=
X-Google-Smtp-Source: ABdhPJxNfjCNb1EhnSVYifdPo3XAhN/dhHy4ovZXB6HKg6s2dYOktqiU7fd4wepF51rLp++h4aCE6Q==
X-Received: by 2002:a17:907:6e21:b0:6e1:c1ab:d0e0 with SMTP id sd33-20020a1709076e2100b006e1c1abd0e0mr6871592ejc.358.1648986111630;
        Sun, 03 Apr 2022 04:41:51 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm3666478edz.29.2022.04.03.04.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 04:41:51 -0700 (PDT)
Message-ID: <bf1137fa-5051-a834-0c1f-042c5a8074a3@gmail.com>
Date:   Sun, 3 Apr 2022 13:41:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: staging: r8188eu: how to handle nested mutex under spinlock
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <356c24cf-625b-eea2-2c04-ce132d881cac@gmail.com>
 <1813843.tdWV9SEqCh@leap> <942bbcb6-725d-9b47-5dfe-f105d30ea6b7@gmail.com>
 <7365301.EvYhyI6sBW@leap>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <7365301.EvYhyI6sBW@leap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 13:17, Fabio M. De Francesco wrote:
> On domenica 3 aprile 2022 13:08:35 CEST Michael Straube wrote:
>> On 4/3/22 12:49, Fabio M. De Francesco wrote:
>>> On domenica 3 aprile 2022 12:43:04 CEST Fabio M. De Francesco wrote:
>>>> On sabato 2 aprile 2022 22:47:27 CEST Michael Straube wrote:
>>>>> Hi all,
>>>>>
>>>>> smatch reported a sleeping in atomic context.
>>>>>
>>>>> rtw_set_802_11_disassociate() <- disables preempt
>>>>> -> _rtw_pwr_wakeup()
>>>>>       -> ips_leave()
>>>>>
>>>>> rtw_set_802_11_disassociate() takes a spinlock and ips_leave() uses a
>>>>> mutex.
>>>>>
>>>>> I'm fairly new to the locking stuff, but as far as I know this is not a
>>>>> false positive since mutex can sleep, but that's not allowed under a
>>>>> spinlock.
>>>>>
>>>>> What is the best way to handle this?
>>>>> I'm not sure if converting the mutex to a spinlock (including all the
>>>>> other places where the mutex is used) is the right thing to do?
>>>>>
>>>>> thanks,
>>>>> Michael
>>>>>
>>>> Hi Michael,
>>>>
>>>> No, this is a false positive: ips_leave is never called under spinlocks.
>>>> Some time ago I blindly trusted Smatch and submitted a patch for what you
>>>> are reporting just now again. Soon after submission I realized it and
>>>> then I had to ask Greg to discard my patch.
>>>>
>>>> Please read the related thread:
>>>>
>>>> [PATCH] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
>>>> https://lore.kernel.org/lkml/20220206225943.7848-1-fmdefrancesco@gmail.com/
>>>>
>>>> Thanks,
>>>>
>>>> Fabio
>>>
>>> I'm sorry, the correct link is the following:
>>> [PATCH v2 2/2] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
>>> https://lore.kernel.org/lkml/20220208180426.27455-3-fmdefrancesco@gmail.com/
>>>
>>> Fabio
>>>
>>
>> Hi Fabio,
>>
>> Ah I see now, thanks. Well, I think the code is not very clear and easy
>> to follow here. Perhaps we should refactor this area someday to avoid
>> future confusions.
>>
>> regards,
>> Michael
>>
> Soon after I sent the email above, I read yours anew. The issue I were trying
> to address were different than what you noticed today. I didn't even see that
> we were in nested mutexes under spinlocks and bottom halves disabled. I just
> saw those kmalloc() with GFP_KERNEL.
> 
> You are noticing something one layer up. And you are right, this is a real
> issue. Larry's suggestion is the only correct one for fixing this.
> 
> I've analyzed and reviewed some code in the tty layer that implements the
> same solution that Larry is talking about. Let me find the link and I'll
> soon send it to you, so that you might be inspired from that implementation.
> 
> Sorry for the confusion.
> 
> Thanks,
> 
> Fabio
> 
> 
> 

Hi Fabio,

wait..

rtw_set_802_11_disassociate() calls rtw_pwr_wakeup() only if
check_fwstate(pmlmepriv, _FW_LINKED) is true.


	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
		rtw_disassoc_cmd(padapter, 0, true);
		rtw_indicate_disconnect(padapter);
		rtw_free_assoc_resources(padapter, 1);
		rtw_pwr_wakeup(padapter);
	}

in rtw_pwr_wakeup() there is the same check and if it is true the
function returns before calling ips_leave().

	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
		ret = _SUCCESS;
		goto exit;
	}
	if (rf_off == pwrpriv->rf_pwrstate) {
		if (_FAIL ==  ips_leave(padapter)) {
			ret = _FAIL;
			goto exit;
		}
	}

So ips_leave() is not called in atomic context in this case and smatch
reports indeed a false positive, or am I wrong?

I have not checked the other calls to rtw_pwr_wakeup().

regards,
Michael

