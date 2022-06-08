Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5372A542904
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiFHIMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiFHILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:11:19 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAFC2AD5ED;
        Wed,  8 Jun 2022 00:40:28 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id u12so39730751eja.8;
        Wed, 08 Jun 2022 00:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VsvnhB36vyqqGMQz5JA8UdAzHUOdOVxuCiylQty2tz8=;
        b=cO75DU8Jb/4CQuY4Hk5TAYlShuOKrw1ULQ+hVu5lcJACgtuaWY9ntNCxrwNHQ1Gw2E
         mjYXMqDF9ma5LolOK72Av35ADrc3x334YksX/NJRDU9btD/NzDEGN3CesTVh1bD6SE10
         jqi0jzUBLeFSDMhBBV7zc9db1c3QDY6HW0tCFtVKBQVbLcBpG76QQd+4x8w15pqn3/fX
         iywWqoU00NcCsw4r3UysEEmsUmvKNM/fppmmZVvHDE5dCJNm0FBRb9Ov37M2o+K9yQVB
         StExC2p/rtfUTOKLLCDWLKoevz1DLDcBxTgsqpcMcOMlNIgo00A/LUcC9mE6PfYqDXtG
         RRew==
X-Gm-Message-State: AOAM532yF5lYAe8am6GGZ+Zx0csHcWPFD6j8HH+c/VNjBqI6d+aWu36a
        hZFHBfPeSUYc6LQHgEg/Tpk=
X-Google-Smtp-Source: ABdhPJxH1mFHSjhIPVGosLiHbdLkMCLk167YZQLhiL/edrjiKInd8x77adBMJtRFE01DbIGQIREESQ==
X-Received: by 2002:a17:906:12d3:b0:6f5:18a2:176d with SMTP id l19-20020a17090612d300b006f518a2176dmr28850351ejb.474.1654674026446;
        Wed, 08 Jun 2022 00:40:26 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id i2-20020a056402054200b004315050d7dfsm5669881edx.81.2022.06.08.00.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 00:40:25 -0700 (PDT)
Message-ID: <e9f35a26-8f5b-f585-2e8c-19690bf3c770@kernel.org>
Date:   Wed, 8 Jun 2022 09:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 16/36] tty/vt: consolemap: check put_user() in
 con_get_unimap()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-16-jslaby@suse.cz>
 <8ad44d3b-449f-4a30-1a4c-dffd43bbbd1@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <8ad44d3b-449f-4a30-1a4c-dffd43bbbd1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 06. 22, 16:19, Ilpo Järvinen wrote:
> On Tue, 7 Jun 2022, Jiri Slaby wrote:
> 
>> Only the return value of copy_to_user() is checked in con_get_unimap().
>> Do the same for put_user() of the count too.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>   drivers/tty/vt/consolemap.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
>> index 831450f2bfd1..92b5dddb00d9 100644
>> --- a/drivers/tty/vt/consolemap.c
>> +++ b/drivers/tty/vt/consolemap.c
>> @@ -813,7 +813,8 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
>>   	console_unlock();
>>   	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
>>   		ret = -EFAULT;
>> -	put_user(ect, uct);
>> +	if (put_user(ect, uct))
>> +		ret = -EFAULT;
>>   	kvfree(unilist);
>>   	return ret ? ret : (ect <= ct) ? 0 : -ENOMEM;
>>   }
>>
> 
> Doesn't this fix something?

If you mean a Fixes tag, this is pre-git.

If you mean a bug, well, likely yes, users now get informed. But I don't 
think anyone cares ;). But who knows, maybe we will start seeing 
userspace failures now (as they might not provide writable count field 
-- unlikely). That's one of the reasons why I did this as a separate 
commit. Let's see if are going to revert this or not...

thanks,
-- 
js
suse labs
