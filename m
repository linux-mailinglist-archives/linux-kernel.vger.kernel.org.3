Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9527E50ECB9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbiDYXoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 19:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiDYXns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 19:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBAD7205F3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650930040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ad/qj4Zo68ooo/7SzhrsVxVtAIe9TBlxwBWAMjhIZ6I=;
        b=aqVYPhWJv4rSLig6JI58Q9gMk/G5/haU8FPH9ydcivOhibtuj+TPbcQMa29U95apHNVt+/
        du2JdqDh1hKFgz6hrWY2/Zax3b1PV1XIzy2dvZzXqRGt1eQQLHQVeYDZK4gxGQHClSFdfl
        i0ED7RnBll1bYCv1EIp4C/OrQOtdlMw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-bRkB0vrYMTCPkAkQqeg_iA-1; Mon, 25 Apr 2022 19:40:39 -0400
X-MC-Unique: bRkB0vrYMTCPkAkQqeg_iA-1
Received: by mail-qk1-f200.google.com with SMTP id c8-20020a05620a268800b0069c0f1b3206so10697929qkp.18
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ad/qj4Zo68ooo/7SzhrsVxVtAIe9TBlxwBWAMjhIZ6I=;
        b=4hSvJTe+xQnUnV52O2ycGrNIlhUolfG279BEuaoudSllu25TBBpPACYzaa2Bm0hksc
         VKk6gxAgzMUxZqP/mhIKinq/am/JtGoRNdYma4TjqPVa93mUVit781/1BZ+BtWlKa0YL
         0y17+ezbS6q/vp9BReDD2ZaQng/00/8xOFaW74aGxS9Ypje4kn69NxETrySZPoFuEwfl
         mLtUCrEguHp+fpocbCHt+UqnSUBf79iKelb2ehIgtTtJLfqje2Fch8sukUxmAguID3+A
         fzVTLq/wr+1byXvalpHkCAnRCnTxAe+AAb0FBvVT7qarUT+dATQypKS4l+ruoWjMiT4u
         GEbQ==
X-Gm-Message-State: AOAM530FvdDi0i+ASWoCQjkw3LQZlaq4UmLOPNoWLrKIgbsPztkI9RSA
        RgcrhcvU55dNsXzRJEwBvMK0WFWGog+V2wFP+TSSUyF7ubXYHUBzm/E+mCZZzWTNB2gGZPE1ssX
        RYPQnyO+RTLpfHQCUQkpkh+yQ
X-Received: by 2002:a37:bbc4:0:b0:69c:3f31:3eb8 with SMTP id l187-20020a37bbc4000000b0069c3f313eb8mr11753305qkf.489.1650930038937;
        Mon, 25 Apr 2022 16:40:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxGPDHUgQ7eVjJvd7TrCqDwXfE8oRxG4vrVJGvUyPSGtlOvfHtaX9cZdgxh/SA9pwIgdinVQ==
X-Received: by 2002:a37:bbc4:0:b0:69c:3f31:3eb8 with SMTP id l187-20020a37bbc4000000b0069c3f313eb8mr11753297qkf.489.1650930038718;
        Mon, 25 Apr 2022 16:40:38 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id 191-20020a3705c8000000b0069f1a425707sm5431897qkf.11.2022.04.25.16.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 16:40:38 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] x86/speculation: Add missing prototype for unpriv_ebpf_notify()
Date:   Mon, 25 Apr 2022 16:40:02 -0700
Message-Id: <5689d065f739602ececaee1e05e68b8644009608.1650930000.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings seen with "make W=1":

  kernel/sysctl.c:183:13: warning: no previous prototype for ‘unpriv_ebpf_notify’ [-Wmissing-prototypes]
    183 | void __weak unpriv_ebpf_notify(int new_state)
        |             ^~~~~~~~~~~~~~~~~~

  arch/x86/kernel/cpu/bugs.c:659:6: warning: no previous prototype for ‘unpriv_ebpf_notify’ [-Wmissing-prototypes]
    659 | void unpriv_ebpf_notify(int new_state)
        |      ^~~~~~~~~~~~~~~~~~

Fixes: 44a3918c8245 ("x86/speculation: Include unprivileged eBPF status in Spectre v2 mitigation reporting")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298735ce..ecc3d3ec41cf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2085,6 +2085,8 @@ void bpf_offload_dev_netdev_unregister(struct bpf_offload_dev *offdev,
 				       struct net_device *netdev);
 bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *netdev);
 
+void unpriv_ebpf_notify(int new_state);
+
 #if defined(CONFIG_NET) && defined(CONFIG_BPF_SYSCALL)
 int bpf_prog_offload_init(struct bpf_prog *prog, union bpf_attr *attr);
 
-- 
2.34.1

