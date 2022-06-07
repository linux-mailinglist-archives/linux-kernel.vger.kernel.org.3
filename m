Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA9753F874
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbiFGIpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiFGIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 559E1D4100
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654591533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gw6n8kcnDAqzzZl0t5SzEkY3u1ygu5PNN0SfRbosyDU=;
        b=E9KRSuxvmCf6bJlJKN4zQMFdt7AmfxKphVC8uNifL86j9j5XWBGWI1cgdOKDBdnYHYSohj
        zQbLhIChWv7Ch8XfrOlR8ZxRt+gu6J8kbTomYOfw/XSkpdg0XAgHk+AQEnQGMMsXZZV0Ub
        m21HRqeC/HSPedVMQ1xDwmVBegcfPYw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-4-bMjQGLOOu6-Ef1xwe_Wg-1; Tue, 07 Jun 2022 04:45:32 -0400
X-MC-Unique: 4-bMjQGLOOu6-Ef1xwe_Wg-1
Received: by mail-ej1-f70.google.com with SMTP id n2-20020a170906724200b006fed87ccbb8so7441517ejk.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gw6n8kcnDAqzzZl0t5SzEkY3u1ygu5PNN0SfRbosyDU=;
        b=4P1pVHi2OgATj9clNeLH+svVrafFkDldSGYf+AgY5WcMELy9tQDx67/69QbOPqTKiS
         h/v/UN3WO/zHwcFKcCdtFJUE6276zhEWJsVsZT/JSGpplPTH5AkNI7lKprsE8qXLXhqV
         J6so2qn1XQLz310FpsMTpkF99kjTmX42U1Q49HHtdW6O50lgYHnXV/+cvuRiMBzN81Mw
         IvizszP5ZD5nTEiHD8eO4KFDkHkeyBV9g6U872fP/GSap7bQXiSLqONc8tgljk/cnytm
         bb9KL1MLRCeIbAOjFpc7tMeIykb/CEtdVk+fGINbvlXjo3t8STlx/0IXhRXXkFJHhpIz
         XPRA==
X-Gm-Message-State: AOAM532Ixqn18jmzItwDv12AsLxs0yT+y94L6FWTBEGXdUz8cKYfif1b
        h35MeXyLMFvGMRi3D5QHE/f28DQ2eJChFDDxilIONutRdyNjKzHcyBxsh4PhPbjMrvmEilRCI4Y
        nAx77A27H5KIrovNjlcS6GXf1
X-Received: by 2002:a17:907:2daa:b0:6fe:b449:6a8f with SMTP id gt42-20020a1709072daa00b006feb4496a8fmr25098967ejc.318.1654591531151;
        Tue, 07 Jun 2022 01:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjr+mGRtNi/fkJf8ZvakUYRPS13AOp0TlU6j86OW8mrDlsW0ssNpowuYW6Cm2YKDaEb5wqdw==
X-Received: by 2002:a17:907:2daa:b0:6fe:b449:6a8f with SMTP id gt42-20020a1709072daa00b006feb4496a8fmr25098945ejc.318.1654591530888;
        Tue, 07 Jun 2022 01:45:30 -0700 (PDT)
Received: from [192.168.0.198] (host-95-248-229-226.retail.telecomitalia.it. [95.248.229.226])
        by smtp.gmail.com with ESMTPSA id w2-20020a056402268200b0042ddd08d5f8sm10457417edd.2.2022.06.07.01.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 01:45:30 -0700 (PDT)
Message-ID: <f24a539c-f6bf-5e5f-c98f-b31d6a5c1564@redhat.com>
Date:   Tue, 7 Jun 2022 10:45:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] sched/deadline: Use proc_douintvec_minmax() limit minimum
 value
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, bsegall@google.com, vschneid@redhat.com,
        rostedt@goodmis.org, mgorman@suse.de, vincent.guittot@linaro.org
References: <46b7ca44-a338-e1c1-e005-326e89576211@redhat.com>
 <20220513024109.648471-1-yajun.deng@linux.dev>
 <9150a4ffa0ff94ab4697d615c60ed9b4@linux.dev>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <9150a4ffa0ff94ab4697d615c60ed9b4@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 10:35, Yajun Deng wrote:
> June 7, 2022 3:55 PM, "Daniel Bristot de Oliveira" <bristot@redhat.com> wrote:
> 
>> Hi Yajun
>>
>> On 5/13/22 04:41, Yajun Deng wrote:
>>
>>> proc_dointvec() is not applicable for unsigned integer, use
>>> proc_douintvec_minmax() limit minimum value.
>> I understand your patch, but your log message is somehow incomplete.
>>
>> Could you expand on that, showing the problem using an example, and then how you
>> see it fixed?
>>
> This patch isn't a fix. It's just an optimization for match data and proc_handler in struct ctl_table.
> 
>> Also, could you please add the Fixes: tag so this patch can land on stable trees?
>>
> This statement 'if (period < min || period > max)' in __checkparam_dl() will work fine even if there hasn't this patch.
> So this patch may not need land on stable trees.
> 

Good, so you already know how to improve your log message.

-- Daniel

