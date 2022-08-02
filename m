Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F885879F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiHBJiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiHBJiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9DF930F55
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659433093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SR3OgXv0SWMYMM8P/TFLmgsz2VZ9k//RlVH2mPzgJ3c=;
        b=acAvV0J6Um2cK4CM2SwACruAoN5MExUdR2WtIYrMjPkZeBe7xhyM8Sw86dwQJbu9ThouBB
        9nDtfdiUBbsjgBUuP3b3XVGl1UwQYyy5Y1dk8SkEKJANgYsGgXiYU9UgxefgZNTqfHesuk
        U01ibrdZ9UFrMHEc8SmgB/awHZvmxkk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-m0Iv7aYfMBuYu_3h_S2j4w-1; Tue, 02 Aug 2022 05:38:11 -0400
X-MC-Unique: m0Iv7aYfMBuYu_3h_S2j4w-1
Received: by mail-wr1-f69.google.com with SMTP id t12-20020adfba4c000000b0021e7440666bso3333898wrg.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 02:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SR3OgXv0SWMYMM8P/TFLmgsz2VZ9k//RlVH2mPzgJ3c=;
        b=qgXmeIEv3jKK07yNnCkU9SjFDx0YqpAA1y4DjtITRkYZ0wUz+inPEjEtDyjUFg1Z3U
         ch9o93haxkGXFYm9HvnTfbA72SJ/UQTw3WeK+9RD73KheoHRdFwA3lKAT3J0WH+ia8LU
         ijLwv+HSp6u/QekffYgnfSH8qV9l4Up1lHRfbCFDIOke/SuPHyDnT3nfCL0BgBeCbBL/
         pibVTG2MgeMWzk0409mwIHgLB3hqsmV9bQdXulpZr2p+Bztvwef2Q/z4plTOLBlFe6NQ
         PdGieTFqlWGmbfBSwKmkw++VTII50OslhRPtrTgRqQLVUzNtiM8h06951tVJ7N07MzXn
         9bKQ==
X-Gm-Message-State: ACgBeo3nzFFfeC2ql08VvDDDicsN7gXtEIC8YCdzEAMLDOgREseaFNej
        UdwjCA2phV/z+jr881i5LuDS6HLuYa2ZDEhKMWHto9a+YTtXYffwUKcLR0f61CZPxsAjdKWzzgm
        JnoX80Epf1VHxNzrJnMMs9tM0
X-Received: by 2002:a5d:688c:0:b0:21f:160d:8859 with SMTP id h12-20020a5d688c000000b0021f160d8859mr11197295wru.711.1659433090731;
        Tue, 02 Aug 2022 02:38:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7QvrzYHDIVdY2kldi5Z2ZLSFcbNVD5KQ4xGD3XDy95tXVmMZVaEQX5WnRvFqmY9FJgBMUgBw==
X-Received: by 2002:a5d:688c:0:b0:21f:160d:8859 with SMTP id h12-20020a5d688c000000b0021f160d8859mr11197274wru.711.1659433090539;
        Tue, 02 Aug 2022 02:38:10 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6405000000b0021f138e07acsm12028845wru.35.2022.08.02.02.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 02:38:10 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tariq Toukan <ttoukan.linux@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>, linux-kernel@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next V4 1/3] sched/topology: Add NUMA-based CPUs
 spread API
In-Reply-To: <9401f754-d4d6-9fbd-7354-3103ececddda@gmail.com>
References: <20220728191203.4055-1-tariqt@nvidia.com>
 <20220728191203.4055-2-tariqt@nvidia.com>
 <7f1ab968-cc10-f0a7-cac8-63dd60021493@gmail.com>
 <9401f754-d4d6-9fbd-7354-3103ececddda@gmail.com>
Date:   Tue, 02 Aug 2022 10:38:08 +0100
Message-ID: <xhsmhpmhjc7en.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/22 09:40, Tariq Toukan wrote:
> On 7/30/2022 8:29 PM, Tariq Toukan wrote:
>>
>>
>> On 7/28/2022 10:12 PM, Tariq Toukan wrote:
>>> Implement and expose API that sets the spread of CPUs based on distance,
>>> given a NUMA node.=C2=A0 Fallback to legacy logic that uses
>>> cpumask_local_spread.
>>>
>>> This logic can be used by device drivers to prefer some remote cpus over
>>> others.
>>>
>>> Reviewed-by: Gal Pressman <gal@nvidia.com>
>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>> ---
>>> =C2=A0 include/linux/sched/topology.h |=C2=A0 5 ++++
>>> =C2=A0 kernel/sched/topology.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 49 ++++++++++++++++++++++++++++++++++
>>> =C2=A0 2 files changed, 54 insertions(+)
>>>
>>
>> ++
>>
>> Dear SCHEDULER maintainers,
>>
>> V3 of my series was submitted ~12 days ago and had significant changes.
>> I'd appreciate your review to this patch, so we could make it to the
>> upcoming kernel.
>>
>> Regards,
>> Tariq
>
> Hi,
> Another reminder.
> Do you have any comments on this patch?
> If not, please provide your Ack.

It's not even been a week since you submitted v4 (and ~3 days since you
last pinged this thread), and not all of us are limitless reviewing
machines :-)

This is already in my todo-list, but isn't the topmost item yet.

