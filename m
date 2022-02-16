Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E434B4B8B62
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiBPOZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:25:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiBPOZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:25:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D097E28881F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:24:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C672212BA;
        Wed, 16 Feb 2022 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645021496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F46OJsdVIEUtxQDqrpSNoJdWyOoNFJrCo/HpT1Gj+W4=;
        b=JGyr15YGjeOAQxNurzfQKthEGo4+jC4YN+JLzmPDNqru5ZZta84NblLDRxhhMbIvs1Id8M
        C/eWGd3bd5Ljzd+ldba/sm6Ee77DCznq4d1indgxKyA4grA8dOl5u3VZrQTmAmzx8i/5s3
        DcSI8LVZz2kxChWH4S7ngy2PEBROJhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645021496;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F46OJsdVIEUtxQDqrpSNoJdWyOoNFJrCo/HpT1Gj+W4=;
        b=8lcIQLUSeKIaRPVR3VNhYPgmAL5sTPOYN6Cbb66YqMQGdEOgUIKLHT64H414eRIJQNLSvu
        BO4cbyaslipCUvBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53B6313B24;
        Wed, 16 Feb 2022 14:24:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ufU3EzgJDWJxEAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 16 Feb 2022 14:24:56 +0000
Message-ID: <fdc14384-e3b7-921c-cc52-5992f3cbfd2c@suse.cz>
Date:   Wed, 16 Feb 2022 15:24:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 4/5] mm/page_alloc: Free pages in a single pass during
 bulk free
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220215145111.27082-1-mgorman@techsingularity.net>
 <20220215145111.27082-5-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220215145111.27082-5-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 15:51, Mel Gorman wrote:
> free_pcppages_bulk() has taken two passes through the pcp lists since
> commit 0a5f4e5b4562 ("mm/free_pcppages_bulk: do not hold lock when picking
> pages to free") due to deferring the cost of selecting PCP lists until
> the zone lock is held. Now that list selection is simplier, the main
> cost during selection is bulkfree_pcp_prepare() which in the normal case
> is a simple check and prefetching. As the list manipulations have cost
> in itself, go back to freeing pages in a single pass.
> 
> The series up to this point was evaulated using a trunc microbenchmark
> that is truncating sparse files stored in page cache (mmtests config
> config-io-trunc). Sparse files were used to limit filesystem interaction.
> 
> The results versus a revert of storing high-order pages in the PCP lists is
> 
> 1-socket Skylake
>                               5.17.0-rc3             5.17.0-rc3             5.17.0-rc3
>                                  vanilla    mm-reverthighpcp-v1r1     mm-highpcpopt-v1
> Min       elapsed      540.00 (   0.00%)      530.00 (   1.85%)      530.00 (   1.85%)
> Amean     elapsed      543.00 (   0.00%)      530.00 *   2.39%*      530.00 *   2.39%*
> Stddev    elapsed        4.83 (   0.00%)        0.00 ( 100.00%)        0.00 ( 100.00%)
> CoeffVar  elapsed        0.89 (   0.00%)        0.00 ( 100.00%)        0.00 ( 100.00%)
> Max       elapsed      550.00 (   0.00%)      530.00 (   3.64%)      530.00 (   3.64%)
> BAmean-50 elapsed      540.00 (   0.00%)      530.00 (   1.85%)      530.00 (   1.85%)
> BAmean-95 elapsed      542.22 (   0.00%)      530.00 (   2.25%)      530.00 (   2.25%)
> BAmean-99 elapsed      542.22 (   0.00%)      530.00 (   2.25%)      530.00 (   2.25%)
> 
> 2-socket CascadeLake
>                               5.17.0-rc3             5.17.0-rc3             5.17.0-rc3
>                                  vanilla    mm-reverthighpcp-v1       mm-highpcpopt-v1
> Min       elapsed      510.00 (   0.00%)      500.00 (   1.96%)      500.00 (   1.96%)
> Amean     elapsed      529.00 (   0.00%)      521.00 (   1.51%)      516.00 *   2.46%*
> Stddev    elapsed       16.63 (   0.00%)       12.87 (  22.64%)        9.66 (  41.92%)
> CoeffVar  elapsed        3.14 (   0.00%)        2.47 (  21.46%)        1.87 (  40.45%)
> Max       elapsed      550.00 (   0.00%)      540.00 (   1.82%)      530.00 (   3.64%)
> BAmean-50 elapsed      516.00 (   0.00%)      512.00 (   0.78%)      510.00 (   1.16%)
> BAmean-95 elapsed      526.67 (   0.00%)      518.89 (   1.48%)      514.44 (   2.32%)
> BAmean-99 elapsed      526.67 (   0.00%)      518.89 (   1.48%)      514.44 (   2.32%)
> 
> The original motivation for multi-passes was will-it-scale page_fault1
> using $nr_cpu processes.
> 
> 2-socket CascadeLake (40 cores, 80 CPUs HT enabled)
>                                                     5.17.0-rc3                 5.17.0-rc3
>                                                        vanilla         mm-highpcpopt-v1r4
> Hmean     page_fault1-processes-2        2694662.26 (   0.00%)      2696801.07 (   0.08%)
> Hmean     page_fault1-processes-5        6425819.34 (   0.00%)      6426573.21 (   0.01%)
> Hmean     page_fault1-processes-8        9642169.10 (   0.00%)      9647444.94 (   0.05%)
> Hmean     page_fault1-processes-12      12167502.10 (   0.00%)     12073323.10 *  -0.77%*
> Hmean     page_fault1-processes-21      15636859.03 (   0.00%)     15587449.50 *  -0.32%*
> Hmean     page_fault1-processes-30      25157348.61 (   0.00%)     25111707.15 *  -0.18%*
> Hmean     page_fault1-processes-48      27694013.85 (   0.00%)     27728568.63 (   0.12%)
> Hmean     page_fault1-processes-79      25928742.64 (   0.00%)     25920933.41 (  -0.03%) <---
> Hmean     page_fault1-processes-110     25730869.75 (   0.00%)     25695727.57 *  -0.14%*
> Hmean     page_fault1-processes-141     25626992.42 (   0.00%)     25675346.68 *   0.19%*
> Hmean     page_fault1-processes-172     25611651.35 (   0.00%)     25650940.14 *   0.15%*
> Hmean     page_fault1-processes-203     25577298.75 (   0.00%)     25584848.65 (   0.03%)
> Hmean     page_fault1-processes-234     25580686.07 (   0.00%)     25601794.52 *   0.08%*
> Hmean     page_fault1-processes-265     25570215.47 (   0.00%)     25553191.25 (  -0.07%)
> Hmean     page_fault1-processes-296     25549488.62 (   0.00%)     25530311.58 (  -0.08%)
> Hmean     page_fault1-processes-320     25555149.05 (   0.00%)     25585059.83 (   0.12%)
> 
> The differences are mostly within the noise and the difference close to
> $nr_cpus is negligible.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>


Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
