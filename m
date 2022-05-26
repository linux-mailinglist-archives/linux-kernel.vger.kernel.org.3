Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05C5534AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346073AbiEZHOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiEZHOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:14:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94613D11E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:14:14 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g184so701659pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7PWU9x3HAGLzVsSUAlMh3r4myWvEgoFD5Gz6eAqAjE=;
        b=LwCzxGaqjRTEB3lJ7R1qQ0cRLoDKTNTcMLfO9flKawGH1CRmaxuoBHWhRSBt2LWQ8q
         isgl6Fcnj3ENnoy+21aozo2qZ16jX5IhO3vuf3TqUj1jz6rvFfke6NR7hIrSvkLzWFvl
         aNttt00VWLAG0zhy8vrulgwgCMiJxd1qBNCUIdrddGZg/wDwCwb9YX1dBIgymgwlnZ79
         rabuxD4pOFnSLjW6LJXjfe00vT8CXXFsEPmXkyqmpKCYZIQYvomVgGSMYf51Q36x53S6
         tCawwreO6XR0rN/YcmV9YAzniXWbF9Et9GiVNIdF8s2+K+KpQ8eBp24VcdQvgnsB4zzU
         2PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C7PWU9x3HAGLzVsSUAlMh3r4myWvEgoFD5Gz6eAqAjE=;
        b=pjaG8KlxhGa0ygxrQBRyU346wnpzjHfJbvbIkZf1TQsxC/GgrP+SK1vECfa+DPtH1M
         +GXeNizI0awI6KZsvzTjnUdBjzgA10jalKEWPXRtiKy/l8TtPVss68efFLUuROEALS/F
         lB9qkCx73YpZKUENbx8RQk6xfMVSoaub5Z04u6vMXUdAfKzowYDt3lFqVi8r79sLwmPm
         e00nC+gCHflcsghNOW1IduZpWbolP0tAk+dafzOPy831WzOhEzpTtiYzv2nIcFDIa4F8
         982N3SAyZDBomhcnY8phVDy0Kz4tmvt8uF/l36/LevLBmIwgtYV+ZL/OzLRfxxZci7yB
         yMDQ==
X-Gm-Message-State: AOAM530MNstV6H8nsLtf9ZjcnVv+YgxhBiemjWCBAwaRKl8TCn66WHSg
        32cLgrmc+D8NM738QXGwrSp6tQ==
X-Google-Smtp-Source: ABdhPJxb24xa445XHHf1HNkwt2afJk4dVMEh/u9Yee2rdsyCR7lzORu9Jhrk0l4bLzsKCzcOF8czSw==
X-Received: by 2002:a05:6a00:1d0e:b0:519:2329:b44e with SMTP id a14-20020a056a001d0e00b005192329b44emr14224pfx.77.1653549254136;
        Thu, 26 May 2022 00:14:14 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id e24-20020aa78c58000000b005184031963bsm640629pfd.85.2022.05.26.00.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 00:14:13 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, odin@uged.al
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 0/2] sched/fair: optimize and simplify rq leaf_cfs_rq_list
Date:   Thu, 26 May 2022 15:13:52 +0800
Message-Id: <20220526071354.6426-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This v2 is based on [1], which try to not put cfs_rqs in throttled_hierarchy
on the rq leaf_cfs_rq_list, simplify the leaf_cfs_rq_list maintenance and
optimize the periodic load decay.

Vincent suggested moving throttled_hierarchy() outside list_add_leaf_cfs_rq()
because the task will not be added in this case which is quite misleading.

When do that moving in propagate_entity_cfs_rq(), I found it has problem
with propagation upwards. So add the fix in the first patch to be easier
to backport, please see the details in its commit message.

[1] https://lore.kernel.org/all/20220427160544.40309-1-zhouchengming@bytedance.com/

Chengming Zhou (2):
  sched/fair: fix propagate during synchronous attach/detach
  sched/fair: optimize and simplify rq leaf_cfs_rq_list

 kernel/sched/fair.c | 83 +++++++++++----------------------------------
 1 file changed, 20 insertions(+), 63 deletions(-)

-- 
2.36.1

