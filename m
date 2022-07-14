Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54EC575223
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbiGNPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240433AbiGNPnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:43:47 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3488862CE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nfadgg2RwVGN0U9zbMOJUV4ip9jB/aIO9F2rxczWRHU=; b=GHC+99XVhfLGqPOJpX8XJIekgf
        IVe5wW9id/p4DTQhtSytmxFaZizonB3wqasjGsrD8kctEEHACHgMKQ3RHD9hGbIM7jqSOxW+HAoUC
        iFwXpcgUEOzwsfDC4s92IOmM8BCU4R5TCxblPGQXn3vnQ1i3Gi0LU6nIIKaTdDN3u3yvOUJoowwp5
        i30H3tIWA3+4iEEinKt2583B+eYRHGdQHmzlIufwIwWjNgOw5c3kdQA5pKa4NvBBwerrNhjpFUBLM
        gXFihoYuePAKRkNW2dF1e02PkGy0Pm0sTnjIBEJXTFBFF3Emp/UEEggAkIYhmBnVcljywvQKpWVF+
        1vlC9x9Q==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oC105-00GXxV-3u; Thu, 14 Jul 2022 17:43:37 +0200
Message-ID: <1106b107-6373-9f89-5310-ea29db9fdf75@igalia.com>
Date:   Thu, 14 Jul 2022 12:43:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] drm/amdgpu: double free error and freeing
 uninitialized null pointer
Content-Language: en-US
To:     Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220710132911.399325-1-mailmesebin00@gmail.com>
 <21df71a6-44d4-48a6-17d2-d463174a10c7@igalia.com>
 <YtAw4dra+g1rcAXd@sebin-inspiron>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <YtAw4dra+g1rcAXd@sebin-inspiron>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 12:06 de 14/07/22, Sebin Sebastian escreveu:
> On Tue, Jul 12, 2022 at 12:14:27PM -0300, André Almeida wrote:
>> Hi Sebin,
>>
>> Às 10:29 de 10/07/22, Sebin Sebastian escreveu:
>>> Fix two coverity warning's double free and and an uninitialized pointer
>>> read. Both tmp and new are pointing at same address and both are freed
>>> which leads to double free. Freeing tmp in the condition after new is
>>> assigned with new address fixes the double free issue. new is not
>>> initialized to null which also leads to a free on an uninitialized
>>> pointer.
>>> Coverity issue: 1518665 (uninitialized pointer read)
>>> 		1518679 (double free)
>>
>> What are those numbers?
>>
> These numbers are the issue ID's for the errors that are being reported
> by the coverity static analyzer tool.
> 

I see, but I don't know which tool was used, so those seem like random
number to me. I would just remove this part of your commit message, but
if you want to keep it, you need to at least mention what's the tool.

>>>
>>> Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 8 +++++---
>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index f3b3c688e4e7..d82fe0e1b06b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1660,7 +1660,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>>  {
>>>  	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>>>  	char reg_offset[11];
>>> -	uint32_t *new, *tmp = NULL;
>>> +	uint32_t *new = NULL, *tmp = NULL;
>>>  	int ret, i = 0, len = 0;
>>>  
>>>  	do {
>>> @@ -1692,17 +1692,19 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>>  		goto error_free;
>>>  	}
>>
>> If the `if (!new) {` above this line is true, will be tmp freed?
>>
> Yes, It doesn't seem to free tmp here. Should I free tmp immediately
> after the do while loop and remove `kfree(tmp)` from the `if (ret)`
> block? Thanks for pointing out the errors.

If you free immediately after the while loop, then you would risk a use
after free here:

	swap(adev->reset_dump_reg_list, tmp);

So this isn't the solution either.

> 
>>>  	ret = down_write_killable(&adev->reset_domain->sem);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		kfree(tmp);
>>>  		goto error_free;
>>> +	}
>>>  
>>>  	swap(adev->reset_dump_reg_list, tmp);
>>>  	swap(adev->reset_dump_reg_value, new);
>>>  	adev->num_regs = i;
>>>  	up_write(&adev->reset_domain->sem);
>>> +	kfree(tmp);
>>>  	ret = size;
>>>  
>>>  error_free:
>>> -	kfree(tmp);
>>>  	kfree(new);
>>>  	return ret;
>>>  }
