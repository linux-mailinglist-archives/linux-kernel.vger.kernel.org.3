Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B793E50D9D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiDYHDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiDYHDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:03:02 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9867919C35
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:59:58 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id y21so10330486edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=69va415PiLD8VvexMqWaGIWFwE7zpQOFIyIx4bGLEew=;
        b=0bvYcl+qaSeUyDeWNFYcMhUeY1Qnt2zDyRjSPHh1CMbKhN7E9aypYrnTylGXTdsj6O
         4bUZRC5RVFsC1A/K95IYLhmCOBoUCyezOQb2Urr92m20E6vVZ992Y2IAREzFHh5cxJ6n
         dgGr9Z/CtfiOaGGx50Yr/yF0VxLI6jaMHGNmLJemsKSPGVHP1B8TR/esoCpH0lM/795g
         9S5hG6PxiF3dG4Vkc5QOke5pasMEFjR5uQHZJYTvyC5JG8mYYOE27BGwieiBr8vxOkBU
         9MmaoNe6J8oUjzf0L1+gQvbTwT+Ps1FhnSAKDwMxYcHy/48E6CfxnuNCvqBOXbigCnhk
         xDOg==
X-Gm-Message-State: AOAM530Qa87419YUeRz9ygY1oVWwoOTjSF6tMgX0zhC2dDLQ7yODsXiD
        C14W4tAXHJ8mubn4kQ05vZWda8PZf4g=
X-Google-Smtp-Source: ABdhPJxNHfKf5gUdSNbtF0smxxhbjCYImpyNeQazpz8YoXuos/zbK/+Zs/WOtXa+6xkKNQjqAT0LrA==
X-Received: by 2002:aa7:c3ca:0:b0:425:ecfc:4258 with SMTP id l10-20020aa7c3ca000000b00425ecfc4258mr2149169edr.266.1650869997126;
        Sun, 24 Apr 2022 23:59:57 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm4023728edb.39.2022.04.24.23.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 23:59:56 -0700 (PDT)
Message-ID: <71d92931-ac01-be32-a7ef-9f533096ab49@kernel.org>
Date:   Mon, 25 Apr 2022 08:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] tty: vt: consolemap: Add missing kfree() in
 con_do_clear_unimap()
Content-Language: en-US
To:     =?UTF-8?B?6IGC5rGf56OK?= <niejianglei2021@163.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220303020630.460257-1-niejianglei2021@163.com>
 <4a7fe3ca.68b6.17f6eacb952.Coremail.niejianglei2021@163.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <4a7fe3ca.68b6.17f6eacb952.Coremail.niejianglei2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09. 03. 22, 13:34, 聂江磊 wrote:
> I found this bug by using clang static analyse checkers. I found that 
> function con_release_unimap() is only called in this 
> file(drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c). There 
> are totally 5 times that con_release_unimap() is called
> (line 430, 466, 522, 599, 673) while con_release_unimap() is not 
> followed by kfree() only in line 522. So I think it is a bug
> and make this patch.
> 
> 
> At 2022-03-03 10:06:30, "Jianglei Nie" <niejianglei2021@163.com> wrote:
>>We should free p after con_release_unimap(p) like the call points of
>>con_release_unimap() do in the same file.

But this one does not free it on purpose, right? See below.

>>This patch adds the missing kfree() after con_release_unimap(p).
>>
>>Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
>>---
>> drivers/tty/vt/consolemap.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>>diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
>>index d815ac98b39e..5279c3d27720 100644
>>--- a/drivers/tty/vt/consolemap.c
>>+++ b/drivers/tty/vt/consolemap.c
>>@@ -520,6 +520,7 @@ static int con_do_clear_unimap(struct vc_data *vc)
>> 		p->refcount++;
>> 		p->sum = 0;
>> 		con_release_unimap(p);
>>+		kfree(p);

You've just broken con_set_unimap(), or do I miss something?

>> 	}
>> 	return 0;
>> }


-- 
js
suse labs
