Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB56F475914
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbhLOMqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhLOMqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:46:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EDCC061574;
        Wed, 15 Dec 2021 04:46:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e5so4573735wrc.5;
        Wed, 15 Dec 2021 04:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tpiEuZ7gXKMamSCO+G0Ixm7VxMr0AHOOGqhkcPxp1o=;
        b=EraqNVst4NkAmlxMzrfqEJp/thqPMlVXk3aHyWar0q0+b6MDKWdd8SMsWnKgJrVqtJ
         3yrCWLKboZw5eeWteDU0g1kkbrZfNbxoR8ccVWNN8xUHETsDvkELcDji8oxJmBwI5M4p
         3i82gHgAKYXQwE3PSDtAv3WEkn4WXyxC505CDaomgkvZn2KGB+ASMI5TIikgbMAZPiqi
         DVcEExmHDKDPlXNUgnBa66o3tJUViY21YFAya0jHYdWVNbAib/EaujHW8zcw4nRE5+xJ
         rHAHylF1UFgBd30nIzWdl5DwDu8T3md/+JEV3K5nBJU2RDHVUv/svt7XYLYIVjlook76
         XF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tpiEuZ7gXKMamSCO+G0Ixm7VxMr0AHOOGqhkcPxp1o=;
        b=W4XXi7Df/LPzVC5x1dZczOWayWEwzbNVrtgMNseOlN9jfTS9hrMPq6dG+aIU3b6FGI
         9V0/AA2fOs4vE9DTJGvzTF9i9jam90Z6vzzpvqWdIDsrDnzwxNxpNpTR7FTd4EcEqias
         yhvQMeRu9WSNeMdfjMC2areQqKMYnZB4q7/o6cQ1608/HZM6HLHA7APNNeCW/00qdwqX
         fIxd05kgO6MDvwpfUUMNUy0ku1KiMsYa+S68xgw5F6c/nztMKc6xoMl1mnz7q1GdM05v
         IsXzISjSgjnfBMMN7H8KnieI4XqXXI8pXPCbEmGLfLsKw1Ins079rW2SMWG2tBe+AEBO
         Bm9Q==
X-Gm-Message-State: AOAM53051Ye9P9vwK/LYcw140fkpIyxNa+tWVoM/WyQkOE+F51F8jRYi
        GwSuyYQsxcD8B2j71EPIg7c=
X-Google-Smtp-Source: ABdhPJzu22hEyHAo2WLXYVE7RqNmEzRk7g2hP1cuVrqFUYqGHNYwy8La8VujjtvaCChrOgKi0mFeTA==
X-Received: by 2002:a05:6000:181b:: with SMTP id m27mr2038755wrh.43.1639572395322;
        Wed, 15 Dec 2021 04:46:35 -0800 (PST)
Received: from kwango.redhat.com (ip-89-102-68-162.net.upcbroadband.cz. [89.102.68.162])
        by smtp.gmail.com with ESMTPSA id k13sm1926734wri.6.2021.12.15.04.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 04:46:34 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 5.16-rc6
Date:   Wed, 15 Dec 2021 13:46:25 +0100
Message-Id: <20211215124625.32575-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.16-rc6

for you to fetch changes up to fd84bfdddd169c219c3a637889a8b87f70a072c2:

  ceph: fix up non-directory creation in SGID directories (2021-12-01 17:08:27 +0100)

----------------------------------------------------------------
An SGID directory handling fix (marked for stable), a metrics
accounting fix and two fixups to appease static checkers.

----------------------------------------------------------------
Christian Brauner (1):
      ceph: fix up non-directory creation in SGID directories

Hu Weiwen (1):
      ceph: fix duplicate increment of opened_inodes metric

Jeff Layton (1):
      ceph: initialize i_size variable in ceph_sync_read

Xiubo Li (1):
      ceph: initialize pathlen variable in reconnect_caps_cb

 fs/ceph/caps.c       | 16 ++++++++--------
 fs/ceph/file.c       | 20 ++++++++++++++++----
 fs/ceph/mds_client.c |  3 +--
 3 files changed, 25 insertions(+), 14 deletions(-)
