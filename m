Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3426A4D3BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbiCIVGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbiCIVGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:06:52 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC2D108558
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:05:53 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id b14so2397037ilf.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 13:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hH3C1LhyPaDv8wejLOvzBm1bdTcO+3Rix77JV0niJRQ=;
        b=hrOos9iyqn4LWGeeERyxvhB9pbIfNlnkwRtaGZGSJdSUr1jnK1LRFN+fn3EaBq0g6l
         /MHI18Xq9Dskl9lrgaR1BHZWHBHwYEjdaSyly9LODKjcG3XhqfIoLOHV6W58uzUaR+AB
         uoASIXG0rXUG8UNMqZiSPrRfsL+5R09idXvIb680Mghq+vD+h68+LYQepaufunkpnEVR
         yKrAVsCLOyAs+72ZGWlc2KDBM/Wy7QmVrUfkfgXctInw03vB1vu/L6sPIhS3uQ8J5b7j
         5bZZIxJd3lY7gv2NImVbrhFoCb/8aJ5D/6ZAe55u3/k9wia/8AEFJDLbDDuqwOx50TC2
         qFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hH3C1LhyPaDv8wejLOvzBm1bdTcO+3Rix77JV0niJRQ=;
        b=F5ApEZOgY63WuUrCpMWRqBim2358PEg4CFILsWjSiX98R90+C0vHvIDtDrlprPePq3
         5fV3AZJ3zs11qxDQwaKw3zhp4PDpTa72+0R1xAp+/lUAuUugQHGwv5D6ndxcxMC2nlqg
         rsEFZ5jAsSfB75DbrnbXwmyI5tZJzFxsgYOdsSuW97XSfUSbJgSbNal3zQI3PsjouKlR
         m0pjIJgEMtq50F6RxG2VDlFnWtWAsIBYUHcaGGNOyXbNUkA2XG3nSGP4BzWZrdGzz6Yj
         kyG30a5qBFJwLKONjzb+mjKEGmfXIa7aGOqoVg/ck7OfHzcGoBDGk06sgMNvfJfnGVzI
         s7WQ==
X-Gm-Message-State: AOAM5330z7b1fDfB2uHlPa6g+jr24PPRb3alPG2Nc32vkseg3Kz6OTHb
        ayyypxbple/jgfqRWxAiKDFzow==
X-Google-Smtp-Source: ABdhPJwBI32AGLKEvw7cjjVqa0Yyd5Obb2Z1aOnpo9pbWYogwdmD3ytasmnnHPA/YfrmfL3MxaSyKw==
X-Received: by 2002:a92:c810:0:b0:2c6:ba9:6a42 with SMTP id v16-20020a92c810000000b002c60ba96a42mr975528iln.275.1646859952437;
        Wed, 09 Mar 2022 13:05:52 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d16-20020a05660225d000b00645c8db7767sm1568074iop.35.2022.03.09.13.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 13:05:51 -0800 (PST)
Message-ID: <01459886-2393-665a-43b1-70082ceace0c@kernel.dk>
Date:   Wed, 9 Mar 2022 14:05:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 07/13] task_work: Introduce task_work_pending
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <20220309162454.123006-7-ebiederm@xmission.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220309162454.123006-7-ebiederm@xmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 9:24 AM, Eric W. Biederman wrote:
> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
> index 5b8a93f288bb..897494b597ba 100644
> --- a/include/linux/task_work.h
> +++ b/include/linux/task_work.h
> @@ -19,6 +19,11 @@ enum task_work_notify_mode {
>  	TWA_SIGNAL,
>  };
>  
> +static inline bool task_work_pending(struct task_struct *task)
> +{
> +	return READ_ONCE(task->task_works);
> +}
> +

Most of the checks for this is current, do we need READ_ONCE here?

-- 
Jens Axboe

