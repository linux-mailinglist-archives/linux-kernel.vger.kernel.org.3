Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72014ECC47
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346129AbiC3SbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351162AbiC3S23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:28:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400E051324;
        Wed, 30 Mar 2022 11:24:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d5so37300192lfj.9;
        Wed, 30 Mar 2022 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AdJ8ve3qHqvvd1c/19/c++F2nvBXXpoJRywWLK1c6GA=;
        b=VzF/bjKqvvZH4+Vs+UicO3gdz9nsJEXm+dcg6UGPbVU/yoLYmVm1YueOWKdDhZNgix
         FY/hHbfESYn9c5fsPZWbC3dGHSEHNdwzq2Na4EsfiTXsSN3f9AEGxQ7WX6R9UspJpGIg
         GjAPpxb4luejAubvpVp9DqPmBzV/k+Uifz+4m6bxdYb3PW5nh+qg64xIFbJpwXxDGbma
         qoDOQnqngwklcxTK5GIuOH1jbuWUIQruO6S704/oPf42LwNUqsE0xxqSPXlF1vvPC2Cb
         1wypDNZE3Rt183RhPwh9ASNC2gk7NFZ98o916r+4FtmsWO03lLUfD25XLuDJcZGZ57IA
         e1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AdJ8ve3qHqvvd1c/19/c++F2nvBXXpoJRywWLK1c6GA=;
        b=AS3iCBpo1t50ULSUoJ4aFWT46T8QUpMLtKKUktcDt/FDFS5C8yFodA2EKrQig82O1l
         PRz4mzXncFcwswnM1/3yINIuAaYA2epTMPZKShTUm33choXdzhjqTDiKq6A6hQFPcREa
         ce3/WXEw5t/PvXn71IN63kwBfjgXOKWM53q97LGEPM5WWtdUda0v3vll4OM+E8m/pjvc
         K9285uqB/NbJf0OQau7NehpWlq56c3ilrR2hzOJyGy4AHnXGvqXAkF6lcfK5rGsz9sYu
         8rV3JD8d9j1N0jmnGZPQgB4eYygiuO+upb8IoiyDtflaxY6jYE9wimwca+Z5sl3VFwiq
         N65Q==
X-Gm-Message-State: AOAM533GZHCJCzxUQcble9//3h6f4EWgYRQgHSU6Pso1tp+/jxF6W4We
        CfrOYlBOyr8XdjxiRgagbGw=
X-Google-Smtp-Source: ABdhPJy/021JKKynej47Sox209kOnGV7+kHTY+Ir+6FxgM4yrCyy/XHL3xiVimSA0AHiJ0FmcxKMmw==
X-Received: by 2002:a19:4f5d:0:b0:44a:2905:84ea with SMTP id a29-20020a194f5d000000b0044a290584eamr7774216lfk.120.1648664694266;
        Wed, 30 Mar 2022 11:24:54 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.67.247])
        by smtp.gmail.com with ESMTPSA id o3-20020a198c03000000b00448b7b1780csm2410866lfd.63.2022.03.30.11.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 11:24:53 -0700 (PDT)
Message-ID: <ecf7ccdd-0d6f-9407-6778-ae7f0a6bf538@gmail.com>
Date:   Wed, 30 Mar 2022 21:24:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Linaro-mm-sig] [PATCH next] dma-buf/sync-file: do not allow zero
 size allocations
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        sumit.semwal@linaro.org, gustavo@padovan.org,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        syzbot+5c943fe38e86d615cac2@syzkaller.appspotmail.com
References: <20220329221425.22691-1-paskripkin@gmail.com>
 <8af3d213-6cb7-a021-c198-e1bd37c47e7c@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <8af3d213-6cb7-a021-c198-e1bd37c47e7c@gmail.com>
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

Hi Christian,

On 3/30/22 10:09, Christian König wrote:
> That problem is already fixed with patch 21d139d73f77 dma-buf/sync-file:
> fix logic error in new fence merge code.
> 
> Am 30.03.22 um 00:14 schrieb Pavel Skripkin:
>> syzbot reported GPF in dma_fence_array_first(), which is caused by
>> dereferencing ZERO_PTR in dma-buf internals.
>>
>> ZERO_PTR was generated in sync_file_merge(). This functuion tries to
>> reduce allocation size, but does not check if it reducing to 0.
> 
> This is actually perfectly ok. The code above should have prevented the
> size to become 0.
> 
> Regards,
> Christian.
> 

Thanks for your reply! I see that 21d139d73f77 fixes GPF in 
dma_fence_array_first(), but what about this part:

>>   
>> -	if (num_fences > INT_MAX)
>> +	if (num_fences > INT_MAX || !num_fences)
>>   		goto err_free_sync_file;
>>   
>>   	fences = kcalloc(num_fences, sizeof(*fences), GFP_KERNEL);
>> @@ -264,7 +264,7 @@ static struct sync_file *sync_file_merge(const char *name, struct sync_file *a,
>>   	if (index == 0)

If num_fences is equal to zero then fences dereference will cause an 
oops. Or this one is also fixed in your tree?


Thanks!




With regards,
Pavel Skripkin
