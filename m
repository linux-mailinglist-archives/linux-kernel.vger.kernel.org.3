Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB3B47953A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhLQUCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhLQUCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:02:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853D5C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:02:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id e3so12141212edu.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=m1TN1vSbPdjQ1kBpJQ5Rf4PvO87o3O/21wRtoQilZgQ=;
        b=gYNhCu1O0aMAZRG4asiGAf3e55Wf0o8FiVDtuR4GK67gevvc+S23mgtPgBOUk9MQ+p
         AwjGB/D1aX5GSxz3Kzx3lznRpbrAY6BylqKKHX0JfjztBu2Lnz+hG//gA7wXdYfBSMno
         7SzlhlRIC4jfjeFMXxHEjJ0inehsh9ZLVlNZb3eo6HM/jQMabMIzvzRw4Z8qGTnJ2TgV
         DRlc5TnGJEjSz41zhLExjgBuqbQeXOL6KDxwZgTYzsxqARsZYJkVbxiPmiWgwzsXZwKn
         ca3hVEzZY3pMcHME24WzHqBgkdwJ8WIlANkm9zQ+eWexkhmpsp8U5wmPc3ZApG/lrrih
         PIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=m1TN1vSbPdjQ1kBpJQ5Rf4PvO87o3O/21wRtoQilZgQ=;
        b=3KTqP/ju7vt5JYjuQCUITEZoM2UBts6Wf5C3itZqS4b7E0FAClmA1uTMJiLsctNqdz
         hDkQou4R4wc7KE0CemrJObeRaSK9YleO3eE09Wpr60OcjHJBczEzZmqmHoRDO4PFii2c
         gKTuaxOGZCVfM/wdfiqsFbU4yMJ3weYv4cRkBdcPK7O9SfRMUv2ISCU2DIqgqw3PwWmS
         +3cViojuqIRrDwjoSynSMYtZN+QffXSnh8wXv52+ypkbhlCjl43FwQbpJDWeZIKBQ9Uc
         RFfQeNshEo0vD2AqnDbAJRL+nGzLAJ/jBU0E+aeuw/iMIRvg264DEfMDnyuMxZgZ7A6p
         GZkg==
X-Gm-Message-State: AOAM530HyUAAV8E1vMSLdonJjTt/C41nvCCaCEWwIAbd2AsgM9BxYqj1
        9VCpMYHKojxBOp5lq7OUddQPzDY5e0bPhEu6FPSB
X-Google-Smtp-Source: ABdhPJz47oCNv1M/lwln/9SrzEuMxNVfX8UYIa8EV2amYt65ZLYqQOF9wuRoDLTDVWlFZC9gBnfE8kBxAUhsOvNsy10=
X-Received: by 2002:a17:906:3a8c:: with SMTP id y12mr3541460ejd.517.1639771364930;
 Fri, 17 Dec 2021 12:02:44 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Dec 2021 15:02:34 -0500
Message-ID: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v5.16 (#3)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another small SELinux fix for v5.16 to ensure that we don't block on
memory allocations while holding a spinlock.  This passes all our
tests without problem, please merge this for the next v5.16-rcX
release.

Thanks,
-Paul

--
The following changes since commit dc27f3c5d10c58069672215787a96b4fae01818b:

 selinux: fix NULL-pointer dereference when hashtab allocation fails
   (2021-11-19 16:11:39 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20211217

for you to fetch changes up to cc274ae7763d9700a56659f3228641d7069e7a3f:

 selinux: fix sleeping function called from invalid context
   (2021-12-16 17:47:39 -0500)

----------------------------------------------------------------
selinux/stable-5.16 PR 20211217

----------------------------------------------------------------
Scott Mayhew (1):
     selinux: fix sleeping function called from invalid context

security/selinux/hooks.c | 33 +++++++++++++++++++--------------
1 file changed, 19 insertions(+), 14 deletions(-)

-- 
paul moore
www.paul-moore.com
