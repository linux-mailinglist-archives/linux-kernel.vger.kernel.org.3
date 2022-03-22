Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C096B4E4976
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbiCVXDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbiCVXDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:03:42 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA656D962
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:02:14 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id x4so21978114iop.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=toy6z6Kl8mnpCW5ENY3GGR71IKLMBRyvi1noEc5gPWw=;
        b=h+oM/mGxRCxY0xxJRyuxMsOYDi1WkKqwJ1Yv7dUJ+okHlDeOgQilO7NlowRm5nFLtm
         Zc4mq1iccPEd0j39BtMBbeRX4rfUuYcZGUTsCC6JZKAjWt1QdYhnR2W9EGM9++sNX1Eb
         +FXptti4OkZnuNPXXDwFp7LOGSAgypXjJcMyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=toy6z6Kl8mnpCW5ENY3GGR71IKLMBRyvi1noEc5gPWw=;
        b=L7YVq73KOAcMhFU58f8kJAjPlJMVlag4wFDG2pMGr6nYeZNr+VItAnjIkFFrgS4ATZ
         eHh6miT9s3TMFRKZHLlAL38x3gAbRW2/ml8i7xF0IgxYVmTmgINZ0inPk/4a2MXVPpqQ
         gdN9OiOpLMRpmnmCTtQUosAIJqL4W0VU/toynOpQ452NBhu1PijF7uve+9kJytE8Dxow
         ov/O40o8XGrqANzVcqa3oOSz8xkqPzBPNG8zcpdn0SY5Bz3F62VoOTOX2KFSCq3reXU5
         zvy2vFbg75KznqYNn2U7ahsSVUosr8o+lkyqt9OxcHNkiYUW/58lBInsu79h6n1WYsGn
         i9vQ==
X-Gm-Message-State: AOAM533matw9dWvx902o3Vt6EstM6y2UjV4rk+j0wKnnudlZZroPfUB9
        XnU2HuO2pKDx1huYJ68vOVn+LQ==
X-Google-Smtp-Source: ABdhPJzmA5svvRVhL72rZCZGP5Bb+JRBYbZHarYCLhpcO3VPjZZufR/4PRSLk3r8/Dp6yWEwcSnqgw==
X-Received: by 2002:a05:6638:130b:b0:317:cc10:1c88 with SMTP id r11-20020a056638130b00b00317cc101c88mr14798927jad.34.1647990133435;
        Tue, 22 Mar 2022 16:02:13 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o11-20020a92a80b000000b002c1ec0ca545sm11069613ilh.18.2022.03.22.16.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 16:02:13 -0700 (PDT)
Subject: Re: [PATCH linux-next] selftests/proc: fix array_size.cocci warning
To:     Guo Zhengkui <guozhengkui@vivo.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     zhengkui_guo@outlook.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220321102546.12569-1-guozhengkui@vivo.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <eb5dd04b-a20c-1874-e71e-60c962ad8dcb@linuxfoundation.org>
Date:   Tue, 22 Mar 2022 17:02:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220321102546.12569-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 4:25 AM, Guo Zhengkui wrote:
> Fix the following coccicheck warning:
> 
> tools/testing/selftests/proc/proc-pid-vm.c:371:26-27:
> WARNING: Use ARRAY_SIZE
> tools/testing/selftests/proc/proc-pid-vm.c:420:26-27:
> WARNING: Use ARRAY_SIZE
> 
> It has been tested with gcc (Debian 8.3.0-6) 8.3.0 on x86_64.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>   tools/testing/selftests/proc/proc-pid-vm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
> index 18a3bde8bc96..28604c9f805c 100644
> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> @@ -46,6 +46,8 @@
>   #include <sys/time.h>
>   #include <sys/resource.h>
>   
> +#include "../kselftest.h"
> +
>   static inline long sys_execveat(int dirfd, const char *pathname, char **argv, char **envp, int flags)
>   {
>   	return syscall(SYS_execveat, dirfd, pathname, argv, envp, flags);
> @@ -368,7 +370,7 @@ int main(void)
>   		};
>   		int i;
>   
> -		for (i = 0; i < sizeof(S)/sizeof(S[0]); i++) {
> +		for (i = 0; i < ARRAY_SIZE(S); i++) {
>   			assert(memmem(buf, rv, S[i], strlen(S[i])));
>   		}
>   
> @@ -417,7 +419,7 @@ int main(void)
>   		};
>   		int i;
>   
> -		for (i = 0; i < sizeof(S)/sizeof(S[0]); i++) {
> +		for (i = 0; i < ARRAY_SIZE(S); i++) {
>   			assert(memmem(buf, rv, S[i], strlen(S[i])));
>   		}
>   	}
> 

Looks good to me. I will apply this once merge window closes.


thanks,
-- Shuah
