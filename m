Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0150E4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbiDYPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243039AbiDYPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C9FA3A5D5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650901958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PgM2qLhKg/3g0W0oCL8uf4x0vy/kiKECpAJOInvAhdA=;
        b=YY8OLUvMc05gLkk6cj1FhUBkKiy4YBEmR31SMvjTMvQKnjKqK9wTvPTmS+tYbzzS9ARuGi
        peSK5vhmr+2/YeQepgJLc9ybfn40SUNdkryKmMFn81KmJaYxOBc7APDy6OUXOKCX63IYXe
        YVgzsA+vyN5MUaAnlmmlg9fZvS0jITs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-hho1pBBFOQKlwzBFil1bRA-1; Mon, 25 Apr 2022 11:52:37 -0400
X-MC-Unique: hho1pBBFOQKlwzBFil1bRA-1
Received: by mail-wr1-f70.google.com with SMTP id j21-20020adfa555000000b0020adb9ac14fso965206wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PgM2qLhKg/3g0W0oCL8uf4x0vy/kiKECpAJOInvAhdA=;
        b=e3M7Gc1ATdAB0v4UDinl13nTxKwzPw+d9robGlHj9tIlFNVJ50sFOuayA6ANNdKMJm
         Mdpc8BhxQsOBv+xQmkyVGap1+pc6rV7pDZdonTz610PgHzGQOR6/9sQrl940TZcr4LCL
         KjH+WQ+JMNHwCg8fzlyc9gayKFpbSlnrui7umBL1IgsGCr8c9rdPzPehjkSMHUzVqCTF
         mxpHNRcYEUiLqYACx/Dobd7/GorDcCW3AuajYSC+uPdbWDtVqEBfm1D2KTwSbmUPbHih
         qLyE8PfTaFaZ5Twi9jkMxuAc1O7I0NY63nRlYWu+8rXk1QzxVBjBbig0jq9ctaqOrtEr
         dIMQ==
X-Gm-Message-State: AOAM531NoUNoVk0gCtRxJL3M9Qr++LGDcUhCXrX1BDkh/yTkVMH0IQl4
        K/BsHzZQx8DFbiAhQTgwpMwVNAlBLcHlmYMq1CPhVsDQ5o9WrkUWq94XBQ2T+xeQUAUEOLAC4Fp
        vlfanqOpNxZFSx7Bfy8s663em
X-Received: by 2002:a05:600c:3d88:b0:391:7aa1:792b with SMTP id bi8-20020a05600c3d8800b003917aa1792bmr26724762wmb.8.1650901955377;
        Mon, 25 Apr 2022 08:52:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXdS6DKZ39EGCFmJ23OR4S+8zKDnitjM6K6I4cX/sVeJrTdSCHoRxjgN/pW6sercbfDqR91A==
X-Received: by 2002:a05:600c:3d88:b0:391:7aa1:792b with SMTP id bi8-20020a05600c3d8800b003917aa1792bmr26724743wmb.8.1650901955144;
        Mon, 25 Apr 2022 08:52:35 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm9119916wmq.46.2022.04.25.08.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:52:34 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2] sched,topology: Update sched topology atomically
In-Reply-To: <20220421003125.195470-1-ying.huang@intel.com>
References: <20220421003125.195470-1-ying.huang@intel.com>
Date:   Mon, 25 Apr 2022 16:52:33 +0100
Message-ID: <xhsmh7d7d9n3y.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/22 08:31, Huang Ying wrote:
> When Peter Zijlstra reviewed commit 0fb3978b0aac ("sched/numa: Fix
> NUMA topology for systems with CPU-less nodes") [1], he pointed out
> that sched_domains_numa_distance and sched_domains_numa_masks are made
> separate RCU variables.  That could go side-ways if there were a
> function using both, although there isn't for now.
>
> So we update sched_domains_numa_distance and sched_domains_numa_masks
> and some other related sched topology parameters atomically to address
> the potential issues.
>
> [1] https://lkml.kernel.org/r/20220214121553.582248-1-ying.huang@intel.com
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>
> Changelog:
>
> v2:
>
> - Addressed comments from Valentin Schneider, Thanks!

One small bug and a whitespace nit below, with those fixed:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

FWIW I briefly tested this vs hotplug on QEMU.

> @@ -1806,8 +1873,7 @@ void sched_init_numa(int offline_node)
>
>                       if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
>                               sched_numa_warn("Invalid distance value range");
> -				bitmap_free(distance_map);
> -				return;
> +                                goto free_bitmap;

The indentation here is wrong (spaces vs tabs).

>                       }
>
>                       bitmap_set(distance_map, distance, 1);

>       /* Compute default topology size */
>       for (i = 0; sched_domain_topology[i].mask; i++);

After the original boot this will now be the default topology with the NUMA
bits on top, so we'll just keep growing the array every time we hotplug a
node. This should use sched_domain_topology_default instead (ditto for the
copy loop further down).

