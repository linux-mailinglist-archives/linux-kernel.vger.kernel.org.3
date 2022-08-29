Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5B5A4500
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiH2IZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiH2IZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09955F5D
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661761500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ffzASJ5RzwrvnsYniqVmCN93ofeL643Qv+eHWwTZAg=;
        b=jIiE3ug9/+JYnNP0OY8SpgEuZZWyVpE2GpG2LpfGkrcX5NnCqoAMKKR7fQyoxJ8H0LeEqt
        CbqtX23/2NLSTm1QKieLBQh7PmWcjLTo7ttrrbDE224DwkL3qVWVVRzC4RkM3e4OxmoGYD
        HL+x8PF9eFbU69UTrIeU/vfGNkI6X94=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-365--kVkDAuINb6nQBOO3IPb5Q-1; Mon, 29 Aug 2022 04:24:58 -0400
X-MC-Unique: -kVkDAuINb6nQBOO3IPb5Q-1
Received: by mail-ej1-f71.google.com with SMTP id gs35-20020a1709072d2300b00730e14fd76eso1980488ejc.15
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3ffzASJ5RzwrvnsYniqVmCN93ofeL643Qv+eHWwTZAg=;
        b=pDb5Bkx8H0LWfHM9YzQ/djq9W1/BNowx2Em/e0RwPTAbJN+IXz1jXsVZTMqNLyROzR
         3lnnNd4faZJt2Um9NSLwmMPn1cJJCjMTF0EB0jdD2Snz66h47AmI0iV24q2I/2U8zcGh
         ZjY+pR6g1l3He1mVHq4tnhmX+a88UF1DvwxUYjutoH21Ol4GT58W6r4mn679yKv0f+Tz
         rv1l/wz+510bsgs/3yBzNlJGus3gdyTHxuRWSBNIpjPEv4OH0awtovJWpjpnLiV6q2VZ
         4MphYKDddoasUJRJsDi0hoeNBMYy7RguGNGEMagh7Rp+2x+0U10eqoI58I1ELM+FPUxX
         Y1og==
X-Gm-Message-State: ACgBeo0r3hu+pjumFP2ia5DoqQc9Gm3Hs7z95dIogGuPa+itR+sIGXij
        6q4IHPtNYpNP5+lMG0iZIAjflUuLbwxbSho7F1dPMXkAMQ9HgH46/ou9WiQBf4xqn6CsDYBStda
        snBx1QQRvfivKIVzB/ck/mIqS
X-Received: by 2002:a17:907:6e94:b0:741:8c76:2ed8 with SMTP id sh20-20020a1709076e9400b007418c762ed8mr2765721ejc.731.1661761496904;
        Mon, 29 Aug 2022 01:24:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zAeCTxDniKZ4Fi7n6IQbOFe/+xeZOarEUliuJGkFveIrggifXwj9ts0bK/JEFcwVZxECKdQ==
X-Received: by 2002:a17:907:6e94:b0:741:8c76:2ed8 with SMTP id sh20-20020a1709076e9400b007418c762ed8mr2765703ejc.731.1661761496721;
        Mon, 29 Aug 2022 01:24:56 -0700 (PDT)
Received: from [192.168.0.198] (host-87-8-60-205.retail.telecomitalia.it. [87.8.60.205])
        by smtp.gmail.com with ESMTPSA id dk1-20020a0564021d8100b0043bea0a48d0sm5367713edb.22.2022.08.29.01.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 01:24:56 -0700 (PDT)
Message-ID: <9498c691-2a85-b9b1-7852-8b362455b840@redhat.com>
Date:   Mon, 29 Aug 2022 10:24:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next] sched/deadline: Move __dl_clear_params out of dl_bw
 lock
Content-Language: en-US
To:     Shang XiaoJing <shangxiaojing@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220827020911.30641-1-shangxiaojing@huawei.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220827020911.30641-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/22 04:09, Shang XiaoJing wrote:

Why are y'all always setting "-next" to the subject?

> As members in sched_dl_entity are independent with dl_bw, move
> __dl_clear_params out of dl_bw lock.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

-- Daniel

