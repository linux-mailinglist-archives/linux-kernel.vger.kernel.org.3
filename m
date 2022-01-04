Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D976E48492F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiADUXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiADUXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:23:05 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD1CC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:23:05 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id h20-20020ac85e14000000b002b2e9555bb1so29122589qtx.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 12:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K4J7Yr0q+JQeQzl29BR8JFO+xMbXu/b7E/RxxERPELU=;
        b=N3/ySZumcxnw7rpBpXCsdIzt3o8HaeNRURMM4QR/Lpt1YZ1j8Wd9xgyMT8IAeG2LVw
         OGA0VSWgZbZPCvTVFZp0PC12tkQMu7SLEEuRNTGrlElbQDDIsYAf4+3cfXUuZkhD1GEG
         fG+/xLWrHmnr/9OMY5M7OntExZEs0+yzYttMFWp3TDEN1cegZMctdfDVcsvRyExKTEks
         +kK31R+DVih4bgpzV9Vud9MhFfj+pLPTjX4YQt9IpfGrgaSZhkHU9GaGteGIAtY6QTeY
         ouHWbu8iyl09npkMCGo4WhkLqvYn28XUQz6gHctE1koUaH3nrshr26SDenoaX0JFXq8t
         qc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K4J7Yr0q+JQeQzl29BR8JFO+xMbXu/b7E/RxxERPELU=;
        b=EBjYxr5L37JpploUX+Lv/afe+456+9UVe444tt34B8N+1mxAvDKjmcWzDAnsuVMxBn
         i5RboKGY7kaMlX7reITvirXeFm9SS8mKEyDo1SGa2efISRiePFqB4K/tv1sSB53aOW3R
         9mEFJ65ffuM6EotEGWkU7DE4a2zRtxv5VKLrl81M64p55NnrU7p9TjOwLyEvsKm/JItA
         x4V2OLfPf3JZB5cetOTNHJ4NcG59fCCV7LKbpKpOPM1lNe8nfHpK0VtVX6XyN7an958A
         f/adQj27MiYM3jrEmNbjuBle3ElyAkg47OHCEtaN3fG+DTqL+BDzMxkIgq0zpgJbyxi0
         4DzA==
X-Gm-Message-State: AOAM53231VT+60883cup4UWUzu0WOTpa4jVCZiTP9pGXvk+WTLcJwp2m
        /BXDU5cBfffEOlvC1hsbrFvqPlu63VY=
X-Google-Smtp-Source: ABdhPJxCUzW2TwXi9MjmaRV35vVSpBymkYeRr8p+MmjPSvtd4Rcm+muywSulMTI3BTbWBiOm5sCrTo1TXck=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:6c8c:5506:7ca2:9dfd])
 (user=yuzhao job=sendgmr) by 2002:a05:622a:a:: with SMTP id
 x10mr44195569qtw.516.1641327784231; Tue, 04 Jan 2022 12:23:04 -0800 (PST)
Date:   Tue,  4 Jan 2022 13:22:47 -0700
In-Reply-To: <20220104202227.2903605-1-yuzhao@google.com>
Message-Id: <20220104202247.2903702-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[*] BENCHMARK
Name: fio_bench_hdd_mq
Description: FIO benchmark running against HDD multi-queue

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 10
  machine_total_logical_cores  | 72
  machine_total_physical_cores | 36
  machine_total_ram_gib        | 256

[*] METRICS
                              LABEL                             | COUNT |          MIN           |          MAX           |          MEAN          |         MEDIAN         |         STDDEV         |   DIRECTION
----------------------------------------------------------------+-------+------------------------+------------------------+------------------------+------------------------+------------------------+----------------
  hdd_bfq_randread_sync1_8k_bw_read                             |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 433.3917662682603      | 557.8477202301904      | 489.18242841063557     | 490.6666666666667      | 19.097252390047217     |
  (B) 84f99e060a66                                              | 481   | 426.431164231961       | 536.8888888888889      | 487.8554059336687      | 487.1111111111111      | 19.48371520112119      |
                                                                |       | -1.61%                 | -3.76%                 | -0.27%                 | -0.72%                 | +2.02%                 | + is good
  hdd_bfq_randread_sync1_8k_lat_read                            |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 1.4456787946614986e+07 | 1.9117502479907356e+07 | 1.645379955129552e+07  | 1.6380090804665854e+07 | 679101.4140279738      |
  (B) 84f99e060a66                                              | 481   | 1.4906508581318656e+07 | 1.9300071993749753e+07 | 1.6499377634492567e+07 | 1.6433589051097086e+07 | 689703.6846144461      |
                                                                |       | +3.11%                 | +0.95%                 | +0.28%                 | +0.33%                 | +1.56%                 | <not defined>
  hdd_bfq_randread_sync1_8k_onedisk_bw_read                     |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 446.764                | 768                    | 642.4415851769633      | 640                    | 49.16317155463473      |
  (B) 84f99e060a66                                              | 481   | 480                    | 826.9960159362549      | 641.5146399847603      | 640                    | 49.84433236262648      |
                                                                |       | +7.44%                 | +7.68%                 | -0.14%                 | +0.00%                 | +1.39%                 | + is good
  hdd_bfq_randread_sync1_8k_onedisk_lat_read                    |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 1.0446467379999999e+07 | 1.8519737817843866e+07 | 1.2503646313603505e+07 | 1.2448606008064516e+07 | 955886.7640578166      |
  (B) 84f99e060a66                                              | 481   | 9.912718333333334e+06  | 1.5913304476987448e+07 | 1.252581114876277e+07  | 1.2491253064257028e+07 | 911555.2614030009      |
                                                                |       | -5.11%                 | -14.07%                | +0.18%                 | +0.34%                 | -4.64%                 | <not defined>
  hdd_bfq_randread_sync1_8m_onedisk_bw_read                     |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 65405.593625498004     | 131072                 | 102073.76626549932     | 98304                  | 16325.722371561216     |
  (B) 84f99e060a66                                              | 481   | 65405.593625498004     | 131072                 | 101552.34142018206     | 98304                  | 16719.246285256806     |
                                                                |       | +0.00%                 | +0.00%                 | -0.51%                 | +0.00%                 | +2.41%                 | + is good
  hdd_bfq_randread_sync1_8m_onedisk_lat_read                    |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 6.4083031916230366e+07 | 1.0661207040092166e+08 | 8.072525879536723e+07  | 7.972267310126582e+07  | 7.477349032091799e+06  |
  (B) 84f99e060a66                                              | 481   | 6.2635378e+07          | 1.2953105246037737e+08 | 8.129236612411591e+07  | 8.028132555691057e+07  | 8.401679764088364e+06  |
                                                                |       | -2.26%                 | +21.50%                | +0.70%                 | +0.70%                 | +12.36%                | <not defined>
  hdd_bfq_randread_sync1_256k_bw_read                           |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 480   | 12281.12793271359      | 15132.444444444445     | 13802.442575918547     | 13767.111111111111     | 527.1238640248814      |
  (B) 84f99e060a66                                              | 480   | 11031.917662682603     | 15246.222222222223     | 13792.122426958833     | 13816.67994687915      | 562.7906225959111      |
                                                                |       | -10.17%                | +0.75%                 | -0.07%                 | +0.36%                 | +6.77%                 | + is good
  hdd_bfq_randread_sync1_256k_lat_read                          |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 1.7051231348338768e+07 | 2.150583715581118e+07  | 1.8638179679985933e+07 | 1.859534185701346e+07  | 717361.022579436       |
  (B) 84f99e060a66                                              | 481   | 1.6743855827803267e+07 | 2.2890306188082602e+07 | 1.8663653487930812e+07 | 1.8575175956296563e+07 | 792153.6139743543      |
                                                                |       | -1.80%                 | +6.44%                 | +0.14%                 | -0.11%                 | +10.43%                | <not defined>
  hdd_bfq_randread_sync1_prio_256k_antagonized_bw_read          |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 480   | 1251.4555112881806     | 5798.982735723771      | 3195.510963197429      | 3185.777777777778      | 656.6188770523272      |
  (B) 84f99e060a66                                              | 480   | 1535.4466578131917     | 6026.538291279327      | 3072.9427623541496     | 3068.9012837538735     | 649.9058467436236      |
                                                                |       | +22.69%                | +3.92%                 | -3.84%                 | -3.67%                 | -1.02%                 | <not defined>
  hdd_bfq_randread_sync1_prio_256k_antagonized_lat_read         |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 5.182094534557305e+07  | 1.8752826185425484e+08 | 8.760924727551427e+07  | 8.352359803888217e+07  | 1.977023914873974e+07  |
  (B) 84f99e060a66                                              | 481   | 4.868626716238696e+07  | 2.3129365653821653e+08 | 9.622444278248079e+07  | 9.149304520876768e+07  | 2.5072713157997187e+07 |
                                                                |       | -6.05%                 | +23.34%                | +9.83%                 | +9.54%                 | +26.82%                | - is good
  hdd_bfq_read_antagonist_bw_read                               |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 479   | 49141.06748148148      | 92770.28154050466      | 72409.54922214251      | 72788.78264718903      | 7631.977908722226      |
  (B) 84f99e060a66                                              | 477   | 40042.492714937165     | 94590.7180168216       | 69249.11870520914      | 69176.88888888889      | 9833.606205014574      |
                                                                |       | -18.52%                | +1.96%                 | -4.36%                 | -4.96%                 | +28.85%                | <not defined>
  hdd_bfq_read_antagonist_lat_read                              |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 9.835670096201618e+07  | 4.235589828743171e+08  | 1.5040176964768988e+08 | 1.383429005580708e+08  | 4.320986674287423e+07  |
  (B) 84f99e060a66                                              | 481   | 9.417358957137848e+07  | 6.887692560481511e+08  | 1.8459262277609617e+08 | 1.657244056006056e+08  | 7.933471967203863e+07  |
                                                                |       | -4.25%                 | +62.61%                | +22.73%                | +19.79%                | +83.60%                | <not defined>
  hdd_mq_deadline_randread_sync1_8k_bw_read                     |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 480   | 437.3333333333333      | 561.4457724656927      | 495.29163403792217     | 493.95263390880916     | 19.203905318609316     |
  (B) 84f99e060a66                                              | 480   | 433.2952633908809      | 550.3762726870295      | 494.36658941271946     | 494.22222222222223     | 20.681036661081237     |
                                                                |       | -0.92%                 | -1.97%                 | -0.19%                 | +0.05%                 | +7.69%                 | + is good
  hdd_mq_deadline_randread_sync1_8k_lat_read                    |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 1.4287019730821868e+07 | 1.854003493473249e+07  | 1.624403335564022e+07  | 1.6215042711709704e+07 | 660211.3697913568      |
  (B) 84f99e060a66                                              | 481   | 1.457414547219332e+07  | 1.987693170638872e+07  | 1.6277774871744607e+07 | 1.6237274064249396e+07 | 697562.5497383556      |
                                                                |       | +2.01%                 | +7.21%                 | +0.21%                 | +0.14%                 | +5.66%                 | <not defined>
  hdd_mq_deadline_randread_sync1_8k_onedisk_bw_read             |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 509.26693227091636     | 800                    | 645.1839843619289      | 640                    | 48.390152611566336     |
  (B) 84f99e060a66                                              | 481   | 541.394422310757       | 800                    | 642.3397967382033      | 640                    | 46.36162021875187      |
                                                                |       | +6.31%                 | +0.00%                 | -0.44%                 | +0.00%                 | -4.19%                 | + is good
  hdd_mq_deadline_randread_sync1_8k_onedisk_lat_read            |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 9.958389815261044e+06  | 1.5173071762295082e+07 | 1.2445965580579078e+07 | 1.2398376431451613e+07 | 854781.9443522815      |
  (B) 84f99e060a66                                              | 481   | 1.004605020746888e+07  | 1.4730739472118959e+07 | 1.2498833967873506e+07 | 1.2471198e+07          | 835410.5859617554      |
                                                                |       | +0.88%                 | -2.92%                 | +0.42%                 | +0.59%                 | -2.27%                 | <not defined>
  hdd_mq_deadline_randread_sync1_8m_onedisk_bw_read             |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 65404.552              | 131072                 | 101739.09871906973     | 98304                  | 17121.347317133757     |
  (B) 84f99e060a66                                              | 481   | 32768                  | 131072                 | 101071.1305132899      | 98304                  | 17759.554496706638     |
                                                                |       | -49.90%                | +0.00%                 | -0.66%                 | +0.00%                 | +3.73%                 | + is good
  hdd_mq_deadline_randread_sync1_8m_onedisk_lat_read            |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 6.42105164229249e+07   | 1.1846633073443983e+08 | 8.12111689093428e+07   | 7.994055613761468e+07  | 8.305693600908015e+06  |
  (B) 84f99e060a66                                              | 481   | 6.3309874666666664e+07 | 1.8769406183846155e+08 | 8.191909383006239e+07  | 8.013581253846154e+07  | 1.035309668574437e+07  |
                                                                |       | -1.40%                 | +58.44%                | +0.87%                 | +0.24%                 | +24.65%                | <not defined>
  hdd_mq_deadline_randread_sync1_256k_bw_read                   |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 12288                  | 15345.823815847722     | 13955.313638231552     | 13988.24789729969      | 531.5198182748803      |
  (B) 84f99e060a66                                              | 481   | 12726.653386454183     | 15912.910137228862     | 13987.495069078263     | 13989.14386896857      | 502.3380051071074      |
                                                                |       | +3.57%                 | +3.70%                 | +0.23%                 | +0.01%                 | -5.49%                 | + is good
  hdd_mq_deadline_randread_sync1_256k_lat_read                  |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 1.6587447357276253e+07 | 2.1053193505200885e+07 | 1.843522900376671e+07  | 1.8378568200036444e+07 | 712649.1729512813      |
  (B) 84f99e060a66                                              | 481   | 1.6634398856924305e+07 | 2.0707193470965516e+07 | 1.8385433302425563e+07 | 1.83216160420976e+07   | 652160.1536307137      |
                                                                |       | +0.28%                 | -1.64%                 | -0.27%                 | -0.31%                 | -8.49%                 | <not defined>
  hdd_mq_deadline_randread_sync1_prio_256k_antagonized_bw_read  |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 480   | 1251.3554670208057     | 4662.554227534307      | 2590.199788013022      | 2614.277556440903      | 467.11616745046547     |
  (B) 84f99e060a66                                              | 480   | 1024                   | 4206.53652058433       | 2563.1885636551333     | 2503.1111111111113     | 502.574450952279       |
                                                                |       | -18.17%                | -9.78%                 | -1.04%                 | -4.25%                 | +7.59%                 | <not defined>
  hdd_mq_deadline_randread_sync1_prio_256k_antagonized_lat_read |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 7.006917667153478e+07  | 2.0013257296266732e+08 | 1.0504890526408787e+08 | 1.0381339802055775e+08 | 1.6038319039515162e+07 |
  (B) 84f99e060a66                                              | 481   | 6.771219982498592e+07  | 2.700827838838999e+08  | 1.0682645729081483e+08 | 1.0264751235651374e+08 | 2.0996399340127923e+07 |
                                                                |       | -3.36%                 | +34.95%                | +1.69%                 | -1.12%                 | +30.91%                | - is good
  hdd_mq_deadline_read_antagonist_bw_read                       |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 480   | 54598.84373616645      | 101857.998229305       | 78569.87317444892      | 80041.66799468792      | 7010.904844771771      |
  (B) 84f99e060a66                                              | 480   | 47317.0290530051       | 98304                  | 76752.34087065593      | 76458.66666666667      | 9130.285131845274      |
                                                                |       | -13.34%                | -3.49%                 | -2.31%                 | -4.48%                 | +30.23%                | <not defined>
  hdd_mq_deadline_read_antagonist_lat_read                      |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 9.07430549319759e+07   | 2.0507063259337398e+08 | 1.1080574314078984e+08 | 1.0644658997988726e+08 | 1.6111792088606713e+07 |
  (B) 84f99e060a66                                              | 481   | 8.921996962268418e+07  | 2.059040225760676e+08  | 1.1478550705415063e+08 | 1.0669493362907396e+08 | 2.0720287473059524e+07 |
                                                                |       | -1.68%                 | +0.41%                 | +3.59%                 | +0.23%                 | +28.60%                | <not defined>
  hdd_mq_none_randread_sync1_8k_bw_read                         |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 480   | 433.58477202301907     | 547.5555555555555      | 495.651889187694       | 495.44444444444446     | 18.920574696942346     |
  (B) 84f99e060a66                                              | 480   | 408.8888888888889      | 568.5568835768039      | 495.5592125092227      | 495.5502434705622      | 19.850744247491154     |
                                                                |       | -5.70%                 | +3.84%                 | -0.02%                 | +0.02%                 | +4.92%                 | + is good
  hdd_mq_none_randread_sync1_8k_lat_read                        |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 1.4739365473777534e+07 | 1.8363069459155805e+07 | 1.6220706242792107e+07 | 1.6167072555843754e+07 | 624498.9705654499      |
  (B) 84f99e060a66                                              | 481   | 1.4144933475971542e+07 | 1.999434545073922e+07  | 1.6228009886758411e+07 | 1.6184862094213549e+07 | 655002.1366949107      |
                                                                |       | -4.03%                 | +8.88%                 | +0.05%                 | +0.11%                 | +4.88%                 | <not defined>
  hdd_mq_none_randread_sync1_8k_onedisk_bw_read                 |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 480                    | 768                    | 642.5459059230853      | 640                    | 48.349233074838665     |
  (B) 84f99e060a66                                              | 481   | 512                    | 864                    | 643.8444091409829      | 640                    | 48.39906828252791      |
                                                                |       | +6.67%                 | +12.50%                | +0.20%                 | +0.00%                 | +0.10%                 | + is good
  hdd_mq_none_randread_sync1_8k_onedisk_lat_read                |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 1.0255825841463415e+07 | 1.6170251333333334e+07 | 1.2493725390487112e+07 | 1.249267448e+07        | 873499.0003406552      |
  (B) 84f99e060a66                                              | 481   | 9.744641596153846e+06  | 1.55867633187251e+07   | 1.2472582618731404e+07 | 1.239832636437247e+07  | 890636.2226532341      |
                                                                |       | -4.98%                 | -3.61%                 | -0.17%                 | -0.76%                 | +1.96%                 | <not defined>
  hdd_mq_none_randread_sync1_8m_onedisk_bw_read                 |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 65405.593625498004     | 131072                 | 101828.76370165072     | 98304                  | 17081.367956301114     |
  (B) 84f99e060a66                                              | 481   | 65404.552              | 131072                 | 101917.20606140923     | 98304                  | 15646.78555952052      |
                                                                |       | -0.00%                 | +0.00%                 | +0.09%                 | +0.00%                 | -8.40%                 | + is good
  hdd_mq_none_randread_sync1_8m_onedisk_lat_read                |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 6.4492800356862746e+07 | 1.1046080762445414e+08 | 8.107383330775987e+07  | 8.005707593333334e+07  | 7.835925234954876e+06  |
  (B) 84f99e060a66                                              | 481   | 6.516480875897436e+07  | 1.0510505822274882e+08 | 8.078266977005598e+07  | 8.006642728971963e+07  | 7.525479082183226e+06  |
                                                                |       | +1.04%                 | -4.85%                 | -0.36%                 | +0.01%                 | -3.96%                 | <not defined>
  hdd_mq_none_randread_sync1_256k_bw_read                       |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 12395.359008410802     | 15466.46303674192      | 13965.324254696627     | 13986.445329791944     | 540.5537898230401      |
  (B) 84f99e060a66                                              | 480   | 12047.32802124834      | 15465.56706507304      | 14005.528092522502     | 13994.666666666666     | 533.422194380433       |
                                                                |       | -2.81%                 | -0.01%                 | +0.29%                 | +0.06%                 | -1.32%                 | + is good
  hdd_mq_none_randread_sync1_256k_lat_read                      |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 1.6759992100125207e+07 | 2.1025788906987265e+07 | 1.841854575650044e+07  | 1.8403686714389365e+07 | 707193.8393873073      |
  (B) 84f99e060a66                                              | 481   | 1.6703674210050877e+07 | 2.1005133391747385e+07 | 1.8354179024851043e+07 | 1.8299694568854973e+07 | 691484.2208106014      |
                                                                |       | -0.34%                 | -0.10%                 | -0.35%                 | -0.57%                 | -2.22%                 | <not defined>
  hdd_mq_none_randread_sync1_prio_256k_antagonized_bw_read      |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 1193.9154316069057     | 3404.9694555112883     | 2470.783381806479      | 2501.119079238601      | 352.37169323696077     |
  (B) 84f99e060a66                                              | 480   | 1251.5555555555557     | 3413.3333333333335     | 2462.8524977844877     | 2502.347056219566      | 353.6393090865356      |
                                                                |       | +4.83%                 | +0.25%                 | -0.32%                 | +0.05%                 | +0.36%                 | <not defined>
  hdd_mq_none_randread_sync1_prio_256k_antagonized_lat_read     |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 7.92758670781183e+07   | 3.6828972945182586e+08 | 1.2276833274554719e+08 | 1.1244387408005123e+08 | 3.580428866616608e+07  |
  (B) 84f99e060a66                                              | 481   | 8.165940581725675e+07  | 5.55477427650102e+08   | 1.2173782155950747e+08 | 1.1184941037184313e+08 | 3.943540948359279e+07  |
                                                                |       | +3.01%                 | +50.83%                | -0.84%                 | -0.53%                 | +10.14%                | - is good
  hdd_mq_none_read_antagonist_bw_read                           |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 480   | 50943.45728198318      | 98304                  | 77545.46814265505      | 76458.67463479415      | 7768.638181488058      |
  (B) 84f99e060a66                                              | 480   | 54584.33820274458      | 98304                  | 78673.59394682551      | 80041.66799468792      | 7623.4260348939215     |
                                                                |       | +7.15%                 | +0.00%                 | +1.45%                 | +4.69%                 | -1.87%                 | <not defined>
  hdd_mq_none_read_antagonist_lat_read                          |       |                        |                        |                        |                        |                        |
  (A) 4db0b9c9d0f3                                              | 481   | 9.16133477798651e+07   | 3.2367121380585676e+08 | 1.1565995741373444e+08 | 1.0929578126101434e+08 | 2.4595102484695204e+07 |
  (B) 84f99e060a66                                              | 481   | 9.223103197939356e+07  | 2.6360696231197134e+08 | 1.1001900110101567e+08 | 1.0668273801871714e+08 | 1.5779026561421016e+07 |
                                                                |       | +0.67%                 | -18.56%                | -4.88%                 | -2.39%                 | -35.84%                | <not defined>

[*] BENCHMARK
Name: lmbench
Description: lmbench is a suite of simple, portable, ANSI/C
microbenchmarks for UNIX/POSIX. In general, it measures two key
features (latency and bandwidth). lmbench is intended to give system
developers insight into basic costs of key operations.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 43
  machine_total_logical_cores  | 12
  machine_total_physical_cores | 6
  machine_total_ram_gib        | 32

[*] METRICS
                             LABEL                             | COUNT |    MIN    |    MAX    |   MEAN    |  MEDIAN   | STDDEV |   DIRECTION
---------------------------------------------------------------+-------+-----------+-----------+-----------+-----------+--------+----------------
  development_1_BCOPY_50__BCOPY_libc_bandwidth_MB_sec          |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 7805.47   | 7805.47   | 7805.47   | 7805.47   | 0      |
  (B) 84f99e060a66                                             | 1     | 7742.96   | 7742.96   | 7742.96   | 7742.96   | 0      |
                                                               |       | -0.80%    | -0.80%    | -0.80%    | -0.80%    | ---    | + is good
  development_1_BCOPY_50__BCOPY_memory_read_bandwidth_MB_sec   |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 8073.16   | 8073.16   | 8073.16   | 8073.16   | 0      |
  (B) 84f99e060a66                                             | 1     | 8256.44   | 8256.44   | 8256.44   | 8256.44   | 0      |
                                                               |       | +2.27%    | +2.27%    | +2.27%    | +2.27%    | ---    | + is good
  development_1_BCOPY_50__BCOPY_memory_write_bandwidth_MB_sec  |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 6493.75   | 6493.75   | 6493.75   | 6493.75   | 0      |
  (B) 84f99e060a66                                             | 1     | 6516.47   | 6516.47   | 6516.47   | 6516.47   | 0      |
                                                               |       | +0.35%    | +0.35%    | +0.35%    | +0.35%    | ---    | + is good
  development_1_BCOPY_50__BCOPY_unrolled_bandwidth_MB_sec      |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 4361.41   | 4361.41   | 4361.41   | 4361.41   | 0      |
  (B) 84f99e060a66                                             | 1     | 4395.6    | 4395.6    | 4395.6    | 4395.6    | 0      |
                                                               |       | +0.78%    | +0.78%    | +0.78%    | +0.78%    | ---    | + is good
  development_1_CONNECT_50__CONNECT_localhost_latency_us       |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 26.3817   | 26.3817   | 26.3817   | 26.3817   | 0      |
  (B) 84f99e060a66                                             | 1     | 24.6721   | 24.6721   | 24.6721   | 24.6721   | 0      |
                                                               |       | -6.48%    | -6.48%    | -6.48%    | -6.48%    | ---    | - is good
  development_1_CTX_50__CTX_96P_0K_latency_us                  |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 3.18      | 3.18      | 3.18      | 3.18      | 0      |
  (B) 84f99e060a66                                             | 1     | 3.26      | 3.26      | 3.26      | 3.26      | 0      |
                                                               |       | +2.52%    | +2.52%    | +2.52%    | +2.52%    | ---    | - is good
  development_1_CTX_50__CTX_96P_16K_latency_us                 |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 3.64      | 3.64      | 3.64      | 3.64      | 0      |
  (B) 84f99e060a66                                             | 1     | 3.71      | 3.71      | 3.71      | 3.71      | 0      |
                                                               |       | +1.92%    | +1.92%    | +1.92%    | +1.92%    | ---    | - is good
  development_1_CTX_50__CTX_96P_64K_latency_us                 |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 6         | 6         | 6         | 6         | 0      |
  (B) 84f99e060a66                                             | 1     | 6.49      | 6.49      | 6.49      | 6.49      | 0      |
                                                               |       | +8.17%    | +8.17%    | +8.17%    | +8.17%    | ---    | - is good
  development_1_FILE_50__FILE_read_bandwidth_MB_sec            |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 4977.81   | 4977.81   | 4977.81   | 4977.81   | 0      |
  (B) 84f99e060a66                                             | 1     | 4916.3    | 4916.3    | 4916.3    | 4916.3    | 0      |
                                                               |       | -1.24%    | -1.24%    | -1.24%    | -1.24%    | ---    | + is good
  development_1_MMAP_50__MMAP_read_bandwidth_MB_sec            |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 9510.52   | 9510.52   | 9510.52   | 9510.52   | 0      |
  (B) 84f99e060a66                                             | 1     | 9538.52   | 9538.52   | 9538.52   | 9538.52   | 0      |
                                                               |       | +0.29%    | +0.29%    | +0.29%    | +0.29%    | ---    | + is good
  development_1_MMAP_50__MMAP_read_open2close_bandwidth_MB_sec |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 4870.85   | 4870.85   | 4870.85   | 4870.85   | 0      |
  (B) 84f99e060a66                                             | 1     | 4841.19   | 4841.19   | 4841.19   | 4841.19   | 0      |
                                                               |       | -0.61%    | -0.61%    | -0.61%    | -0.61%    | ---    | + is good
  development_1_OPS_50__OPS_double_add_latency_ns              |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 1.4       | 1.4       | 1.4       | 1.4       | 0      |
  (B) 84f99e060a66                                             | 1     | 1.39      | 1.39      | 1.39      | 1.39      | 0      |
                                                               |       | -0.71%    | -0.71%    | -0.71%    | -0.71%    | ---    | - is good
  development_1_OPS_50__OPS_double_div_latency_ns              |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 6.58      | 6.58      | 6.58      | 6.58      | 0      |
  (B) 84f99e060a66                                             | 1     | 6.55      | 6.55      | 6.55      | 6.55      | 0      |
                                                               |       | -0.46%    | -0.46%    | -0.46%    | -0.46%    | ---    | - is good
  development_1_OPS_50__OPS_double_mul_latency_ns              |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 1.4       | 1.4       | 1.4       | 1.4       | 0      |
  (B) 84f99e060a66                                             | 1     | 1.39      | 1.39      | 1.39      | 1.39      | 0      |
                                                               |       | -0.71%    | -0.71%    | -0.71%    | -0.71%    | ---    | - is good
  development_1_OPS_50__OPS_float_add_latency_ns               |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 1.4       | 1.4       | 1.4       | 1.4       | 0      |
  (B) 84f99e060a66                                             | 1     | 1.39      | 1.39      | 1.39      | 1.39      | 0      |
                                                               |       | -0.71%    | -0.71%    | -0.71%    | -0.71%    | ---    | - is good
  development_1_OPS_50__OPS_float_div_latency_ns               |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 5.17      | 5.17      | 5.17      | 5.17      | 0      |
  (B) 84f99e060a66                                             | 1     | 5.15      | 5.15      | 5.15      | 5.15      | 0      |
                                                               |       | -0.39%    | -0.39%    | -0.39%    | -0.39%    | ---    | - is good
  development_1_OPS_50__OPS_float_mul_latency_ns               |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 1.4       | 1.4       | 1.4       | 1.4       | 0      |
  (B) 84f99e060a66                                             | 1     | 1.39      | 1.39      | 1.39      | 1.39      | 0      |
                                                               |       | -0.71%    | -0.71%    | -0.71%    | -0.71%    | ---    | - is good
  development_1_OPS_50__OPS_int64_bit_latency_ns               |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 0.32      | 0.32      | 0.32      | 0.32      | 0      |
  (B) 84f99e060a66                                             | 1     | 0.31      | 0.31      | 0.31      | 0.31      | 0      |
                                                               |       | -3.13%    | -3.13%    | -3.13%    | -3.13%    | ---    | - is good
  development_1_OPS_50__OPS_int64_div_latency_ns               |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 19.65     | 19.65     | 19.65     | 19.65     | 0      |
  (B) 84f99e060a66                                             | 1     | 19.54     | 19.54     | 19.54     | 19.54     | 0      |
                                                               |       | -0.56%    | -0.56%    | -0.56%    | -0.56%    | ---    | - is good
  development_1_OPS_50__OPS_int64_mul_latency_ns               |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 1.41      | 1.41      | 1.41      | 1.41      | 0      |
  (B) 84f99e060a66                                             | 1     | 1.41      | 1.41      | 1.41      | 1.41      | 0      |
                                                               |       | +0.00%    | +0.00%    | +0.00%    | +0.00%    | ---    | <not defined>
  development_1_OPS_50__OPS_integer_bit_latency_ns             |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 0.31      | 0.31      | 0.31      | 0.31      | 0      |
  (B) 84f99e060a66                                             | 1     | 0.31      | 0.31      | 0.31      | 0.31      | 0      |
                                                               |       | +0.00%    | +0.00%    | +0.00%    | +0.00%    | ---    | - is good
  development_1_OPS_50__OPS_integer_div_latency_ns             |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 10.97     | 10.97     | 10.97     | 10.97     | 0      |
  (B) 84f99e060a66                                             | 1     | 10.92     | 10.92     | 10.92     | 10.92     | 0      |
                                                               |       | -0.46%    | -0.46%    | -0.46%    | -0.46%    | ---    | - is good
  development_1_OPS_50__OPS_integer_mul_latency_ns             |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 1.44      | 1.44      | 1.44      | 1.44      | 0      |
  (B) 84f99e060a66                                             | 1     | 1.44      | 1.44      | 1.44      | 1.44      | 0      |
                                                               |       | +0.00%    | +0.00%    | +0.00%    | +0.00%    | ---    | - is good
  development_1_PAGEFAULT_50__Pagefaults_ms                    |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 0.4384    | 0.4384    | 0.4384    | 0.4384    | 0      |
  (B) 84f99e060a66                                             | 1     | 0.4584    | 0.4584    | 0.4584    | 0.4584    | 0      |
                                                               |       | +4.56%    | +4.56%    | +4.56%    | +4.56%    | ---    | - is good
  development_1_PIPE_50__PIPE_bandwidth_MB_sec                 |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 2236.41   | 2236.41   | 2236.41   | 2236.41   | 0      |
  (B) 84f99e060a66                                             | 1     | 2230.42   | 2230.42   | 2230.42   | 2230.42   | 0      |
                                                               |       | -0.27%    | -0.27%    | -0.27%    | -0.27%    | ---    | + is good
  development_1_PIPE_50__PIPE_latency_us                       |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 7.646     | 7.646     | 7.646     | 7.646     | 0      |
  (B) 84f99e060a66                                             | 1     | 7.7923    | 7.7923    | 7.7923    | 7.7923    | 0      |
                                                               |       | +1.91%    | +1.91%    | +1.91%    | +1.91%    | ---    | - is good
  development_1_PROC_50__Process_fork__bin_sh_latency_us       |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 1403.875  | 1403.875  | 1403.875  | 1403.875  | 0      |
  (B) 84f99e060a66                                             | 1     | 1408.8684 | 1408.8684 | 1408.8684 | 1408.8684 | 0      |
                                                               |       | +0.36%    | +0.36%    | +0.36%    | +0.36%    | ---    | - is good
  development_1_PROC_50__Process_fork_execve_latency_us        |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 629.3372  | 629.3372  | 629.3372  | 629.3372  | 0      |
  (B) 84f99e060a66                                             | 1     | 634.5765  | 634.5765  | 634.5765  | 634.5765  | 0      |
                                                               |       | +0.83%    | +0.83%    | +0.83%    | +0.83%    | ---    | - is good
  development_1_PROC_50__Process_fork_exit_latency_us          |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 209.3123  | 209.3123  | 209.3123  | 209.3123  | 0      |
  (B) 84f99e060a66                                             | 1     | 204.6007  | 204.6007  | 204.6007  | 204.6007  | 0      |
                                                               |       | -2.25%    | -2.25%    | -2.25%    | -2.25%    | ---    | - is good
  development_1_SELECT_50__Select_100fd_latency_us             |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 2.5596    | 2.5596    | 2.5596    | 2.5596    | 0      |
  (B) 84f99e060a66                                             | 1     | 2.641     | 2.641     | 2.641     | 2.641     | 0      |
                                                               |       | +3.18%    | +3.18%    | +3.18%    | +3.18%    | ---    | - is good
  development_1_SELECT_50__Select_100tcp_latency_us            |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 4.5837    | 4.5837    | 4.5837    | 4.5837    | 0      |
  (B) 84f99e060a66                                             | 1     | 4.7101    | 4.7101    | 4.7101    | 4.7101    | 0      |
                                                               |       | +2.76%    | +2.76%    | +2.76%    | +2.76%    | ---    | - is good
  development_1_SYSCALL_50__syscall_fstat_latency_us           |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 0.8384    | 0.8384    | 0.8384    | 0.8384    | 0      |
  (B) 84f99e060a66                                             | 1     | 0.8248    | 0.8248    | 0.8248    | 0.8248    | 0      |
                                                               |       | -1.62%    | -1.62%    | -1.62%    | -1.62%    | ---    | - is good
  development_1_SYSCALL_50__syscall_open_close_latency_us      |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 3.7714    | 3.7714    | 3.7714    | 3.7714    | 0      |
  (B) 84f99e060a66                                             | 1     | 3.7521    | 3.7521    | 3.7521    | 3.7521    | 0      |
                                                               |       | -0.51%    | -0.51%    | -0.51%    | -0.51%    | ---    | - is good
  development_1_SYSCALL_50__syscall_read_latency_us            |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 0.6679    | 0.6679    | 0.6679    | 0.6679    | 0      |
  (B) 84f99e060a66                                             | 1     | 0.6671    | 0.6671    | 0.6671    | 0.6671    | 0      |
                                                               |       | -0.12%    | -0.12%    | -0.12%    | -0.12%    | ---    | - is good
  development_1_SYSCALL_50__syscall_stat_latency_us            |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 1.5253    | 1.5253    | 1.5253    | 1.5253    | 0      |
  (B) 84f99e060a66                                             | 1     | 1.5942    | 1.5942    | 1.5942    | 1.5942    | 0      |
                                                               |       | +4.52%    | +4.52%    | +4.52%    | +4.52%    | ---    | - is good
  development_1_SYSCALL_50__syscall_syscall_latency_us         |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 0.6118    | 0.6118    | 0.6118    | 0.6118    | 0      |
  (B) 84f99e060a66                                             | 1     | 0.6114    | 0.6114    | 0.6114    | 0.6114    | 0      |
                                                               |       | -0.07%    | -0.07%    | -0.07%    | -0.07%    | ---    | - is good
  development_1_SYSCALL_50__syscall_write_latency_us           |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 0.6313    | 0.6313    | 0.6313    | 0.6313    | 0      |
  (B) 84f99e060a66                                             | 1     | 0.6292    | 0.6292    | 0.6292    | 0.6292    | 0      |
                                                               |       | -0.33%    | -0.33%    | -0.33%    | -0.33%    | ---    | - is good
  development_1_TCP_50__TCP_localhost_latency                  |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 14.7063   | 14.7063   | 14.7063   | 14.7063   | 0      |
  (B) 84f99e060a66                                             | 1     | 15.0935   | 15.0935   | 15.0935   | 15.0935   | 0      |
                                                               |       | +2.63%    | +2.63%    | +2.63%    | +2.63%    | ---    | - is good
  development_1_TCP_50__TCP_socket_bandwidth_10MB_MB_sec       |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 4387.19   | 4387.19   | 4387.19   | 4387.19   | 0      |
  (B) 84f99e060a66                                             | 1     | 4435.23   | 4435.23   | 4435.23   | 4435.23   | 0      |
                                                               |       | +1.10%    | +1.10%    | +1.10%    | +1.10%    | ---    | + is good
  development_1_TCP_50__TCP_socket_bandwidth_64B_MB_sec        |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 63.26     | 63.26     | 63.26     | 63.26     | 0      |
  (B) 84f99e060a66                                             | 1     | 66.65     | 66.65     | 66.65     | 66.65     | 0      |
                                                               |       | +5.36%    | +5.36%    | +5.36%    | +5.36%    | ---    | + is good
  development_1_UDP_50__UDP_usinglocalhost_latency_us          |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 11.5949   | 11.5949   | 11.5949   | 11.5949   | 0      |
  (B) 84f99e060a66                                             | 1     | 11.5451   | 11.5451   | 11.5451   | 11.5451   | 0      |
                                                               |       | -0.43%    | -0.43%    | -0.43%    | -0.43%    | ---    | - is good
  development_1_UNIX_50__AF_UNIX_sock_stream_bandwidth_MB_sec  |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 5700.99   | 5700.99   | 5700.99   | 5700.99   | 0      |
  (B) 84f99e060a66                                             | 1     | 5722.12   | 5722.12   | 5722.12   | 5722.12   | 0      |
                                                               |       | +0.37%    | +0.37%    | +0.37%    | +0.37%    | ---    | + is good
  development_1_UNIX_50__AF_UNIX_sock_stream_latency_us        |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3                                             | 1     | 12.9419   | 12.9419   | 12.9419   | 12.9419   | 0      |
  (B) 84f99e060a66                                             | 1     | 12.8052   | 12.8052   | 12.8052   | 12.8052   | 0      |
                                                               |       | -1.06%    | -1.06%    | -1.06%    | -1.06%    | ---    | - is good

[*] BENCHMARK
Name: parallelio
Description: parallelio measures the impact of IO on the performance
of an in-memory workload. The primary worklod in-memory workload. The
primary workload is a memcached server with a memcachetest client
tuned to use 80% of memory. The test runs multiple times starting with
no parallel IO andthen doing IO with dd to a file sized to be  10% of
physical memory and finishing with a file 80% of physical memory. The
metrics of the test are how much performance is lost by running the IO
in parallel and checking if it prematurely pushed to swap. A positive
swapout figure is not necessarily bad but high swaptotals imply that
the in-memory workload is thrashing.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 10
  machine_total_logical_cores  | 72
  machine_total_physical_cores | 36
  machine_total_ram_gib        | 256

[*] METRICS
              LABEL              | COUNT |  MIN   |  MAX   |       MEAN        | MEDIAN |       STDDEV       |   DIRECTION
---------------------------------+-------+--------+--------+-------------------+--------+--------------------+----------------
  parallelio_memcachetest_0M     |       |        |        |                   |        |                    |
  (A) 4db0b9c9d0f3               | 3     | 405274 | 414589 | 409674            | 409159 | 3820.2290507245766 |
  (B) 84f99e060a66               | 3     | 408722 | 410821 | 409731            | 409650 | 858.825166530806   |
                                 |       | +0.85% | -0.91% | +0.01%            | +0.12% | -77.52%            | <not defined>
  parallelio_memcachetest_25784M |       |        |        |                   |        |                    |
  (A) 4db0b9c9d0f3               | 3     | 408843 | 414268 | 411967.6666666667 | 412792 | 2290.167436867645  |
  (B) 84f99e060a66               | 1     | 410109 | 410109 | 410109            | 410109 | 0                  |
                                 |       | +0.31% | -1.00% | -0.45%            | -0.65% | -100.00%           | <not defined>
  parallelio_memcachetest_maxM   |       |        |        |                   |        |                    |
  (A) 4db0b9c9d0f3               | 3     | 403039 | 407154 | 405639.3333333333 | 406725 | 1847.0355227288503 |
  (B) 84f99e060a66               | 1     | 410109 | 410109 | 410109            | 410109 | 0                  |
                                 |       | +1.75% | +0.73% | +1.10%            | +0.83% | -100.00%           | + is good
  parallelio_memcachetest_minM   |       |        |        |                   |        |                    |
  (A) 4db0b9c9d0f3               | 3     | 405274 | 414589 | 409674            | 409159 | 3820.2290507245766 |
  (B) 84f99e060a66               | 3     | 408722 | 410821 | 409731            | 409650 | 858.825166530806   |
                                 |       | +0.85% | -0.91% | +0.01%            | +0.12% | -77.52%            | + is good

[*] BENCHMARK
Name: postmark
Description: PostMark is a benchmark that demonstrates system
performance for short-lived small files seen typically in Internet
applications such as electronic mail, netnews and web-based commerce.
The benchmark creates an initial pool of random text files of varying
size. Once the pool has been created, the benchmark performs two types
of transactions on the pool: (i) create or delete a file; (ii) read
from or append to a file. The incidence of each transaction and its
subtype are chosen randomly to eliminate the effect of caching and
read-ahead.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 43
  machine_total_logical_cores  | 12
  machine_total_physical_cores | 6
  machine_total_ram_gib        | 32

[*] METRICS
           LABEL          | COUNT |   MIN   |   MAX   |  MEAN   | MEDIAN  | STDDEV | DIRECTION
--------------------------+-------+---------+---------+---------+---------+--------+------------
  postmark_CreateTransact |       |         |         |         |         |        |
  (A) 4db0b9c9d0f3        | 1     | 12      | 12      | 12      | 12      | 0      |
  (B) 84f99e060a66        | 1     | 12      | 12      | 12      | 12      | 0      |
                          |       | +0.00%  | +0.00%  | +0.00%  | +0.00%  | ---    | + is good
  postmark_DataRead_MB    |       |         |         |         |         |        |
  (A) 4db0b9c9d0f3        | 1     | 20.61   | 20.61   | 20.61   | 20.61   | 0      |
  (B) 84f99e060a66        | 1     | 19.84   | 19.84   | 19.84   | 19.84   | 0      |
                          |       | -3.74%  | -3.74%  | -3.74%  | -3.74%  | ---    | + is good
  postmark_DataWrite_MB   |       |         |         |         |         |        |
  (A) 4db0b9c9d0f3        | 1     | 57.81   | 57.81   | 57.81   | 57.81   | 0      |
  (B) 84f99e060a66        | 1     | 55.66   | 55.66   | 55.66   | 55.66   | 0      |
                          |       | -3.72%  | -3.72%  | -3.72%  | -3.72%  | ---    | + is good
  postmark_DeleteTransact |       |         |         |         |         |        |
  (A) 4db0b9c9d0f3        | 1     | 12      | 12      | 12      | 12      | 0      |
  (B) 84f99e060a66        | 1     | 12      | 12      | 12      | 12      | 0      |
                          |       | +0.00%  | +0.00%  | +0.00%  | +0.00%  | ---    | + is good
  postmark_FilesCreate    |       |         |         |         |         |        |
  (A) 4db0b9c9d0f3        | 1     | 31      | 31      | 31      | 31      | 0      |
  (B) 84f99e060a66        | 1     | 29      | 29      | 29      | 29      | 0      |
                          |       | -6.45%  | -6.45%  | -6.45%  | -6.45%  | ---    | + is good
  postmark_FilesDeleted   |       |         |         |         |         |        |
  (A) 4db0b9c9d0f3        | 1     | 3095    | 3095    | 3095    | 3095    | 0      |
  (B) 84f99e060a66        | 1     | 4127    | 4127    | 4127    | 4127    | 0      |
                          |       | +33.34% | +33.34% | +33.34% | +33.34% | ---    | + is good
  postmark_Transactions   |       |         |         |         |         |        |
  (A) 4db0b9c9d0f3        | 1     | 24      | 24      | 24      | 24      | 0      |
  (B) 84f99e060a66        | 1     | 24      | 24      | 24      | 24      | 0      |
                          |       | +0.00%  | +0.00%  | +0.00%  | +0.00%  | ---    | + is good

[*] BENCHMARK
Name: hackbench
Description: Hackbench is both a benchmark and a stress test for the
Linux kernel scheduler. It's main job  is  to  create a specified
number of pairs of schedulable entities (either threads or traditional
processes) which communicate via either sockets or pipes and time how
long it takes for each pair to send data back and forth.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 112
  machine_total_physical_cores | 56
  machine_total_ram_gib        | 384

[*] METRICS
              LABEL             | COUNT |   MIN   |   MAX   |        MEAN        | MEDIAN |       STDDEV        |   DIRECTION
--------------------------------+-------+---------+---------+--------------------+--------+---------------------+----------------
  hackbench_process_pipes_234   |       |         |         |                    |        |                     |
  (A) 4db0b9c9d0f3              | 7     | 3.052   | 3.773   | 3.3674285714285714 | 3.329  | 0.285106925878123   |
  (B) 84f99e060a66              | 7     | 2.998   | 3.359   | 3.1277142857142857 | 3.074  | 0.11753262682058513 |
                                |       | -1.77%  | -10.97% | -7.12%             | -7.66% | -58.78%             | <not defined>
  hackbench_process_pipes_max   |       |         |         |                    |        |                     |
  (A) 4db0b9c9d0f3              | 7     | 3.052   | 3.773   | 3.3674285714285714 | 3.329  | 0.285106925878123   |
  (B) 84f99e060a66              | 7     | 2.998   | 3.359   | 3.1277142857142857 | 3.074  | 0.11753262682058513 |
                                |       | -1.77%  | -10.97% | -7.12%             | -7.66% | -58.78%             | - is good
  hackbench_process_sockets_234 |       |         |         |                    |        |                     |
  (A) 4db0b9c9d0f3              | 7     | 6.156   | 6.36    | 6.284571428571429  | 6.285  | 0.06349771006637552 |
  (B) 84f99e060a66              | 7     | 6.194   | 6.806   | 6.408428571428572  | 6.335  | 0.20896606501183543 |
                                |       | +0.62%  | +7.01%  | +1.97%             | +0.80% | +229.09%            | <not defined>
  hackbench_process_sockets_max |       |         |         |                    |        |                     |
  (A) 4db0b9c9d0f3              | 7     | 6.156   | 6.36    | 6.284571428571429  | 6.285  | 0.06349771006637552 |
  (B) 84f99e060a66              | 7     | 6.194   | 6.806   | 6.408428571428572  | 6.335  | 0.20896606501183543 |
                                |       | +0.62%  | +7.01%  | +1.97%             | +0.80% | +229.09%            | - is good
  hackbench_thread_pipes_234    |       |         |         |                    |        |                     |
  (A) 4db0b9c9d0f3              | 7     | 4.222   | 4.651   | 4.377857142857143  | 4.361  | 0.14447879584554812 |
  (B) 84f99e060a66              | 7     | 3.71    | 4.328   | 4.072              | 4.105  | 0.20410991436688505 |
                                |       | -12.13% | -6.94%  | -6.99%             | -5.87% | +41.27%             | <not defined>
  hackbench_thread_pipes_max    |       |         |         |                    |        |                     |
  (A) 4db0b9c9d0f3              | 7     | 4.222   | 4.651   | 4.377857142857143  | 4.361  | 0.14447879584554812 |
  (B) 84f99e060a66              | 7     | 3.71    | 4.328   | 4.072              | 4.105  | 0.20410991436688505 |
                                |       | -12.13% | -6.94%  | -6.99%             | -5.87% | +41.27%             | - is good
  hackbench_thread_sockets_234  |       |         |         |                    |        |                     |
  (A) 4db0b9c9d0f3              | 7     | 6.163   | 6.274   | 6.194857142857143  | 6.18   | 0.03647867702577801 |
  (B) 84f99e060a66              | 7     | 5.993   | 6.286   | 6.166857142857143  | 6.235  | 0.10362766945922779 |
                                |       | -2.76%  | +0.19%  | -0.45%             | +0.89% | +184.08%            | <not defined>
  hackbench_thread_sockets_max  |       |         |         |                    |        |                     |
  (A) 4db0b9c9d0f3              | 7     | 6.163   | 6.274   | 6.194857142857143  | 6.18   | 0.03647867702577801 |
  (B) 84f99e060a66              | 7     | 5.993   | 6.286   | 6.166857142857143  | 6.235  | 0.10362766945922779 |
                                |       | -2.76%  | +0.19%  | -0.45%             | +0.89% | +184.08%            | - is good

[*] BENCHMARK
Name: kernbench
Description: kernbench is a simple average of five kernel compiles of
the vmlinuxbinary image. kernbench checks out and builds v5.9.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 112
  machine_total_physical_cores | 56
  machine_total_ram_gib        | 384

[*] METRICS
        LABEL        | COUNT |   MIN   |   MAX   |        MEAN        | MEDIAN  |       STDDEV       |   DIRECTION
---------------------+-------+---------+---------+--------------------+---------+--------------------+----------------
  kernbench_elsp_112 |       |         |         |                    |         |                    |
  (A) 4db0b9c9d0f3   | 5     | 51.13   | 53.51   | 52.581999999999994 | 52.64   | 0.7946672259505867 |
  (B) 84f99e060a66   | 5     | 51.52   | 53.22   | 52.128             | 52.08   | 0.6266865245080647 |
                     |       | +0.76%  | -0.54%  | -0.86%             | -1.06%  | -21.14%            | <not defined>
  kernbench_elsp_max |       |         |         |                    |         |                    |
  (A) 4db0b9c9d0f3   | 5     | 51.13   | 53.51   | 52.581999999999994 | 52.64   | 0.7946672259505867 |
  (B) 84f99e060a66   | 5     | 51.52   | 53.22   | 52.128             | 52.08   | 0.6266865245080647 |
                     |       | +0.76%  | -0.54%  | -0.86%             | -1.06%  | -21.14%            | - is good
  kernbench_syst_112 |       |         |         |                    |         |                    |
  (A) 4db0b9c9d0f3   | 5     | 478.47  | 498.33  | 493.546            | 496.52  | 7.582455011406262  |
  (B) 84f99e060a66   | 5     | 479.37  | 496.39  | 491.84200000000004 | 494.62  | 6.357538517382332  |
                     |       | +0.19%  | -0.39%  | -0.35%             | -0.38%  | -16.15%            | <not defined>
  kernbench_syst_max |       |         |         |                    |         |                    |
  (A) 4db0b9c9d0f3   | 5     | 478.47  | 498.33  | 493.546            | 496.52  | 7.582455011406262  |
  (B) 84f99e060a66   | 5     | 479.37  | 496.39  | 491.84200000000004 | 494.62  | 6.357538517382332  |
                     |       | +0.19%  | -0.39%  | -0.35%             | -0.38%  | -16.15%            | - is good
  kernbench_user_112 |       |         |         |                    |         |                    |
  (A) 4db0b9c9d0f3   | 5     | 3086.46 | 3091.98 | 3088.51            | 3086.97 | 2.2000000000000863 |
  (B) 84f99e060a66   | 5     | 3085.06 | 3092.73 | 3089.646           | 3090.99 | 2.9837466380374402 |
                     |       | -0.05%  | +0.02%  | +0.04%             | +0.13%  | +35.62%            | <not defined>
  kernbench_user_max |       |         |         |                    |         |                    |
  (A) 4db0b9c9d0f3   | 5     | 3086.46 | 3091.98 | 3088.51            | 3086.97 | 2.2000000000000863 |
  (B) 84f99e060a66   | 5     | 3085.06 | 3092.73 | 3089.646           | 3090.99 | 2.9837466380374402 |
                     |       | -0.05%  | +0.02%  | +0.04%             | +0.13%  | +35.62%            | - is good

[*] BENCHMARK
Name: memcached
Description: memcached benchmark drived by mcperf.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 256
  machine_total_physical_cores | 128
  machine_total_ram_gib        | 1024

[*] METRICS
       LABEL       | COUNT |      MIN      |      MAX      |          MEAN          |    MEDIAN     |      STDDEV       | DIRECTION
-------------------+-------+---------------+---------------+------------------------+---------------+-------------------+------------
  QPS              |       |               |               |                        |               |                   |
  (A) 4db0b9c9d0f3 | 5     | 1.0583485e+06 | 1.0695842e+06 | 1.0632277999999998e+06 | 1.0616673e+06 | 3820.724428691447 |
  (B) 84f99e060a66 | 5     | 1.0654889e+06 | 1.0724847e+06 | 1.06819692e+06         | 1.0683428e+06 | 2454.762893152803 |
                   |       | +0.67%        | +0.27%        | +0.47%                 | +0.63%        | -35.75%           | + is good

[*] BENCHMARK
Name: multichase
Description: multichase is a pointer chaser microbenchmark.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 256
  machine_total_physical_cores | 128
  machine_total_ram_gib        | 1024

[*] METRICS
                       LABEL                      | COUNT |  MIN   |  MAX   |        MEAN        | MEDIAN |       STDDEV        | DIRECTION
--------------------------------------------------+-------+--------+--------+--------------------+--------+---------------------+------------
  best_ns_per_chase_4_thread_local_2m             |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 100.9  | 101.2  | 101                | 100.9  | 0.12649110640673303 |
  (B) 84f99e060a66                                | 5     | 101    | 101.2  | 101.14             | 101.2  | 0.08000000000000318 |
                                                  |       | +0.10% | +0.00% | +0.14%             | +0.30% | -36.75%             | - is good
  best_ns_per_chase_4_thread_local_4k             |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 103.3  | 103.5  | 103.4              | 103.4  | 0.06324555320336923 |
  (B) 84f99e060a66                                | 5     | 103.3  | 103.5  | 103.4              | 103.4  | 0.06324555320336793 |
                                                  |       | +0.00% | +0.00% | +0.00%             | +0.00% | -0.00%              | - is good
  best_ns_per_chase_all_cores                     |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 388.7  | 389.8  | 389.22             | 389.2  | 0.43081318457077317 |
  (B) 84f99e060a66                                | 5     | 388.6  | 389.4  | 388.98             | 389    | 0.2993325909419067  |
                                                  |       | -0.03% | -0.10% | -0.06%             | -0.05% | -30.52%             | - is good
  best_ns_per_chase_all_cores_interleaved         |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 321.7  | 322.8  | 322.26             | 322.3  | 0.36110940170536426 |
  (B) 84f99e060a66                                | 5     | 322.2  | 323.3  | 322.61999999999995 | 322.5  | 0.3762977544445408  |
                                                  |       | +0.16% | +0.15% | +0.11%             | +0.06% | +4.21%              | - is good
  best_ns_per_chase_all_thread_local_2m           |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 172.3  | 211    | 191.51999999999998 | 188.2  | 13.47136221768238   |
  (B) 84f99e060a66                                | 5     | 173.3  | 206.7  | 193.18             | 193.1  | 11.561729974359364  |
                                                  |       | +0.58% | -2.04% | +0.87%             | +2.60% | -14.18%             | - is good
  best_ns_per_chase_all_thread_local_4k           |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 181    | 187.2  | 183.62             | 182.7  | 2.609521028848008   |
  (B) 84f99e060a66                                | 5     | 179    | 184    | 182.38             | 182.7  | 1.8148278155241067  |
                                                  |       | -1.10% | -1.71% | -0.68%             | +0.00% | -30.45%             | - is good
  best_ns_per_chase_one_socket_local              |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 173.3  | 173.8  | 173.56             | 173.6  | 0.1854723699099109  |
  (B) 84f99e060a66                                | 5     | 173.6  | 173.7  | 173.64             | 173.6  | 0.04898979485566097 |
                                                  |       | +0.17% | -0.06% | +0.05%             | +0.00% | -73.59%             | - is good
  best_ns_per_chase_one_socket_remote             |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 254.4  | 255    | 254.57999999999998 | 254.5  | 0.21354156504062177 |
  (B) 84f99e060a66                                | 5     | 254.2  | 254.9  | 254.48000000000002 | 254.4  | 0.27856776554368984 |
                                                  |       | -0.08% | -0.04% | -0.04%             | -0.04% | +30.45%             | - is good
  best_ns_per_chase_single_thread_local_0         |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 142.8  | 144.8  | 144.20000000000002 | 144.6  | 0.7589466384404142  |
  (B) 84f99e060a66                                | 5     | 143.3  | 145.1  | 144.12             | 144    | 0.6554387843269566  |
                                                  |       | +0.35% | +0.21% | -0.06%             | -0.41% | -13.64%             | - is good
  best_ns_per_chase_single_thread_local_1         |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 142.8  | 143.9  | 143.48             | 143.6  | 0.3762977544445269  |
  (B) 84f99e060a66                                | 5     | 141.7  | 144.4  | 142.84             | 142.3  | 1.098362417419681   |
                                                  |       | -0.77% | +0.35% | -0.45%             | -0.91% | +191.89%            | - is good
  best_ns_per_chase_single_thread_local_2m        |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 69.006 | 69.578 | 69.399             | 69.466 | 0.2022117701816582  |
  (B) 84f99e060a66                                | 5     | 69.506 | 69.838 | 69.64559999999999  | 69.657 | 0.11971399249879164 |
                                                  |       | +0.72% | +0.37% | +0.36%             | +0.27% | -40.80%             | - is good
  best_ns_per_chase_single_thread_local_4k        |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 69.949 | 70.246 | 70.0564            | 69.999 | 0.11009741141371474 |
  (B) 84f99e060a66                                | 5     | 69.954 | 70.332 | 70.104             | 70.103 | 0.127741927337898   |
                                                  |       | +0.01% | +0.12% | +0.07%             | +0.15% | +16.03%             | - is good
  best_ns_per_chase_single_thread_local_50g_2m    |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 111.6  | 111.7  | 111.66000000000001 | 111.7  | 0.0489897948556674  |
  (B) 84f99e060a66                                | 5     | 111    | 111.6  | 111.42             | 111.5  | 0.22271057451320025 |
                                                  |       | -0.54% | -0.09% | -0.21%             | -0.18% | +354.61%            | - is good
  best_ns_per_chase_single_thread_local_50g_4k    |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 141.9  | 144.2  | 142.9              | 142.9  | 0.8173126696681018  |
  (B) 84f99e060a66                                | 5     | 141.7  | 144.5  | 143.16             | 143.4  | 0.9134549797335416  |
                                                  |       | -0.14% | +0.21% | +0.18%             | +0.35% | +11.76%             | - is good
  best_ns_per_chase_single_thread_remote          |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 248.8  | 256.6  | 252.98000000000002 | 254.4  | 3.3695103501844326  |
  (B) 84f99e060a66                                | 5     | 247.5  | 259.4  | 252.45999999999998 | 252.3  | 4.070675619599272   |
                                                  |       | -0.52% | +1.09% | -0.21%             | -0.83% | +20.81%             | - is good
  best_ns_per_chase_single_thread_remote_reversed |       |        |        |                    |        |                     |
  (A) 4db0b9c9d0f3                                | 5     | 268.3  | 272.1  | 270.76000000000005 | 271    | 1.3124023773218374  |
  (B) 84f99e060a66                                | 5     | 251.7  | 270.8  | 265.72             | 268.4  | 7.135656942426554   |
                                                  |       | -6.19% | -0.48% | -1.86%             | -0.96% | +443.71%            | - is good

[*] BENCHMARK
Name: nginx
Description: nginx web server benchmark.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 256
  machine_total_physical_cores | 128
  machine_total_ram_gib        | 1024

[*] METRICS
       LABEL       | COUNT |    MIN    |    MAX    |   MEAN    |  MEDIAN   | STDDEV | DIRECTION
-------------------+-------+-----------+-----------+-----------+-----------+--------+------------
  requests_per_sec |       |           |           |           |           |        |
  (A) 4db0b9c9d0f3 | 1     | 239142.25 | 239142.25 | 239142.25 | 239142.25 | 0      |
  (B) 84f99e060a66 | 1     | 240934.99 | 240934.99 | 240934.99 | 240934.99 | 0      |
                   |       | +0.75%    | +0.75%    | +0.75%    | +0.75%    | ---    | + is good

[*] BENCHMARK
Name: pft
Description: pft is a page fault microbenchmark.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 112
  machine_total_physical_cores | 56
  machine_total_ram_gib        | 384

[*] METRICS
        LABEL        | COUNT |       MIN       |       MAX       |          MEAN          |         MEDIAN         |       STDDEV       |   DIRECTION
---------------------+-------+-----------------+-----------------+------------------------+------------------------+--------------------+----------------
  pft_faults_cpu_1   |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 484154.455      | 498063.798      | 492351.76326666656     | 492720.2755            | 4126.981613976473  |
  (B) 84f99e060a66   | 30    | 482742.695      | 494479.926      | 489330.9015999999      | 489143.3515            | 2618.891200946336  |
                     |       | -0.29%          | -0.72%          | -0.61%                 | -0.73%                 | -36.54%            | <not defined>
  pft_faults_cpu_4   |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 417255.026      | 436288.218      | 428640.1996333333      | 430395.16150000005     | 4746.028941246967  |
  (B) 84f99e060a66   | 30    | 415617.241      | 437189.129      | 427759.93749999994     | 429933.131             | 5261.030587409123  |
                     |       | -0.39%          | +0.21%          | -0.21%                 | -0.11%                 | +10.85%            | <not defined>
  pft_faults_cpu_7   |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 372190.395      | 400357.397      | 387933.1743333333      | 387656.1515            | 6724.31140527816   |
  (B) 84f99e060a66   | 30    | 369391.438      | 409099.695      | 388038.53069999994     | 387980.819             | 8197.679887071488  |
                     |       | -0.75%          | +2.18%          | +0.03%                 | +0.08%                 | +21.91%            | <not defined>
  pft_faults_cpu_12  |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 309306.251      | 368030.388      | 334522.85160000005     | 334821.131             | 11465.852240019683 |
  (B) 84f99e060a66   | 30    | 318117.629      | 391477.132      | 350409.11253333336     | 342996.01749999996     | 19334.051623320604 |
                     |       | +2.85%          | +6.37%          | +4.75%                 | +2.44%                 | +68.62%            | <not defined>
  pft_faults_cpu_21  |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 212079.413      | 240668.262      | 223933.0883666667      | 223797.9645            | 6708.986752443093  |
  (B) 84f99e060a66   | 30    | 209471.97       | 253796.094      | 231684.6007            | 232578.2415            | 8994.590384813879  |
                     |       | -1.23%          | +5.45%          | +3.46%                 | +3.92%                 | +34.07%            | <not defined>
  pft_faults_cpu_30  |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 149503.828      | 169490.187      | 157576.0666666667      | 156733.52000000002     | 4880.567067589405  |
  (B) 84f99e060a66   | 30    | 146606.506      | 159328.049      | 153893.34433333337     | 153843.4095            | 3658.1395313921544 |
                     |       | -1.94%          | -6.00%          | -2.34%                 | -1.84%                 | -25.05%            | <not defined>
  pft_faults_cpu_48  |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 89186.867       | 105649.211      | 96896.45703333334      | 96477.243              | 3547.1707756648643 |
  (B) 84f99e060a66   | 30    | 95000.878       | 104614.989      | 99554.7385             | 99217.7575             | 2777.940310004704  |
                     |       | +6.52%          | -0.98%          | +2.74%                 | +2.84%                 | -21.69%            | <not defined>
  pft_faults_cpu_79  |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 57662.997       | 65575.52        | 61964.21549999999      | 62236.382              | 2375.343252427598  |
  (B) 84f99e060a66   | 30    | 59007.184       | 64639.405       | 62038.662000000004     | 62079.3465             | 1445.370658156032  |
                     |       | +2.33%          | -1.43%          | +0.12%                 | -0.25%                 | -39.15%            | <not defined>
  pft_faults_cpu_110 |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 38555.581       | 43263.373       | 41597.62980000001      | 41827.095              | 1083.5797160778825 |
  (B) 84f99e060a66   | 30    | 38994.493       | 42748.637       | 40923.156866666664     | 40935.1565             | 803.2742110120612  |
                     |       | +1.14%          | -1.19%          | -1.62%                 | -2.13%                 | -25.87%            | <not defined>
  pft_faults_cpu_112 |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 37132.764       | 42444.162       | 39839.86603333334      | 39874.229              | 1333.3398674946425 |
  (B) 84f99e060a66   | 30    | 38258.017       | 41967.179       | 40467.65890000001      | 40828.6995             | 1129.7326503081576 |
                     |       | +3.03%          | -1.12%          | +1.58%                 | +2.39%                 | -15.27%            | <not defined>
  pft_faults_cpu_max |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 37132.764       | 42444.162       | 39839.86603333334      | 39874.229              | 1333.3398674946425 |
  (B) 84f99e060a66   | 30    | 38258.017       | 41967.179       | 40467.65890000001      | 40828.6995             | 1129.7326503081576 |
                     |       | +3.03%          | -1.12%          | +1.58%                 | +2.39%                 | -15.27%            | + is good
  pft_faults_cpu_min |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 484154.455      | 498063.798      | 492351.76326666656     | 492720.2755            | 4126.981613976473  |
  (B) 84f99e060a66   | 30    | 482742.695      | 494479.926      | 489330.9015999999      | 489143.3515            | 2618.891200946336  |
                     |       | -0.29%          | -0.72%          | -0.61%                 | -0.73%                 | -36.54%            | <not defined>
  pft_faults_sec_1   |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 482655.212      | 496337.449      | 490741.9783666667      | 491119.00399999996     | 4087.2010942607367 |
  (B) 84f99e060a66   | 30    | 481121.66       | 492991.898      | 487799.8169666667      | 487654.93200000003     | 2614.246674701353  |
                     |       | -0.32%          | -0.67%          | -0.60%                 | -0.71%                 | -36.04%            | <not defined>
  pft_faults_sec_4   |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 1.656675025e+06 | 1.734861822e+06 | 1.7028609316666666e+06 | 1.708249671e+06        | 18396.918176364477 |
  (B) 84f99e060a66   | 30    | 1.65463698e+06  | 1.740377412e+06 | 1.6982376496e+06       | 1.7050573065e+06       | 21839.976016046272 |
                     |       | -0.12%          | +0.32%          | -0.27%                 | -0.19%                 | +18.72%            | <not defined>
  pft_faults_sec_7   |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 2.576784434e+06 | 2.781667761e+06 | 2.691555006733333e+06  | 2.688371363e+06        | 49862.74427563325  |
  (B) 84f99e060a66   | 30    | 2.542283262e+06 | 2.842252505e+06 | 2.688004269666667e+06  | 2.6849550785e+06       | 60323.253971796265 |
                     |       | -1.34%          | +2.18%          | -0.13%                 | -0.13%                 | +20.98%            | <not defined>
  pft_faults_sec_12  |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 3.633401181e+06 | 4.374679466e+06 | 3.938532944666667e+06  | 3.939308249e+06        | 149662.241812175   |
  (B) 84f99e060a66   | 30    | 3.725404786e+06 | 4.656017688e+06 | 4.1528862671666667e+06 | 4.0556863770000003e+06 | 246622.15667207883 |
                     |       | +2.53%          | +6.43%          | +5.44%                 | +2.95%                 | +64.79%            | <not defined>
  pft_faults_sec_21  |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 4.257593175e+06 | 4.97357222e+06  | 4.576851050233333e+06  | 4.593935882999999e+06  | 168307.08800032237 |
  (B) 84f99e060a66   | 30    | 4.171296711e+06 | 5.280228369e+06 | 4.7697711534e+06       | 4.7752310005e+06       | 219077.6547498594  |
                     |       | -2.03%          | +6.17%          | +4.22%                 | +3.95%                 | +30.17%            | <not defined>
  pft_faults_sec_30  |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 4.1342909e+06   | 4.83459836e+06  | 4.389753519166667e+06  | 4.361737706499999e+06  | 178674.78729718164 |
  (B) 84f99e060a66   | 30    | 3.876906006e+06 | 4.532188933e+06 | 4.238873766100001e+06  | 4.247939301e+06        | 133754.5309846267  |
                     |       | -6.23%          | -6.26%          | -3.44%                 | -2.61%                 | -25.14%            | <not defined>
  pft_faults_sec_48  |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 3.92643344e+06  | 4.513617248e+06 | 4.2207080896333335e+06 | 4.1957761735e+06       | 126421.31890762268 |
  (B) 84f99e060a66   | 30    | 4.094672788e+06 | 4.456402988e+06 | 4.276243805466667e+06  | 4.27633757e+06         | 108063.75636518569 |
                     |       | +4.28%          | -1.27%          | +1.32%                 | +1.92%                 | -14.52%            | <not defined>
  pft_faults_sec_79  |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 3.973659764e+06 | 4.432766382e+06 | 4.249352675600002e+06  | 4.2673665505e+06       | 125455.19112125924 |
  (B) 84f99e060a66   | 30    | 4.056523429e+06 | 4.393364151e+06 | 4.229541857999999e+06  | 4.223422776e+06        | 93487.38184650465  |
                     |       | +2.09%          | -0.89%          | -0.47%                 | -1.03%                 | -25.48%            | <not defined>
  pft_faults_sec_110 |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 3.924296032e+06 | 4.323501374e+06 | 4.198218468433334e+06  | 4.1928832964999997e+06 | 83650.67974854974  |
  (B) 84f99e060a66   | 30    | 3.869292322e+06 | 4.273456407e+06 | 4.109747521433334e+06  | 4.1008859835e+06       | 85885.92884576393  |
                     |       | -1.40%          | -1.16%          | -2.11%                 | -2.19%                 | +2.67%             | <not defined>
  pft_faults_sec_112 |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 3.883455039e+06 | 4.315943652e+06 | 4.1168769454e+06       | 4.14878067e+06         | 118389.0875606618  |
  (B) 84f99e060a66   | 30    | 3.912952449e+06 | 4.28290919e+06  | 4.1253468313666666e+06 | 4.1466393205000004e+06 | 98247.69508444188  |
                     |       | +0.76%          | -0.77%          | +0.21%                 | -0.05%                 | -17.01%            | <not defined>
  pft_faults_sec_max |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 3.883455039e+06 | 4.315943652e+06 | 4.1168769454e+06       | 4.14878067e+06         | 118389.0875606618  |
  (B) 84f99e060a66   | 30    | 3.912952449e+06 | 4.28290919e+06  | 4.1253468313666666e+06 | 4.1466393205000004e+06 | 98247.69508444188  |
                     |       | +0.76%          | -0.77%          | +0.21%                 | -0.05%                 | -17.01%            | + is good
  pft_faults_sec_min |       |                 |                 |                        |                        |                    |
  (A) 4db0b9c9d0f3   | 30    | 482655.212      | 496337.449      | 490741.9783666667      | 491119.00399999996     | 4087.2010942607367 |
  (B) 84f99e060a66   | 30    | 481121.66       | 492991.898      | 487799.8169666667      | 487654.93200000003     | 2614.246674701353  |
                     |       | -0.32%          | -0.67%          | -0.60%                 | -0.71%                 | -36.04%            | <not defined>

[*] BENCHMARK
Name: pgsql-hammerdb
Description: Postgres benchmark drived by hammerdb.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 256
  machine_total_physical_cores | 128
  machine_total_ram_gib        | 1024

[*] METRICS
          LABEL         | COUNT |  MIN   |  MAX   |  MEAN  | MEDIAN | STDDEV | DIRECTION
------------------------+-------+--------+--------+--------+--------+--------+------------
  new_orders_per_minute |       |        |        |        |        |        |
  (A) 4db0b9c9d0f3      | 1     | 337717 | 337717 | 337717 | 337717 | 0      |
  (B) 84f99e060a66      | 1     | 341671 | 341671 | 341671 | 341671 | 0      |
                        |       | +1.17% | +1.17% | +1.17% | +1.17% | ---    | + is good

[*] BENCHMARK
Name: redis
Description: redis is a single-threaded server in-memory data store.
This is a basic configuration that uses one server even if running on
a NUMA machine with clients unbound.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 112
  machine_total_physical_cores | 56
  machine_total_ram_gib        | 384

[*] METRICS
             LABEL             | COUNT |    MIN    |    MAX    |        MEAN        |       MEDIAN       |       STDDEV       |   DIRECTION
-------------------------------+-------+-----------+-----------+--------------------+--------------------+--------------------+----------------
  redis_large_112_GET          |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 86121.52  | 97641.95  | 89782.828          | 87288.98           | 4211.594426691152  |
  (B) 84f99e060a66             | 5     | 81245.33  | 106947.3  | 99600.116          | 103938.22          | 9595.9089538086    |
                               |       | -5.66%    | +9.53%    | +10.93%            | +19.07%            | +127.85%           | <not defined>
  redis_large_112_INCR         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 83982.8   | 99338.41  | 91855.92199999999  | 91971.79           | 4859.882740146716  |
  (B) 84f99e060a66             | 5     | 94742.73  | 107902.8  | 102147.482         | 103681.74          | 5328.512361773783  |
                               |       | +12.81%   | +8.62%    | +11.20%            | +12.73%            | +9.64%             | <not defined>
  redis_large_112_LPOP         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 77050.51  | 103915.53 | 91193.33           | 90605.98           | 8760.399742863337  |
  (B) 84f99e060a66             | 5     | 102777.04 | 106855.88 | 105447.25          | 105883.97          | 1508.874453186883  |
                               |       | +33.39%   | +2.83%    | +15.63%            | +16.86%            | -82.78%            | <not defined>
  redis_large_112_LPUSH        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 10    | 76444.42  | 105362.97 | 91002.66000000002  | 91349.625          | 8440.749480048564  |
  (B) 84f99e060a66             | 10    | 92986.93  | 108131.48 | 103406.56999999999 | 105310.51500000001 | 5454.677779080998  |
                               |       | +21.64%   | +2.63%    | +13.63%            | +15.28%            | -35.38%            | <not defined>
  redis_large_112_LRANGE_100   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 63462.25  | 67180.82  | 65070.407999999996 | 64373.27           | 1328.4272375768319 |
  (B) 84f99e060a66             | 5     | 66256.32  | 67993.45  | 67324.19           | 67227.34           | 637.2648417730207  |
                               |       | +4.40%    | +1.21%    | +3.46%             | +4.43%             | -52.03%            | <not defined>
  redis_large_112_LRANGE_300   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 28794.13  | 30684.35  | 29872.71           | 29611.64           | 720.4084873181326  |
  (B) 84f99e060a66             | 5     | 30024.98  | 30781.64  | 30501.838          | 30559.27           | 260.3957379374709  |
                               |       | +4.27%    | +0.32%    | +2.11%             | +3.20%             | -63.85%            | <not defined>
  redis_large_112_LRANGE_500   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 20009.64  | 22382.88  | 21281.039999999997 | 21232.28           | 945.9369798881954  |
  (B) 84f99e060a66             | 5     | 21256.83  | 22582.08  | 22141.614          | 22271.86           | 471.52600961558824 |
                               |       | +6.23%    | +0.89%    | +4.04%             | +4.90%             | -50.15%            | <not defined>
  redis_large_112_LRANGE_600   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 15732.15  | 17724.53  | 16962.964          | 17026.55           | 738.9997225872282  |
  (B) 84f99e060a66             | 5     | 17638.86  | 18001.54  | 17813.78           | 17760.41           | 132.1847308882529  |
                               |       | +12.12%   | +1.56%    | +5.02%             | +4.31%             | -82.11%            | <not defined>
  redis_large_112_MSET_10      |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 69913.45  | 83562.44  | 75068.09           | 73061.49           | 4699.897939789759  |
  (B) 84f99e060a66             | 5     | 82621.41  | 86909.67  | 85500.666          | 86207.64           | 1513.6861191224532 |
                               |       | +18.18%   | +4.01%    | +13.90%            | +17.99%            | -67.79%            | <not defined>
  redis_large_112_PING_BULK    |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 76210.8   | 91588.52  | 81885.012          | 76924.86           | 6672.886753669362  |
  (B) 84f99e060a66             | 5     | 97981.58  | 104706.56 | 102659.61          | 103046.04          | 2454.010128585455  |
                               |       | +28.57%   | +14.32%   | +25.37%            | +33.96%            | -63.22%            | <not defined>
  redis_large_112_PING_INLINE  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 85209.36  | 95981.27  | 88791.15199999999  | 87157.36           | 3883.6930501026986 |
  (B) 84f99e060a66             | 5     | 84930.74  | 100740.45 | 91988.232          | 94507.24           | 6083.486538712485  |
                               |       | -0.33%    | +4.96%    | +3.60%             | +8.43%             | +56.64%            | <not defined>
  redis_large_112_SADD         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 87508.2   | 100579.34 | 96678.14           | 98047.87           | 4697.426045455105  |
  (B) 84f99e060a66             | 5     | 95320.71  | 109097.65 | 104946.528         | 107563.89          | 5187.759965481825  |
                               |       | +8.93%    | +8.47%    | +8.55%             | +9.71%             | +10.44%            | <not defined>
  redis_large_112_SET          |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 83984.21  | 88511.24  | 87263.608          | 88101.07           | 1681.5648135162658 |
  (B) 84f99e060a66             | 5     | 91495.49  | 108322.41 | 103931.492         | 107452.93          | 6323.713351904558  |
                               |       | +8.94%    | +22.38%   | +19.10%            | +21.97%            | +276.06%           | <not defined>
  redis_large_112_SPOP         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 75318.22  | 101266.85 | 90612.204          | 99986              | 12424.38900873697  |
  (B) 84f99e060a66             | 5     | 91482.94  | 108124.48 | 104229.332         | 107524.57          | 6411.221696748284  |
                               |       | +21.46%   | +6.77%    | +15.03%            | +7.54%             | -48.40%            | <not defined>
  redis_large_max_GET          |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 86121.52  | 97641.95  | 89782.828          | 87288.98           | 4211.594426691152  |
  (B) 84f99e060a66             | 5     | 81245.33  | 106947.3  | 99600.116          | 103938.22          | 9595.9089538086    |
                               |       | -5.66%    | +9.53%    | +10.93%            | +19.07%            | +127.85%           | + is good
  redis_large_max_INCR         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 83982.8   | 99338.41  | 91855.92199999999  | 91971.79           | 4859.882740146716  |
  (B) 84f99e060a66             | 5     | 94742.73  | 107902.8  | 102147.482         | 103681.74          | 5328.512361773783  |
                               |       | +12.81%   | +8.62%    | +11.20%            | +12.73%            | +9.64%             | + is good
  redis_large_max_LPOP         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 77050.51  | 103915.53 | 91193.33           | 90605.98           | 8760.399742863337  |
  (B) 84f99e060a66             | 5     | 102777.04 | 106855.88 | 105447.25          | 105883.97          | 1508.874453186883  |
                               |       | +33.39%   | +2.83%    | +15.63%            | +16.86%            | -82.78%            | + is good
  redis_large_max_LPUSH        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 10    | 76444.42  | 105362.97 | 91002.66000000002  | 91349.625          | 8440.749480048564  |
  (B) 84f99e060a66             | 10    | 92986.93  | 108131.48 | 103406.56999999999 | 105310.51500000001 | 5454.677779080998  |
                               |       | +21.64%   | +2.63%    | +13.63%            | +15.28%            | -35.38%            | + is good
  redis_large_max_LRANGE_100   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 63462.25  | 67180.82  | 65070.407999999996 | 64373.27           | 1328.4272375768319 |
  (B) 84f99e060a66             | 5     | 66256.32  | 67993.45  | 67324.19           | 67227.34           | 637.2648417730207  |
                               |       | +4.40%    | +1.21%    | +3.46%             | +4.43%             | -52.03%            | + is good
  redis_large_max_LRANGE_300   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 28794.13  | 30684.35  | 29872.71           | 29611.64           | 720.4084873181326  |
  (B) 84f99e060a66             | 5     | 30024.98  | 30781.64  | 30501.838          | 30559.27           | 260.3957379374709  |
                               |       | +4.27%    | +0.32%    | +2.11%             | +3.20%             | -63.85%            | + is good
  redis_large_max_LRANGE_500   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 20009.64  | 22382.88  | 21281.039999999997 | 21232.28           | 945.9369798881954  |
  (B) 84f99e060a66             | 5     | 21256.83  | 22582.08  | 22141.614          | 22271.86           | 471.52600961558824 |
                               |       | +6.23%    | +0.89%    | +4.04%             | +4.90%             | -50.15%            | + is good
  redis_large_max_LRANGE_600   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 15732.15  | 17724.53  | 16962.964          | 17026.55           | 738.9997225872282  |
  (B) 84f99e060a66             | 5     | 17638.86  | 18001.54  | 17813.78           | 17760.41           | 132.1847308882529  |
                               |       | +12.12%   | +1.56%    | +5.02%             | +4.31%             | -82.11%            | + is good
  redis_large_max_MSET_10      |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 69913.45  | 83562.44  | 75068.09           | 73061.49           | 4699.897939789759  |
  (B) 84f99e060a66             | 5     | 82621.41  | 86909.67  | 85500.666          | 86207.64           | 1513.6861191224532 |
                               |       | +18.18%   | +4.01%    | +13.90%            | +17.99%            | -67.79%            | + is good
  redis_large_max_PING_BULK    |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 76210.8   | 91588.52  | 81885.012          | 76924.86           | 6672.886753669362  |
  (B) 84f99e060a66             | 5     | 97981.58  | 104706.56 | 102659.61          | 103046.04          | 2454.010128585455  |
                               |       | +28.57%   | +14.32%   | +25.37%            | +33.96%            | -63.22%            | + is good
  redis_large_max_PING_INLINE  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 85209.36  | 95981.27  | 88791.15199999999  | 87157.36           | 3883.6930501026986 |
  (B) 84f99e060a66             | 5     | 84930.74  | 100740.45 | 91988.232          | 94507.24           | 6083.486538712485  |
                               |       | -0.33%    | +4.96%    | +3.60%             | +8.43%             | +56.64%            | + is good
  redis_large_max_SADD         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 87508.2   | 100579.34 | 96678.14           | 98047.87           | 4697.426045455105  |
  (B) 84f99e060a66             | 5     | 95320.71  | 109097.65 | 104946.528         | 107563.89          | 5187.759965481825  |
                               |       | +8.93%    | +8.47%    | +8.55%             | +9.71%             | +10.44%            | + is good
  redis_large_max_SET          |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 83984.21  | 88511.24  | 87263.608          | 88101.07           | 1681.5648135162658 |
  (B) 84f99e060a66             | 5     | 91495.49  | 108322.41 | 103931.492         | 107452.93          | 6323.713351904558  |
                               |       | +8.94%    | +22.38%   | +19.10%            | +21.97%            | +276.06%           | + is good
  redis_large_max_SPOP         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 75318.22  | 101266.85 | 90612.204          | 99986              | 12424.38900873697  |
  (B) 84f99e060a66             | 5     | 91482.94  | 108124.48 | 104229.332         | 107524.57          | 6411.221696748284  |
                               |       | +21.46%   | +6.77%    | +15.03%            | +7.54%             | -48.40%            | + is good
  redis_medium_112_GET         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71464.3   | 105296.41 | 98298.09           | 104887.77          | 13418.040732782114 |
  (B) 84f99e060a66             | 5     | 71037.87  | 105764.15 | 88069.89799999999  | 86184.61           | 15326.191434544195 |
                               |       | -0.60%    | +0.44%    | -10.41%            | -17.83%            | +14.22%            | <not defined>
  redis_medium_112_INCR        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 89952.33  | 106894.71 | 102742.21399999999 | 105374.08          | 6425.891039034509  |
  (B) 84f99e060a66             | 5     | 72035.73  | 108530.5  | 91255.438          | 97238.42           | 16017.995235722103 |
                               |       | -19.92%   | +1.53%    | -11.18%            | -7.72%             | +149.27%           | <not defined>
  redis_medium_112_LPOP        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 70546.73  | 106202.2  | 98540.89600000001  | 105563.19          | 14009.409711759596 |
  (B) 84f99e060a66             | 5     | 99800.4   | 106281.22 | 104831.92599999999 | 106112.05          | 2520.25111201722   |
                               |       | +41.47%   | +0.07%    | +6.38%             | +0.52%             | -82.01%            | <not defined>
  redis_medium_112_LPUSH       |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 10    | 70596.54  | 109253.8  | 102989.75099999999 | 106360.395         | 10868.068935072552 |
  (B) 84f99e060a66             | 10    | 67317.41  | 107284.62 | 99283.43799999998  | 106264.28          | 14661.570625569964 |
                               |       | -4.64%    | -1.80%    | -3.60%             | -0.09%             | +34.91%            | <not defined>
  redis_medium_112_LRANGE_100  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 67344.6   | 69536.2   | 68463.45199999999  | 68535.4            | 852.3302381213465  |
  (B) 84f99e060a66             | 5     | 66827.05  | 69237.7   | 68027.628          | 68157.03           | 811.0692465480314  |
                               |       | -0.77%    | -0.43%    | -0.64%             | -0.55%             | -4.84%             | <not defined>
  redis_medium_112_LRANGE_300  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 30814.74  | 31701.75  | 31275.802          | 31251.95           | 349.8131587805122  |
  (B) 84f99e060a66             | 5     | 30562.35  | 31373.53  | 31060.512000000002 | 31065.55           | 298.0781213306358  |
                               |       | -0.82%    | -1.04%    | -0.69%             | -0.60%             | -14.79%            | <not defined>
  redis_medium_112_LRANGE_500  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 22397.92  | 23195.94  | 22846.742000000002 | 22862.89           | 264.14444346985744 |
  (B) 84f99e060a66             | 5     | 22414.99  | 23173.9   | 22770.994          | 22789.43           | 259.2454181350172  |
                               |       | +0.08%    | -0.10%    | -0.33%             | -0.32%             | -1.85%             | <not defined>
  redis_medium_112_LRANGE_600  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 17964.61  | 18386.75  | 18159.345999999998 | 18146.19           | 145.55850653259614 |
  (B) 84f99e060a66             | 5     | 17892.93  | 18372.22  | 18151.72           | 18141.91           | 158.25971072891696 |
                               |       | -0.40%    | -0.08%    | -0.04%             | -0.02%             | +8.73%             | <not defined>
  redis_medium_112_MSET_10     |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 82891.24  | 93764.65  | 90304.758          | 91224.23           | 3859.0309716476713 |
  (B) 84f99e060a66             | 5     | 82569.56  | 92498.38  | 87018.09199999999  | 88550.43           | 3799.8862641158103 |
                               |       | -0.39%    | -1.35%    | -3.64%             | -2.93%             | -1.53%             | <not defined>
  redis_medium_112_PING_BULK   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 70866.7   | 105719.42 | 88936.732          | 86625.09           | 14234.524281637798 |
  (B) 84f99e060a66             | 5     | 70656.4   | 82149.02  | 75741.51999999999  | 76091.91           | 4234.288704918454  |
                               |       | -0.30%    | -22.30%   | -14.84%            | -12.16%            | -70.25%            | <not defined>
  redis_medium_112_PING_INLINE |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 79164.03  | 101245.32 | 93598.43000000001  | 97924.02           | 8205.051511289863  |
  (B) 84f99e060a66             | 5     | 82054.65  | 101936.8  | 91002.572          | 86782.96           | 8258.393592532146  |
                               |       | +3.65%    | +0.68%    | -2.77%             | -11.38%            | +0.65%             | <not defined>
  redis_medium_112_SADD        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71204.79  | 108873.16 | 99893.516          | 106202.2           | 14385.239455086732 |
  (B) 84f99e060a66             | 5     | 107066.38 | 108577.63 | 107833.04000000001 | 107805.09          | 506.20947272843495 |
                               |       | +50.36%   | -0.27%    | +7.95%             | +1.51%             | -96.48%            | <not defined>
  redis_medium_112_SET         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71078.26  | 107169.65 | 98957.382          | 106803.38          | 14032.888516120123 |
  (B) 84f99e060a66             | 5     | 71128.81  | 106746.37 | 84412.32400000001  | 78814.63           | 13971.086249029599 |
                               |       | +0.07%    | -0.39%    | -14.70%            | -26.21%            | -0.44%             | <not defined>
  redis_medium_112_SPOP        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 90555.1   | 108108.11 | 103639.896         | 106849.02          | 6593.160307380974  |
  (B) 84f99e060a66             | 5     | 79706.68  | 108601.21 | 100128.342         | 106168.39          | 10971.534908081734 |
                               |       | -11.98%   | +0.46%    | -3.39%             | -0.64%             | +66.41%            | <not defined>
  redis_medium_max_GET         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71464.3   | 105296.41 | 98298.09           | 104887.77          | 13418.040732782114 |
  (B) 84f99e060a66             | 5     | 71037.87  | 105764.15 | 88069.89799999999  | 86184.61           | 15326.191434544195 |
                               |       | -0.60%    | +0.44%    | -10.41%            | -17.83%            | +14.22%            | + is good
  redis_medium_max_INCR        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 89952.33  | 106894.71 | 102742.21399999999 | 105374.08          | 6425.891039034509  |
  (B) 84f99e060a66             | 5     | 72035.73  | 108530.5  | 91255.438          | 97238.42           | 16017.995235722103 |
                               |       | -19.92%   | +1.53%    | -11.18%            | -7.72%             | +149.27%           | + is good
  redis_medium_max_LPOP        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 70546.73  | 106202.2  | 98540.89600000001  | 105563.19          | 14009.409711759596 |
  (B) 84f99e060a66             | 5     | 99800.4   | 106281.22 | 104831.92599999999 | 106112.05          | 2520.25111201722   |
                               |       | +41.47%   | +0.07%    | +6.38%             | +0.52%             | -82.01%            | + is good
  redis_medium_max_LPUSH       |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 10    | 70596.54  | 109253.8  | 102989.75099999999 | 106360.395         | 10868.068935072552 |
  (B) 84f99e060a66             | 10    | 67317.41  | 107284.62 | 99283.43799999998  | 106264.28          | 14661.570625569964 |
                               |       | -4.64%    | -1.80%    | -3.60%             | -0.09%             | +34.91%            | + is good
  redis_medium_max_LRANGE_100  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 67344.6   | 69536.2   | 68463.45199999999  | 68535.4            | 852.3302381213465  |
  (B) 84f99e060a66             | 5     | 66827.05  | 69237.7   | 68027.628          | 68157.03           | 811.0692465480314  |
                               |       | -0.77%    | -0.43%    | -0.64%             | -0.55%             | -4.84%             | + is good
  redis_medium_max_LRANGE_300  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 30814.74  | 31701.75  | 31275.802          | 31251.95           | 349.8131587805122  |
  (B) 84f99e060a66             | 5     | 30562.35  | 31373.53  | 31060.512000000002 | 31065.55           | 298.0781213306358  |
                               |       | -0.82%    | -1.04%    | -0.69%             | -0.60%             | -14.79%            | + is good
  redis_medium_max_LRANGE_500  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 22397.92  | 23195.94  | 22846.742000000002 | 22862.89           | 264.14444346985744 |
  (B) 84f99e060a66             | 5     | 22414.99  | 23173.9   | 22770.994          | 22789.43           | 259.2454181350172  |
                               |       | +0.08%    | -0.10%    | -0.33%             | -0.32%             | -1.85%             | + is good
  redis_medium_max_LRANGE_600  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 17964.61  | 18386.75  | 18159.345999999998 | 18146.19           | 145.55850653259614 |
  (B) 84f99e060a66             | 5     | 17892.93  | 18372.22  | 18151.72           | 18141.91           | 158.25971072891696 |
                               |       | -0.40%    | -0.08%    | -0.04%             | -0.02%             | +8.73%             | + is good
  redis_medium_max_MSET_10     |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 82891.24  | 93764.65  | 90304.758          | 91224.23           | 3859.0309716476713 |
  (B) 84f99e060a66             | 5     | 82569.56  | 92498.38  | 87018.09199999999  | 88550.43           | 3799.8862641158103 |
                               |       | -0.39%    | -1.35%    | -3.64%             | -2.93%             | -1.53%             | + is good
  redis_medium_max_PING_BULK   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 70866.7   | 105719.42 | 88936.732          | 86625.09           | 14234.524281637798 |
  (B) 84f99e060a66             | 5     | 70656.4   | 82149.02  | 75741.51999999999  | 76091.91           | 4234.288704918454  |
                               |       | -0.30%    | -22.30%   | -14.84%            | -12.16%            | -70.25%            | + is good
  redis_medium_max_PING_INLINE |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 79164.03  | 101245.32 | 93598.43000000001  | 97924.02           | 8205.051511289863  |
  (B) 84f99e060a66             | 5     | 82054.65  | 101936.8  | 91002.572          | 86782.96           | 8258.393592532146  |
                               |       | +3.65%    | +0.68%    | -2.77%             | -11.38%            | +0.65%             | + is good
  redis_medium_max_SADD        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71204.79  | 108873.16 | 99893.516          | 106202.2           | 14385.239455086732 |
  (B) 84f99e060a66             | 5     | 107066.38 | 108577.63 | 107833.04000000001 | 107805.09          | 506.20947272843495 |
                               |       | +50.36%   | -0.27%    | +7.95%             | +1.51%             | -96.48%            | + is good
  redis_medium_max_SET         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71078.26  | 107169.65 | 98957.382          | 106803.38          | 14032.888516120123 |
  (B) 84f99e060a66             | 5     | 71128.81  | 106746.37 | 84412.32400000001  | 78814.63           | 13971.086249029599 |
                               |       | +0.07%    | -0.39%    | -14.70%            | -26.21%            | -0.44%             | + is good
  redis_medium_max_SPOP        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 90555.1   | 108108.11 | 103639.896         | 106849.02          | 6593.160307380974  |
  (B) 84f99e060a66             | 5     | 79706.68  | 108601.21 | 100128.342         | 106168.39          | 10971.534908081734 |
                               |       | -11.98%   | +0.46%    | -3.39%             | -0.64%             | +66.41%            | + is good
  redis_small_112_GET          |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71942.45  | 99009.9   | 92823.784          | 97847.36           | 10459.059890851764 |
  (B) 84f99e060a66             | 5     | 97656.24  | 103199.18 | 99421.75399999999  | 99009.9            | 1965.130453416262  |
                               |       | +35.74%   | +4.23%    | +7.11%             | +1.19%             | -81.21%            | <not defined>
  redis_small_112_INCR         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71428.57  | 100502.52 | 94127.908          | 99403.58           | 11357.9112414764   |
  (B) 84f99e060a66             | 5     | 99502.48  | 105263.16 | 101133.712         | 100300.91          | 2088.725085858836  |
                               |       | +39.30%   | +4.74%    | +7.44%             | +0.90%             | -81.61%            | <not defined>
  redis_small_112_LPOP         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 67430.88  | 97465.88  | 80725.542          | 71377.59           | 13650.5478862138   |
  (B) 84f99e060a66             | 5     | 97370.98  | 103519.66 | 99722.42199999999  | 99206.34           | 2051.336756560467  |
                               |       | +44.40%   | +6.21%    | +23.53%            | +38.99%            | -84.97%            | <not defined>
  redis_small_112_LPUSH        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 10    | 71275.84  | 98039.22  | 84531.177          | 82620.555          | 11398.639723914474 |
  (B) 84f99e060a66             | 10    | 71275.84  | 102880.66 | 95015.00399999999  | 98961.13           | 10393.818308459315 |
                               |       | +0.00%    | +4.94%    | +12.40%            | +19.78%            | -8.82%             | <not defined>
  redis_small_112_LRANGE_100   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 52521.01  | 68166.33  | 60484.19           | 64516.13           | 6610.609484164073  |
  (B) 84f99e060a66             | 5     | 52631.58  | 67796.61  | 60568.95           | 64808.82           | 6536.080283922469  |
                               |       | +0.21%    | -0.54%    | +0.14%             | +0.45%             | -1.13%             | <not defined>
  redis_small_112_LRANGE_300   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 27693.16  | 31152.65  | 29220.967999999997 | 29568.3            | 1266.5903558356993 |
  (B) 84f99e060a66             | 5     | 27964.21  | 30892.8   | 29287.316          | 29726.52           | 1136.400625212782  |
                               |       | +0.98%    | -0.83%    | +0.23%             | +0.54%             | -10.28%            | <not defined>
  redis_small_112_LRANGE_500   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 20964.36  | 22872.83  | 21715.272          | 21588.95           | 642.6844450397102  |
  (B) 84f99e060a66             | 5     | 21043.77  | 22670.6   | 21761.058          | 21881.84           | 561.3368975365854  |
                               |       | +0.38%    | -0.88%    | +0.21%             | +1.36%             | -12.66%            | <not defined>
  redis_small_112_LRANGE_600   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 17424.64  | 18532.25  | 17707.992          | 17537.71           | 416.9294510777572  |
  (B) 84f99e060a66             | 5     | 17325.02  | 18315.02  | 17634.145999999997 | 17488.63           | 350.3809420388055  |
                               |       | -0.57%    | -1.17%    | -0.42%             | -0.28%             | -15.96%            | <not defined>
  redis_small_112_MSET_10      |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71022.73  | 102564.1  | 89180.122          | 99403.58           | 14342.618805543705 |
  (B) 84f99e060a66             | 5     | 71377.59  | 104166.67 | 90567.052          | 98039.22           | 12918.439933028136 |
                               |       | +0.50%    | +1.56%    | +1.56%             | -1.37%             | -9.93%             | <not defined>
  redis_small_112_PING_BULK    |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 86058.52  | 98231.83  | 94980.186          | 96993.21           | 4506.456414144485  |
  (B) 84f99e060a66             | 5     | 88417.33  | 97656.24  | 95486.45           | 97087.38           | 3546.8647583238903 |
                               |       | +2.74%    | -0.59%    | +0.53%             | +0.10%             | -21.29%            | <not defined>
  redis_small_112_PING_INLINE  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 98039.22  | 100200.4  | 98800.73599999999  | 98716.68           | 774.7318891487538  |
  (B) 84f99e060a66             | 5     | 91074.68  | 100603.62 | 97840.432          | 99108.03           | 3437.0745702553527 |
                               |       | -7.10%    | +0.40%    | -0.97%             | +0.40%             | +343.65%           | <not defined>
  redis_small_112_SADD         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 66711.14  | 98425.2   | 81154.564          | 71326.68           | 14081.393480563775 |
  (B) 84f99e060a66             | 5     | 99403.58  | 105042.02 | 101136.232         | 99900.09           | 2141.9583192153873 |
                               |       | +49.01%   | +6.72%    | +24.62%            | +40.06%            | -84.79%            | <not defined>
  redis_small_112_SET          |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 72358.9   | 99800.4   | 93916.536          | 99009.9            | 10782.800109525542 |
  (B) 84f99e060a66             | 5     | 99403.58  | 105485.23 | 101242.73          | 100200.4           | 2246.7532169955816 |
                               |       | +37.38%   | +5.70%    | +7.80%             | +1.20%             | -79.16%            | <not defined>
  redis_small_112_SPOP         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 67385.45  | 99900.09  | 81554.86600000001  | 71581.96           | 14338.592272095051 |
  (B) 84f99e060a66             | 5     | 71890.73  | 104275.29 | 94837.97600000001  | 99601.6            | 11640.699220503204 |
                               |       | +6.69%    | +4.38%    | +16.29%            | +39.14%            | -18.82%            | <not defined>
  redis_small_max_GET          |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71942.45  | 99009.9   | 92823.784          | 97847.36           | 10459.059890851764 |
  (B) 84f99e060a66             | 5     | 97656.24  | 103199.18 | 99421.75399999999  | 99009.9            | 1965.130453416262  |
                               |       | +35.74%   | +4.23%    | +7.11%             | +1.19%             | -81.21%            | + is good
  redis_small_max_INCR         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71428.57  | 100502.52 | 94127.908          | 99403.58           | 11357.9112414764   |
  (B) 84f99e060a66             | 5     | 99502.48  | 105263.16 | 101133.712         | 100300.91          | 2088.725085858836  |
                               |       | +39.30%   | +4.74%    | +7.44%             | +0.90%             | -81.61%            | + is good
  redis_small_max_LPOP         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 67430.88  | 97465.88  | 80725.542          | 71377.59           | 13650.5478862138   |
  (B) 84f99e060a66             | 5     | 97370.98  | 103519.66 | 99722.42199999999  | 99206.34           | 2051.336756560467  |
                               |       | +44.40%   | +6.21%    | +23.53%            | +38.99%            | -84.97%            | + is good
  redis_small_max_LPUSH        |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 10    | 71275.84  | 98039.22  | 84531.177          | 82620.555          | 11398.639723914474 |
  (B) 84f99e060a66             | 10    | 71275.84  | 102880.66 | 95015.00399999999  | 98961.13           | 10393.818308459315 |
                               |       | +0.00%    | +4.94%    | +12.40%            | +19.78%            | -8.82%             | + is good
  redis_small_max_LRANGE_100   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 52521.01  | 68166.33  | 60484.19           | 64516.13           | 6610.609484164073  |
  (B) 84f99e060a66             | 5     | 52631.58  | 67796.61  | 60568.95           | 64808.82           | 6536.080283922469  |
                               |       | +0.21%    | -0.54%    | +0.14%             | +0.45%             | -1.13%             | + is good
  redis_small_max_LRANGE_300   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 27693.16  | 31152.65  | 29220.967999999997 | 29568.3            | 1266.5903558356993 |
  (B) 84f99e060a66             | 5     | 27964.21  | 30892.8   | 29287.316          | 29726.52           | 1136.400625212782  |
                               |       | +0.98%    | -0.83%    | +0.23%             | +0.54%             | -10.28%            | + is good
  redis_small_max_LRANGE_500   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 20964.36  | 22872.83  | 21715.272          | 21588.95           | 642.6844450397102  |
  (B) 84f99e060a66             | 5     | 21043.77  | 22670.6   | 21761.058          | 21881.84           | 561.3368975365854  |
                               |       | +0.38%    | -0.88%    | +0.21%             | +1.36%             | -12.66%            | + is good
  redis_small_max_LRANGE_600   |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 17424.64  | 18532.25  | 17707.992          | 17537.71           | 416.9294510777572  |
  (B) 84f99e060a66             | 5     | 17325.02  | 18315.02  | 17634.145999999997 | 17488.63           | 350.3809420388055  |
                               |       | -0.57%    | -1.17%    | -0.42%             | -0.28%             | -15.96%            | + is good
  redis_small_max_MSET_10      |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 71022.73  | 102564.1  | 89180.122          | 99403.58           | 14342.618805543705 |
  (B) 84f99e060a66             | 5     | 71377.59  | 104166.67 | 90567.052          | 98039.22           | 12918.439933028136 |
                               |       | +0.50%    | +1.56%    | +1.56%             | -1.37%             | -9.93%             | + is good
  redis_small_max_PING_BULK    |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 86058.52  | 98231.83  | 94980.186          | 96993.21           | 4506.456414144485  |
  (B) 84f99e060a66             | 5     | 88417.33  | 97656.24  | 95486.45           | 97087.38           | 3546.8647583238903 |
                               |       | +2.74%    | -0.59%    | +0.53%             | +0.10%             | -21.29%            | + is good
  redis_small_max_PING_INLINE  |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 98039.22  | 100200.4  | 98800.73599999999  | 98716.68           | 774.7318891487538  |
  (B) 84f99e060a66             | 5     | 91074.68  | 100603.62 | 97840.432          | 99108.03           | 3437.0745702553527 |
                               |       | -7.10%    | +0.40%    | -0.97%             | +0.40%             | +343.65%           | + is good
  redis_small_max_SADD         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 66711.14  | 98425.2   | 81154.564          | 71326.68           | 14081.393480563775 |
  (B) 84f99e060a66             | 5     | 99403.58  | 105042.02 | 101136.232         | 99900.09           | 2141.9583192153873 |
                               |       | +49.01%   | +6.72%    | +24.62%            | +40.06%            | -84.79%            | + is good
  redis_small_max_SET          |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 72358.9   | 99800.4   | 93916.536          | 99009.9            | 10782.800109525542 |
  (B) 84f99e060a66             | 5     | 99403.58  | 105485.23 | 101242.73          | 100200.4           | 2246.7532169955816 |
                               |       | +37.38%   | +5.70%    | +7.80%             | +1.20%             | -79.16%            | + is good
  redis_small_max_SPOP         |       |           |           |                    |                    |                    |
  (A) 4db0b9c9d0f3             | 5     | 67385.45  | 99900.09  | 81554.86600000001  | 71581.96           | 14338.592272095051 |
  (B) 84f99e060a66             | 5     | 71890.73  | 104275.29 | 94837.97600000001  | 99601.6            | 11640.699220503204 |
                               |       | +6.69%    | +4.38%    | +16.29%            | +39.14%            | -18.82%            | + is good

[*] BENCHMARK
Name: stream
Description: The STREAM benchmark is a simple synthetic benchmark
program that measures sustainable memory bandwidth (in MB/s) and the
corresponding computation rate for simple vector kernels.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 112
  machine_total_physical_cores | 56
  machine_total_ram_gib        | 384

[*] METRICS
              LABEL             | COUNT |   MIN    |   MAX    |        MEAN        |  MEDIAN  |       STDDEV       |   DIRECTION
--------------------------------+-------+----------+----------+--------------------+----------+--------------------+----------------
  stream_omp_llcs_add           |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 22535.34 | 22843.54 | 22692.140000000003 | 22697.54 | 125.88004872364232 |
  (B) 84f99e060a66              | 3     | 22575.5  | 22817.18 | 22708.606666666667 | 22733.14 | 100.1789030795518  |
                                |       | +0.18%   | -0.12%   | +0.07%             | +0.16%   | -20.42%            | + is good
  stream_omp_llcs_cale          |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 21177.26 | 21481.86 | 21343.32           | 21370.84 | 125.86580896600515 |
  (B) 84f99e060a66              | 3     | 21181.64 | 21482.28 | 21363.833333333332 | 21427.58 | 130.75124099687224 |
                                |       | +0.02%   | +0.00%   | +0.10%             | +0.27%   | +3.88%             | <not defined>
  stream_omp_llcs_copy          |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 21672.48 | 21970.32 | 21848.106666666667 | 21901.52 | 127.32348443586098 |
  (B) 84f99e060a66              | 3     | 21729.34 | 21947.58 | 21859.36666666667  | 21901.18 | 93.87381790941001  |
                                |       | +0.26%   | -0.10%   | +0.05%             | -0.00%   | -26.27%            | + is good
  stream_omp_llcs_spread_add    |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 23957.28 | 24110.2  | 24008.460000000003 | 23957.9  | 71.94148918855313  |
  (B) 84f99e060a66              | 3     | 24048.46 | 24176.1  | 24122.753333333334 | 24143.7  | 54.17296086507334  |
                                |       | +0.38%   | +0.27%   | +0.48%             | +0.78%   | -24.70%            | + is good
  stream_omp_llcs_spread_cale   |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 22520.3  | 22686.48 | 22588.213333333333 | 22557.86 | 71.15683023356871  |
  (B) 84f99e060a66              | 3     | 22492.22 | 22590.84 | 22527.266666666666 | 22498.74 | 45.0318711827762   |
                                |       | -0.12%   | -0.42%   | -0.27%             | -0.26%   | -36.71%            | <not defined>
  stream_omp_llcs_spread_copy   |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 22939.62 | 23205.3  | 23077.006666666664 | 23086.1  | 108.65382991664622 |
  (B) 84f99e060a66              | 3     | 22990.68 | 23027.42 | 23006.306666666667 | 23000.82 | 15.492676406037758 |
                                |       | +0.22%   | -0.77%   | -0.31%             | -0.37%   | -85.74%            | + is good
  stream_omp_llcs_spread_triad  |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 23893.94 | 24038.62 | 23981.6            | 24012.24 | 62.91360637148918  |
  (B) 84f99e060a66              | 3     | 24101.42 | 24109.2  | 24105.993333333332 | 24107.36 | 3.3199330649230476 |
                                |       | +0.87%   | +0.29%   | +0.52%             | +0.40%   | -94.72%            | + is good
  stream_omp_llcs_triad         |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 22481.2  | 22847.08 | 22687.286666666667 | 22733.58 | 152.91467802521686 |
  (B) 84f99e060a66              | 3     | 22552.6  | 22847.1  | 22726.29333333333  | 22779.18 | 125.91084711899201 |
                                |       | +0.32%   | +0.00%   | +0.17%             | +0.20%   | -17.66%            | + is good
  stream_omp_nodes_add          |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 43473.82 | 44035.92 | 43819.69333333333  | 43949.34 | 247.11036148966852 |
  (B) 84f99e060a66              | 3     | 43966.06 | 44021.64 | 43988.86666666666  | 43978.9  | 23.75969883834887  |
                                |       | +1.13%   | -0.03%   | +0.39%             | +0.07%   | -90.38%            | + is good
  stream_omp_nodes_cale         |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 41266.66 | 41827.52 | 41541.420000000006 | 41530.08 | 229.11049968664912 |
  (B) 84f99e060a66              | 3     | 41509.96 | 41809.12 | 41676.520000000004 | 41710.48 | 124.46990961674327 |
                                |       | +0.59%   | -0.04%   | +0.33%             | +0.43%   | -45.67%            | <not defined>
  stream_omp_nodes_copy         |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 42152.32 | 42453.44 | 42340.46           | 42415.62 | 133.92804734881528 |
  (B) 84f99e060a66              | 3     | 42313.68 | 42651.36 | 42475.193333333336 | 42460.54 | 138.2461228710901  |
                                |       | +0.38%   | +0.47%   | +0.32%             | +0.11%   | +3.22%             | + is good
  stream_omp_nodes_spread_add   |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 46556.3  | 46572.58 | 46565.64           | 46568.04 | 6.8595237929947395 |
  (B) 84f99e060a66              | 3     | 46590.1  | 46628.86 | 46613.94666666666  | 46622.88 | 17.037952406972313 |
                                |       | +0.07%   | +0.12%   | +0.10%             | +0.12%   | +148.38%           | + is good
  stream_omp_nodes_spread_cale  |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 43479.12 | 43572.42 | 43516.58666666666  | 43498.22 | 40.24279093480293  |
  (B) 84f99e060a66              | 3     | 43421.88 | 43708.9  | 43519.96666666667  | 43429.12 | 133.628733769684   |
                                |       | -0.13%   | +0.31%   | +0.01%             | -0.16%   | +232.06%           | <not defined>
  stream_omp_nodes_spread_copy  |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 44680.66 | 44813.96 | 44766.71333333333  | 44805.52 | 60.94637278423656  |
  (B) 84f99e060a66              | 3     | 44484.82 | 44774.08 | 44597.08666666667  | 44532.36 | 126.64910299283304 |
                                |       | -0.44%   | -0.09%   | -0.38%             | -0.61%   | +107.80%           | + is good
  stream_omp_nodes_spread_triad |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 46425.72 | 46524.82 | 46476.62           | 46479.32 | 40.50242791076154  |
  (B) 84f99e060a66              | 3     | 46525.12 | 46829.82 | 46693.26666666667  | 46724.86 | 126.38334946590818 |
                                |       | +0.21%   | +0.66%   | +0.47%             | +0.53%   | +212.04%           | + is good
  stream_omp_nodes_triad        |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 43550.7  | 43982.02 | 43810.44666666666  | 43898.62 | 186.79781963990425 |
  (B) 84f99e060a66              | 3     | 43898.6  | 44159.54 | 44019.7            | 44000.96 | 107.34931019806498 |
                                |       | +0.80%   | +0.40%   | +0.48%             | +0.23%   | -42.53%            | + is good
  stream_single_add             |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 11777.74 | 11914.54 | 11832.186666666666 | 11804.28 | 59.232010114652255 |
  (B) 84f99e060a66              | 3     | 11607.02 | 12019.86 | 11824.220000000001 | 11845.78 | 169.22931503337858 |
                                |       | -1.45%   | +0.88%   | -0.07%             | +0.35%   | +185.71%           | + is good
  stream_single_cale            |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 11108.2  | 11173.12 | 11133.539999999999 | 11119.3  | 28.3517759584829   |
  (B) 84f99e060a66              | 3     | 10884.56 | 11234.86 | 11068.66           | 11086.56 | 143.56840413777255 |
                                |       | -2.01%   | +0.55%   | -0.58%             | -0.29%   | +406.38%           | <not defined>
  stream_single_copy            |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 11396.58 | 11485.98 | 11436.106666666667 | 11425.76 | 37.2234704931653   |
  (B) 84f99e060a66              | 3     | 11125.68 | 11495.18 | 11329.753333333334 | 11368.4  | 153.30304657406094 |
                                |       | -2.38%   | +0.08%   | -0.93%             | -0.50%   | +311.85%           | + is good
  stream_single_triad           |       |          |          |                    |          |                    |
  (A) 4db0b9c9d0f3              | 3     | 11780.48 | 11898.12 | 11827.6            | 11804.2  | 50.79673480320089  |
  (B) 84f99e060a66              | 3     | 11586.2  | 12035.82 | 11835.193333333335 | 11883.56 | 186.71553574592673 |
                                |       | -1.65%   | +1.16%   | +0.06%             | +0.67%   | +267.57%           | + is good

[*] BENCHMARK
Name: sysbenchthread
Description: Sysbench is a suite of microbenchmarks. This runs the
thread microbench which has threads loop on a lock, yield, unlock. It
is considered to be of questionable value given its vunerability to
load balancing and sched_yield decisions.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 256
  machine_total_physical_cores | 128
  machine_total_ram_gib        | 1024

[*] METRICS
        LABEL        | COUNT |  MIN   |  MAX   |        MEAN        | MEDIAN |        STDDEV        |   DIRECTION
---------------------+-------+--------+--------+--------------------+--------+----------------------+----------------
  sysbenchthread_1   |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.71   | 2.76   | 2.742857142857143  | 2.75   | 0.014846149779161799 |
  (B) 84f99e060a66   | 7     | 2.67   | 2.74   | 2.7128571428571426 | 2.71   | 0.022497165354319542 |
                     |       | -1.48% | -0.72% | -1.09%             | -1.45% | +51.54%              | <not defined>
  sysbenchthread_4   |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.74   | 2.79   | 2.7699999999999996 | 2.77   | 0.015118578920369087 |
  (B) 84f99e060a66   | 7     | 2.72   | 2.76   | 2.747142857142857  | 2.75   | 0.012777531299998568 |
                     |       | -0.73% | -1.08% | -0.83%             | -0.72% | -15.48%              | <not defined>
  sysbenchthread_7   |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.72   | 2.75   | 2.738571428571429  | 2.74   | 0.011248582677159752 |
  (B) 84f99e060a66   | 7     | 2.73   | 2.76   | 2.748571428571428  | 2.75   | 0.008329931278350345 |
                     |       | +0.37% | +0.36% | +0.37%             | +0.36% | -25.95%              | <not defined>
  sysbenchthread_12  |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.71   | 2.76   | 2.744285714285714  | 2.75   | 0.016781914463529526 |
  (B) 84f99e060a66   | 7     | 2.72   | 2.74   | 2.7271428571428573 | 2.73   | 0.006998542122237587 |
                     |       | +0.37% | -0.72% | -0.62%             | -0.73% | -58.30%              | <not defined>
  sysbenchthread_21  |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.73   | 2.79   | 2.7585714285714285 | 2.77   | 0.020995626366712965 |
  (B) 84f99e060a66   | 7     | 2.72   | 2.78   | 2.738571428571429  | 2.73   | 0.020995626366712813 |
                     |       | -0.37% | -0.36% | -0.73%             | -1.44% | -0.00%               | <not defined>
  sysbenchthread_30  |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.72   | 2.78   | 2.74               | 2.73   | 0.020701966780270524 |
  (B) 84f99e060a66   | 7     | 2.71   | 2.76   | 2.734285714285714  | 2.74   | 0.017612611437054292 |
                     |       | -0.37% | -0.72% | -0.21%             | +0.37% | -14.92%              | <not defined>
  sysbenchthread_48  |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.73   | 2.77   | 2.7528571428571427 | 2.76   | 0.014846149779161651 |
  (B) 84f99e060a66   | 7     | 2.73   | 2.76   | 2.742857142857143  | 2.74   | 0.010301575072754249 |
                     |       | +0.00% | -0.36% | -0.36%             | -0.72% | -30.61%              | <not defined>
  sysbenchthread_79  |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.7    | 2.76   | 2.7300000000000004 | 2.73   | 0.019999999999999945 |
  (B) 84f99e060a66   | 7     | 2.69   | 2.75   | 2.722857142857143  | 2.72   | 0.02249716535431943  |
                     |       | -0.37% | -0.36% | -0.26%             | -0.37% | +12.49%              | <not defined>
  sysbenchthread_110 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.72   | 2.76   | 2.742857142857143  | 2.74   | 0.013850513878332155 |
  (B) 84f99e060a66   | 7     | 2.72   | 2.75   | 2.73               | 2.73   | 0.010690449676496893 |
                     |       | +0.00% | -0.36% | -0.47%             | -0.36% | -22.82%              | <not defined>
  sysbenchthread_141 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.73   | 2.77   | 2.75               | 2.75   | 0.013093073414159504 |
  (B) 84f99e060a66   | 7     | 2.71   | 2.75   | 2.73               | 2.73   | 0.013093073414159578 |
                     |       | -0.73% | -0.72% | -0.73%             | -0.73% | +0.00%               | <not defined>
  sysbenchthread_172 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.73   | 2.76   | 2.7471428571428573 | 2.75   | 0.010301575072754037 |
  (B) 84f99e060a66   | 7     | 2.7    | 2.76   | 2.73               | 2.73   | 0.021380899352993758 |
                     |       | -1.10% | +0.00% | -0.62%             | -0.73% | +107.55%             | <not defined>
  sysbenchthread_203 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.74   | 2.82   | 2.7671428571428573 | 2.76   | 0.024327694808466156 |
  (B) 84f99e060a66   | 7     | 2.67   | 2.77   | 2.727142857142857  | 2.73   | 0.02864276807966222  |
                     |       | -2.55% | -1.77% | -1.45%             | -1.09% | +17.74%              | <not defined>
  sysbenchthread_234 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.74   | 2.78   | 2.7599999999999993 | 2.77   | 0.015118578920368945 |
  (B) 84f99e060a66   | 7     | 2.72   | 2.77   | 2.745714285714286  | 2.74   | 0.016781914463529463 |
                     |       | -0.73% | -0.36% | -0.52%             | -1.08% | +11.00%              | <not defined>
  sysbenchthread_265 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.73   | 2.79   | 2.76               | 2.76   | 0.023299294900428702 |
  (B) 84f99e060a66   | 7     | 2.71   | 2.77   | 2.737142857142857  | 2.73   | 0.019059520091608894 |
                     |       | -0.73% | -0.72% | -0.83%             | -1.09% | -18.20%              | <not defined>
  sysbenchthread_296 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.73   | 2.79   | 2.7514285714285713 | 2.74   | 0.01958758457257428  |
  (B) 84f99e060a66   | 7     | 2.72   | 2.75   | 2.735714285714286  | 2.74   | 0.00903507902905251  |
                     |       | -0.37% | -1.43% | -0.57%             | +0.00% | -53.87%              | <not defined>
  sysbenchthread_327 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.72   | 2.75   | 2.738571428571429  | 2.74   | 0.009897433186107772 |
  (B) 84f99e060a66   | 7     | 2.71   | 2.77   | 2.7357142857142858 | 2.74   | 0.017612611437054282 |
                     |       | -0.37% | +0.73% | -0.10%             | +0.00% | +77.95%              | <not defined>
  sysbenchthread_358 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.74   | 2.79   | 2.7614285714285716 | 2.76   | 0.016413036132965755 |
  (B) 84f99e060a66   | 7     | 2.71   | 2.76   | 2.7399999999999998 | 2.74   | 0.015118578920369066 |
                     |       | -1.09% | -1.08% | -0.78%             | -0.72% | -7.89%               | <not defined>
  sysbenchthread_389 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.73   | 2.76   | 2.744285714285714  | 2.74   | 0.011780301787479    |
  (B) 84f99e060a66   | 7     | 2.71   | 2.73   | 2.724285714285714  | 2.73   | 0.009035079029052493 |
                     |       | -0.73% | -1.09% | -0.73%             | -0.36% | -23.30%              | <not defined>
  sysbenchthread_420 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.74   | 2.79   | 2.76               | 2.76   | 0.017728105208558324 |
  (B) 84f99e060a66   | 7     | 2.7    | 2.77   | 2.73               | 2.72   | 0.0239045721866878   |
                     |       | -1.46% | -0.72% | -1.09%             | -1.45% | +34.84%              | <not defined>
  sysbenchthread_451 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.72   | 2.77   | 2.7457142857142856 | 2.75   | 0.018405855323892807 |
  (B) 84f99e060a66   | 7     | 2.7    | 2.74   | 2.72               | 2.72   | 0.014142135623731006 |
                     |       | -0.74% | -1.08% | -0.94%             | -1.09% | -23.17%              | <not defined>
  sysbenchthread_482 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.71   | 2.8    | 2.742857142857143  | 2.74   | 0.028139593719417412 |
  (B) 84f99e060a66   | 7     | 2.69   | 2.75   | 2.727142857142857  | 2.73   | 0.02050385727772484  |
                     |       | -0.74% | -1.79% | -0.57%             | -0.36% | -27.14%              | <not defined>
  sysbenchthread_512 |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.7    | 2.75   | 2.7399999999999998 | 2.75   | 0.01690308509457031  |
  (B) 84f99e060a66   | 7     | 2.71   | 2.75   | 2.7285714285714286 | 2.73   | 0.01245399698154476  |
                     |       | +0.37% | +0.00% | -0.42%             | -0.73% | -26.32%              | <not defined>
  sysbenchthread_max |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.7    | 2.75   | 2.7399999999999998 | 2.75   | 0.01690308509457031  |
  (B) 84f99e060a66   | 7     | 2.71   | 2.75   | 2.7285714285714286 | 2.73   | 0.01245399698154476  |
                     |       | +0.37% | +0.00% | -0.42%             | -0.73% | -26.32%              | - is good
  sysbenchthread_min |       |        |        |                    |        |                      |
  (A) 4db0b9c9d0f3   | 7     | 2.71   | 2.76   | 2.742857142857143  | 2.75   | 0.014846149779161799 |
  (B) 84f99e060a66   | 7     | 2.67   | 2.74   | 2.7128571428571426 | 2.71   | 0.022497165354319542 |
                     |       | -1.48% | -0.72% | -1.09%             | -1.45% | +51.54%              | <not defined>

[*] BENCHMARK
Name: tpcc_spark
Description: spark sql drived by tpcc.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 256
  machine_total_physical_cores | 128
  machine_total_ram_gib        | 1024

[*] METRICS
           LABEL           | COUNT |  MIN   |  MAX   |  MEAN  | MEDIAN | STDDEV | DIRECTION
---------------------------+-------+--------+--------+--------+--------+--------+------------
  geo_mean_of_running_time |       |        |        |        |        |        |
  (A) 4db0b9c9d0f3         | 1     | 196.95 | 196.95 | 196.95 | 196.95 | 0      |
  (B) 84f99e060a66         | 1     | 194.48 | 194.48 | 194.48 | 194.48 | 0      |
                           |       | -1.25% | -1.25% | -1.25% | -1.25% | ---    | - is good

[*] BENCHMARK
Name: unixbench
Description: UnixBench is the original BYTE UNIX benchmark suite,
updated and revised by many people over the years. The purpose of
UnixBench is to provide a basic indicator of the performance of a
Unix-like system; hence, multiple tests are used to test various
aspects of the system's performance. These test results are then
compared to the scores from a baseline system to produce an index
value, which is generally easier to handle than the raw scores. The
entire set of index values is then combined to make an overall index
for the system.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 112
  machine_total_physical_cores | 56
  machine_total_ram_gib        | 384

[*] METRICS
            LABEL            | COUNT |      MIN       |      MAX       |          MEAN          |     MEDIAN     |       STDDEV       |   DIRECTION
-----------------------------+-------+----------------+----------------+------------------------+----------------+--------------------+----------------
  unixbench_dhry2reg_1       |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 4.34865736e+07 | 4.39381302e+07 | 4.360061844e+07        | 4.35072825e+07 | 170784.08300336136 |
  (B) 84f99e060a66           | 5     | 4.30655821e+07 | 4.41854107e+07 | 4.3621910260000005e+07 | 4.34371903e+07 | 417733.3283639879  |
                             |       | -0.97%         | +0.56%         | +0.05%                 | -0.16%         | +144.60%           | <not defined>
  unixbench_dhry2reg_lbr_1   |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 4.27938746e+07 | 4.36690393e+07 | 4.316068858e+07        | 4.30693911e+07 | 331395.00245936995 |
  (B) 84f99e060a66           | 5     | 4.27925274e+07 | 4.35598498e+07 | 4.3150110199999996e+07 | 4.31818175e+07 | 285228.20294770785 |
                             |       | -0.00%         | -0.25%         | -0.02%                 | +0.26%         | -13.93%            | <not defined>
  unixbench_dhry2reg_lbr_max |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 4.27938746e+07 | 4.36690393e+07 | 4.316068858e+07        | 4.30693911e+07 | 331395.00245936995 |
  (B) 84f99e060a66           | 5     | 4.27925274e+07 | 4.35598498e+07 | 4.3150110199999996e+07 | 4.31818175e+07 | 285228.20294770785 |
                             |       | -0.00%         | -0.25%         | -0.02%                 | +0.26%         | -13.93%            | + is good
  unixbench_dhry2reg_max     |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 4.34865736e+07 | 4.39381302e+07 | 4.360061844e+07        | 4.35072825e+07 | 170784.08300336136 |
  (B) 84f99e060a66           | 5     | 4.30655821e+07 | 4.41854107e+07 | 4.3621910260000005e+07 | 4.34371903e+07 | 417733.3283639879  |
                             |       | -0.97%         | +0.56%         | +0.05%                 | -0.16%         | +144.60%           | + is good
  unixbench_execl_1          |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 4727.9         | 4792.1         | 4765.64                | 4768           | 21.35093440578216  |
  (B) 84f99e060a66           | 5     | 4723.7         | 4759.4         | 4742.96                | 4741.8         | 11.76343487251919  |
                             |       | -0.09%         | -0.68%         | -0.48%                 | -0.55%         | -44.90%            | <not defined>
  unixbench_execl_max        |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 4727.9         | 4792.1         | 4765.64                | 4768           | 21.35093440578216  |
  (B) 84f99e060a66           | 5     | 4723.7         | 4759.4         | 4742.96                | 4741.8         | 11.76343487251919  |
                             |       | -0.09%         | -0.68%         | -0.48%                 | -0.55%         | -44.90%            | + is good
  unixbench_pipe_1           |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 920680.7       | 937292         | 928936.9800000001      | 929920.6       | 6293.150348243733  |
  (B) 84f99e060a66           | 5     | 933339.5       | 945690.7       | 938268.84              | 937086.6       | 4363.416421383563  |
                             |       | +1.37%         | +0.90%         | +1.00%                 | +0.77%         | -30.66%            | <not defined>
  unixbench_pipe_max         |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 920680.7       | 937292         | 928936.9800000001      | 929920.6       | 6293.150348243733  |
  (B) 84f99e060a66           | 5     | 933339.5       | 945690.7       | 938268.84              | 937086.6       | 4363.416421383563  |
                             |       | +1.37%         | +0.90%         | +1.00%                 | +0.77%         | -30.66%            | + is good
  unixbench_spawn_1          |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 4387.2         | 4430.4         | 4409.04                | 4402.9         | 15.872315521057407 |
  (B) 84f99e060a66           | 5     | 4320           | 4426.7         | 4377.78                | 4398.3         | 43.46213984607764  |
                             |       | -1.53%         | -0.08%         | -0.71%                 | -0.10%         | +173.82%           | <not defined>
  unixbench_spawn_max        |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 4387.2         | 4430.4         | 4409.04                | 4402.9         | 15.872315521057407 |
  (B) 84f99e060a66           | 5     | 4320           | 4426.7         | 4377.78                | 4398.3         | 43.46213984607764  |
                             |       | -1.53%         | -0.08%         | -0.71%                 | -0.10%         | +173.82%           | + is good
  unixbench_syscall_1        |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 478285         | 486881.9       | 484686.64              | 485948.1       | 3236.679989495396  |
  (B) 84f99e060a66           | 5     | 487976         | 495269.6       | 491429.3               | 491264.2       | 2527.8799022105263 |
                             |       | +2.03%         | +1.72%         | +1.39%                 | +1.09%         | -21.90%            | <not defined>
  unixbench_syscall_max      |       |                |                |                        |                |                    |
  (A) 4db0b9c9d0f3           | 5     | 478285         | 486881.9       | 484686.64              | 485948.1       | 3236.679989495396  |
  (B) 84f99e060a66           | 5     | 487976         | 495269.6       | 491429.3               | 491264.2       | 2527.8799022105263 |
                             |       | +2.03%         | +1.72%         | +1.39%                 | +1.09%         | -21.90%            | + is good

[*] BENCHMARK
Name: vm-scalability
Description: The motivation behind this suite is to exercise functions
and regions of Linux kernel mm/ which are of interest to us.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 112
  machine_total_physical_cores | 56
  machine_total_ram_gib        | 384

[*] METRICS
                 LABEL                 | COUNT |       MIN        |       MAX        |       MEAN        |      MEDIAN      |         STDDEV         | DIRECTION
---------------------------------------+-------+------------------+------------------+-------------------+------------------+------------------------+------------
  300s_128G_truncate_throughput        |       |                  |                  |                   |                  |                        |
  (A) 4db0b9c9d0f3                     | 5     | 3.1402485727e+10 | 3.3524240955e+10 | 3.23467699884e+10 | 3.2213360935e+10 | 6.990084677110682e+08  |
  (B) 84f99e060a66                     | 5     | 3.2437265981e+10 | 3.3540529674e+10 | 3.2928619191e+10  | 3.2833916458e+10 | 3.9777278144953775e+08 |
                                       |       | +3.30%           | +0.05%           | +1.80%            | +1.93%           | -43.09%                | + is good
  300s_512G_anon_wx_rand_mt_throughput |       |                  |                  |                   |                  |                        |
  (A) 4db0b9c9d0f3                     | 5     | 7.913872e+06     | 8.193942e+06     | 8.019662e+06      | 7.956032e+06     | 105183.50364196849     |
  (B) 84f99e060a66                     | 5     | 8.110757e+06     | 8.295155e+06     | 8.1804372e+06     | 8.156313e+06     | 62091.47716844879      |
                                       |       | +2.49%           | +1.24%           | +2.00%            | +2.52%           | -40.97%                | + is good

[*] BENCHMARK
Name: will-it-scale
Description: Will It Scale takes a testcase and runs it from 1 through
to n parallel copies to see if the testcase will scale. It builds both
a process and threads based test in order to see any differences
between the two.

[*] KERNELS
+-----------------+
| BASE KERNEL (A) |
+-----------------+
CommitId: 4db0b9c9d0f3ee84d954c94d7f48aeccc348b354
Describe: v5.16-rc7-12-g4db0b9c9d0f3

+-----------------+
| TEST KERNEL (B) |
+-----------------+
CommitId: 84f99e060a66b8ae5f1867e60f73e47a77a567aa
Describe: v5.16-rc7-22-g84f99e060a66

[*] TAGS
             LABEL             |                  VALUE
-------------------------------+-------------------------------------------
  machine_platform_arch        | X86_64
  machine_total_disks          | 0
  machine_total_logical_cores  | 112
  machine_total_physical_cores | 56
  machine_total_ram_gib        | 384

[*] METRICS
               LABEL               | COUNT |      MIN      |      MAX      |     MEAN      |    MEDIAN     | STDDEV | DIRECTION
-----------------------------------+-------+---------------+---------------+---------------+---------------+--------+------------
  brk1_per_process_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.182196e+06  | 1.182196e+06  | 1.182196e+06  | 1.182196e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.180751e+06  | 1.180751e+06  | 1.180751e+06  | 1.180751e+06  | 0      |
                                   |       | -0.12%        | -0.12%        | -0.12%        | -0.12%        | ---    | + is good
  brk1_per_thread_ops              |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 262491        | 262491        | 262491        | 262491        | 0      |
  (B) 84f99e060a66                 | 1     | 271219        | 271219        | 271219        | 271219        | 0      |
                                   |       | +3.33%        | +3.33%        | +3.33%        | +3.33%        | ---    | + is good
  brk1_scalability                 |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.110562      | 1.110562      | 1.110562      | 1.110562      | 0      |
  (B) 84f99e060a66                 | 1     | 1.118674      | 1.118674      | 1.118674      | 1.118674      | 0      |
                                   |       | +0.73%        | +0.73%        | +0.73%        | +0.73%        | ---    | + is good
  context_switch1_per_process_ops  |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 329041        | 329041        | 329041        | 329041        | 0      |
  (B) 84f99e060a66                 | 1     | 335598        | 335598        | 335598        | 335598        | 0      |
                                   |       | +1.99%        | +1.99%        | +1.99%        | +1.99%        | ---    | + is good
  context_switch1_per_thread_ops   |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 297899        | 297899        | 297899        | 297899        | 0      |
  (B) 84f99e060a66                 | 1     | 304690        | 304690        | 304690        | 304690        | 0      |
                                   |       | +2.28%        | +2.28%        | +2.28%        | +2.28%        | ---    | + is good
  context_switch1_scalability      |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.093104      | 1.093104      | 1.093104      | 1.093104      | 0      |
  (B) 84f99e060a66                 | 1     | 1.166822      | 1.166822      | 1.166822      | 1.166822      | 0      |
                                   |       | +6.74%        | +6.74%        | +6.74%        | +6.74%        | ---    | + is good
  dup1_per_process_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 914239        | 914239        | 914239        | 914239        | 0      |
  (B) 84f99e060a66                 | 1     | 916208        | 916208        | 916208        | 916208        | 0      |
                                   |       | +0.22%        | +0.22%        | +0.22%        | +0.22%        | ---    | + is good
  dup1_per_thread_ops              |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 319906        | 319906        | 319906        | 319906        | 0      |
  (B) 84f99e060a66                 | 1     | 313047        | 313047        | 313047        | 313047        | 0      |
                                   |       | -2.14%        | -2.14%        | -2.14%        | -2.14%        | ---    | + is good
  dup1_scalability                 |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.988697      | 0.988697      | 0.988697      | 0.988697      | 0      |
  (B) 84f99e060a66                 | 1     | 0.993808      | 0.993808      | 0.993808      | 0.993808      | 0      |
                                   |       | +0.52%        | +0.52%        | +0.52%        | +0.52%        | ---    | + is good
  eventfd1_per_process_ops         |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 883174        | 883174        | 883174        | 883174        | 0      |
  (B) 84f99e060a66                 | 1     | 884553        | 884553        | 884553        | 884553        | 0      |
                                   |       | +0.16%        | +0.16%        | +0.16%        | +0.16%        | ---    | + is good
  eventfd1_per_thread_ops          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 840497        | 840497        | 840497        | 840497        | 0      |
  (B) 84f99e060a66                 | 1     | 839392        | 839392        | 839392        | 839392        | 0      |
                                   |       | -0.13%        | -0.13%        | -0.13%        | -0.13%        | ---    | + is good
  eventfd1_scalability             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.984995      | 0.984995      | 0.984995      | 0.984995      | 0      |
  (B) 84f99e060a66                 | 1     | 0.992564      | 0.992564      | 0.992564      | 0.992564      | 0      |
                                   |       | +0.77%        | +0.77%        | +0.77%        | +0.77%        | ---    | + is good
  futex1_per_process_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.685172e+06  | 1.685172e+06  | 1.685172e+06  | 1.685172e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.690119e+06  | 1.690119e+06  | 1.690119e+06  | 1.690119e+06  | 0      |
                                   |       | +0.29%        | +0.29%        | +0.29%        | +0.29%        | ---    | + is good
  futex1_per_thread_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.682975e+06  | 1.682975e+06  | 1.682975e+06  | 1.682975e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.687864e+06  | 1.687864e+06  | 1.687864e+06  | 1.687864e+06  | 0      |
                                   |       | +0.29%        | +0.29%        | +0.29%        | +0.29%        | ---    | + is good
  futex1_scalability               |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.977692      | 0.977692      | 0.977692      | 0.977692      | 0      |
  (B) 84f99e060a66                 | 1     | 0.992208      | 0.992208      | 0.992208      | 0.992208      | 0      |
                                   |       | +1.48%        | +1.48%        | +1.48%        | +1.48%        | ---    | + is good
  futex2_per_process_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.477896e+06  | 1.477896e+06  | 1.477896e+06  | 1.477896e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.477849e+06  | 1.477849e+06  | 1.477849e+06  | 1.477849e+06  | 0      |
                                   |       | -0.00%        | -0.00%        | -0.00%        | -0.00%        | ---    | + is good
  futex2_per_thread_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.475865e+06  | 1.475865e+06  | 1.475865e+06  | 1.475865e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.472128e+06  | 1.472128e+06  | 1.472128e+06  | 1.472128e+06  | 0      |
                                   |       | -0.25%        | -0.25%        | -0.25%        | -0.25%        | ---    | + is good
  futex2_scalability               |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.987299      | 0.987299      | 0.987299      | 0.987299      | 0      |
  (B) 84f99e060a66                 | 1     | 0.998003      | 0.998003      | 0.998003      | 0.998003      | 0      |
                                   |       | +1.08%        | +1.08%        | +1.08%        | +1.08%        | ---    | + is good
  futex3_per_process_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.947335e+06  | 1.947335e+06  | 1.947335e+06  | 1.947335e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.947543e+06  | 1.947543e+06  | 1.947543e+06  | 1.947543e+06  | 0      |
                                   |       | +0.01%        | +0.01%        | +0.01%        | +0.01%        | ---    | + is good
  futex3_per_thread_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.94926e+06   | 1.94926e+06   | 1.94926e+06   | 1.94926e+06   | 0      |
  (B) 84f99e060a66                 | 1     | 1.943119e+06  | 1.943119e+06  | 1.943119e+06  | 1.943119e+06  | 0      |
                                   |       | -0.32%        | -0.32%        | -0.32%        | -0.32%        | ---    | + is good
  futex3_scalability               |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.98336       | 0.98336       | 0.98336       | 0.98336       | 0      |
  (B) 84f99e060a66                 | 1     | 0.993609      | 0.993609      | 0.993609      | 0.993609      | 0      |
                                   |       | +1.04%        | +1.04%        | +1.04%        | +1.04%        | ---    | + is good
  futex4_per_process_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.663509e+06  | 1.663509e+06  | 1.663509e+06  | 1.663509e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.661453e+06  | 1.661453e+06  | 1.661453e+06  | 1.661453e+06  | 0      |
                                   |       | -0.12%        | -0.12%        | -0.12%        | -0.12%        | ---    | + is good
  futex4_per_thread_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.663546e+06  | 1.663546e+06  | 1.663546e+06  | 1.663546e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.663659e+06  | 1.663659e+06  | 1.663659e+06  | 1.663659e+06  | 0      |
                                   |       | +0.01%        | +0.01%        | +0.01%        | +0.01%        | ---    | + is good
  futex4_scalability               |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.983372      | 0.983372      | 0.983372      | 0.983372      | 0      |
  (B) 84f99e060a66                 | 1     | 0.994158      | 0.994158      | 0.994158      | 0.994158      | 0      |
                                   |       | +1.10%        | +1.10%        | +1.10%        | +1.10%        | ---    | + is good
  getppid1_per_process_ops         |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 2.040868e+06  | 2.040868e+06  | 2.040868e+06  | 2.040868e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 2.036659e+06  | 2.036659e+06  | 2.036659e+06  | 2.036659e+06  | 0      |
                                   |       | -0.21%        | -0.21%        | -0.21%        | -0.21%        | ---    | + is good
  getppid1_per_thread_ops          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 2.037917e+06  | 2.037917e+06  | 2.037917e+06  | 2.037917e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 2.035906e+06  | 2.035906e+06  | 2.035906e+06  | 2.035906e+06  | 0      |
                                   |       | -0.10%        | -0.10%        | -0.10%        | -0.10%        | ---    | + is good
  getppid1_scalability             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.983373      | 0.983373      | 0.983373      | 0.983373      | 0      |
  (B) 84f99e060a66                 | 1     | 0.993657      | 0.993657      | 0.993657      | 0.993657      | 0      |
                                   |       | +1.05%        | +1.05%        | +1.05%        | +1.05%        | ---    | + is good
  lock1_per_process_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.110729e+06  | 1.110729e+06  | 1.110729e+06  | 1.110729e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.10133e+06   | 1.10133e+06   | 1.10133e+06   | 1.10133e+06   | 0      |
                                   |       | -0.85%        | -0.85%        | -0.85%        | -0.85%        | ---    | + is good
  lock1_per_thread_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 741007        | 741007        | 741007        | 741007        | 0      |
  (B) 84f99e060a66                 | 1     | 751044        | 751044        | 751044        | 751044        | 0      |
                                   |       | +1.35%        | +1.35%        | +1.35%        | +1.35%        | ---    | + is good
  lock1_scalability                |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.945011      | 0.945011      | 0.945011      | 0.945011      | 0      |
  (B) 84f99e060a66                 | 1     | 0.968271      | 0.968271      | 0.968271      | 0.968271      | 0      |
                                   |       | +2.46%        | +2.46%        | +2.46%        | +2.46%        | ---    | + is good
  lseek1_per_process_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 2.029997e+06  | 2.029997e+06  | 2.029997e+06  | 2.029997e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 2.029771e+06  | 2.029771e+06  | 2.029771e+06  | 2.029771e+06  | 0      |
                                   |       | -0.01%        | -0.01%        | -0.01%        | -0.01%        | ---    | + is good
  lseek1_per_thread_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.874244e+06  | 1.874244e+06  | 1.874244e+06  | 1.874244e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.877163e+06  | 1.877163e+06  | 1.877163e+06  | 1.877163e+06  | 0      |
                                   |       | +0.16%        | +0.16%        | +0.16%        | +0.16%        | ---    | + is good
  lseek1_scalability               |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.985154      | 0.985154      | 0.985154      | 0.985154      | 0      |
  (B) 84f99e060a66                 | 1     | 0.993361      | 0.993361      | 0.993361      | 0.993361      | 0      |
                                   |       | +0.83%        | +0.83%        | +0.83%        | +0.83%        | ---    | + is good
  lseek2_per_process_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 2.026038e+06  | 2.026038e+06  | 2.026038e+06  | 2.026038e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 2.022826e+06  | 2.022826e+06  | 2.022826e+06  | 2.022826e+06  | 0      |
                                   |       | -0.16%        | -0.16%        | -0.16%        | -0.16%        | ---    | + is good
  lseek2_per_thread_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.873717e+06  | 1.873717e+06  | 1.873717e+06  | 1.873717e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.872512e+06  | 1.872512e+06  | 1.872512e+06  | 1.872512e+06  | 0      |
                                   |       | -0.06%        | -0.06%        | -0.06%        | -0.06%        | ---    | + is good
  lseek2_scalability               |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.986396      | 0.986396      | 0.986396      | 0.986396      | 0      |
  (B) 84f99e060a66                 | 1     | 0.993642      | 0.993642      | 0.993642      | 0.993642      | 0      |
                                   |       | +0.73%        | +0.73%        | +0.73%        | +0.73%        | ---    | + is good
  malloc1_per_process_ops          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 97835         | 97835         | 97835         | 97835         | 0      |
  (B) 84f99e060a66                 | 1     | 98645         | 98645         | 98645         | 98645         | 0      |
                                   |       | +0.83%        | +0.83%        | +0.83%        | +0.83%        | ---    | + is good
  malloc1_per_thread_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 41808         | 41808         | 41808         | 41808         | 0      |
  (B) 84f99e060a66                 | 1     | 42333         | 42333         | 42333         | 42333         | 0      |
                                   |       | +1.26%        | +1.26%        | +1.26%        | +1.26%        | ---    | + is good
  malloc1_scalability              |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.306071      | 0.306071      | 0.306071      | 0.306071      | 0      |
  (B) 84f99e060a66                 | 1     | 0.311208      | 0.311208      | 0.311208      | 0.311208      | 0      |
                                   |       | +1.68%        | +1.68%        | +1.68%        | +1.68%        | ---    | + is good
  malloc2_per_process_ops          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 8.5964713e+07 | 8.5964713e+07 | 8.5964713e+07 | 8.5964713e+07 | 0      |
  (B) 84f99e060a66                 | 1     | 8.5729456e+07 | 8.5729456e+07 | 8.5729456e+07 | 8.5729456e+07 | 0      |
                                   |       | -0.27%        | -0.27%        | -0.27%        | -0.27%        | ---    | + is good
  malloc2_per_thread_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 8.5909382e+07 | 8.5909382e+07 | 8.5909382e+07 | 8.5909382e+07 | 0      |
  (B) 84f99e060a66                 | 1     | 8.5643483e+07 | 8.5643483e+07 | 8.5643483e+07 | 8.5643483e+07 | 0      |
                                   |       | -0.31%        | -0.31%        | -0.31%        | -0.31%        | ---    | + is good
  malloc2_scalability              |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.990744      | 0.990744      | 0.990744      | 0.990744      | 0      |
  (B) 84f99e060a66                 | 1     | 0.999912      | 0.999912      | 0.999912      | 0.999912      | 0      |
                                   |       | +0.93%        | +0.93%        | +0.93%        | +0.93%        | ---    | + is good
  mmap1_per_process_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 405846        | 405846        | 405846        | 405846        | 0      |
  (B) 84f99e060a66                 | 1     | 411130        | 411130        | 411130        | 411130        | 0      |
                                   |       | +1.30%        | +1.30%        | +1.30%        | +1.30%        | ---    | + is good
  mmap1_per_thread_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 123503        | 123503        | 123503        | 123503        | 0      |
  (B) 84f99e060a66                 | 1     | 127042        | 127042        | 127042        | 127042        | 0      |
                                   |       | +2.87%        | +2.87%        | +2.87%        | +2.87%        | ---    | + is good
  mmap1_scalability                |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.975408      | 0.975408      | 0.975408      | 0.975408      | 0      |
  (B) 84f99e060a66                 | 1     | 0.978192      | 0.978192      | 0.978192      | 0.978192      | 0      |
                                   |       | +0.29%        | +0.29%        | +0.29%        | +0.29%        | ---    | + is good
  mmap2_per_process_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 358352        | 358352        | 358352        | 358352        | 0      |
  (B) 84f99e060a66                 | 1     | 363506        | 363506        | 363506        | 363506        | 0      |
                                   |       | +1.44%        | +1.44%        | +1.44%        | +1.44%        | ---    | + is good
  mmap2_per_thread_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 110050        | 110050        | 110050        | 110050        | 0      |
  (B) 84f99e060a66                 | 1     | 113049        | 113049        | 113049        | 113049        | 0      |
                                   |       | +2.73%        | +2.73%        | +2.73%        | +2.73%        | ---    | + is good
  mmap2_scalability                |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.973879      | 0.973879      | 0.973879      | 0.973879      | 0      |
  (B) 84f99e060a66                 | 1     | 0.969964      | 0.969964      | 0.969964      | 0.969964      | 0      |
                                   |       | -0.40%        | -0.40%        | -0.40%        | -0.40%        | ---    | + is good
  open1_per_process_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 204637        | 204637        | 204637        | 204637        | 0      |
  (B) 84f99e060a66                 | 1     | 206390        | 206390        | 206390        | 206390        | 0      |
                                   |       | +0.86%        | +0.86%        | +0.86%        | +0.86%        | ---    | + is good
  open1_per_thread_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 182428        | 182428        | 182428        | 182428        | 0      |
  (B) 84f99e060a66                 | 1     | 184978        | 184978        | 184978        | 184978        | 0      |
                                   |       | +1.40%        | +1.40%        | +1.40%        | +1.40%        | ---    | + is good
  open1_scalability                |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.270073      | 0.270073      | 0.270073      | 0.270073      | 0      |
  (B) 84f99e060a66                 | 1     | 0.280171      | 0.280171      | 0.280171      | 0.280171      | 0      |
                                   |       | +3.74%        | +3.74%        | +3.74%        | +3.74%        | ---    | + is good
  open2_per_process_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 187624        | 187624        | 187624        | 187624        | 0      |
  (B) 84f99e060a66                 | 1     | 188959        | 188959        | 188959        | 188959        | 0      |
                                   |       | +0.71%        | +0.71%        | +0.71%        | +0.71%        | ---    | + is good
  open2_per_thread_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 175546        | 175546        | 175546        | 175546        | 0      |
  (B) 84f99e060a66                 | 1     | 178140        | 178140        | 178140        | 178140        | 0      |
                                   |       | +1.48%        | +1.48%        | +1.48%        | +1.48%        | ---    | + is good
  open2_scalability                |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.240907      | 0.240907      | 0.240907      | 0.240907      | 0      |
  (B) 84f99e060a66                 | 1     | 0.246053      | 0.246053      | 0.246053      | 0.246053      | 0      |
                                   |       | +2.14%        | +2.14%        | +2.14%        | +2.14%        | ---    | + is good
  page_fault1_per_process_ops      |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 296104        | 296104        | 296104        | 296104        | 0      |
  (B) 84f99e060a66                 | 1     | 293518        | 293518        | 293518        | 293518        | 0      |
                                   |       | -0.87%        | -0.87%        | -0.87%        | -0.87%        | ---    | + is good
  page_fault1_per_thread_ops       |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 245302        | 245302        | 245302        | 245302        | 0      |
  (B) 84f99e060a66                 | 1     | 239501        | 239501        | 239501        | 239501        | 0      |
                                   |       | -2.36%        | -2.36%        | -2.36%        | -2.36%        | ---    | + is good
  page_fault1_scalability          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.591157      | 0.591157      | 0.591157      | 0.591157      | 0      |
  (B) 84f99e060a66                 | 1     | 0.557408      | 0.557408      | 0.557408      | 0.557408      | 0      |
                                   |       | -5.71%        | -5.71%        | -5.71%        | -5.71%        | ---    | + is good
  page_fault2_per_process_ops      |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 263242        | 263242        | 263242        | 263242        | 0      |
  (B) 84f99e060a66                 | 1     | 265093        | 265093        | 265093        | 265093        | 0      |
                                   |       | +0.70%        | +0.70%        | +0.70%        | +0.70%        | ---    | + is good
  page_fault2_per_thread_ops       |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 209335        | 209335        | 209335        | 209335        | 0      |
  (B) 84f99e060a66                 | 1     | 204871        | 204871        | 204871        | 204871        | 0      |
                                   |       | -2.13%        | -2.13%        | -2.13%        | -2.13%        | ---    | + is good
  page_fault2_scalability          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.583137      | 0.583137      | 0.583137      | 0.583137      | 0      |
  (B) 84f99e060a66                 | 1     | 0.588389      | 0.588389      | 0.588389      | 0.588389      | 0      |
                                   |       | +0.90%        | +0.90%        | +0.90%        | +0.90%        | ---    | + is good
  page_fault3_per_process_ops      |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 649712        | 649712        | 649712        | 649712        | 0      |
  (B) 84f99e060a66                 | 1     | 652223        | 652223        | 652223        | 652223        | 0      |
                                   |       | +0.39%        | +0.39%        | +0.39%        | +0.39%        | ---    | + is good
  page_fault3_per_thread_ops       |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 490220        | 490220        | 490220        | 490220        | 0      |
  (B) 84f99e060a66                 | 1     | 497988        | 497988        | 497988        | 497988        | 0      |
                                   |       | +1.58%        | +1.58%        | +1.58%        | +1.58%        | ---    | + is good
  page_fault3_scalability          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.985479      | 0.985479      | 0.985479      | 0.985479      | 0      |
  (B) 84f99e060a66                 | 1     | 0.998238      | 0.998238      | 0.998238      | 0.998238      | 0      |
                                   |       | +1.29%        | +1.29%        | +1.29%        | +1.29%        | ---    | + is good
  pipe1_per_process_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 768258        | 768258        | 768258        | 768258        | 0      |
  (B) 84f99e060a66                 | 1     | 767503        | 767503        | 767503        | 767503        | 0      |
                                   |       | -0.10%        | -0.10%        | -0.10%        | -0.10%        | ---    | + is good
  pipe1_per_thread_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 735575        | 735575        | 735575        | 735575        | 0      |
  (B) 84f99e060a66                 | 1     | 734427        | 734427        | 734427        | 734427        | 0      |
                                   |       | -0.16%        | -0.16%        | -0.16%        | -0.16%        | ---    | + is good
  pipe1_scalability                |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.992941      | 0.992941      | 0.992941      | 0.992941      | 0      |
  (B) 84f99e060a66                 | 1     | 0.99995       | 0.99995       | 0.99995       | 0.99995       | 0      |
                                   |       | +0.71%        | +0.71%        | +0.71%        | +0.71%        | ---    | + is good
  poll1_per_process_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.704129e+06  | 1.704129e+06  | 1.704129e+06  | 1.704129e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.701779e+06  | 1.701779e+06  | 1.701779e+06  | 1.701779e+06  | 0      |
                                   |       | -0.14%        | -0.14%        | -0.14%        | -0.14%        | ---    | + is good
  poll1_per_thread_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.626484e+06  | 1.626484e+06  | 1.626484e+06  | 1.626484e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.625619e+06  | 1.625619e+06  | 1.625619e+06  | 1.625619e+06  | 0      |
                                   |       | -0.05%        | -0.05%        | -0.05%        | -0.05%        | ---    | + is good
  poll1_scalability                |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.98568       | 0.98568       | 0.98568       | 0.98568       | 0      |
  (B) 84f99e060a66                 | 1     | 0.993592      | 0.993592      | 0.993592      | 0.993592      | 0      |
                                   |       | +0.80%        | +0.80%        | +0.80%        | +0.80%        | ---    | + is good
  poll2_per_process_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 520641        | 520641        | 520641        | 520641        | 0      |
  (B) 84f99e060a66                 | 1     | 515893        | 515893        | 515893        | 515893        | 0      |
                                   |       | -0.91%        | -0.91%        | -0.91%        | -0.91%        | ---    | + is good
  poll2_per_thread_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 201450        | 201450        | 201450        | 201450        | 0      |
  (B) 84f99e060a66                 | 1     | 201523        | 201523        | 201523        | 201523        | 0      |
                                   |       | +0.04%        | +0.04%        | +0.04%        | +0.04%        | ---    | + is good
  poll2_scalability                |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.996518      | 0.996518      | 0.996518      | 0.996518      | 0      |
  (B) 84f99e060a66                 | 1     | 1.018321      | 1.018321      | 1.018321      | 1.018321      | 0      |
                                   |       | +2.19%        | +2.19%        | +2.19%        | +2.19%        | ---    | + is good
  posix_semaphore1_per_process_ops |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 4.16846e+07   | 4.16846e+07   | 4.16846e+07   | 4.16846e+07   | 0      |
  (B) 84f99e060a66                 | 1     | 4.153911e+07  | 4.153911e+07  | 4.153911e+07  | 4.153911e+07  | 0      |
                                   |       | -0.35%        | -0.35%        | -0.35%        | -0.35%        | ---    | + is good
  posix_semaphore1_per_thread_ops  |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 4.1673991e+07 | 4.1673991e+07 | 4.1673991e+07 | 4.1673991e+07 | 0      |
  (B) 84f99e060a66                 | 1     | 4.1539286e+07 | 4.1539286e+07 | 4.1539286e+07 | 4.1539286e+07 | 0      |
                                   |       | -0.32%        | -0.32%        | -0.32%        | -0.32%        | ---    | + is good
  posix_semaphore1_scalability     |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.990928      | 0.990928      | 0.990928      | 0.990928      | 0      |
  (B) 84f99e060a66                 | 1     | 0.998181      | 0.998181      | 0.998181      | 0.998181      | 0      |
                                   |       | +0.73%        | +0.73%        | +0.73%        | +0.73%        | ---    | + is good
  pread1_per_process_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 964152        | 964152        | 964152        | 964152        | 0      |
  (B) 84f99e060a66                 | 1     | 961951        | 961951        | 961951        | 961951        | 0      |
                                   |       | -0.23%        | -0.23%        | -0.23%        | -0.23%        | ---    | + is good
  pread1_per_thread_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 942991        | 942991        | 942991        | 942991        | 0      |
  (B) 84f99e060a66                 | 1     | 941389        | 941389        | 941389        | 941389        | 0      |
                                   |       | -0.17%        | -0.17%        | -0.17%        | -0.17%        | ---    | + is good
  pread1_scalability               |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.430538      | 0.430538      | 0.430538      | 0.430538      | 0      |
  (B) 84f99e060a66                 | 1     | 0.442705      | 0.442705      | 0.442705      | 0.442705      | 0      |
                                   |       | +2.83%        | +2.83%        | +2.83%        | +2.83%        | ---    | + is good
  pread2_per_process_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 461091        | 461091        | 461091        | 461091        | 0      |
  (B) 84f99e060a66                 | 1     | 469057        | 469057        | 469057        | 469057        | 0      |
                                   |       | +1.73%        | +1.73%        | +1.73%        | +1.73%        | ---    | + is good
  pread2_per_thread_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 458218        | 458218        | 458218        | 458218        | 0      |
  (B) 84f99e060a66                 | 1     | 462848        | 462848        | 462848        | 462848        | 0      |
                                   |       | +1.01%        | +1.01%        | +1.01%        | +1.01%        | ---    | + is good
  pread2_scalability               |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.072925      | 0.072925      | 0.072925      | 0.072925      | 0      |
  (B) 84f99e060a66                 | 1     | 0.074731      | 0.074731      | 0.074731      | 0.074731      | 0      |
                                   |       | +2.48%        | +2.48%        | +2.48%        | +2.48%        | ---    | + is good
  pread3_per_process_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 957692        | 957692        | 957692        | 957692        | 0      |
  (B) 84f99e060a66                 | 1     | 952552        | 952552        | 952552        | 952552        | 0      |
                                   |       | -0.54%        | -0.54%        | -0.54%        | -0.54%        | ---    | + is good
  pread3_per_thread_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 938537        | 938537        | 938537        | 938537        | 0      |
  (B) 84f99e060a66                 | 1     | 928731        | 928731        | 928731        | 928731        | 0      |
                                   |       | -1.04%        | -1.04%        | -1.04%        | -1.04%        | ---    | + is good
  pread3_scalability               |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.431635      | 0.431635      | 0.431635      | 0.431635      | 0      |
  (B) 84f99e060a66                 | 1     | 0.437535      | 0.437535      | 0.437535      | 0.437535      | 0      |
                                   |       | +1.37%        | +1.37%        | +1.37%        | +1.37%        | ---    | + is good
  pthread_mutex1_per_process_ops   |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 4.4554995e+07 | 4.4554995e+07 | 4.4554995e+07 | 4.4554995e+07 | 0      |
  (B) 84f99e060a66                 | 1     | 4.4471991e+07 | 4.4471991e+07 | 4.4471991e+07 | 4.4471991e+07 | 0      |
                                   |       | -0.19%        | -0.19%        | -0.19%        | -0.19%        | ---    | + is good
  pthread_mutex1_per_thread_ops    |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.0863168e+07 | 1.0863168e+07 | 1.0863168e+07 | 1.0863168e+07 | 0      |
  (B) 84f99e060a66                 | 1     | 1.0721714e+07 | 1.0721714e+07 | 1.0721714e+07 | 1.0721714e+07 | 0      |
                                   |       | -1.30%        | -1.30%        | -1.30%        | -1.30%        | ---    | + is good
  pthread_mutex1_scalability       |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.957534      | 0.957534      | 0.957534      | 0.957534      | 0      |
  (B) 84f99e060a66                 | 1     | 0.971139      | 0.971139      | 0.971139      | 0.971139      | 0      |
                                   |       | +1.42%        | +1.42%        | +1.42%        | +1.42%        | ---    | + is good
  pthread_mutex2_per_process_ops   |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 4.4283917e+07 | 4.4283917e+07 | 4.4283917e+07 | 4.4283917e+07 | 0      |
  (B) 84f99e060a66                 | 1     | 4.4068084e+07 | 4.4068084e+07 | 4.4068084e+07 | 4.4068084e+07 | 0      |
                                   |       | -0.49%        | -0.49%        | -0.49%        | -0.49%        | ---    | + is good
  pthread_mutex2_per_thread_ops    |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 4.5017533e+07 | 4.5017533e+07 | 4.5017533e+07 | 4.5017533e+07 | 0      |
  (B) 84f99e060a66                 | 1     | 4.4966205e+07 | 4.4966205e+07 | 4.4966205e+07 | 4.4966205e+07 | 0      |
                                   |       | -0.11%        | -0.11%        | -0.11%        | -0.11%        | ---    | + is good
  pthread_mutex2_scalability       |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.976762      | 0.976762      | 0.976762      | 0.976762      | 0      |
  (B) 84f99e060a66                 | 1     | 0.979919      | 0.979919      | 0.979919      | 0.979919      | 0      |
                                   |       | +0.32%        | +0.32%        | +0.32%        | +0.32%        | ---    | + is good
  pwrite1_per_process_ops          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 842395        | 842395        | 842395        | 842395        | 0      |
  (B) 84f99e060a66                 | 1     | 858472        | 858472        | 858472        | 858472        | 0      |
                                   |       | +1.91%        | +1.91%        | +1.91%        | +1.91%        | ---    | + is good
  pwrite1_per_thread_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 793710        | 793710        | 793710        | 793710        | 0      |
  (B) 84f99e060a66                 | 1     | 803656        | 803656        | 803656        | 803656        | 0      |
                                   |       | +1.25%        | +1.25%        | +1.25%        | +1.25%        | ---    | + is good
  pwrite1_scalability              |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.52403       | 0.52403       | 0.52403       | 0.52403       | 0      |
  (B) 84f99e060a66                 | 1     | 0.548598      | 0.548598      | 0.548598      | 0.548598      | 0      |
                                   |       | +4.69%        | +4.69%        | +4.69%        | +4.69%        | ---    | + is good
  pwrite2_per_process_ops          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 282885        | 282885        | 282885        | 282885        | 0      |
  (B) 84f99e060a66                 | 1     | 280819        | 280819        | 280819        | 280819        | 0      |
                                   |       | -0.73%        | -0.73%        | -0.73%        | -0.73%        | ---    | + is good
  pwrite2_per_thread_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 264000        | 264000        | 264000        | 264000        | 0      |
  (B) 84f99e060a66                 | 1     | 259404        | 259404        | 259404        | 259404        | 0      |
                                   |       | -1.74%        | -1.74%        | -1.74%        | -1.74%        | ---    | + is good
  pwrite2_scalability              |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.038412      | 0.038412      | 0.038412      | 0.038412      | 0      |
  (B) 84f99e060a66                 | 1     | 0.038888      | 0.038888      | 0.038888      | 0.038888      | 0      |
                                   |       | +1.24%        | +1.24%        | +1.24%        | +1.24%        | ---    | + is good
  pwrite3_per_process_ops          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 323618        | 323618        | 323618        | 323618        | 0      |
  (B) 84f99e060a66                 | 1     | 330871        | 330871        | 330871        | 330871        | 0      |
                                   |       | +2.24%        | +2.24%        | +2.24%        | +2.24%        | ---    | + is good
  pwrite3_per_thread_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 300116        | 300116        | 300116        | 300116        | 0      |
  (B) 84f99e060a66                 | 1     | 305806        | 305806        | 305806        | 305806        | 0      |
                                   |       | +1.90%        | +1.90%        | +1.90%        | +1.90%        | ---    | + is good
  pwrite3_scalability              |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.062845      | 0.062845      | 0.062845      | 0.062845      | 0      |
  (B) 84f99e060a66                 | 1     | 0.068264      | 0.068264      | 0.068264      | 0.068264      | 0      |
                                   |       | +8.62%        | +8.62%        | +8.62%        | +8.62%        | ---    | + is good
  read1_per_process_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 849497        | 849497        | 849497        | 849497        | 0      |
  (B) 84f99e060a66                 | 1     | 851557        | 851557        | 851557        | 851557        | 0      |
                                   |       | +0.24%        | +0.24%        | +0.24%        | +0.24%        | ---    | + is good
  read1_per_thread_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 825148        | 825148        | 825148        | 825148        | 0      |
  (B) 84f99e060a66                 | 1     | 825696        | 825696        | 825696        | 825696        | 0      |
                                   |       | +0.07%        | +0.07%        | +0.07%        | +0.07%        | ---    | + is good
  read1_scalability                |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.492216      | 0.492216      | 0.492216      | 0.492216      | 0      |
  (B) 84f99e060a66                 | 1     | 0.504087      | 0.504087      | 0.504087      | 0.504087      | 0      |
                                   |       | +2.41%        | +2.41%        | +2.41%        | +2.41%        | ---    | + is good
  read2_per_process_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 804636        | 804636        | 804636        | 804636        | 0      |
  (B) 84f99e060a66                 | 1     | 835800        | 835800        | 835800        | 835800        | 0      |
                                   |       | +3.87%        | +3.87%        | +3.87%        | +3.87%        | ---    | + is good
  read2_per_thread_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 782155        | 782155        | 782155        | 782155        | 0      |
  (B) 84f99e060a66                 | 1     | 813638        | 813638        | 813638        | 813638        | 0      |
                                   |       | +4.03%        | +4.03%        | +4.03%        | +4.03%        | ---    | + is good
  read2_scalability                |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.474276      | 0.474276      | 0.474276      | 0.474276      | 0      |
  (B) 84f99e060a66                 | 1     | 0.509206      | 0.509206      | 0.509206      | 0.509206      | 0      |
                                   |       | +7.36%        | +7.36%        | +7.36%        | +7.36%        | ---    | + is good
  readseek1_per_process_ops        |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 700211        | 700211        | 700211        | 700211        | 0      |
  (B) 84f99e060a66                 | 1     | 702424        | 702424        | 702424        | 702424        | 0      |
                                   |       | +0.32%        | +0.32%        | +0.32%        | +0.32%        | ---    | + is good
  readseek1_per_thread_ops         |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 666974        | 666974        | 666974        | 666974        | 0      |
  (B) 84f99e060a66                 | 1     | 669790        | 669790        | 669790        | 669790        | 0      |
                                   |       | +0.42%        | +0.42%        | +0.42%        | +0.42%        | ---    | + is good
  readseek1_scalability            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.709055      | 0.709055      | 0.709055      | 0.709055      | 0      |
  (B) 84f99e060a66                 | 1     | 0.723066      | 0.723066      | 0.723066      | 0.723066      | 0      |
                                   |       | +1.98%        | +1.98%        | +1.98%        | +1.98%        | ---    | + is good
  readseek2_per_process_ops        |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 359075        | 359075        | 359075        | 359075        | 0      |
  (B) 84f99e060a66                 | 1     | 362790        | 362790        | 362790        | 362790        | 0      |
                                   |       | +1.03%        | +1.03%        | +1.03%        | +1.03%        | ---    | + is good
  readseek2_per_thread_ops         |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 353384        | 353384        | 353384        | 353384        | 0      |
  (B) 84f99e060a66                 | 1     | 358400        | 358400        | 358400        | 358400        | 0      |
                                   |       | +1.42%        | +1.42%        | +1.42%        | +1.42%        | ---    | + is good
  readseek2_scalability            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.121419      | 0.121419      | 0.121419      | 0.121419      | 0      |
  (B) 84f99e060a66                 | 1     | 0.124333      | 0.124333      | 0.124333      | 0.124333      | 0      |
                                   |       | +2.40%        | +2.40%        | +2.40%        | +2.40%        | ---    | + is good
  readseek3_per_process_ops        |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 421886        | 421886        | 421886        | 421886        | 0      |
  (B) 84f99e060a66                 | 1     | 414691        | 414691        | 414691        | 414691        | 0      |
                                   |       | -1.71%        | -1.71%        | -1.71%        | -1.71%        | ---    | + is good
  readseek3_per_thread_ops         |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 400726        | 400726        | 400726        | 400726        | 0      |
  (B) 84f99e060a66                 | 1     | 397327        | 397327        | 397327        | 397327        | 0      |
                                   |       | -0.85%        | -0.85%        | -0.85%        | -0.85%        | ---    | + is good
  readseek3_scalability            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.195407      | 0.195407      | 0.195407      | 0.195407      | 0      |
  (B) 84f99e060a66                 | 1     | 0.20046       | 0.20046       | 0.20046       | 0.20046       | 0      |
                                   |       | +2.59%        | +2.59%        | +2.59%        | +2.59%        | ---    | + is good
  sched_yield_per_process_ops      |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.426126e+06  | 1.426126e+06  | 1.426126e+06  | 1.426126e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.428767e+06  | 1.428767e+06  | 1.428767e+06  | 1.428767e+06  | 0      |
                                   |       | +0.19%        | +0.19%        | +0.19%        | +0.19%        | ---    | + is good
  sched_yield_per_thread_ops       |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.356631e+06  | 1.356631e+06  | 1.356631e+06  | 1.356631e+06  | 0      |
  (B) 84f99e060a66                 | 1     | 1.357941e+06  | 1.357941e+06  | 1.357941e+06  | 1.357941e+06  | 0      |
                                   |       | +0.10%        | +0.10%        | +0.10%        | +0.10%        | ---    | + is good
  sched_yield_scalability          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 1.007993      | 1.007993      | 1.007993      | 1.007993      | 0      |
  (B) 84f99e060a66                 | 1     | 1.014633      | 1.014633      | 1.014633      | 1.014633      | 0      |
                                   |       | +0.66%        | +0.66%        | +0.66%        | +0.66%        | ---    | + is good
  signal1_per_process_ops          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 226669        | 226669        | 226669        | 226669        | 0      |
  (B) 84f99e060a66                 | 1     | 227201        | 227201        | 227201        | 227201        | 0      |
                                   |       | +0.23%        | +0.23%        | +0.23%        | +0.23%        | ---    | + is good
  signal1_per_thread_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 93562         | 93562         | 93562         | 93562         | 0      |
  (B) 84f99e060a66                 | 1     | 95743         | 95743         | 95743         | 95743         | 0      |
                                   |       | +2.33%        | +2.33%        | +2.33%        | +2.33%        | ---    | + is good
  signal1_scalability              |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.957449      | 0.957449      | 0.957449      | 0.957449      | 0      |
  (B) 84f99e060a66                 | 1     | 0.963292      | 0.963292      | 0.963292      | 0.963292      | 0      |
                                   |       | +0.61%        | +0.61%        | +0.61%        | +0.61%        | ---    | + is good
  unix1_per_process_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 522468        | 522468        | 522468        | 522468        | 0      |
  (B) 84f99e060a66                 | 1     | 530562        | 530562        | 530562        | 530562        | 0      |
                                   |       | +1.55%        | +1.55%        | +1.55%        | +1.55%        | ---    | + is good
  unix1_per_thread_ops             |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 510443        | 510443        | 510443        | 510443        | 0      |
  (B) 84f99e060a66                 | 1     | 518060        | 518060        | 518060        | 518060        | 0      |
                                   |       | +1.49%        | +1.49%        | +1.49%        | +1.49%        | ---    | + is good
  unix1_scalability                |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.979953      | 0.979953      | 0.979953      | 0.979953      | 0      |
  (B) 84f99e060a66                 | 1     | 0.959629      | 0.959629      | 0.959629      | 0.959629      | 0      |
                                   |       | -2.07%        | -2.07%        | -2.07%        | -2.07%        | ---    | + is good
  unlink1_per_process_ops          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 25502         | 25502         | 25502         | 25502         | 0      |
  (B) 84f99e060a66                 | 1     | 25657         | 25657         | 25657         | 25657         | 0      |
                                   |       | +0.61%        | +0.61%        | +0.61%        | +0.61%        | ---    | + is good
  unlink1_per_thread_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 25408         | 25408         | 25408         | 25408         | 0      |
  (B) 84f99e060a66                 | 1     | 25585         | 25585         | 25585         | 25585         | 0      |
                                   |       | +0.70%        | +0.70%        | +0.70%        | +0.70%        | ---    | + is good
  unlink1_scalability              |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.070072      | 0.070072      | 0.070072      | 0.070072      | 0      |
  (B) 84f99e060a66                 | 1     | 0.070865      | 0.070865      | 0.070865      | 0.070865      | 0      |
                                   |       | +1.13%        | +1.13%        | +1.13%        | +1.13%        | ---    | + is good
  unlink2_per_process_ops          |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 52050         | 52050         | 52050         | 52050         | 0      |
  (B) 84f99e060a66                 | 1     | 51677         | 51677         | 51677         | 51677         | 0      |
                                   |       | -0.72%        | -0.72%        | -0.72%        | -0.72%        | ---    | + is good
  unlink2_per_thread_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 51363         | 51363         | 51363         | 51363         | 0      |
  (B) 84f99e060a66                 | 1     | 51159         | 51159         | 51159         | 51159         | 0      |
                                   |       | -0.40%        | -0.40%        | -0.40%        | -0.40%        | ---    | + is good
  unlink2_scalability              |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.302468      | 0.302468      | 0.302468      | 0.302468      | 0      |
  (B) 84f99e060a66                 | 1     | 0.29703       | 0.29703       | 0.29703       | 0.29703       | 0      |
                                   |       | -1.80%        | -1.80%        | -1.80%        | -1.80%        | ---    | + is good
  write1_per_process_ops           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 770496        | 770496        | 770496        | 770496        | 0      |
  (B) 84f99e060a66                 | 1     | 762628        | 762628        | 762628        | 762628        | 0      |
                                   |       | -1.02%        | -1.02%        | -1.02%        | -1.02%        | ---    | + is good
  write1_per_thread_ops            |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 757006        | 757006        | 757006        | 757006        | 0      |
  (B) 84f99e060a66                 | 1     | 746414        | 746414        | 746414        | 746414        | 0      |
                                   |       | -1.40%        | -1.40%        | -1.40%        | -1.40%        | ---    | + is good
  write1_scalability               |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.602205      | 0.602205      | 0.602205      | 0.602205      | 0      |
  (B) 84f99e060a66                 | 1     | 0.596005      | 0.596005      | 0.596005      | 0.596005      | 0      |
                                   |       | -1.03%        | -1.03%        | -1.03%        | -1.03%        | ---    | + is good
  writeseek1_per_process_ops       |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 629967        | 629967        | 629967        | 629967        | 0      |
  (B) 84f99e060a66                 | 1     | 626663        | 626663        | 626663        | 626663        | 0      |
                                   |       | -0.52%        | -0.52%        | -0.52%        | -0.52%        | ---    | + is good
  writeseek1_per_thread_ops        |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 582490        | 582490        | 582490        | 582490        | 0      |
  (B) 84f99e060a66                 | 1     | 579400        | 579400        | 579400        | 579400        | 0      |
                                   |       | -0.53%        | -0.53%        | -0.53%        | -0.53%        | ---    | + is good
  writeseek1_scalability           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.785506      | 0.785506      | 0.785506      | 0.785506      | 0      |
  (B) 84f99e060a66                 | 1     | 0.800547      | 0.800547      | 0.800547      | 0.800547      | 0      |
                                   |       | +1.91%        | +1.91%        | +1.91%        | +1.91%        | ---    | + is good
  writeseek2_per_process_ops       |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 206887        | 206887        | 206887        | 206887        | 0      |
  (B) 84f99e060a66                 | 1     | 207179        | 207179        | 207179        | 207179        | 0      |
                                   |       | +0.14%        | +0.14%        | +0.14%        | +0.14%        | ---    | + is good
  writeseek2_per_thread_ops        |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 195575        | 195575        | 195575        | 195575        | 0      |
  (B) 84f99e060a66                 | 1     | 193851        | 193851        | 193851        | 193851        | 0      |
                                   |       | -0.88%        | -0.88%        | -0.88%        | -0.88%        | ---    | + is good
  writeseek2_scalability           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.057881      | 0.057881      | 0.057881      | 0.057881      | 0      |
  (B) 84f99e060a66                 | 1     | 0.060053      | 0.060053      | 0.060053      | 0.060053      | 0      |
                                   |       | +3.75%        | +3.75%        | +3.75%        | +3.75%        | ---    | + is good
  writeseek3_per_process_ops       |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 252163        | 252163        | 252163        | 252163        | 0      |
  (B) 84f99e060a66                 | 1     | 251815        | 251815        | 251815        | 251815        | 0      |
                                   |       | -0.14%        | -0.14%        | -0.14%        | -0.14%        | ---    | + is good
  writeseek3_per_thread_ops        |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 236912        | 236912        | 236912        | 236912        | 0      |
  (B) 84f99e060a66                 | 1     | 236544        | 236544        | 236544        | 236544        | 0      |
                                   |       | -0.16%        | -0.16%        | -0.16%        | -0.16%        | ---    | + is good
  writeseek3_scalability           |       |               |               |               |               |        |
  (A) 4db0b9c9d0f3                 | 1     | 0.098322      | 0.098322      | 0.098322      | 0.098322      | 0      |
  (B) 84f99e060a66                 | 1     | 0.090771      | 0.090771      | 0.090771      | 0.090771      | 0      |
                                   |       | -7.68%        | -7.68%        | -7.68%        | -7.68%        | ---    | + is good
