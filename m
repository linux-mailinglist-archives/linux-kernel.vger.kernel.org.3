Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B369A508FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381587AbiDTSvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347153AbiDTSu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:50:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C42742EEC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:48:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bg9so2430426pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=trC3Jlxugt+DSRiVxo9xrs63CVYLuv/9eCn2KJJLdms=;
        b=CzzmjkHZYTeeLA4VQjVJtRzQ2KUxzKMzUAu8XCCnixPad50uf9dqsbi+yBo0RH077z
         Q0ZuID/UQaEVBzRnxtZSHcuHsHISgOvBFEoFD1GhyorPjqrVRkiaIjWDcjHHuba+aMlY
         xPXctABj1/GCQLG6fYutac4EDEoxze5my84ivnf3+Hj6BzcacQJye8OApJH3hzIw7nss
         IBsKWtgNzGrzQIVrUYsogBIXs2ZlNjtz6lbpOr++/7CUdS3ZdUV0Cu1lFhPTRlpdimpz
         ZmoIg7LzhrJEojLWuMU6f9h0NuyZo9fH2kr3Da/ALoRkshDAC0zer4yGYXI2ahKVMpn/
         p5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=trC3Jlxugt+DSRiVxo9xrs63CVYLuv/9eCn2KJJLdms=;
        b=vUP41sg/rwiFtAaBxXJlA91v1b2VFamfjUdmuPtX5yxBBIan67kCuRVeZC2x1gNgVf
         D92/iy9defj1ba86FVVnD/ewviLrDUA5uHtPn22Qd25AJ8OLAsrjUze75cCh5LfZLy8R
         5t+bwdRLVcd3GMnrVs1IjxYX9c/UW+sihFR6bo/TdBn9PUsLaKhb+CGsLSSoqogs3I9p
         OzVN6eqHPG9tsthEBaO7vDaDSud+HNpTInjcyd82AiETWFeDg29S7n8tq+qVpwkZekOq
         bFJnWLkZzMn3HAbQO4WP/hJAujtdCuYGDUGINJw7JGzMYxrRxeTW7ibNgLDfVOdJ5KmB
         CVGw==
X-Gm-Message-State: AOAM533eayhqO2fB4gLwz9tOptGqlne1arC2PHIrT5caihfdcG7hOzSL
        DDzDJFINamMfWO1/zvO4zeBM0A==
X-Google-Smtp-Source: ABdhPJxMxDsl+AQjvcOpN1nXpf/ttAsJ1UpUjyGXJaFRKoI8lVKUPxgJEPMoUNRJqp9fNFPEEUaD2A==
X-Received: by 2002:a05:6a00:1489:b0:50a:90d7:e69d with SMTP id v9-20020a056a00148900b0050a90d7e69dmr12354299pfu.70.1650480491099;
        Wed, 20 Apr 2022 11:48:11 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id s89-20020a17090a69e200b001cd5b0dcaa1sm120809pjj.17.2022.04.20.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:48:10 -0700 (PDT)
Subject: [PATCH v2 0/4] RISC-V: Various XIP fixes
Date:   Wed, 20 Apr 2022 11:40:52 -0700
Message-Id: <20220420184056.7886-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, vincent.chen@sifive.com, guoren@kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        alexandre.ghiti@canonical.com, jszhang@kernel.org,
        vitaly.wool@konsulko.com, gatecat@ds0.me,
        wangkefeng.wang@huawei.com, mick@ics.forth.gr,
        panqinglin2020@iscas.ac.cn, rppt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, rdunlap@infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found a handful of XIP-related bit rot when chasing down a
LKP-reported issue.  They're not really related, aside from all being
XIP-related.  I thought I had an XIP build test, I'll make sure to
add/resurrect one when I get back around to these.

Changes since v1 <20220419194846.18318-1-palmer@rivosinc.com>:
* Defines the mapping functions themselves to have no-op bodies, as
  opposed to wrapping their uses.
* 2-4 are new patches.


