Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E7D51A519
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353171AbiEDQSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353185AbiEDQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:18:14 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB0F46669
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:14:32 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id hh4so1198062qtb.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdaverde-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJOJi8YEJ3nP6hlbpshmirix9MrBDt+9JGOZowYXyaA=;
        b=NSzMWvYKnEfZDxgAOpWkhcjwjhxHgjigx5wtKMUEQdE1q2F6Or6GBrYZkkI6nh5BG1
         KXgmq2OuHfYRtCtV4pJrKqI5GkR0usospZiQzhX62Gf0/td+E6uXZ2PIdFa9OQb2NjnD
         K4LnbqNYXgRZA+NaU4enZrshTPOq9GNl1eYiFedIBP+hHTMb89lyc/8ig5DoiHcjOx9c
         FYU5Z3ymfaJiiyaM0gRgwS/DS0e0Bmmv1kgyhmeUrBttTLFzn8rSWWbcwB7f8W/hPNk5
         fyZX9EV7gd+5qMrcw2PahkkBTeK6yqmdtZOc5XmedV4lZliTK1cdI4cObmm7TSGxa6gd
         RMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sJOJi8YEJ3nP6hlbpshmirix9MrBDt+9JGOZowYXyaA=;
        b=vDtxtz4KBoro7NNFW0G6EtonB2+5yD/4YjLxBAWHJllNB5Nu7FmhzsLl2byKRK0E4N
         CtxTh49t1XvYstV3oO6MH+G7HczGlPvkzd6ankU5in7SpsIoqZIhT6MOTPRwDwxz5iRI
         qIWrgl5+mxvCjylty97sV5WkPEm205zRDHU+BbRp5kUJKAX4gO+0xzV47BpEjEpg1aex
         yUykj0UHe5pKPQjK+gcU6NnKpIYWi2h8rmfEGntPV3RkNILRbxh1vIb2wa4e7fXnAtGe
         V3lbK5A0aEUI0YaFSeh9+Ui3r4zsPp6tAW2T4tRqMri7wf7AM8p5Rp08u+mUNvK8zt1u
         oR/w==
X-Gm-Message-State: AOAM531Aar+dyX4OZ8AJWot0LIM8HIxlPCASk22F5iq34C7V0WYWyFJH
        qJFy0xW3i66mbUtkarc+atwlYA==
X-Google-Smtp-Source: ABdhPJymksLoPvkTLHfa0YnuD5MRTcGcSjxLfqBXtJJNlbLcwtDeYtX0EMi7UTf/mDept2goA47Uyw==
X-Received: by 2002:a05:622a:100c:b0:2e1:b261:f66d with SMTP id d12-20020a05622a100c00b002e1b261f66dmr19760607qte.381.1651680871121;
        Wed, 04 May 2022 09:14:31 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:1d10:5830:4611:5fd6:ef88:7605])
        by smtp.gmail.com with ESMTPSA id 18-20020ac85652000000b002f39b99f66dsm7594467qtt.7.2022.05.04.09.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 09:14:30 -0700 (PDT)
From:   Milan Landaverde <milan@mdaverde.com>
Cc:     milan@mdaverde.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Paul Chaignon <paul@isovalent.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpftool: fix feature output when helper probes fail
Date:   Wed,  4 May 2022 12:13:30 -0400
Message-Id: <20220504161356.3497972-1-milan@mdaverde.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in bpftool's feature probe, we incorrectly tell the user that
all of the helper functions are supported for program types where helper
probing fails or is explicitly unsupported[1]:

$ bpftool feature probe
...
eBPF helpers supported for program type tracing:
	- bpf_map_lookup_elem
	- bpf_map_update_elem
	- bpf_map_delete_elem
	...
	- bpf_redirect_neigh
	- bpf_check_mtu
	- bpf_sys_bpf
	- bpf_sys_close

This patch adjusts bpftool to relay to the user when helper support
can't be determined:

$ bpftool feature probe
...
eBPF helpers supported for program type lirc_mode2:
    Program type not supported
eBPF helpers supported for program type tracing:
    Could not determine which helpers are available
eBPF helpers supported for program type struct_opts:
    Could not determine which helpers are available
eBPF helpers supported for program type ext:
    Could not determine which helpers are available

Rather than imply that no helpers are available for the program type, we
let the user know that helper function probing failed entirely.

[1] https://lore.kernel.org/bpf/20211217171202.3352835-2-andrii@kernel.org/

Milan Landaverde (2):
  bpftool: adjust for error codes from libbpf probes
  bpftool: output message if no helpers found in feature probing

 tools/bpf/bpftool/feature.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--
2.32.0

