Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA406542936
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiFHIRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiFHIP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:15:29 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4EE362ED0;
        Wed,  8 Jun 2022 00:44:15 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id c2so25884369edf.5;
        Wed, 08 Jun 2022 00:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6d//xLMZewJABqjk9QF8SiDnR9wNTei67iI7EwN0sFs=;
        b=5y6MAFkU9tZWqfaonH4bxUiQSBZKYz+tFXGcwlfbMjDOzmoED7bkcM+cCKm4hXmKDD
         26CF7DouWcjj+BQPedtKXDGAK4wiqX8EtMTrBBMysbV+g286zsM/AebFEub9zfmGgrED
         6vxnMtGT5xIonC+VpnuUs8FfWs7xhKkhXSGDZeN6eMkjSzro0W53qCCfMkbmnASwkL58
         K8lEQpyJTLxqHRHAqsjxY+nTwvoKvDE37XMjr4PWXAV0kLWYx8pbgOwUOcK39t3msauv
         8TtMIZmNkATN/GuHaAtxU3LSSfTINYI1Zhn1/Y8qjIrHKFSl6QH36rJA3MAe9RytKUPz
         GfaQ==
X-Gm-Message-State: AOAM532q/YyDCVPNNrj0LJOncuIoJkjRv8J1gUG8ea+hojsQY+NNLfr2
        mFZj9UY8WmfV1ZflbvRIleU=
X-Google-Smtp-Source: ABdhPJxyyFTKvGz9kEQLpR9zJPuDnKAaz/raw6uJkYYmoQi0Ai2zJzPLHXoSEa09sAApFS1eSJc/cg==
X-Received: by 2002:a05:6402:40d4:b0:430:97a9:fa53 with SMTP id z20-20020a05640240d400b0043097a9fa53mr24886638edb.158.1654674254041;
        Wed, 08 Jun 2022 00:44:14 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id s4-20020a1709067b8400b006f3ef214ddfsm7067295ejo.69.2022.06.08.00.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 00:44:13 -0700 (PDT)
Message-ID: <5a1a600a-5a1f-d93b-e854-2586c412e505@kernel.org>
Date:   Wed, 8 Jun 2022 09:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 33/36] tty/vt: consolemap: change refcount only if needed
 in con_do_clear_unimap()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-33-jslaby@suse.cz>
 <ce9f52c5-4b46-77a8-8dd4-1de787e5b8b@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <ce9f52c5-4b46-77a8-8dd4-1de787e5b8b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 06. 22, 17:31, Ilpo Järvinen wrote:
> On Tue, 7 Jun 2022, Jiri Slaby wrote:
> 
>> con_do_clear_unimap() currently decreases and increases refcount of old
>> dictionary in a back and forth fashion. This makes the code really hard
>> to follow. Decrease the refcount only if everything went well and we
>> really allocated a new one and decoupled from the old dictionary.
>>
>> I sincerelly hope I did not make a mistake in this (ill) logic.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> 
> It seems fine:
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> One unrelated comment below for additional cleanup opportunity.
> 
>> ---
>>   drivers/tty/vt/consolemap.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
>> index 01b7e49f1f91..4d8efe74315c 100644
>> --- a/drivers/tty/vt/consolemap.c
>> +++ b/drivers/tty/vt/consolemap.c
>> @@ -535,22 +535,23 @@ static int con_do_clear_unimap(struct vc_data *vc)
>>   {
>>   	struct uni_pagedict *old = *vc->vc_uni_pagedir_loc;
>>   
>> -	if (!old || --old->refcount) {
>> +	if (!old || old->refcount > 1) {
>>   		struct uni_pagedict *new = kzalloc(sizeof(*new), GFP_KERNEL);
>> -		if (!new) {
>> -			if (old)
>> -				old->refcount++;
>> +		if (!new)
>>   			return -ENOMEM;
>> -		}
>> +
>>   		new->refcount = 1;
>>   		*vc->vc_uni_pagedir_loc = new;
>> +
>> +		if (old)
>> +			old->refcount--;
>>   	} else {
>>   		if (old == dflt)
>>   			dflt = NULL;
> 
> This seems unnecessary as con_release_unimap() already does it.

Good point -- the code is real mess... Now, the mess is more apparent, 
at least ;).

I will create a separate patch for this.

thanks,
-- 
js
suse labs
