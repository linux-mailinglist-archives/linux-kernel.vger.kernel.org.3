Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEE14B5C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiBNVRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:17:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiBNVRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:17:07 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B290A12E9FA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:16:58 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y84so21619847iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fWI/C1yfb+9wFKwbONNPcLLBB0Ih56XvX3BMqqSOd1Y=;
        b=ESbE50vsogJHzE+1a/RYDHo/WgfZXW73RrPEMeyIGALKiYdqqPys80tZoNhVgugEYs
         iY6dmuXr1ODeIJMb/NYXeihuzaHzGJbdSdEU6uK3uSLGkRuBUd30/OSlMjY1cIxkJUjd
         m5gyZU313xbSJaxxtdTVjWincj2DECIIAvsWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fWI/C1yfb+9wFKwbONNPcLLBB0Ih56XvX3BMqqSOd1Y=;
        b=iXcWpnw2TOcNqvaOBzHdvpb/vPJA5oN5+3/Qw4x4EofpcTX+tiMhtmcxVaGKXBGjxv
         Coz8WYUwlGv5RBacEWFVs68xlstR3pTBaPiRZWEAN2ZCsrLWbsICnxowKXER64vCr8Kz
         4T9Pi6oElcSjXiDAz3GY/RE7+VF8nnsVyk+ZBy21cm5MBcoj6zG/ZnMyv1wZZscAIiME
         fNtv5neFXNn7ONCsu67iP0RxHiYFWdZHL/yavUSdvB2bnTg5+lcex2CDXULXpFF7QXYG
         EEIlSYaJU02z/5abrY32ganG3taI9WrZ+c4eEgzVBGaPudWxqM7M0wBWD6+ZruUhjeDs
         D4Sw==
X-Gm-Message-State: AOAM531KRQvV3OTOom3e1aMuZyBWJFnvEUdxROUW0sctTiKH7rnd1sBE
        pY11PkwFZMCzRcEUZUCXt6gxwA==
X-Google-Smtp-Source: ABdhPJyrXxz2EbuHWruPVS7GR25u9adQa2p6SuorPSX8MtPWSZ2UB8Ze0ZZB2AU1wMN1OrX+AeBeNg==
X-Received: by 2002:a05:6602:2c0d:: with SMTP id w13mr462239iov.184.1644873417859;
        Mon, 14 Feb 2022 13:16:57 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id j12sm10118708ilu.12.2022.02.14.13.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 13:16:57 -0800 (PST)
Subject: Re: [PATCH V2] selftests: Use -isystem instead of -I to include
 headers
To:     Kees Cook <keescook@chromium.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        sherry.yang@oracle.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220214160756.3543590-1-usama.anjum@collabora.com>
 <202202141125.085DF9BA6@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <51b7f746-d98c-b8e6-7d8f-98064ce0f697@linuxfoundation.org>
Date:   Mon, 14 Feb 2022 14:16:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202202141125.085DF9BA6@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 12:25 PM, Kees Cook wrote:
> On Mon, Feb 14, 2022 at 09:07:56PM +0500, Muhammad Usama Anjum wrote:
>> Selftests need kernel headers and glibc for compilation. In compilation
>> of selftests, uapi headers from kernel source are used instead of
>> default ones while glibc has already been compiled with different header
>> files installed in the operating system. So there can be redefination

Spelling - redefinition

>> warnings from compiler. These warnings can be suppressed by using
>> -isystem to include the uapi headers.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Looks good to me. With the above minor type fixed:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

This one depends on an earlier patch that added that added KHDR_INCLUDES
which is in Andrew's

https://ozlabs.org/~akpm/mmotm/broken-out/selftests-add-and-export-a-kernel-uapi-headers-path.patch

Andrew, would you like to take this through your tree?

thanks,
-- Shuah

Would you like to apply this on top of th
