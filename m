Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F77555C46F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbiF1M1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345607AbiF1M1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:27:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558AE1208B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:27:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i25so11941250wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XecWFv8BJ9dhDMzcKO9+pHi/v+FsHPKm0rD5CDzqQsQ=;
        b=eMuLBRclklQv7ZkZS+mcJWeuRRJB/06DrG4Wg3av5N283Jo90OYG9na6pIn/03AaT/
         quKhbFdkQ4hyjqp+niUXRQ9NIjMSiARtjd8Ut2zrgIyNonrTOxLEefQfON2oGAcW2bp7
         wLzI/tvHzckJu9rhEfrz7lgzbnFKBStezvvjjxY9a5xeNawmKYdjRzsHCj9yz6QbJ3Nj
         bX113jv7AASShx8buwmnkS1KWmf9UXBdTHkHb/9t0irgwQ/MjMSwjxj+Bq6DUYgDZ1tH
         pRlSUC0aqZtMOtSAld8QJi13nB+CDs8aICnLr3Q/TiG1gGPgcmvnqj6fEe74ZNMRPzUX
         //Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XecWFv8BJ9dhDMzcKO9+pHi/v+FsHPKm0rD5CDzqQsQ=;
        b=zl0RfYbkPoI1EqCem9/665tSOPfKeqlZ3kjfUB3aRuk9rSnb3UjU+0GbNgYdzp6iwy
         VcQKcTldUcHD9gsmRjphqXHTWX/jI52kQMoR7K8CeUGzrHIrNcucDObdbysL+0OA2bzb
         4lZjesQ640Ze4WgdJ9VG8PUUYYIF8/3A71MAqu3qnuz1OBR5zcTcs58KI2p8BrI8BXZy
         51ak9yJuh+PQHdmpRXsX23R/ohQ+Sdfec8Gyr/Un9uUcC0wGBr1XgIbGcwK1JpjaoDye
         uh0jTnKC0xYAc0bmyJn5FcCuxjry2v0Xniaj26HTzrC/l8S3c/HaY2e3XWkWuxLa86MO
         Pwlg==
X-Gm-Message-State: AJIora+cDm9km+h7+UmEuPEIU38rVga2iRu8vR+4MyNNQ8l0B8cZddC+
        lx+lzS8qfFLMHkR4hb0VDvinYsioi4/AIwdc
X-Google-Smtp-Source: AGRyM1tOh42lNgvUY/nPjcoLX2cbYvrNKo9Ve5tYdeDFc+WBu+DfqAKkBLSxlBKNPZvL4BAQe9Z6Xw==
X-Received: by 2002:a05:6000:156e:b0:21d:2031:e8fb with SMTP id 14-20020a056000156e00b0021d2031e8fbmr2729134wrz.715.1656419265845;
        Tue, 28 Jun 2022 05:27:45 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id ay36-20020a05600c1e2400b0039746638d6esm17184212wmb.33.2022.06.28.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:27:44 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Enable clang tools for kernels build using gcc
Date:   Tue, 28 Jun 2022 13:27:38 +0100
Message-Id: <20220628122741.93641-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set makes it possible to use clang based tools, such as
the clangd completion engine, regardless of our choice of compiler
for the actual kernel build.

Most of the fine details are included in the patch header for the
first patch (since we'd like them to appear in the kernel history so
they can help future archaeologists).

Daniel Thompson (2):
  clang-tools: Generate clang compatible output even with gcc builds
  Makefile: Enable clang-tidy and clang-analyzer for gcc builds

 Makefile                                    | 11 ++--
 scripts/clang-tools/gen_compile_commands.py | 71 ++++++++++++++++++++-
 2 files changed, 74 insertions(+), 8 deletions(-)


base-commit: a111daf0c53ae91e71fd2bfe7497862d14132e3e
--
2.35.1

