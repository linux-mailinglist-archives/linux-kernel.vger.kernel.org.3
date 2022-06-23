Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B6C557009
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiFWBoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiFWBoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:44:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235494349C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:44:14 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id t21so11415573pfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=8OYLl95mf9+YxDcCBNvZSRU5aHDebQNBoQMTob1Sdeg=;
        b=qxZY0UQ4su1To4vMkojOPanPe2kdRw7d+t26ToDi4Y0iFSVfRLSE6Iw+BVSwpTU2Eh
         FnuMaWl20DljeYow8xp8Qp+pQ5FqDyV+jenzjIo3mGkEx+DtJQcNHddsF5PrcbEyZAxH
         WNgPuuh+he0G6agaZ73XzSWcEz+T+11DSFTReZBqn7UNJ2iTaIY9sfLqmOvnQusyPMOY
         nG5PXoIlJfR/xY26TxpqYluvBYG7GITfQryoq+trWXP92Ea/+K/wU02NsXaizU7MD97+
         2PXgjMPOsmzyA7W42p5+mjmIC1BjKmFzAKGn52q7wDflbOzcG1UEfbjBSZjlsPaiBOGw
         xOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=8OYLl95mf9+YxDcCBNvZSRU5aHDebQNBoQMTob1Sdeg=;
        b=bO2vzFKS20wvrWq/udA9XB8Lb9kjTXXC56HUpQvTh6nF9yOPERLAco5k04Yk22K4XX
         V3+GJiHRBjeBAEy+YqeRdKtmMOVORelfgPmBHkC420l6lcJG9mNsf5JWCj01imGqsg35
         2IXZ1KiS8K0/A1Q8fNfnVq/juDa0eR8sQKf5QlCLawacQJLwLQWVJYAffFuqsncqlVtX
         bonWrdpeMGEMrWbpnbAlr7oas9ysB5AKPRyf5LG2BchhqlUNEGxwnJHVCgR3bmEdavx8
         wt9EXzwmXDu76+Lgcijgi2BeDn1u+dcIjsEPThfhKTvRDsyVnuKbfvI5cN9sqN4+CEtj
         jqnA==
X-Gm-Message-State: AJIora/Rf0MR7/RALjQWuuAa9qE2EAtMUSwuw+0+GsKIHh2nHUNYVP7S
        kZkLXtI8bAwgavjCKvaiDZmQidKrL0IigIKf
X-Google-Smtp-Source: AGRyM1tHsth2D+8SWRUl0QfIlT0e02ZW+58iaAtiK8+/XIA/PjhfGZ3Heo+y2rA3m1jZN6lfLstExg==
X-Received: by 2002:a05:6a00:179e:b0:518:9e1d:1cbd with SMTP id s30-20020a056a00179e00b005189e1d1cbdmr38052645pfg.12.1655948653642;
        Wed, 22 Jun 2022 18:44:13 -0700 (PDT)
Received: from [192.168.50.247] ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id h8-20020aa79f48000000b00525251ce47esm7117430pfr.103.2022.06.22.18.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 18:44:13 -0700 (PDT)
Message-ID: <17b9ef27-028c-06ac-a2d9-7cb46b3951cb@gmail.com>
Date:   Thu, 23 Jun 2022 09:44:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] hwtracing: stm: fix possible double free in
 stm_register_device()
Content-Language: en-US
From:   Hangyu Hua <hbh25y@gmail.com>
To:     alexander.shishkin@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, gregkh@linuxfoundation.org,
        mathieu.poirier@linaro.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220418081632.35121-1-hbh25y@gmail.com>
 <3e01d35c-e748-3e03-4417-8b7dea09075e@gmail.com>
 <45ae7332-074e-cb76-2674-7431fc58b886@gmail.com>
In-Reply-To: <45ae7332-074e-cb76-2674-7431fc58b886@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/23 09:55, Hangyu Hua wrote:
> Gentel ping.
> 
> On 2022/5/5 09:29, Hangyu Hua wrote:
>> Ping
>>
>> On 2022/4/18 16:16, Hangyu Hua wrote:
>>> put_device() will call stm_device_release() to free stm when
>>> stm_register_device() fails. So there is no need to call vfree() again.
>>>
>>> Fix this by adding a return after put_device().
>>>
>>> Fixes: 7bd1d4093c2f ("stm class: Introduce an abstraction for System 
>>> Trace Module devices")
>>> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
>>> ---
>>>   drivers/hwtracing/stm/core.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
>>> index 2712e699ba08..403b4f41bb1b 100644
>>> --- a/drivers/hwtracing/stm/core.c
>>> +++ b/drivers/hwtracing/stm/core.c
>>> @@ -915,6 +915,7 @@ int stm_register_device(struct device *parent, 
>>> struct stm_data *stm_data,
>>>       /* matches device_initialize() above */
>>>       put_device(&stm->dev);
>>> +    return err;
>>>   err_free:
>>>       vfree(stm);

Gentel ping.
