Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B614FB5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiDKIYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241982AbiDKIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D04893E5D2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649665344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rjDOzT6HPUJp5MrWv3mn082xYi7VB03GumbwdLSUDiY=;
        b=JArr9EMJA2Hu4SV84D2bIysnz30Nf8deyRVQ0sfazQ7gWfHFBZFxLWgBUtwYNa8x5yGqw0
        BCR/CyL59G4sXfl1iorzvolCbB+fnCFt9noKgPKjY1rcxj4ziL0+rCJ1gah8TKQsA9rgo0
        IMqexrHGKQUazO7UXsX90ZukWgQZtsE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-2_LMzZ_tNVCHRB5vHxrCKg-1; Mon, 11 Apr 2022 04:22:23 -0400
X-MC-Unique: 2_LMzZ_tNVCHRB5vHxrCKg-1
Received: by mail-wr1-f72.google.com with SMTP id p18-20020adfc392000000b00207a2102f9bso659395wrf.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rjDOzT6HPUJp5MrWv3mn082xYi7VB03GumbwdLSUDiY=;
        b=xqIv4ojEqevasWfJLdCBWao5ahPFNWQJ+5E1YtJwLknAn1uCmxbm+mO2w1HMwtqqXK
         +EJXKnDdbjNcybCTaeWwlYg3wgEUdTddP88yiAFqL6qox5SHncozT1FkRj06KRK3Cc1w
         aCDnndHQHI7uSV1Fic8FECBPNcUV09HQQ73TvwlU5ZLWy5QexJLjKmrQs+6ge0gxArV5
         oO2/v4Qo3+Cb7Zj/i15+UOpWz7WgTLQfaVEQH3GfYWaE0gTKB/J6kU0sgO1sLJzOZYqZ
         q4cgOAFUm0HHV5yMsPXkoEI/kNK62KCaIeuYV0oUIZ/OtedueVhRk5YGxoK+v+ddn/Nm
         5U/w==
X-Gm-Message-State: AOAM53366OtouR76js5L3+48FQTqfglf8vmRV2sH3quLtoCLSh5hxACt
        YZ1xWDK8QFtIAKtrR3yiKSc2KUrUeUCJNfbSAhqzGt//yxxkGDqUMzHPC3Bs/nYKAord6a1fdzm
        tFfh/b/XDNARJsCl6oHVg0CaR
X-Received: by 2002:a05:600c:2307:b0:38e:bf05:677c with SMTP id 7-20020a05600c230700b0038ebf05677cmr1352211wmo.44.1649665342202;
        Mon, 11 Apr 2022 01:22:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeTH47fbeD6O9S90q36RFwclZsZAPgbUQasz4gS4rkOL91f96QZzKd5f92pdo3f5dGNNGqxA==
X-Received: by 2002:a05:600c:2307:b0:38e:bf05:677c with SMTP id 7-20020a05600c230700b0038ebf05677cmr1352192wmo.44.1649665341816;
        Mon, 11 Apr 2022 01:22:21 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm30586891wrz.29.2022.04.11.01.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:22:21 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] sched,topology: Update sched topology atomically
In-Reply-To: <xhsmhczhrwm9z.mognet@vschneid.remote.csb>
References: <20220406070159.68111-1-ying.huang@intel.com>
 <xhsmhczhrwm9z.mognet@vschneid.remote.csb>
Date:   Mon, 11 Apr 2022 09:22:13 +0100
Message-ID: <xhsmh7d7wni6i.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/22 17:52, Valentin Schneider wrote:
>> +	topology = rcu_dereference(sched_numa_topology);
>> +	for (i = 0; i < topology->nr_levels; i++) {
>> +		if (!topology->masks[i][j])
>
> If I got default_numa_topology right and it's meant to be static,
> sched_numa_topology->masks can still be NULL, but here this would be gated
> by nr_levels being 0... Did I get that right?
>

Being a file-global variable, that's already init'd-as-0, (I'll use
my longish break as an excuse for forgetting that one), but the rest still
applies.

>>                       break;
>> -		cpu = cpumask_any_and(cpus, masks[i][j]);
>> +		cpu = cpumask_any_and(cpus, topology->masks[i][j]);
>>               if (cpu < nr_cpu_ids) {
>>                       found = cpu;
>>                       break;
>>               }
>>       }
>> -unlock:
>>       rcu_read_unlock();
>>
>>       return found;
>> --
>> 2.30.2

