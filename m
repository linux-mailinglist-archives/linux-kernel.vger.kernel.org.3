Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF09477556
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbhLPPHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbhLPPHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:07:50 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3596CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:07:50 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b19so37155264ljr.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9X0RjBHPLivbiVNAdZyiLl4+pNiD7DUVjNDWx5AeBbc=;
        b=Zdsgu9qsJq4qcchiaa3E8O8yDJy0sQTGRNh42sfeTfhjLAjueKtQnNHRh5QkVdz85e
         fGApJ31vD8zYtCewzZCXSG9w8C+hkCCjUbc7f/eFIQeyiNL7zbrp8YI1mOx50tpKTRKf
         ecogXo0Dt4Ki2/0HdDQRRpteZNVkQqO0wDIlkrXxOmeH3F28gKDFra9gTxDAk1JuUXjM
         iriUD9JMRFJgjRBGx4y5C/y+u4sJjNvu7Oly3+kzAUp5+Frf7xDPouMpxawk9Y7BGdwb
         S6bLzvgYLGCkx3fXikDS9nYXsEMm+HSMJKB+ATNcph0YjEZVoRzdcAYxxYwBWmkIs5Bu
         Awxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9X0RjBHPLivbiVNAdZyiLl4+pNiD7DUVjNDWx5AeBbc=;
        b=BzUO1DdcROi8bwpKwxK9kF9jR0fl1pPIbkOIQV+G/516CJOfl2PRwcx7LHkqkotF6k
         BlbLEjGF3blf7iKwKRbQ9M25YbBGwAJDxauH4dsaxVCgKPALu45/g8oPKZvehAIHzNWt
         034J/VT45iv10aO3uJQBy8Vb64MMy4QgQgTfwE8zk8QsZlNwXI+QWwKyvlqM5U7/6qXI
         6LWgsjq0FJvvhQ7wVTkbLLpUl8jAeqeEP9BjduS/ZBPkqVMMcitpaabQTkHsDK2Vt+1+
         bhaBt5n9v6JZHp05Tb+ONlpbwLD+Hblyc+VsjT2+fazQ3CirlNGDyYknJ7LargigqjIV
         Xz1Q==
X-Gm-Message-State: AOAM530BQzgHararQYFayCsvbo0qFizGKGp6atZmXF3cJkdh9ymz+eLO
        JtVZ71oMumlxEMbSQHYFvrgUpg==
X-Google-Smtp-Source: ABdhPJx98BP9clojgv/CDFJocfhgP1byE1E+a6NOGsae8EetpchJRYkFFgaCcK1kf4if7RGsFK0eJA==
X-Received: by 2002:a2e:b5b7:: with SMTP id f23mr15447783ljn.244.1639667268258;
        Thu, 16 Dec 2021 07:07:48 -0800 (PST)
Received: from jade (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id l20sm912682lfj.36.2021.12.16.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:07:47 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:07:45 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE and OP-TEE fixes for v5.16
Message-ID: <20211216150745.GA3347954@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these TEE subsystem and OP-TEE driver fixes which by coincident
all are concerning memory shared with secure world.

There's one in particular nasty race fixed when a tee_shm is about to be
teared down.

Thanks,
Jens

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/fixes-for-v5.16

for you to fetch changes up to 6add87fdae9bcb1d20b4503df5bd02ce5246cc8b:

  optee: Suppress false positive kmemleak report in optee_handle_rpc() (2021-12-16 15:32:48 +0100)

----------------------------------------------------------------
TEE and OP-TEE fixes for v5.16

- Fixes a race when a tee_shm reaches reference count 0 and is about to
  be teared down
- Fixes an incorrect page free bug in an error path of the OP-TEE shared
  memory pool handling
- Suppresses a false positive kmemleak report when allocating driver
  private shared memory buffers for OP-TEE

----------------------------------------------------------------
Jens Wiklander (1):
      tee: handle lookup of shm with reference count 0

Sumit Garg (1):
      tee: optee: Fix incorrect page free bug

Xiaolei Wang (1):
      optee: Suppress false positive kmemleak report in optee_handle_rpc()

 drivers/tee/optee/core.c    |   6 +-
 drivers/tee/optee/smc_abi.c |   2 +
 drivers/tee/tee_shm.c       | 174 +++++++++++++++++---------------------------
 include/linux/tee_drv.h     |   4 +-
 4 files changed, 72 insertions(+), 114 deletions(-)
