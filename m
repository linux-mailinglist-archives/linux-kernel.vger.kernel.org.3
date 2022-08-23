Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB76259ED0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbiHWUFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiHWUEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:04:42 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF149BB48
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:20 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t140so8297576oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=so3WdZSQ2eXeaaIN/ZeTDUPvU8ksUXfaJlhvSOwutR4=;
        b=zjmFEogk2oGNq73zWJMUogAbsyKIqCwVhX+da2VoQCFIqnkYFx5C/VQdhgnU/4x2BY
         8MXiSyJOEX9OR6ZODkpC9V0sYMIRB+k48NVVLimG6eMIzuuA0+07TBqHFjGbExJhf0Do
         0wu/lS4mKD/JgCeHRnMQSqmhjwoLHhVQNX6F9Z3rF/oDW+L9Qutv8nJMuOX84NsdvTPt
         wPWGMcVOq1n8aDsJiTqjD/GNdVl2C8nCq/EeFn3jW4Hpa95tLaaQ+mS7dhuIYJLb2zG3
         y894s+cPizSFP7jNuxf1yC0PX5YIjtrzrOOOUUN/V2k2DCu03rn5c1E4yZ69Ol2VGH/x
         mhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=so3WdZSQ2eXeaaIN/ZeTDUPvU8ksUXfaJlhvSOwutR4=;
        b=rVbLKyK4t25rwx5z/MRNY/fr0DAc0+Uy0ZGjGo8PlKZqlYXTWd6BCj7i0FmwSh+MiG
         uCzYDNA6ra3xOB4ZfXMmGzqFZXsYRQxvyYvFU0zimSOc9skR4QZYcHuqKoYDYNxTOeUk
         fSgFf1Pe7DLAkq8+YIaoEqrjroBAkJ+3pbP1C3eoZELRD3Jb6bfEvx6DLuE7o6v+3L8g
         sMsC7OP3mE/yiGJIRWp7fxU8DbHYoi+wo2fQvzZ0PLjmODxIzdACBLlnX0DrqagwmV9X
         RDOjbRjHjzufxt0nwC6+ls2x7+dqaCF6KLwBxGcb+RH3Zn1y6aKlnWWgCEv4+SKCKQyN
         anbQ==
X-Gm-Message-State: ACgBeo2HSpI3vkKh49MNSpY7+FUEwtsjYAuHwrZYuj62Lscxy+xzrV2M
        vcGeOZvkmo/hRi7oXQEWMDniv/DWY0oIZn5XlI0b
X-Google-Smtp-Source: AA6agR5v1Km44i0hrjO0fXev40AHQ+sMtKqQj/EheZkrT9/R2FdVAnbybqnDPRYV+j49VGyHPVGSBkhcfz2jWREIinM=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr1932886oie.41.1661282360270; Tue, 23 Aug
 2022 12:19:20 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Aug 2022 15:19:09 -0400
Message-ID: <CAHC9VhRVFNy06XjVzd7BbPgMOxGYo4hV7bh5t73qFV_AQTrUPg@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v6.0 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

A single audit patch to fix a potential double-free on a fsnotify
error path.  Please merge for v6.0.

Thanks,
-Paul

--
The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

 Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20220823

for you to fetch changes up to ad982c3be4e60c7d39c03f782733503cbd88fd2a:

 audit: fix potential double free on error path from
        fsnotify_add_inode_mark (2022-08-22 18:50:06 -0400)

----------------------------------------------------------------
audit/stable-6.0 PR 20220823

----------------------------------------------------------------
Gaosheng Cui (1):
     audit: fix potential double free on error path from
            fsnotify_add_inode_mark

kernel/audit_fsnotify.c | 1 +
1 file changed, 1 insertion(+)

-- 
paul-moore.com
