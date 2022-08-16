Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E4459620E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbiHPSKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbiHPSKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4756F28E12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660673347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5Cxl1yMNjN1JWkJUDea+B9kQSTSEbSpFhOYq99gTDk4=;
        b=QG/J4FxPHFUVAo/RXrelALh9O1cQ476t2BcgiOmHqkQg4o35CFBMgNanFOeS3tNb+guAUd
        CIH38R79cziATGWSR12g5GewrNK5rRtEUFbVVTNMYx9Mzd5PbPbawJby/8dDG6BVjwI2Sk
        JavOd3c0yZgQsAzczfEVMHeM5C6p7Bs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-tt4yDBeHNaO7FJrK3pY5jw-1; Tue, 16 Aug 2022 14:07:37 -0400
X-MC-Unique: tt4yDBeHNaO7FJrK3pY5jw-1
Received: by mail-wm1-f69.google.com with SMTP id v11-20020a1cf70b000000b003a318238826so2205115wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5Cxl1yMNjN1JWkJUDea+B9kQSTSEbSpFhOYq99gTDk4=;
        b=WMOBoq0ikO2MPBZ1pgGE/3oFC48DWZQpj7bcouvgEtS1WpXvbLlV8ByMzLIpVPaYzI
         SkoHIzYem9dhXYh0zU2mxsdBDnP+cHBOgEgTB3wZqWhLbKZGU2GLSNz69E0D8T3cFY7t
         9J1Sp6QCdVE7ROzcngjJXGrePVqP2qS15QT/dQlHepArikf82IYViBgi12JTfCXLJnLu
         QeZXR/95swuKNjGS3/dfAtxIXQ5axZoLZg9VJi3OeqV3RnPWkMDzjjD/CW+xFf94OvLx
         dP7ctgQUqTmVg/sORmGYgxcJlLYDy7w4s3yWabu05jPp0LTBoZXUhjHDL4ZNlL83UzuN
         99cQ==
X-Gm-Message-State: ACgBeo066tnFY+nlhP7wOPbOnXrhmXcTB8tOkQrfIfHnl9AhKUCzC78V
        6u228pJefI/vmyO9YEcnKggdgXaU40cIZ/Zi9otnl5dL0mhnPy1EJqYBPeELh9iJzCegN3fX3qY
        RerYiCS19MBZJjQzxEDpEpoX6
X-Received: by 2002:a5d:4912:0:b0:220:6633:104f with SMTP id x18-20020a5d4912000000b002206633104fmr12446500wrq.625.1660673256724;
        Tue, 16 Aug 2022 11:07:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6uR8z5D5D8T/gAXNcIujuyju0f7+AmovqCm4Vq6ys0+45zUiErhIRXXQQ3OhAWcNPgXMOXnw==
X-Received: by 2002:a5d:4912:0:b0:220:6633:104f with SMTP id x18-20020a5d4912000000b002206633104fmr12446491wrq.625.1660673256534;
        Tue, 16 Aug 2022 11:07:36 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b003a319bd3278sm14694961wmq.40.2022.08.16.11.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:07:36 -0700 (PDT)
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
Subject: [PATCH 0/5] cpumask, sched/topology: NUMA-aware CPU spreading interface
Date:   Tue, 16 Aug 2022 19:07:22 +0100
Message-Id: <20220816180727.387807-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

Cheers,
Valentin

Valentin Schneider (5):
  bitops: Introduce find_next_andnot_bit()
  cpumask: Introduce for_each_cpu_andnot()
  sched/topology: Introduce sched_numa_hop_mask()
  sched/topology: Introduce for_each_numa_hop_cpu()
  SHOWCASE: net/mlx5e: Leverage for_each_numa_hop_cpu()

 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 12 ++++-
 include/linux/cpumask.h                      | 32 ++++++++++++++
 include/linux/find.h                         | 44 ++++++++++++++++---
 include/linux/topology.h                     | 46 ++++++++++++++++++++
 kernel/sched/topology.c                      | 28 ++++++++++++
 lib/cpumask.c                                | 19 ++++++++
 lib/find_bit.c                               | 16 ++++---
 7 files changed, 184 insertions(+), 13 deletions(-)

--
2.31.1

