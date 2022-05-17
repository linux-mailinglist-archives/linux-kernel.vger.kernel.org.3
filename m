Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0204852A535
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349268AbiEQOs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349244AbiEQOsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E1E44CD5F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652798931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lrq/y6BGlNlVOgPjtbRzFqsueG5xaPLbHBUEC0COjvA=;
        b=C45/SXAkVJTtw4SW1tEubueQRN6Npo9H9IGuaqbEoTYsVY4fPQfBFCq/BkH4ZTN4bLcv8w
        54u6/XACyGqoXp8ejQVbYlHZBgskhUtWW4cWseYVF/Qcuy2QIz0F9zWyH47ddAnWuJOqFv
        3b0aDfPrdlfyzW4cKcfPIryjZ9djfbg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-zMjbcAprPKahZTJiNs49Uw-1; Tue, 17 May 2022 10:48:49 -0400
X-MC-Unique: zMjbcAprPKahZTJiNs49Uw-1
Received: by mail-wm1-f72.google.com with SMTP id i131-20020a1c3b89000000b00393fbb0718bso1396079wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Lrq/y6BGlNlVOgPjtbRzFqsueG5xaPLbHBUEC0COjvA=;
        b=1GsGQtk5em6H7jcAr2DdmxP0mit7VMnIk/WgqA/SJgXRcOUQ0SN978lxhMyI9hEhfb
         GS1L1/hjTJ4sdznunzU+8bP35lBxCo+ag4Vtzv5SU42Y04JLZTXUs7VI+9A3aLHERfp5
         Ka6EQCnOffS+J4jRrponU2E6R6DPFtDAfrGayI988kARma11lJqwI8pA+Bea5h4IVLhi
         mf7lBfEsnq9gM8Lnv3x8TSFGN/BBvysTeLsLezHMr2k6FhXG+VhgNwzfji6C+PyVVlfi
         NJ/juGK2cC0tUv/lSL3PtxI64UjjW299EGxqTrEn5YUfMrEOeJKg64p7v7knwPxDWL9b
         llqg==
X-Gm-Message-State: AOAM530x1dUyLcvqw0NU/VlVokInHkJeRYT6+z0YJl4owXGwHQqJ81hf
        66JgF8dcuv2WMz2MNZL57q7I0Tqv0pam86r2JaP+WNxWSqrPRkmvq4d8EGgQAYmAxiT9C0ssUfV
        mPcRwUI0pyq8lMWfUnB+6xMPCRAfIbPxc3/CI6N6T+4btvtnC2oHlHYaL350YPxJCN6fgA01gdF
        dP
X-Received: by 2002:a05:600c:4e94:b0:394:89c9:a505 with SMTP id f20-20020a05600c4e9400b0039489c9a505mr32372847wmq.172.1652798928337;
        Tue, 17 May 2022 07:48:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh56zphmlDWqYRhxQTx06KjFt7Px60hp28D9kA81BoQtzj/874xNJDmv2Be5W4+J65STy6RQ==
X-Received: by 2002:a05:600c:4e94:b0:394:89c9:a505 with SMTP id f20-20020a05600c4e9400b0039489c9a505mr32372824wmq.172.1652798928100;
        Tue, 17 May 2022 07:48:48 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id n4-20020a1c2704000000b003942a244eebsm2009750wmn.48.2022.05.17.07.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:48:47 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yajun Deng <yajun.deng@linux.dev>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/rt: fix the case where sched_rt_period_us is
 negative
In-Reply-To: <fdfc0c8f6027c2071674d52f27f7d7da@linux.dev>
References: <xhsmhmtfh1ptb.mognet@vschneid.remote.csb>
 <20220512003945.610093-1-yajun.deng@linux.dev>
 <fdfc0c8f6027c2071674d52f27f7d7da@linux.dev>
Date:   Tue, 17 May 2022 15:48:46 +0100
Message-ID: <xhsmhk0ak1agh.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/22 01:55, Yajun Deng wrote:
> May 16, 2022 11:04 PM, "Valentin Schneider" <vschneid@redhat.com> wrote:
>>> },
>>> {
>>> .procname = "sched_rt_runtime_us",
>>> @@ -44,6 +45,8 @@ static struct ctl_table sched_rt_sysctls[] = {
>>> .maxlen = sizeof(int),
>>> .mode = 0644,
>>> .proc_handler = sched_rt_handler,
>>> + .extra1 = SYSCTL_NEG_ONE,
>>> + .extra2 = (void *)&sysctl_sched_rt_period,
>>
>> Per this, you could also remove the
>>
>> ((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
>>
>> from sched_rt_global_validate(), no?
>>
>
> No, the extra2 just limit the maximum value of sysctl_sched_rt_runtime is sysctl_sched_rt_period, but not limit the minimum value of sysctl_sched_rt_period is sysctl_sched_rt_runtime. (sysctl_sched_rt_runtime > sysctl_sched_rt_period) can do both.

Gotcha.

> Its purpose is to return error earlier. Perhaps I should remove extra2 to avoid ambiguity.
>

It's probably better to only have the "pure" bounds in there yes.

