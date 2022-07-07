Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9201569EBB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiGGJmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiGGJmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:42:37 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050504D140
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 02:42:36 -0700 (PDT)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2231740A91
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657186953;
        bh=0/k9jZrw5vV9CBwx2r80FHe2MFjiQPs5GdaiVI7LCog=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=WQs9Du5z84wa8TtPXMIdwjqTLXtlghVNXD6uULT00dmlFKcJ8XgpQPkfFgmGhbqlP
         6gbwixl9HoRAuErPBinow+Yba/PKgRb7DGJnfH2ZqHaC1sU0+RnBjx3QbukqYGSCzE
         pSoC2qsahCxFCMEDJtY0erfZOv7ZAIRwH6V+YgC4LX+yZkA16jz/KiBUx4DUgpmWdB
         bTYUwZKXjY6pxTXErSeGRIGz5d/v/rTBq50+zSlyVYBPB00Yveqqjp/5VmQya34qHY
         71wx5CmOu20DQyH28z4UZLSO1lNQfkP+zJT1HGiUc0eFH0qCP0jDVIfcGeiE23DvNx
         AsHDJ3sd32dtw==
Received: by mail-pg1-f199.google.com with SMTP id 9-20020a631449000000b00412b1418c79so1987950pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 02:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0/k9jZrw5vV9CBwx2r80FHe2MFjiQPs5GdaiVI7LCog=;
        b=Ew0DbBAqbehJIvM3WrqZDgaa2fEl/7oyJtsvJ6yqN3M1jzgUCI6PEp7ZyrgHmo9d2b
         v02Cdu/UzJpLfuQrCE21TKudJDryUaiJ4ORV69nbOxQH73zwaJM/nmWFzun2xjqfCZLS
         ReGhKF0iCHYo+G3tfwIqWx4019/G3Jhxufcj0GcJKEby9/DAeGAVA+D+PjSijeBdNhjE
         E50yYOr956UJnmJkH9mhrSC4q1U2WI/ozBD+94CO+Dg8bJq2oZlxq0K9TyVWCxLosCzi
         g+acNXOcX9VRQ70M84/RQklmT0KGW+FMfQp+bgbLlAKSJOIZHIABo+zbXrMjkYKINIBh
         EKiA==
X-Gm-Message-State: AJIora/spFp7PnRi1u5rVcbq6jCcWE2onVgW8Dd3GhUmEm8afh9UOL4+
        2nwp4Y9p5wZqtJN/c2WDIZbZhCkMVI0J2ncXheKKD7PynvEzIMnjZzg+nQyoFxl+gg1NnDQOOmI
        4qBl8KPsTWhK0awITG+j19enJxVTtmxCHlboVv1vk
X-Received: by 2002:a17:902:c205:b0:16b:f021:4299 with SMTP id 5-20020a170902c20500b0016bf0214299mr15311600pll.70.1657186951638;
        Thu, 07 Jul 2022 02:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sXIgj1gZjhjX5O1aSA2f5ZCznB445mcYvPL8KykhClWZybIN58wmPKyPvJtbx4KxW197vKjw==
X-Received: by 2002:a17:902:c205:b0:16b:f021:4299 with SMTP id 5-20020a170902c20500b0016bf0214299mr15311565pll.70.1657186951382;
        Thu, 07 Jul 2022 02:42:31 -0700 (PDT)
Received: from localhost.localdomain (223-137-51-72.emome-ip.hinet.net. [223.137.51.72])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709027b8f00b0016230703ca3sm27085064pll.231.2022.07.07.02.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 02:42:30 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     memxor@gmail.com, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
        po-hsu.lin@canonical.com
Subject: [PATCH stable 5.15 0/1] Revert "selftests/bpf: Add test for bpf_timer overwriting crash"
Date:   Thu,  7 Jul 2022 17:42:06 +0800
Message-Id: <20220707094207.229875-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bpf_timer overwriting crash test will cause bpf selftest build
fail on the stable 5.15 tree with:

progs/timer_crash.c:8:19: error: field has incomplete type 'struct bpf_timer'
        struct bpf_timer timer;
                         ^
/home/ubuntu/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helper_defs.h:39:8:
note: forward declaration of 'struct bpf_timer'
struct bpf_timer;
       ^
1 error generated.

Test shows this can only be built with 5.17 and newer kernels. Let's
revert it for the 5.15 tree.

Po-Hsu Lin (1):
  Revert "selftests/bpf: Add test for bpf_timer overwriting crash"

 .../testing/selftests/bpf/prog_tests/timer_crash.c | 32 -------------
 tools/testing/selftests/bpf/progs/timer_crash.c    | 54 ----------------------
 2 files changed, 86 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/timer_crash.c
 delete mode 100644 tools/testing/selftests/bpf/progs/timer_crash.c

-- 
2.7.4

