Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B694F4B3822
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 22:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiBLVBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 16:01:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiBLVBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 16:01:33 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12578606F4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 13:01:29 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id i62so15626413ioa.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 13:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pMbNysZicDjla5m+LqKnIivTQyASvMT8jxUwCbQWv1g=;
        b=riVGorTeXgSv6f6PSqT26L43SORlysK2m4uRC/QszDsHk26fohbl3AcXeAU1z5WReD
         NiLXebj+jUjwxHFaizCF5lM+/IPGT9AeDHCQP7Ki4Nq39KGTQ668UcwNvKBImkPaoHXk
         KmbjeDZw7fppxgwkgRuh9xN/64WYlgfkC6a5u1qi/mrP2cuMCkW/R7DJwRORH6OWAt7P
         ethnE+skfclWxvZ36JWfsq6I+25qukq2eaM6QuAD0d/SybO6tkaG8PsRMLAk7yUPMg6G
         WyCg8Q53Rqg73T6F0bVKystdOEWJIJIs3XjVCZVbtZJJIgeFp3D7X2O9KlWWJvlNgBvj
         KumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pMbNysZicDjla5m+LqKnIivTQyASvMT8jxUwCbQWv1g=;
        b=tL70dJtQA5fD7aqT775s2xDc3aAGY3EoC91Z8sVV6hau3yk772hLxZHPeGdZztM20q
         73OVLb3cMpe2j/aBIfNaLidAnB/JSOoQcozVMRtPnIpwbDjVALi0oKRm/+a3XdlyCf0U
         bjbH7ZehGrdOSqVA9RhYKNzP9JwNMHaEHOj6wlD8iCG+7RNDZ9syYXkBDFtDlJyqSEd3
         pSsm6B9pKFQl6BtgsG+t/xOywvEzpfTJdSfw4K7LsQacMlgMnR2WdmQjnNWbrNDtofCa
         2kS5cCsmdMvLKA8/JrZ7dAx90ZN52YKG6mO3kWtg4qwnOBeVvRWo8QxPQUr/jNs2D5Td
         +afA==
X-Gm-Message-State: AOAM530yKktlsPBhs/2d7cAFQyOA7BtoPGpMxSvLVuVfS2NL56sI4539
        YsyHNQj7JXrH1JL1QjESr5WtBA==
X-Google-Smtp-Source: ABdhPJzPD41+d7IoHgG5Q9TFesNC7mfL4rvQpeFd/BtV8ZyYVWurBH52if7QSOBzPeihv02iT4Y7qQ==
X-Received: by 2002:a05:6638:22c6:: with SMTP id j6mr3979977jat.216.1644699688189;
        Sat, 12 Feb 2022 13:01:28 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7f5c:29f4:d1c2:e1f6])
        by smtp.gmail.com with ESMTPSA id v8sm1703481iox.53.2022.02.12.13.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 13:01:27 -0800 (PST)
Date:   Sat, 12 Feb 2022 14:01:23 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Alexey Avramov <hakavlad0@seznam.cz>
Cc:     21cnbao@gmail.com, Michael@michaellarabel.com, ak@linux.intel.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        axboe@kernel.dk, catalin.marinas@arm.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, hannes@cmpxchg.org, hdanton@sina.com,
        jsbarnes@google.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, mhocko@kernel.org,
        page-reclaim@google.com, riel@surriel.com, rppt@kernel.org,
        torvalds@linux-foundation.org, vbabka@suse.cz, will@kernel.org,
        willy@infradead.org, x86@kernel.org, ying.huang@intel.com
Subject: Re: [PATCH v7 00/12] Multigenerational LRU Framework
Message-ID: <YgggI+vvtNvh3jBY@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220212051219.183d1baf@PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212051219.183d1baf@PC>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 05:12:19AM +0900, Alexey Avramov wrote:
> Aggressive swapping even with vm.swappiness=1 with MGLRU
> ========================================================
> 
> Reading a large mmapped file leads to a super agressive swapping.
> Reducing vm.swappiness even to 1 does not have effect.

Mind explaining why you think it's "super agressive"? I assume you
expected a different behavior that would perform better. If so,
please spell it out.

> Demo: https://www.youtube.com/watch?v=J81kwJeuW58
> 
> Linux 5.17-rc3, Multigenerational LRU v7, 
> vm.swappiness=1, MemTotal: 11.5 GiB.
> 
> $ cache-bench -r 35000 -m1 -b1 -p1 -f test20000
> Reading mmapped file (file size: 20000 MiB)
> cache-bench v0.2.0: https://github.com/hakavlad/cache-bench

Writing your own benchmark is a good exercise but fio is the standard
benchmark in this case. Please use it with --ioengine=mmap.

> Swapping started with MemAvailable=71%.
> At the end 33 GiB was swapped out when MemAvailable=60%.
> 
> Is it OK?

MemAvailable is an estimate (free + page cache), and it doesn't imply
any reclaim preferences. In the worst case scenario, e.g., out of swap
space, MemAvailable *may* be reclaimed.

Here is my benchmark result with file mmap + *high* swap usage. Ram
disk was used to reduce the variance in the result (and SSD wear out
if you care). More details on additional configurations here:
https://lore.kernel.org/linux-mm/20220208081902.3550911-6-yuzhao@google.com/

  Mixed workloads:
    fio (buffered I/O): +13%
                IOPS         BW
      5.17-rc3: 275k         1075MiB/s
            v7: 313k         1222MiB/s

    memcached (anon): +12%
                Ops/sec      KB/sec
      5.17-rc3: 511282.72    19861.04
            v7: 572408.80    22235.49

  cat mmap.sh
  systemctl restart memcached
  swapoff -a
  umount /mnt
  rmmod brd
  
  modprobe brd rd_nr=2 rd_size=56623104
  
  mkswap /dev/ram0
  swapon /dev/ram0
  
  mkfs.ext4 /dev/ram1
  mount -t ext4 /dev/ram1 /mnt
  
  memtier_benchmark -S /var/run/memcached/memcached.sock \
  -P memcache_binary -n allkeys --key-minimum=1 \
  --key-maximum=50000000 --key-pattern=P:P -c 1 \
  -t 36 --ratio 1:0 --pipeline 8 -d 2000
  
  sysctl vm.overcommit_memory=1
  
  fio -name=mglru --numjobs=36 --directory=/mnt --size=1408m \
  --buffered=1 --ioengine=mmap --iodepth=128 --iodepth_batch_submit=32 \
  --iodepth_batch_complete=32 --rw=randread --random_distribution=random \
  --norandommap --time_based --ramp_time=10m --runtime=990m \
  --group_reporting &
  pid=$!
  
  sleep 200
  
  memcached.sock -P memcache_binary -n allkeys --key-minimum=1 \
  --key-maximum=50000000 --key-pattern=R:R -c 1 -t 36 --ratio 0:1 \
  --pipeline 8 --randomize --distinct-client-seed
  
  kill -INT $pid
  wait
