Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4CB514D15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377152AbiD2Oee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377467AbiD2Oe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B18997E589
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651242657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otC9DXNrumV9ADnWdC4KITC7tB4toV2wezmUxcguZqs=;
        b=iIpTW8c+IrAmZiLgvhgvLC3mb29eFN1q7VSexrN6z5BH/3BiGnkOeAYf8D35LH0Zbi8W+l
        nC4JGVvXvrduiS2aX7QcspMZlMjRwXvDJHutD71KIl5iZGLLDI3ClaRVqavfBB7XuVzdC9
        7TWOLS4nBwkaKsc5i8zOHD4Xza0xqEI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-Q5Cu1JIQPj6TVWVVj8lgDw-1; Fri, 29 Apr 2022 10:30:54 -0400
X-MC-Unique: Q5Cu1JIQPj6TVWVVj8lgDw-1
Received: by mail-ed1-f70.google.com with SMTP id w8-20020a50d788000000b00418e6810364so4581120edi.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=otC9DXNrumV9ADnWdC4KITC7tB4toV2wezmUxcguZqs=;
        b=leH2VgFjf5vMpwrm303R2d1UXJgVibJyTNtrezwZKlXxcGpDhKQkiCc/H+InwR80gs
         C/loOz5sDorU/E/I9obUIZ6lZCmXo76nsNPLedgjGKdN9LzCCMiuv6jNrrGUXHNp13U1
         OC2mjQJigxbfp1XMWcnCBahV+noXb2fzBp1usd4nF2rHm4zVQX/izGeKwBYMhyE4Du32
         i0ax+MDva8XtxygrWIO0W5Eh2KUTyvtw5stDVQ3kY7PyXug6YxornL8bymBA+IpfjRqZ
         LmuNkE3pxzSWi/x5DajKTsbG/d8wmDtD+J+PCMbTaK3l9YIbAUX0QOei7NMgLYvNDFa1
         XLJA==
X-Gm-Message-State: AOAM531YW8N2mX3662yOSKsR5fX+D/rzwKBNwoE7ye5hTRH4SqrVvacC
        jH5NmxO10NM8W8iJPuUMJDMdnCTHpatzyDIazu5kb/njflXDE/yvhMVQEPAayUjVw6M6c4yvecJ
        d7wAwIUNJ5JfRqIasNWnuc1tr
X-Received: by 2002:a17:907:d22:b0:6f4:7bb:d53e with SMTP id gn34-20020a1709070d2200b006f407bbd53emr1081146ejc.251.1651242653361;
        Fri, 29 Apr 2022 07:30:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxm48FH0VCEF+U8tQQMoFCKag5I+XS0/Sr4pcNWpDjj1rw/mFVrxKOCL2YGjUjrZbOhl4tPOA==
X-Received: by 2002:a17:907:d22:b0:6f4:7bb:d53e with SMTP id gn34-20020a1709070d2200b006f407bbd53emr1081133ejc.251.1651242653161;
        Fri, 29 Apr 2022 07:30:53 -0700 (PDT)
Received: from [192.168.0.205] (host-95-246-22-34.retail.telecomitalia.it. [95.246.22.34])
        by smtp.gmail.com with ESMTPSA id rb48-20020a170907693000b006f3ef214e10sm707940ejc.118.2022.04.29.07.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 07:30:52 -0700 (PDT)
Message-ID: <e5931289-fd8c-c4d9-5ec3-c2c9edb1d2c6@redhat.com>
Date:   Fri, 29 Apr 2022 16:30:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/2] sched/deadline: Remove superfluous rq clock update
 in push_dl_task()
Content-Language: en-US
To:     Hao Jia <jiahao.os@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
References: <20220427080014.18483-1-jiahao.os@bytedance.com>
 <20220427080014.18483-3-jiahao.os@bytedance.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220427080014.18483-3-jiahao.os@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 10:00, Hao Jia wrote:
> The change to call update_rq_clock() before activate_task()
> commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq
> when pushing a task") is no longer needed since commit f4904815f97a
> ("sched/deadline: Fix double accounting of rq/running bw in push & pull")
> removed the add_running_bw() before the activate_task().
> 
> So we remove some comments that are no longer needed and update
> rq clock in activate_task().
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

-- Daniel

