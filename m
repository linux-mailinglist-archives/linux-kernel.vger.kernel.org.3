Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790F0560B83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiF2VSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiF2VSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:18:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD765B7F2;
        Wed, 29 Jun 2022 14:18:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso1961398pjz.0;
        Wed, 29 Jun 2022 14:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i7eaMBVB7yUnTpudl4qdcwzP++vYZc8Pq3HUMlacEVQ=;
        b=ITiV0rXMXIjJoVjJRJvV/mxBOzcJCHSlCNG8ScPXIbpaE1GPpDtZgqnkQecgrQhvcg
         kPouE6lpWixq8ZIl0gf0U6VU4EJzFpSXsuV1VtcGC3CwedeLDDIDzUPh7ePqLSYTVCnw
         1YbS6MImVhSMtfyyJlAjfkGx840UGeciSjZQh6LR5VHZ1i25JnMhnTrBJ9CX3q4uBJ9h
         /VugsDeOAVs2lkA4sZGyl8JA6QPU8RAXprqHFN/z3fgCHXvyKDLvRWITTpXUUhZHXFA0
         RVFd8zGOH1UhsXk9rnxyPuhCew3vk8pHK0wDzQYV/POJb7AuIqGXrKyxCHrS91nfGjf+
         cImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i7eaMBVB7yUnTpudl4qdcwzP++vYZc8Pq3HUMlacEVQ=;
        b=SMx2VDJbtOmdXL8d7U7Dpwqcm5Qsbieku6RQ0nl5qWrvx+dQY659HSzvCD0TBZ/DSK
         mSLWMzgSoUhQP6hHe5ayX/hz2kGWMIGk/6T64C2ZUSLy4NP3ozdX73j1KhAEyzKegzJx
         7Onun1EfReSrF9L6HpaUCnAGDnDe6mlkdKxX18v5iFX9mDMcddB1iTpvrHgV0YQpDw7T
         Py+a7b1yjVIaYuGsPtksHVUdQn/Rbz8/3I6q/iqHU9iIlg4VoujkTXlPM/W2NpYfCmUF
         xr0Ra0YryvBN8b5nooQWuno7jQaE+SgZyCMy09IU2hpwE2Gss2VTT0YWRieod0DiU+LL
         s2dA==
X-Gm-Message-State: AJIora+lxKBiM0SaDjmBUy9227xFiIt5sjKtmf3zO8ru2DHs8cdaRmSv
        m5seYpYjJ0O2MVp25u+Dt6gs/DejNDs=
X-Google-Smtp-Source: AGRyM1tPobdvnh0ZkpuTCg79dx/XZ6u3r3wUqOtBNbfnAMNCpGvyhPAI+2xLNc0UKC2T1MUb5MhHnA==
X-Received: by 2002:a17:90a:760e:b0:1ec:83e0:3ae1 with SMTP id s14-20020a17090a760e00b001ec83e03ae1mr7624976pjk.25.1656537494241;
        Wed, 29 Jun 2022 14:18:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b0016378bfeb90sm11915322plb.227.2022.06.29.14.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 14:18:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <14b0ee4f-a12f-ccf2-633a-470be3cdfa38@roeck-us.net>
Date:   Wed, 29 Jun 2022 14:18:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] hwmon: (lm90) Use worker for alarm notifications
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <20220629154210.2389765-1-linux@roeck-us.net>
 <ba43ed2c-0290-ca5b-ab4b-1f25dad9d882@collabora.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ba43ed2c-0290-ca5b-ab4b-1f25dad9d882@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 13:02, Dmitry Osipenko wrote:
> On 6/29/22 18:42, Guenter Roeck wrote:
>> Reporting alarms using hwmon_notify_event() may result in a callback
>> from the thermal subsystem. This means that such notifications must
>> not hold the update lock to avoid a deadlock. To avoid this situation,
>> use a worker to handle notifications.
>>
>> Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Fixes: e182cf579f0f ("hwmon: (lm90) Rework alarm/status handling")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Dmitry,
>>
>> can you give this patch a try in your system ?
> 
> It works, thanks!
> 
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
Thanks a lot for testing!

Guenter
