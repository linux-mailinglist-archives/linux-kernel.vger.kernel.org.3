Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA2525BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377387AbiEMGkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346401AbiEMGkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:40:10 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAFF2A1FD1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:40:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e24so7284061pjt.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vA/znE+i09DhUWKh38WBzZk1E94QdiyaC5f+azg2XE=;
        b=HO+IEzWRMHUd2gSj0Rslnlkv7u5u6tOkgPwzVhyfjVAFIQJpTyYf/TKsD/mUYEJceM
         1Stj/myO1nSVfjH6qI627L/o8flVqm4GEGlxGOc8cMgc8vxuM1g/LxF3idpTdX6LobkX
         YJaso/fthxHiueAvPeuc9nLTk34jLQxnK598cyl/Hj5SeRhwGE02HGpD2+v6JI6V0RkG
         gxiey+NxdgUb+MqlfdC+hmmNBWDKsMsLQYm3BTku0P8F45KfSfXC8Juw57X8qkukec4G
         9If11Z7xvK55s+vGNykutWFHKiJTRaWQJUR+6lsht279g5xTEMtrUdLrPAC9aQMB/suQ
         kdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0vA/znE+i09DhUWKh38WBzZk1E94QdiyaC5f+azg2XE=;
        b=E58P7I6z/x7Yr7seCidROwHB2aJJnefoXu145hnfrgvxG7eo8/fuC3LAaEjBMsw4wy
         LGBeVmApisNRU8IUU+34YH9/LMNQxe3tIeljjcNRiX/EnbSFyFPsJi5wrUsE6efDQTJi
         3dVeKvF7+mCaY7ixMei7xEctrwEtdwnOBYbu0tPaC2zBAyhuoPWlqsfc8KNZ8i10RcSo
         qIxxUHDtb3iZXLzlw99seOkBzSSKwqxAj0slUOcSJlCVPvNJF+wQ71xV+PH28AdpyMAP
         8CxLncL8zpfs1R1EBwgJXfvlfF6/oy7WMcP3tEOGeWSGLCzYYFWhQSSYz6C4vNiFleq7
         5a2Q==
X-Gm-Message-State: AOAM532eVCZ9KCWWiJdYAa/YSrkfDEfOZ9+uLg/U8tlruQW8taPn+M/L
        9dBzeeIaQAgRVoQetdyXpwQkgQ==
X-Google-Smtp-Source: ABdhPJxzvpLxrI2mTWLvx+8ZR1o/6zMUl2qsyROBeylDkd74zt2/j07bDGqbIqsNKmkDas39P86prQ==
X-Received: by 2002:a17:902:6bc1:b0:15d:1e15:1a75 with SMTP id m1-20020a1709026bc100b0015d1e151a75mr3405242plt.114.1652424007223;
        Thu, 12 May 2022 23:40:07 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id 185-20020a6204c2000000b0050dc76281d8sm934990pfe.178.2022.05.12.23.39.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2022 23:40:06 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, jolsa@kernel.org, davemarchevsky@fb.com,
        joannekoong@fb.com, geliang.tang@suse.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, wangdongdong.6@bytedance.com,
        cong.wang@bytedance.com, zhouchengming@bytedance.com,
        zhoufeng.zf@bytedance.com, yosryahmed@google.com
Subject: [PATCH bpf-next v3 0/2] Introduce access remote cpu elem support in BPF percpu map
Date:   Fri, 13 May 2022 14:39:50 +0800
Message-Id: <20220513063952.41794-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Trace some functions, such as enqueue_task_fair, need to access the
corresponding cpu, not the current cpu, and bpf_map_lookup_elem percpu map
cannot do it. So add bpf_map_lookup_percpu_elem to accomplish it for
percpu_array_map, percpu_hash_map, lru_percpu_hash_map.

Changelog:
----------
v2->v3: Addressed comments from Andrii Nakryiko.
- use /* */ instead of //
- use libbpf_num_possible_cpus() instead of sysconf(_SC_NPROCESSORS_ONLN)
- use 8 bytes for value size
- fix memory leak
- use ASSERT_EQ instead of ASSERT_OK
- add bpf_loop to fetch values on each possible CPU
some details in here:
https://lore.kernel.org/lkml/20220511093854.411-1-zhoufeng.zf@bytedance.com/T/

v1->v2: Addressed comments from Alexei Starovoitov.
- add a selftest for bpf_map_lookup_percpu_elem.

Feng Zhou (2):
  bpf: add bpf_map_lookup_percpu_elem for percpu map
  selftests/bpf: add test case for bpf_map_lookup_percpu_elem

 include/linux/bpf.h                           |  2 +
 include/uapi/linux/bpf.h                      |  9 +++
 kernel/bpf/arraymap.c                         | 15 ++++
 kernel/bpf/core.c                             |  1 +
 kernel/bpf/hashtab.c                          | 32 +++++++++
 kernel/bpf/helpers.c                          | 18 +++++
 kernel/bpf/verifier.c                         | 17 ++++-
 kernel/trace/bpf_trace.c                      |  2 +
 tools/include/uapi/linux/bpf.h                |  9 +++
 .../bpf/prog_tests/map_lookup_percpu_elem.c   | 59 +++++++++++++++
 .../bpf/progs/test_map_lookup_percpu_elem.c   | 71 +++++++++++++++++++
 11 files changed, 233 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_lookup_percpu_elem.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_map_lookup_percpu_elem.c

-- 
2.20.1

