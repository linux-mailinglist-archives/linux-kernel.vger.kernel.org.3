Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7854E2066
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344471AbiCUGEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiCUGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:04:36 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216141118
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:03:12 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id r64so7861518wmr.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EBikgYRw2c/sHqkB4t0mvVHWvtvXzFCbbvoiILuwHkg=;
        b=bn16jzKJJv2GQVBD8Z/Bp6eeIo1tQmq6eLeuPzvBN+vUbG/cOSssmBknmn7oO54C5k
         hU8rdwVhUodWtZhtsZKLEwFE0tzRESuQ5FZJrAmQ8A2jCMVwCueaxw/t75h4bUe9py4v
         FI20VtpT/FLiPxJoh/gZrZ2Ws7vf/+6pqkbi2CWhu7SpZIeXQ1IFx+bVk8prxTxWs0+M
         OMlNuCIjI0MgqFLnqy2hbzGkjwjbA430dlam3qdRoqudgt2k9XSc2PDmQmbw3W3xxmXQ
         YtHvr5aGYCPtk4266ieCJGbHtlVn/QxZ6Qn/Sdwg2aazldMdZzH8COaJ9k19+z3YawiQ
         ySDw==
X-Gm-Message-State: AOAM5326TYPUG9bF332asCkmY6oR6CU3VV0UcnnGTZgjiOstu6XXD1FV
        J+aOMRe6Rgn8vs4n9JXyUwMoeOOrDuQ=
X-Google-Smtp-Source: ABdhPJwVvIfLfqwr1wpVFAth37S4Y8p69+DoDJNk+LsmtspevUU9DDjR4+IsUkSvwHMDV7uTjWV1WA==
X-Received: by 2002:a7b:c319:0:b0:38c:8655:4019 with SMTP id k25-20020a7bc319000000b0038c86554019mr14256639wmj.60.1647842590648;
        Sun, 20 Mar 2022 23:03:10 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id s6-20020adfc546000000b00203f3de84d7sm8293068wrf.23.2022.03.20.23.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 23:03:10 -0700 (PDT)
Message-ID: <c7e6ca16-87a6-dbff-a2ad-852671b81b84@kernel.org>
Date:   Mon, 21 Mar 2022 07:03:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] try: synclink_cs: Use bitwise instead of arithmetic
 operator for flags
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org, dsterba@suse.com, elder@linaro.org,
        jcmvbkbc@gmail.com
Cc:     johan@kernel.org, linux-kernel@vger.kernel.org
References: <1647831852-28973-1-git-send-email-baihaowen@meizu.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1647831852-28973-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the $SUBJ says:

"try: synclink_cs: ..."

but you actually meant "tty:".

On 21. 03. 22, 4:04, Haowen Bai wrote:
> This silences the following coccinelle warning:
> drivers/s390/char/tape_34xx.c:360:38-39: WARNING: sum of probable bitmasks, consider |
> 
> we will try to make code cleaner
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>   drivers/char/pcmcia/synclink_cs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> index 78baba5..e6f2186 100644
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -922,7 +922,7 @@ static void rx_ready_async(MGSLPC_INFO *info, int tcd)
>   		// BIT7:parity error
>   		// BIT6:framing error
>   
> -		if (status & (BIT7 + BIT6)) {
> +		if (status & (BIT7 | BIT6)) {
>   			if (status & BIT7)
>   				icount->parity++;
>   			else


-- 
js
suse labs
