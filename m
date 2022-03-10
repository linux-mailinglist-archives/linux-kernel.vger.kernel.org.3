Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60804D4F26
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbiCJQZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbiCJQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:25:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2DD61965D7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646929409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LrMJGsRhySAdwcmVt0/LXVkS9ESBsyQGj95P9lRe80=;
        b=FGPWIzSSTp3gEt7Q5LBU945Z4ffV8848WKgdC23ReFfyC5LsFqTMeDwmQp3NXzFj64q6+/
        2R0t1cp9FC/Tsg6kS/3Ke3EC+tMll5+zKK7IeNL8iff28db6rN2XPmfjZwwhR6/FRfMTiP
        AtZ0PVjjKZhZVjDO5PJCsUQ9ucUpKGU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-cKaqQbpqPcufF42rZTE_SA-1; Thu, 10 Mar 2022 11:23:28 -0500
X-MC-Unique: cKaqQbpqPcufF42rZTE_SA-1
Received: by mail-ed1-f72.google.com with SMTP id x5-20020a50ba85000000b004161d68ace6so3378951ede.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/LrMJGsRhySAdwcmVt0/LXVkS9ESBsyQGj95P9lRe80=;
        b=RrXmWoxGCviAqSOR5y4Rij2qRXfgl00z6Ds/HCOumgkwHija95XXG9cY5ooIoaQWMI
         SyrRzhAQNXsAYxmPGcFinqMnR9/AlURW21nxFnPrCavZPs6VLzUGNbNu4SuJH2QCzKhj
         IlLKgCa+rK+9UTjltr/2C6Dj9f6SgS+BEzRYHtLkyP0J5OM8KjeG6IiG7qfrIoP5x88E
         W313QXxsj3V2rwaI51Q1BDUPDulnbh5Hy/nbmZdkWolciiR6HptH27IbHQLP8qmoD/xX
         tDBolOPIiUjmxukcIT30oJ4bwJXMnb8vuKk6u7fu9Fof7e+2AuuZuDC6QDOCBwSgRI3Z
         hF7Q==
X-Gm-Message-State: AOAM5301gjvQgCberwbdhQh3pW79wllGKT9VjMMPtK7yih8D4QX0RaGc
        aYpHGyZCi3Ag6aGBV+YDWWjlFFf8btOGRxhB7pfcP/ch3JTCVWyan1BY+VxrQiDVU4MVctcIfCU
        4eAhy37S4mmEtRvj3Sx6yueCw
X-Received: by 2002:a17:906:7948:b0:6da:64ed:178e with SMTP id l8-20020a170906794800b006da64ed178emr5111011ejo.523.1646929407438;
        Thu, 10 Mar 2022 08:23:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKHSpml9DJiRShy7pIH12x1tMWeeh06s5kZMm+JyroAbNXUJkPOkvsHv+TIUbgrJKS+57yZw==
X-Received: by 2002:a17:906:7948:b0:6da:64ed:178e with SMTP id l8-20020a170906794800b006da64ed178emr5110995ejo.523.1646929407241;
        Thu, 10 Mar 2022 08:23:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id a1-20020aa7d901000000b00416217c99bcsm2196958edr.65.2022.03.10.08.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 08:23:26 -0800 (PST)
Message-ID: <b9fec908-5f57-4f77-72f1-7d5eb0898e8f@redhat.com>
Date:   Thu, 10 Mar 2022 17:23:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/4] x86/platform/uv: Add gap hole end size
Content-Language: en-US
To:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20220308010537.70150-1-mike.travis@hpe.com>
 <20220308010537.70150-5-mike.travis@hpe.com>
 <Yid/x8NUqOP8fO+7@swahl-home.5wahls.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Yid/x8NUqOP8fO+7@swahl-home.5wahls.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/8/22 17:09, Steve Wahl wrote:
> Mike,
> 
> I know you're trying to get this out and don't really need another
> delta, and I'd be holding it back if I didn't think it might make
> things smoother upstream.
> 
> But what I'd consider for this one is:  Add the word log to the
> subject line, perhaps "Add gap hole end size to log", or just "Log gap
> hole end size".  Without it, the reviewer has to ask "add to *where*?"

I agree that "Log gap hole end size" would be a better subject for this patch.

Regards,

Hans


> 
> And I believe the second sentence of the description, "The structure
> stores PA bits 56:26, for > 64MB granularity, up to 64PB max size," is
> perhaps not necessary, and I think it may slow down somebody trying to
> read the patch quickly.  So I'd consider deleting it.
> 
> With those two changes the description still matches the code, and
> seems simpler and easier to accept.
> 
> Your call on either / both, of course.
> 
> --> Steve
> 
> On Mon, Mar 07, 2022 at 07:05:37PM -0600, Mike Travis wrote:
>> Show value of gap end in kernel log which equates to number of physical
>> address bits used by system.  The structure stores PA bits 56:26, for
>> 64MB granularity, up to 64PB max size.
>>
>> Signed-off-by: Mike Travis <mike.travis@hpe.com>
>> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
>> ---
>>  arch/x86/kernel/apic/x2apic_uv_x.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
>> index 387d6533549a..146f0f63a43b 100644
>> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
>> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
>> @@ -1346,7 +1346,7 @@ static void __init decode_gam_params(unsigned long ptr)
>>  static void __init decode_gam_rng_tbl(unsigned long ptr)
>>  {
>>  	struct uv_gam_range_entry *gre = (struct uv_gam_range_entry *)ptr;
>> -	unsigned long lgre = 0;
>> +	unsigned long lgre = 0, gend = 0;
>>  	int index = 0;
>>  	int sock_min = 999999, pnode_min = 99999;
>>  	int sock_max = -1, pnode_max = -1;
>> @@ -1380,6 +1380,9 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
>>  			flag, size, suffix[order],
>>  			gre->type, gre->nasid, gre->sockid, gre->pnode);
>>  
>> +		if (gre->type == UV_GAM_RANGE_TYPE_HOLE)
>> +			gend = (unsigned long)gre->limit << UV_GAM_RANGE_SHFT;
>> +
>>  		/* update to next range start */
>>  		lgre = gre->limit;
>>  		if (sock_min > gre->sockid)
>> @@ -1397,7 +1400,8 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
>>  	_max_pnode	= pnode_max;
>>  	_gr_table_len	= index;
>>  
>> -	pr_info("UV: GRT: %d entries, sockets(min:%x,max:%x) pnodes(min:%x,max:%x)\n", index, _min_socket, _max_socket, _min_pnode, _max_pnode);
>> +	pr_info("UV: GRT: %d entries, sockets(min:%x,max:%x), pnodes(min:%x,max:%x), gap_end(%d)\n",
>> +	  index, _min_socket, _max_socket, _min_pnode, _max_pnode, fls64(gend));
>>  }
>>  
>>  /* Walk through UVsystab decoding the fields */
>> -- 
>> 2.26.2
>>
> 

