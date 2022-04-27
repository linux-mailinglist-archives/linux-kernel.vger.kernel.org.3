Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6467E51257F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiD0Wtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbiD0Wtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:49:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BE23FBDB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:46:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so3548999edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ue6rVu6i+LhfCao8kUR1Z6Jfs0LQjlJynwWVcrWd6VM=;
        b=Gndc1RCGkDncdLnhWZGKEMfSDA6RiY6gYsq2cfbAeZNK4nrXaz/6N1hr6sqvdr311j
         JWoa0bmCoQ403+CD/hq+Sfq2bCXRvGzfLvjnwjye9dkw8VgX78EKPb1PHzbS6qOQ4x67
         IfrxMTZCU0wjTwJB4VIaKx7ERPHXDEo7k7W8VQosJNY/stX38nDCk3GR6BRnaPrk7dmm
         6fFhd/zSnRznh4bRhxzaNHYIxwfYNBvel6PUZnkpkDdpVak3IFPGVWSZ5NWYIn9gwwkR
         ZxNPOZKzDXvQu/0bdtnoy4oXB1JsUhap5CcqYbV3WUp3mfjo3KFJ+zFdt4MxQlGAZ+4Q
         G55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ue6rVu6i+LhfCao8kUR1Z6Jfs0LQjlJynwWVcrWd6VM=;
        b=UMd2BBO5xHUx6ZBgYmfeMdKaxi+L+oYTjAgnc6Gd7EPEhzzx223h8oi8TVNu58LMZX
         XM/hlGft+e3iqBjDr5hDJZcJvrpD1AzwQ1TdU1otyC3VA5iPPx+XP1nmDXmM+tMF3Aw+
         UQlYBodtUDgNgcaTtBJcFRxHyCb0UTX03Q2wxG2kwmUid/zyr/DkrVCVzMMiuoh79+Zn
         J6MPcvL68xc+Hb1Mdo2pOtL4HmDIJuflTHDLSU5Q35sE6kS4OYaL9QsWNbHKegcTFE/S
         lZrmx/07WMGB/L5OOZv2qWW7oVJbB6MVJ7XV5DW+FJD96RBmBvcv9D7iC4VuTP1OHQKo
         dEVw==
X-Gm-Message-State: AOAM530bLckXxo9f10QbGd0FdBOuhfc2Hz5XPbpU776KVedpOFouSFp1
        v+gN89lI2KV+e/mlAnZVw5TX0Jms1Y4=
X-Google-Smtp-Source: ABdhPJxd0YZSftPkxD/+f96yvJ2QI3MqleeuNByzeM6djihWCYdTQgVG4j7ZbQTiHW3uDizGz0UT8Q==
X-Received: by 2002:aa7:ce84:0:b0:425:d2e0:a75f with SMTP id y4-20020aa7ce84000000b00425d2e0a75fmr25946415edv.263.1651099579646;
        Wed, 27 Apr 2022 15:46:19 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id o14-20020a170906774e00b006d5b915f27dsm7351657ejn.169.2022.04.27.15.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 15:46:19 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mina Almasry <almasrymina@google.com>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH 0/2] mm: mremap: fix sign for EFAULT error return value
Date:   Thu, 28 Apr 2022 00:44:37 +0200
Message-Id: <20220427224439.23828-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mremap syscall is supposed to return a pointer to the new virtual
memory area on success, and a negative value of the error code in case
of failure. Currently, EFAULT is returned when the VMA is not found,
instead of -EFAULT. The users of this syscall will therefore believe
the syscall succeeded in case the VMA didn't exist, as it returns a
pointer to address 0xe (0xe being the value of EFAULT).

This can easily be reproduced by the following C program. I expected
mremap to fail, but it does not. If the bug is present, it will print
0xe, otherwise the mremap will fail.

The patchset contains two patches: one that fixes the error, and
one that adds a small test case.


#define _GNU_SOURCE
#include <sys/mman.h>
#include <stdio.h>
int main() {
	// Get pointer that's definitely not mapped
	void* ptr = mmap(NULL, 4096, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if (ptr == MAP_FAILED) { perror("mmap"); return 1; }
	int err = munmap(ptr, 4096);
	if (err < 0) { perror("munmap"); return 1; }
	// Remap unexisting VMA
	ptr = mremap(ptr, 4096, 4096, 0);
	if (ptr == MAP_FAILED) { perror("mremap"); return 1; }
	printf("%p\n", ptr);
	return 0;
}


Niels Dossche (2):
  mm: mremap: fix sign for EFAULT error return value
  selftest/vm: test that mremap fails on non-existent vma

 mm/mremap.c                                  | 2 +-
 tools/testing/selftests/vm/hugepage-mremap.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.35.2

