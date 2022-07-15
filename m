Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13C757655F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiGOQjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiGOQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:39:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439F6CE03;
        Fri, 15 Jul 2022 09:39:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k30so6980852edk.8;
        Fri, 15 Jul 2022 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvhJn0S9vThyG29jKQokHXLUcesyw2+MD4EcSS/waNs=;
        b=VP6d032bLh9GUakmfJFN/99OsICffhB7LIxn0V2jLbf5WK1vT82XPIpJGW0+po4I39
         y+VD1rCISE0JYfjYStuCfzYvku9iOd+EbMhvW2TI766DvBhbdlW6vcjwfAF05m8obMbp
         T9v0SiZ2XjTgN0cg7oubmXYchbA83ECyP53M5GrSFod2wsQKvcSO6kePuly7/ySRaf1Y
         E+7ypRhbUVSSZa/S9gaXqqdC0JwD8kMj3IBk9H3q3rzZQqw4ydcpUMN/oQY16FKI8YKA
         JrmeBr/lUZa0jUDVwSOAZNLtoZhFREuDJMfCmPVbdfWEmF+BaKpX4aR/NGu+O6vV3jip
         ykfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XvhJn0S9vThyG29jKQokHXLUcesyw2+MD4EcSS/waNs=;
        b=VWnXKyb26E6Geu6e8lKb+4P7zs2GWv95Av2NvyWyj3h86k5rHxScUwGJGNTDgfxbOB
         TFYYi4MDMUFzFyo92yl+189jGEMU36PcCC4ABccVOPDBnSuX94GiX/rdbTo2Ne29WS/5
         BO4d0j9qo+dLT+dIlZtM258E6wkhVRFytSUR0WP1Z0st1B72nsfe1BJvZ0HHWWyLs+UC
         pQpc9ZU5j0dcKd/mPk9BuAsjG8MWUzH7g2eOu1jhaX49wVfvizGQdCAmhenhRPxsrVQw
         YcHVCNgRz28tdZKpZrysqe76qSAzL30Rc9pn7TV22oW4BWe0v10jfloq135Lq9QWfxIH
         TEjg==
X-Gm-Message-State: AJIora8NyWXRGDAA46VNbAeYX4BkRa10Y5O714QnnJSP/n0Z+ZxE4pxK
        pSOWFOHVc+kXLL/PFiE1TtrjAfZmZMk=
X-Google-Smtp-Source: AGRyM1vpPD+akTTTBupGIXyQOUMc6Rc3zoPpZqKTi9XIVgT8lPhTPbWAFcPXq4mMNqnAInTnHJ6nJQ==
X-Received: by 2002:a05:6402:26c3:b0:43a:a846:b2c1 with SMTP id x3-20020a05640226c300b0043aa846b2c1mr20252243edd.133.1657903146842;
        Fri, 15 Jul 2022 09:39:06 -0700 (PDT)
Received: from kwango.redhat.com (ip-94-112-17-81.bb.vodafone.cz. [94.112.17.81])
        by smtp.gmail.com with ESMTPSA id t6-20020aa7d706000000b0043a85d7d15esm3045460edq.12.2022.07.15.09.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 09:39:06 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 5.19-rc7
Date:   Fri, 15 Jul 2022 18:38:45 +0200
Message-Id: <20220715163845.14481-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
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

Hi Linus,

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.19-rc7

for you to fetch changes up to fac47b43c760ea90e64b895dba60df0327be7775:

  netfs: do not unlock and put the folio twice (2022-07-14 10:10:12 +0200)

----------------------------------------------------------------
A folio locking fixup that Xiubo and David cooperated on, marked for
stable.  Most of it is in netfs but I picked it up into ceph tree on
agreement with David.

----------------------------------------------------------------
Xiubo Li (1):
      netfs: do not unlock and put the folio twice

 Documentation/filesystems/netfs_library.rst |  8 +++++---
 fs/afs/file.c                               |  2 +-
 fs/ceph/addr.c                              | 11 ++++++-----
 fs/netfs/buffered_read.c                    | 17 ++++++++++-------
 include/linux/netfs.h                       |  2 +-
 5 files changed, 23 insertions(+), 17 deletions(-)
