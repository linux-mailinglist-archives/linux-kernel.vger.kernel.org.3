Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9F248B1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbiAKQUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbiAKQT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:19:57 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD89C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:19:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso1771489wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzDPDtmZcf1JkCwHy8uphmdNH63NACWxOruLcR+YRzM=;
        b=UmQnQGZogndZaXUFhpJa03xTCx7fBNT8VNxoUmY+UsvAfzj2fADPRqOli9HxsLMq63
         ii7NzDgjye4uYFOsiArqjt2pBrCwRqJWu+L6PSVLkB4Vg6cWL0pMnai7afMw/jDsuelo
         bkT+80SKDY6lGWcvIk1Dw+S+iDmW2k1AH/0pPm276BNE+3f0TSK/jqh/pmP7ey54Gkcl
         86HQUpAaF+jR7cMdQC1qI5PU4qJ5fGaLYBilnJ3lXBtp6zz4SXpxkYNBLtoFL4qBmBxp
         7BxitiucJawRwU6Uc37H74zRW2xVNWkx3Zh3g0DQIOEXeqs4FmhAa0ttEvZlYT3JkwAd
         dmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzDPDtmZcf1JkCwHy8uphmdNH63NACWxOruLcR+YRzM=;
        b=r1s6mTlCUV9zyuP5+8bBzM/dfin485MsyyH79YCSSSgA/9mmh4BGyerACH4DQkwk4S
         dA7wnkZ6Zsh87FhYdg9d7QO8/667RjdZ/r+JA0AdjXRJ0Ti2/LyE3b7kXQ5wjO3pMpW2
         DWP5zsx6fW1offCdnkUPyalEYsMt/UmBuKfDzk50DjsYTP9Zqz1U4HioRsnkBH4JFD+q
         96zd8bZc2d8dimn7eAvnkv5FRHfJLG1rJoKU4Zp+V3uYB8Ezu5ao/IkagzauUzXzsEqX
         Uxplun7EFAzz+RM4RfFRu/g0i7mx4Eys5s7e7JU5pUAMwMKnD4rnqN8sqCKKMjPfhoW2
         ZFQw==
X-Gm-Message-State: AOAM532D2SH+TSBCbxRfhC3+801I2QBsMAyk5D/QYEOjjg//m/xlWP5o
        SbddDOqBYongivF8Mu+Wyxs=
X-Google-Smtp-Source: ABdhPJypQ2Df/GvB83RXg+sGXjQrR1aN+4Hk0+Gb5DM+pxwdBnFLVIiqG9IeU63qjXkcRKZNldxXjw==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15mr3129291wmb.38.1641917995256;
        Tue, 11 Jan 2022 08:19:55 -0800 (PST)
Received: from lb01399.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id p18sm3012397wmq.0.2022.01.11.08.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 08:19:54 -0800 (PST)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     nvdimm@lists.linux.dev, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, jmoyer@redhat.com, stefanha@redhat.com,
        david@redhat.com, mst@redhat.com, cohuck@redhat.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, pankaj.gupta@ionos.com,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [RFC v3 0/2] virtio-pmem: Asynchronous flush
Date:   Tue, 11 Jan 2022 17:19:35 +0100
Message-Id: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Jeff reported preflush order issue with the existing implementation
 of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
 for virtio pmem using work queue as done in md/RAID. This patch series
 intends to solve the preflush ordering issue and makes the flush asynchronous
 for the submitting thread. Also, adds the flush coalscing logic.

 Submitting this RFC v3 series for review. Thank You!

 RFC v2 -> RFC v3
 - Improve commit log message - patch1.
 - Improve return error handling for Async flush.
 - declare'INIT_WORK' only once.
 - More testing and bug fix.

 [1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2

Pankaj Gupta (2):
  virtio-pmem: Async virtio-pmem flush
  pmem: enable pmem_submit_bio for asynchronous flush

 drivers/nvdimm/nd_virtio.c   | 74 +++++++++++++++++++++++++++---------
 drivers/nvdimm/pmem.c        | 15 ++++++--
 drivers/nvdimm/region_devs.c |  4 +-
 drivers/nvdimm/virtio_pmem.c | 10 +++++
 drivers/nvdimm/virtio_pmem.h | 16 ++++++++
 5 files changed, 98 insertions(+), 21 deletions(-)

-- 
2.25.1

