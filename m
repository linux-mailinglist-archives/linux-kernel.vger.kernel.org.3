Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E957149597F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348690AbiAUFi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348580AbiAUFiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:38:51 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38540C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:38:50 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id k4so9330548qvt.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1SZ1MKlaPOoMbHKtysksxIjJYZsh98oFml9zv0E9xIk=;
        b=i6zz4/o+RsZMTvWuKVm6tDTfZJCIqbdwiWIgPaklTN8vSjxeZM0vkZH2OHdGQhswcg
         SlYpf8scRQzN8+FfBTWl9hF/P919pqx7sf6mmxqzEdmYh+kwf2RUyD+VYrl3ZUhltHTU
         B6DAqkrSh4IvmO1zi7c+UttaX+0KZTGI8rOVubKMFc/zsXZ+hplmPN3hORvrsqEq/Nwx
         W2pjA4GdhJyJj+kBaJndlHbmC8Lcos4gUgetxPBH7HgN6mHAYOGkxWUwhbY+3xZwWrTU
         SuO23zpQAbCnT4APFtUsUhjGLBIiaVurxux4pI0AvWeEm5F/k0qldhqmZpH1v+rhn6g0
         H4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1SZ1MKlaPOoMbHKtysksxIjJYZsh98oFml9zv0E9xIk=;
        b=5jEPWS5aNb+/ZHmmVr1kZx5wkoVAYPVXgQsM3UUPJlXcv4qa4S3kpGLZf+C/BdiEgz
         12j/lYA6Z5TSfsD1p+2SzBLlL/myWRaYKl0P5LoS/qJlD/hvqn1RgTUgO/layQFIVRvj
         J5uk6o/O39+jRBOXdDxAdwrNNlwT6MvM0qZxdmby2/hsOnf73reX4oBcp4hPVZeVKCvO
         RBXnOIEpFJhBwu5OdtGzfcUvMT3fNnERu3ZHblcP2KdWuZ7KyGjUAMYOHhFLA6KNd9vS
         YTRgQNVjEtiUPr0bzuP3+t4opSMdVCJIyZav6ojR7apgj8fumhtPvBgs1pMfSfW0mxiY
         4XFg==
X-Gm-Message-State: AOAM531fVnnP5yWvvxnUJIlumOoSNV1lzZF3qRApY2RUP8no2trRIpUw
        tbvydjNs/ZsyIrTQDLxUXb8=
X-Google-Smtp-Source: ABdhPJzwyGQOc9vFy5d4cZrdQumiuFOkXPuf0g7Zgqd4I0uB7Nl5uIpt9zGn2F2ntp0/tYcQwBlvBg==
X-Received: by 2002:a0c:f84b:: with SMTP id g11mr2281904qvo.109.1642743529517;
        Thu, 20 Jan 2022 21:38:49 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id y17sm2607169qtw.0.2022.01.20.21.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 21:38:48 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Amitay Isaacs <amitay@ozlabs.org>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] fsi: sbefifo: Add userspace timeout control 
Date:   Fri, 21 Jan 2022 16:08:14 +1030
Message-Id: <20220121053816.82253-1-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain SBE operations (e.g. collecting trace information from processors)
can take long time (> 10 seconds) to finish before SBE can respond.
Such operations will currently timeout due to the default response
timeout of 10 seconds.  This patchset allows users to set a longer timeout
using ioctl on the sbefifo device fd, before issuing SBE operations that
are likely to take longer.

The userspace that interacts with the sbefifo character device is
libpdbg. An example use of the ioctl is in this branch:

 https://github.com/amitay/pdbg/commits/ioctl

v3:
 Take over from Amitay
 Clarify use case in commit message
 Link to userspace implementation in cover letter

Amitay Isaacs (2):
  fsi: sbefifo: Use specified value of start of response timeout
  fsi: sbefifo: Implement FSI_SBEFIFO_READ_TIMEOUT_SECONDS ioctl

 drivers/fsi/fsi-sbefifo.c | 53 ++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/fsi.h  | 14 +++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.34.1

