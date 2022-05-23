Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA6530FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiEWLom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiEWLok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:44:40 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CE9506FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:44:39 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h9so7754420qtx.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=3aVJI5c5O7jSRmeZkmnQH6lIAVqqKmbO2pfiDyl8EZU=;
        b=dhT1tTlWhGNbttlcLl4Y5fWajhOaXFyuZ2HHTqdyC4e4dN7K9VvWEl/jvuVKMbMEqr
         hEqft0M9ImFSgiBn3uta3LM1IM7bY2hjUdpiX2Snqe1/fhgFbD/2kDpqmro2DliDsqNA
         x942o9YqnV49E+C75zV2q81nwNAZIr1LQSTQRv0MDMM3S6r9H7EMHeoGghBbFR7whlYO
         Vk9cdN4HNe9CmDMls2sZ/58f4weVHGYCj4s1nwKpscyTMv820QQ0CCQD3pyBhGdu6ZYt
         R27WuJGXPw+5Pe+2DixQdTWPXtjuPLKtgES/BpXqsZ2/ogEB6n45l0i+3D5hoPbQL6Ps
         CU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=3aVJI5c5O7jSRmeZkmnQH6lIAVqqKmbO2pfiDyl8EZU=;
        b=Vy1ztLsvGHOZy4WW3JsF6/QtWTk44XZqfj9EK4twhASu3A3FnBJ4C+UH3gaWQ5Qq8U
         NHt4tbds160dDEkJyzca+DXfrqhtJl9Bgv93MEiSXK0uYgyy1yk11QVKWW0eUs1SlQxg
         vQ5jyHfAaUf/lVp5Saf+BLBGCEXlcCvLI6ITi2X9Erit5LbohyARxJPZeSnEIPcQdHzL
         93O/iMkAhmangKnZyJ0Qwfs2/mYk4FKKu9m5WLB0pAFgTdVNqAzGveci0pjiRIDGeSfY
         Qiym8I1pXCoJDOcYOS9v7kvS6osDvnvMMqVrDymOO8q1bu8pXa8u3NIKORa51NH6RDXZ
         vFBg==
X-Gm-Message-State: AOAM532W7JaBRPY3OjxbtywKgrpY7kNG78TQq3HZZuKOrHtUb1TWwWaQ
        o5hSIPwHNoHa2I8LmeZEtg==
X-Google-Smtp-Source: ABdhPJwjG10A9KRoD/7HLjsZameMg7bZMBi1dJt3007qZj1gnTAlUB442LXftvJM1onztMZ0uIMPiQ==
X-Received: by 2002:ac8:7fc4:0:b0:2f3:f174:e8c4 with SMTP id b4-20020ac87fc4000000b002f3f174e8c4mr16010968qtk.572.1653306278379;
        Mon, 23 May 2022 04:44:38 -0700 (PDT)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id 131-20020a370989000000b0069fe1fc72e7sm4350941qkj.90.2022.05.23.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 04:44:37 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:75dd:56d5:b937:8615])
        by serve.minyard.net (Postfix) with ESMTPSA id A757F18000C;
        Mon, 23 May 2022 11:44:36 +0000 (UTC)
Date:   Mon, 23 May 2022 06:44:35 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 4.19
Message-ID: <20220523114435.GH3767252@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a7391ad3572431a354c927cf8896e86e50d7d0bf:

  Merge tag 'iomm-fixes-v5.18-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu (2022-05-04 11:04:52 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-4.19-1

for you to fetch changes up to a508e33956b538e034ed5df619a73ec7c15bda72:

  ipmi:ipmb: Fix refcount leak in ipmi_ipmb_probe (2022-05-12 10:00:04 -0500)

----------------------------------------------------------------
Fixes for IPMI

Add limits on the number of users and messages, plus sysfs interfaces
to control those limits.

Other than that, little cleanups, use dev_xxx() insted of pr_xxx(),
create initializers for structures, fix a refcount leak, etc.

----------------------------------------------------------------
Corey Minyard (11):
      ipmi: Add a limit on the number of users that may use IPMI
      ipmi: Limit the number of message a user may have outstanding
      ipmi: Add a sysfs interface to view the number of users
      ipmi: Add a sysfs count of total outstanding messages for an interface
      ipmi:ssif: Check for NULL msg when handling events and messages
      ipmi: Add an intializer for ipmi_smi_msg struct
      ipmi: Add an intializer for ipmi_recv_msg struct
      ipmi: Fix pr_fmt to avoid compilation issues
      ipmi: Convert pr_debug() to dev_dbg()
      ipmi:si: Convert pr_debug() to dev_dbg()
      ipmi: Make two logs unique

Miaoqian Lin (1):
      ipmi:ipmb: Fix refcount leak in ipmi_ipmb_probe

Stephen Kitt (1):
      ipmi: use simple i2c probe function

Yu Zhe (1):
      ipmi: remove unnecessary type castings

 drivers/char/ipmi/ipmb_dev_int.c    |   5 +-
 drivers/char/ipmi/ipmi_ipmb.c       |   6 +-
 drivers/char/ipmi/ipmi_msghandler.c | 111 ++++++++++++++++++++++++++++++++----
 drivers/char/ipmi/ipmi_poweroff.c   |   8 +--
 drivers/char/ipmi/ipmi_si_intf.c    |  17 +++---
 drivers/char/ipmi/ipmi_ssif.c       |  33 +++++++++--
 drivers/char/ipmi/ipmi_watchdog.c   |  28 ++++-----
 include/linux/ipmi.h                |   5 ++
 include/linux/ipmi_smi.h            |   6 ++
 9 files changed, 165 insertions(+), 54 deletions(-)

