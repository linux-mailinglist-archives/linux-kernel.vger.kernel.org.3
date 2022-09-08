Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34E75B1677
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiIHIKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiIHIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:10:26 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1776171BF9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:10:16 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id bj12so36134137ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Bj+mLV6GrBWexFrxYIG1e6IyShZ1xzdoaItMhP88h9U=;
        b=DYD9H3kNrMMX1v9aGFkGmSJPdsk6yOOj902oYmmJTRFDo8Zgz0C+fXTLI+cVbBneaW
         W5HRO4GJUA42yo3BG3yqmWE33xPhkHRRyuRJvOU0SAAdRzJ8aEkm8oY71WoeVQ6rZNP9
         8xLHgyDa7KgTEL+MbBPt3gw6lRNErmtmjB9z8eeTenUWbX/2qMwpwOpYI9Ucq3aLG3TD
         Wv6JbU3cKcsPBSYTa35EfNYrc3667+DnZueyvVexl+T9/SPYWRuqAqHWuUlOdVaFR3+Y
         1gdupqjpyWi3FdTDxBNJo+3la3WJKO2qN65K0nzuRXTzipzkVwvsvKtwJcVe5LkYEeNd
         pgSQ==
X-Gm-Message-State: ACgBeo0HQ7DF61FiQ8ZKazOvDNv6/mD9Gc8mfAM3O7Ami13e4Gt3Bpfu
        F7VqkT+RfbGxTzoTUqWtyNtCEoeO630=
X-Google-Smtp-Source: AA6agR6k1Um0VmSoHS4As+BSzUbpu1RWDNGgrfO4GNVwN+5EjmH2dmPTHcms2++xzuWuoe8RrY7guw==
X-Received: by 2002:a17:907:2c44:b0:770:8623:66c4 with SMTP id hf4-20020a1709072c4400b00770862366c4mr4364644ejc.3.1662624614380;
        Thu, 08 Sep 2022 01:10:14 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7c6c5000000b00450206d9dfbsm783233eds.84.2022.09.08.01.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 01:10:13 -0700 (PDT)
Message-ID: <6236da54-c651-9dc7-f5ce-824be96b3e9d@kernel.org>
Date:   Thu, 8 Sep 2022 10:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] tty: vt: add a bounds checking in vt_do_kdgkb_ioctl()
To:     Hangyu Hua <hbh25y@gmail.com>, gregkh@linuxfoundation.org,
        changlianzhi@uniontech.com, dmitry.torokhov@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20220908075403.27930-1-hbh25y@gmail.com>
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220908075403.27930-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 09. 22, 9:54, Hangyu Hua wrote:
> As array_index_nospec's comments indicate，a bounds checking need to add
> before calling array_index_nospec.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>   drivers/tty/vt/keyboard.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index be8313cdbac3..b9845455df79 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2067,6 +2067,9 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>   	if (get_user(kb_func, &user_kdgkb->kb_func))
>   		return -EFAULT;
>   
> +	if (kb_func >= MAX_NR_FUNC)

kb_func is unsigned char and MAX_NR_FUNC is 256. So this should be 
eliminated by the compiler anyway.

But the check might be a good idea if we ever decide to support more 
keys. But will/can we? I am not so sure, so adding it right now is kind 
of superfluous. In any way we'd need to introduce a completely different 
iterface/ioctls.

> +		return -EFAULT;

EINVAL would be more appropriate, IMO.

> +
>   	kb_func = array_index_nospec(kb_func, MAX_NR_FUNC);
>   
>   	switch (cmd) {

thanks,
-- 
js
suse labs

