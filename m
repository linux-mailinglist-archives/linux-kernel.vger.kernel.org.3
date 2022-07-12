Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6FA571BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiGLNp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiGLNpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:45:43 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1320C2ED4C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:45:43 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id s6-20020a4aa546000000b00432fb4f59deso1515765oom.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dlui1MM85qPWou0rQy0Hs7CHorUMH/STDx1YOYBhbKk=;
        b=i3ZzFDMrgqoYrvc4Jwpi18P/Hww70sLUcodotac7+Wej5kO+JV5JsTEVvQF3jcO+Y+
         hD0Pi9dz5NYKpR2DQIdu2/BTVKr8wQhzu0fJNuULeIZddsD5dAtSvAO4DZvsNzh5pckt
         c4AWIQuw4M+kZ6UZZrMPxS2A177bp77ynPe5eRQXLQa6aj4FACXHxTk8RVLQhjf04dJL
         Mrs8PGxiPeK6TFua+OhtLTMfPnRJ7dJ9bB2Uq6GPq6HmngpQaUblYVI8T5kGsEvsuNji
         2yugGs+7JELJQEmOxoePXvjFE4sZ9fkFkOczQ9CSub7mAdZSDVYKdtRzhTXRXU8NSfUx
         R54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dlui1MM85qPWou0rQy0Hs7CHorUMH/STDx1YOYBhbKk=;
        b=oQG2nJ180Hx8EzMaeWkHL+7HHcHr1F8jo/va9hbX9a91Cqymv2R7dqsDeZ0uGSXilZ
         ggg9EBzUqeFapDn1dfzygn193hi4RqQ5asmREFOaAx10hdupCENKjQDFoeJ2R7siM87e
         uxpjVgU5Nb3e+NBva5cQEJNHIyVqW3VYdq57/DMZbhUwEj/5aA4QQq23FuuMlPRqC1mc
         2bMGOCdUgqnvyswYihFaRRDIPL8UWnVJEaZmwt6gWfbB3MnGb4Um2N9eflDPwd0eN/zr
         aVZA4mRxSPi/L5NHYPUMxM9kySmfwGzROEwBACvxCtmVUM9jwaG7Kv+B+UZuj0mJQEH+
         U/rw==
X-Gm-Message-State: AJIora8lNAPNJvKYUHgocsSZk+GfRqQudPx6R1FiAJ+Og5KjylSsmm0g
        OTwaBa7NNGSCtN2tBL5Mg5A=
X-Google-Smtp-Source: AGRyM1vkBg6CxYfgap5cCiBm1aQDmkILGJmL0vfocytDayk26xsoFmmFUOe72VnqpzDQlhai+8rXzQ==
X-Received: by 2002:a4a:e797:0:b0:435:5d08:f813 with SMTP id x23-20020a4ae797000000b004355d08f813mr174426oov.94.1657633542410;
        Tue, 12 Jul 2022 06:45:42 -0700 (PDT)
Received: from [192.168.1.108] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id 7-20020a9d0687000000b0061c5233ae54sm1615398otx.60.2022.07.12.06.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 06:45:41 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <28adfbda-4820-d6e4-cacd-8e1ef89a841d@lwfinger.net>
Date:   Tue, 12 Jul 2022 08:45:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/14] staging: r8188eu: use a local buffer for efuse data
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220709171000.180481-1-martin@kaiser.cx>
 <20220709171000.180481-6-martin@kaiser.cx> <20220712122507.GN2338@kadam>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20220712122507.GN2338@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 07:25, Dan Carpenter wrote:
> On Sat, Jul 09, 2022 at 07:09:51PM +0200, Martin Kaiser wrote:
>> The efuse_eeprom_data array in struct eeprom_priv is used only by
>> ReadAdapterInfo8188EU. We can remove efuse_eeprom_data and use a local
>> buffer instead.
>>
>> Use EFUSE_MAP_LEN_88E as buffer size. Its value is the same as
>> HWSET_MAX_SIZE_512. The functions that access the buffer use
>> EFUSE_MAP_LEN_88E for its size.
>>
>> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
>> ---
>>   drivers/staging/r8188eu/hal/usb_halinit.c    | 23 ++++++++++----------
>>   drivers/staging/r8188eu/include/rtw_eeprom.h |  3 ---
>>   2 files changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
>> index 18c2817bf1e3..807d8ce8cbfc 100644
>> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
>> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
>> @@ -929,6 +929,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
>>   {
>>   	struct eeprom_priv *eeprom = &Adapter->eeprompriv;
>>   	struct led_priv *ledpriv = &Adapter->ledpriv;
>> +	u8 efuse_buf[EFUSE_MAP_LEN_88E] __aligned(4);
> 
> This is 512 bytes.  We used to be slightly worried about declaring 512
> bytes on the stack, but I'm not sure the situation now.
> 

I think we should still avoid using an on-stack buffer of that size. It is 
better to use a local pointer, and kmalloc() the buffer and free it before exit.

Larry

