Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF4B482898
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 22:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiAAV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 16:58:29 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:48662 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiAAV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 16:58:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 356AB614E2DB;
        Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Uza_YeM-BWNn; Sat,  1 Jan 2022 22:58:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C65F1614E2ED;
        Sat,  1 Jan 2022 22:58:22 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id co084GGPbvim; Sat,  1 Jan 2022 22:58:22 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 71D0E614E2CD;
        Sat,  1 Jan 2022 22:58:22 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, johannes.berg@intel.com,
        anton.ivanov@cambridgegreys.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 0/4] um: Assorted console related fixes
Date:   Sat,  1 Jan 2022 22:58:06 +0100
Message-Id: <20220101215810.13260-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When UML terminates (gracefully or panic) it does not always
cleanup on the host side.
Especially when fd:0,fd:1 is used as console it can leave a misconfigured
stdin/out on the host side.
Also stale processes such as port-helper can left behind.

This series fixes the console exit code to make sure UML
undoes everything it changed on the host side.

Richard Weinberger (4):
  um: Run console exit code also upon kernel panic
  um: os_set_fd_block: Return old blocking mode
  um: chan: Restore blocking mode upon exit
  um: irq: Restore O_ASYNC upon exit

 arch/um/drivers/chan.h               |  1 +
 arch/um/drivers/chan_kern.c          | 11 +++++++----
 arch/um/drivers/chan_user.c          |  2 +-
 arch/um/drivers/mconsole_kern.c      |  2 +-
 arch/um/drivers/stdio_console.c      |  4 ++--
 arch/um/drivers/ubd_user.c           |  2 +-
 arch/um/drivers/xterm.c              |  2 +-
 arch/um/include/shared/uml_console.h | 11 +++++++++++
 arch/um/kernel/irq.c                 |  5 ++++-
 arch/um/kernel/um_arch.c             |  8 +++++---
 arch/um/os-Linux/file.c              |  5 ++++-
 11 files changed, 38 insertions(+), 15 deletions(-)
 create mode 100644 arch/um/include/shared/uml_console.h

--=20
2.26.2

