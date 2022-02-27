Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739694C5C54
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiB0OhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 09:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiB0OhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 09:37:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 008C6574BD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 06:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645972598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qWBd2uqezPG2fToqHlW/A1scR+v8Ogo7G12uSyyLcCQ=;
        b=a21T8OoIGxOCEIrY/1gDeGlLYuZgwmqEWCVcrwF6im29kHFC7K8AE4L4V0sc4x5cJqvbUf
        AH9SJXrF+c3x6FWOUTjOJWZx6T16BqTijnOzHc7jXJXi0S1KNUGh/4Oi2SbV+r/MHO21ja
        eqZiweYS5ByK9+88BsSusR0t+f0Lnd0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-09EVrRGcPn2PXCXEunl9bQ-1; Sun, 27 Feb 2022 09:36:37 -0500
X-MC-Unique: 09EVrRGcPn2PXCXEunl9bQ-1
Received: by mail-qv1-f70.google.com with SMTP id fv11-20020a056214240b00b0043253a948f0so10004923qvb.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 06:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qWBd2uqezPG2fToqHlW/A1scR+v8Ogo7G12uSyyLcCQ=;
        b=5Xh/xhKCygjlQWTnSts3eVTJIMKGJ3/e9I2zrBuLQr57E8ySexWqotlmK7O7Q7EUb/
         jBIzARSUjlkrGTRs2RVYi4Lq1cbkynwAPz5eMAp/I13GyKM11Jql1WH5ThiH7Wgm9Lxn
         sae0ojiBk/NSWAb7EPcbPVnq11PTJ+VdJ1c15Xh2V1NZvYNVH63aMUVFRAA341aK2Qp0
         Fz1sHp5J2WWMF7AO0m6tBsvEkynUfzv9YSmNbD7+VdqWt2btRmj/DyiNaB5kdp8PXK/f
         mGkUW4V/xh0ufCsrPIlXjskaaRynV719PmQOkedeucMf+UypUZ/INpkSnAbyr1sb9bvZ
         lx/A==
X-Gm-Message-State: AOAM531WKNJbipSf2spk5qOKKcNBF/akaK6wDST5+L+66IxsKWJWHHBa
        wSfrLGb82kWz4JW9SAPcsLutZbNYUif2MIQTHs5VnFeAF6jtXFQ+Ma7iF+/xSvhacNmZ+6leacA
        qYBg9/OnMC0PrfSwb7zfrQNxf
X-Received: by 2002:ae9:e019:0:b0:648:f1d0:5a6b with SMTP id m25-20020ae9e019000000b00648f1d05a6bmr9072842qkk.403.1645972596679;
        Sun, 27 Feb 2022 06:36:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdiTObBYWNwgLyr7HxQB9rQWsfgRx6OEQV9Wzfl34xTDHCFV8xS44GTKugd4k/6bgusrhUYg==
X-Received: by 2002:ae9:e019:0:b0:648:f1d0:5a6b with SMTP id m25-20020ae9e019000000b00648f1d05a6bmr9072825qkk.403.1645972596417;
        Sun, 27 Feb 2022 06:36:36 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id d186-20020a379bc3000000b006490a4e507esm3831221qke.70.2022.02.27.06.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 06:36:35 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Fix realloc of ptr
To:     David Laight <David.Laight@ACULAB.COM>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "nirmoy.das@amd.com" <nirmoy.das@amd.com>,
        "lijo.lazar@amd.com" <lijo.lazar@amd.com>,
        "tom.stdenis@amd.com" <tom.stdenis@amd.com>,
        "evan.quan@amd.com" <evan.quan@amd.com>,
        "kevin1.wang@amd.com" <kevin1.wang@amd.com>,
        "Amaranath.Somalapuram@amd.com" <Amaranath.Somalapuram@amd.com>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <20220226155851.4176109-1-trix@redhat.com>
 <f863c19ccba34e50802836bcb3b0b622@AcuMS.aculab.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a857b5ec-8a6c-9c84-0525-33155261dd41@redhat.com>
Date:   Sun, 27 Feb 2022 06:36:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f863c19ccba34e50802836bcb3b0b622@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/26/22 2:21 PM, David Laight wrote:
> From: trix@redhat.com
>> Sent: 26 February 2022 15:59
>>
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this error
>> amdgpu_debugfs.c:1690:9: warning: 1st function call
>>    argument is an uninitialized value
>>    tmp = krealloc_array(tmp, i + 1,
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> realloc will free tmp, so tmp can not be garbage.
>> And the return needs to be checked.
> Are you sure?
> A quick check seems to show that krealloc() behaves the same
> way as libc realloc() and the pointer isn't freed on failure.

I suck, I'll respin the patch

Thanks

Tom

>
> 	David
>
>> Fixes: 5ce5a584cb82 ("drm/amdgpu: add debugfs for reset registers list")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 9eb9b440bd438..159b97c0b4ebc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1676,7 +1676,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>   {
>>   	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>>   	char reg_offset[11];
>> -	uint32_t *tmp;
>> +	uint32_t *tmp = NULL;
>>   	int ret, i = 0, len = 0;
>>
>>   	do {
>> @@ -1688,6 +1688,10 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>   		}
>>
>>   		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
>> +		if (!tmp) {
>> +			ret = -ENOMEM;
>> +			goto error_free;
>> +		}
>>   		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
>>   			ret = -EINVAL;
>>   			goto error_free;
>> --
>> 2.26.3
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

