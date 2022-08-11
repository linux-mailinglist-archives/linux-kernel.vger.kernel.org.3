Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DCD58FE3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiHKO1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiHKO1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D0DF6F54E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660228024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k6yotpOqfyuu01Y33PcNlzcmcE9s0sp8bN10/xbieqY=;
        b=ibP3N5ZUozjLSCQHDE6XIp0BorAsisqoeZCN9Gv/CiiT2fEGlfw31lh8eTJzicfHCJYm+l
        n5PCTlzB+GXcr+nuXH5mmJAxP2frZ+JkXnOsO3d+EHH2D0VptrWo9xGidSDiVa9m3pgIvO
        92JtavXFCOkrWTLu0z1Po6M5Us/u5lo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-bC6t3UrsPeGg_Vcos-UtVg-1; Thu, 11 Aug 2022 10:27:03 -0400
X-MC-Unique: bC6t3UrsPeGg_Vcos-UtVg-1
Received: by mail-wm1-f71.google.com with SMTP id i132-20020a1c3b8a000000b003a537064611so1482215wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=k6yotpOqfyuu01Y33PcNlzcmcE9s0sp8bN10/xbieqY=;
        b=WVMSMr1EjGTA0crP2mecnZbeqVv0+HYM2UmjHSIqg8/9M0+9/q5eWiSpBpJwCLuOpW
         q/POvxM2PYLa+vPj+iMVy8JAlr+MygK9y7NORjJuTNuyZaiwMFJUBzEH0Sqmn+di2hAl
         mHpRssVrT9pqKkrDMxFWsNqru013MddDAU1VhO6IH4ru19xKaJxAdccDZ2rlLC0L3zJ2
         wDlr1q8RYuwDIptCxNpLRkFEfaDX7a3af/KKDplRlG6bnS7Vi0bb0rJcG/cj4giLRJzS
         TbUzON9JU0pZp1bL6WnQI4lN/cKiFsfdnQXPtGEW0C+O9Ifolg9CZ9pUwy8tIo+gr7I+
         EHzg==
X-Gm-Message-State: ACgBeo356TCp+nvIvgeKSPK4x4J3grze18lYJDvoIjz8amtebOGvWAGg
        VyPMbiOZHPcl8+cbxDPHBA5oV/4WHdabq7u4D+IHIMqny29mo361X1N9XBfFAJxlVUOCk8SsBkj
        SfVMSZxv/Hl38g36noHOi4z2p
X-Received: by 2002:a1c:e916:0:b0:3a4:f29b:2eb8 with SMTP id q22-20020a1ce916000000b003a4f29b2eb8mr5719315wmc.173.1660228021524;
        Thu, 11 Aug 2022 07:27:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4v+pPAj+QwRObk/U/WEytQ65DQ99nq3GNGtgRavaTlIR1er8+g16rNkpqpzCptJ5xffBkFwQ==
X-Received: by 2002:a1c:e916:0:b0:3a4:f29b:2eb8 with SMTP id q22-20020a1ce916000000b003a4f29b2eb8mr5719297wmc.173.1660228021336;
        Thu, 11 Aug 2022 07:27:01 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id t24-20020a1c7718000000b003a501ad8648sm5962505wmi.40.2022.08.11.07.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 07:27:00 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc:     Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/2] net/mlx5e: Leverage sched_numa_hop_mask()
In-Reply-To: <8448dade-a64a-0b6b-1ed0-dd164917eedf@gmail.com>
References: <xhsmhtu6kbckc.mognet@vschneid.remote.csb>
 <20220810105119.2684079-1-vschneid@redhat.com>
 <20220810105119.2684079-2-vschneid@redhat.com>
 <8448dade-a64a-0b6b-1ed0-dd164917eedf@gmail.com>
Date:   Thu, 11 Aug 2022 15:26:59 +0100
Message-ID: <xhsmhleruc0uk.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/22 15:57, Tariq Toukan wrote:
> On 8/10/2022 1:51 PM, Valentin Schneider wrote:
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/eq.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>
> Missing description.
>
> I had a very detailed description with performance numbers and an
> affinity hints example with before/after tables. I don't want to get
> them lost.
>

Me neither! This here is just a stand-in to show how the interface would be
used, I'd much rather have someone who actually knows the code and can
easily test it do it :)

>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> index 229728c80233..2eb4ffd96a95 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> @@ -809,9 +809,12 @@ static void comp_irqs_release(struct mlx5_core_dev *dev)
>>   static int comp_irqs_request(struct mlx5_core_dev *dev)
>>   {
>>      struct mlx5_eq_table *table = dev->priv.eq_table;
>> +	const struct cpumask *mask;
>>      int ncomp_eqs = table->num_comp_eqs;
>> +	int hops = 0;
>>      u16 *cpus;
>>      int ret;
>> +	int cpu;
>>      int i;
>>
>>      ncomp_eqs = table->num_comp_eqs;
>> @@ -830,8 +833,17 @@ static int comp_irqs_request(struct mlx5_core_dev *dev)
>>              ret = -ENOMEM;
>>              goto free_irqs;
>>      }
>> -	for (i = 0; i < ncomp_eqs; i++)
>> -		cpus[i] = cpumask_local_spread(i, dev->priv.numa_node);
>> +
>> +	rcu_read_lock();
>> +	for_each_numa_hop_mask(dev->priv.numa_node, hops, mask) {
>
> We don't really use this 'hops' iterator. We always pass 0 (not a
> valuable input...), and we do not care about its final value. Probably
> it's best to hide it from the user into the macro.
>

That's a very valid point. After a lot of mulling around, I've found some
way to hide it away in a macro, but it's not pretty :-) cf. other email.

