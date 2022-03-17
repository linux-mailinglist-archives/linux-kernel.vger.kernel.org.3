Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0754DBC95
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355939AbiCQBom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiCQBoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F679DEE0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647481402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8AtmjGS1vXubXcDgtou9X22B2f2JlRHSplmqpl737tA=;
        b=bFRvD06MiSRJDtf0elwTpcRD3VNqiACbLDzXrte53c6fGnAUJ7SQwIWCRKy82Rim0uZ+Xn
        3LLPF1YiFjO+k7fVFh7mwqOBhyyW7EoueMILzuxIvSASAWyp7ivX38SPTV9N3zX8yaifPI
        2GiaBNb3WgW4szjtDx+L06r7sRDeoAE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-slCeuqqSNoy9W5pXdRXMOQ-1; Wed, 16 Mar 2022 21:43:21 -0400
X-MC-Unique: slCeuqqSNoy9W5pXdRXMOQ-1
Received: by mail-qt1-f197.google.com with SMTP id f13-20020ac8014d000000b002ddae786fb0so2558436qtg.19
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8AtmjGS1vXubXcDgtou9X22B2f2JlRHSplmqpl737tA=;
        b=nKcFda98a1fCUu6sVH1L4Z20aqRtzj9g9oTEcPKrG5FJPkenFB6oM+gVhtIGF+/KlE
         HQYZkFpQsfmox1TQHIscYi0ow5ya7/hRDYTuYBlhxMH4c78BkgEA8luvDRodqCPEq8Ob
         5zdrG7Ib0oZGzWlc+XRjsCgGCDJha9208jIcXfir2ktdn+yFv3zENcQR6+C8L0tTSf/H
         nT5Sq0qlrJLSVDY8/Lv8qLU7UAa7YJhQNoaVZEsHyf457R2FPB9Vg3VcskN7EwIRlYXs
         hDM5Gwc+kxrC5NhrxGeVqSqF4JoQY24rkYurL1c+ccZegfxo0JyXvok9cyPt5GfDiTpz
         tA8w==
X-Gm-Message-State: AOAM5336+9am0fA+u+NBVMsu88/+RHvkPRgeMafOMBnTvyE+NkOj5/hk
        1YwreP9GTwkhXmBrsfMt1dE9X3+tO0zktlu5YCej/LkHczC6ou8MXDk0AQ2nIboQATZXbCxgLL2
        +TJDX7iHpifO9f5Sz6CAbR0kr
X-Received: by 2002:a37:a608:0:b0:67b:27c5:3251 with SMTP id p8-20020a37a608000000b0067b27c53251mr1537131qke.516.1647481400362;
        Wed, 16 Mar 2022 18:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVhPHrQernikSYA5a0thX53Ung/97niWL0y/GFHwSsrulR3MufVvrubsYHVEtr/Dxm/wciNg==
X-Received: by 2002:a37:a608:0:b0:67b:27c5:3251 with SMTP id p8-20020a37a608000000b0067b27c53251mr1537122qke.516.1647481400093;
        Wed, 16 Mar 2022 18:43:20 -0700 (PDT)
Received: from [192.168.1.9] (pool-68-163-101-245.bstnma.fios.verizon.net. [68.163.101.245])
        by smtp.gmail.com with ESMTPSA id k6-20020a378806000000b0064915d9584fsm1700226qkd.8.2022.03.16.18.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 18:43:19 -0700 (PDT)
Subject: Re: [PATCH v3] livepatch: Don't block removal of patches that are
 safe to unload
To:     Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, jpoimboe@redhat.com,
        jikos@kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com
References: <20220312152220.88127-1-zhouchengming@bytedance.com>
 <alpine.LSU.2.21.2203161536330.6444@pobox.suse.cz> <YjH7rniD4rBO6JIP@alley>
 <alpine.LSU.2.21.2203161602490.6444@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <6c613fc8-a436-a17e-799f-afd2ead02bb5@redhat.com>
Date:   Wed, 16 Mar 2022 21:43:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2203161602490.6444@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/22 11:03 AM, Miroslav Benes wrote:
>>>> + /*
>>>> +	 * Only need to set forced flag for the transition patch
>>>> +	 * when force transition to KLP_UNPATCHED state, but
>>>> +	 * have to set forced flag for all replaced patches
>>>> +	 * when force atomic replace transition.
>>>> +	 */
>>>
>>> How about something like
>>>
>>> /*
>>>  * Set forced flag for patches being removed, which is the transition
>>>  * patch in KLP_UNPATCHED state or all replaced patches when forcing
>>>  * the atomic replace transition.
>>>  */
>>
>> Or just the first sentence:
>>
>> 	/* Set forced flag for patches being removed */
>>
>> The rest is visible from the code.
> 
> True. This would work for me as well.
> 

Sorry for not following this one more closely as we don't use force nor
atomic replace patches (yet) ... but the code and use case seems clear
enough for the shorter comment.

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- 
Joe

