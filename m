Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3E597576
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbiHQR6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240967AbiHQR6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB5522531
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660759104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q8k/4HCcN/UGunNvTL0b69uKxOR1f4+pdK/Be6AO1Sw=;
        b=jVMQ7dm7vM5e9JNyTsYhsfLpzxaaRw7ZQLjECJXqBWYMoC7MDMnF1zLHk53UuhA9AbOS6s
        Dq3yvqVqnPsMQADYxY/aRUQyHkXzQ4oS86e/UaieTLAo6diYea0akYERwk5klip/gOsbBB
        CdLRiJ4rb5TbBJ9u7zeFZKLvCwXSI/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-111-k_CRi1ftMO6Rfb4ubfH-6g-1; Wed, 17 Aug 2022 13:58:23 -0400
X-MC-Unique: k_CRi1ftMO6Rfb4ubfH-6g-1
Received: by mail-wm1-f72.google.com with SMTP id b16-20020a05600c4e1000b003a5a47762c3so6579562wmq.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=q8k/4HCcN/UGunNvTL0b69uKxOR1f4+pdK/Be6AO1Sw=;
        b=2+tWIDAAdwc1rqZYyydvAYTn+CjJ9q94XoJj8fI6t0YR59QD1+7M1hdjlDPPu1ImSb
         VGe8gSC/1ZVeqsIPmYK62Yjw5dcD7VchLkUgrtm3TixrA1PbG3CzKdJsogxmZjBoEhOu
         kQnVqAL+w017zMHB3EjbGnIeDfPic9Q4z5CyKg47KzxgGY+8KOUSY7vyHKcptd/n1oYd
         vt6CT0f2KUJFoEmY2pQjRnWGOXEiMMTHKFXDfp2Yrew+khqAAv9KQMqRusFhnBsKTTx0
         W15jBEABGMLWL8NzNp1ZbusFbV6xADKKwhzbXF/l9kSJEULMdUhCbytPQnQUD8zzh48/
         yZVg==
X-Gm-Message-State: ACgBeo08HpKNNdRB77NhUPMy2YWhRF8j4sKEFZofkJamTUbnZzhJqi26
        8BHtZdsJ1W40luD1nHxDbzdEv7ihnj9lHmAUcjpKR5kqRi8yusxdDs5NUUME5qfvo+laSn17zli
        Zozjemedn6UrixChFRSj7ON7n
X-Received: by 2002:a05:6000:1188:b0:220:6c20:fbf6 with SMTP id g8-20020a056000118800b002206c20fbf6mr15410585wrx.372.1660759102411;
        Wed, 17 Aug 2022 10:58:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4g2Wjhx+/wnYjBzzOdcggBFY0lr0AV5E1fHOH4siQgevqHOcomt3rIJVSRvYt6p93UbxGJJQ==
X-Received: by 2002:a05:6000:1188:b0:220:6c20:fbf6 with SMTP id g8-20020a056000118800b002206c20fbf6mr15410561wrx.372.1660759102173;
        Wed, 17 Aug 2022 10:58:22 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003a541d893desm2809009wmq.38.2022.08.17.10.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:58:21 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH v2 0/5] sched, net: NUMA-aware CPU spreading interface
Date:   Wed, 17 Aug 2022 18:58:07 +0100
Message-Id: <20220817175812.671843-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Tariq pointed out in [1] that drivers allocating IRQ vectors would benefit
from having smarter NUMA-awareness (cpumask_local_spread() doesn't quite cut
it).

The proposed interface involved an array of CPUs and a temporary cpumask, and
being my difficult self what I'm proposing here is an interface that doesn't
require any temporary storage other than some stack variables (at the cost of
one wild macro).

Patch 5/5 is just there to showcase how the thing would be used. If this doesn't
get hated on, I'll let Tariq pick this up and push it with his networking driver
changes (with actual changelogs).

[1]: https://lore.kernel.org/all/20220728191203.4055-1-tariqt@nvidia.com/

Revisions
=========

v1 -> v2
++++++++

o Split _find_next_bit() @invert into @invert1 and @invert2 (Yury)
o Rebase onto v6.0-rc1

Cheers,
Valentin

Valentin Schneider (5):
  bitops: Introduce find_next_andnot_bit()
  cpumask: Introduce for_each_cpu_andnot()
  sched/topology: Introduce sched_numa_hop_mask()
  sched/topology: Introduce for_each_numa_hop_cpu()
  SHOWCASE: net/mlx5e: Leverage for_each_numa_hop_cpu()

 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 12 ++++-
 include/linux/cpumask.h                      | 38 ++++++++++++++++
 include/linux/find.h                         | 44 ++++++++++++++++---
 include/linux/topology.h                     | 46 ++++++++++++++++++++
 kernel/sched/topology.c                      | 28 ++++++++++++
 lib/find_bit.c                               | 23 +++++-----
 6 files changed, 172 insertions(+), 19 deletions(-)

--
2.31.1

