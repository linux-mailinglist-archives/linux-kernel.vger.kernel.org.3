Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF64478039
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhLPW7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhLPW7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:59:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B343C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 14:59:01 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so988508eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 14:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P0EWZEq2FY/J/n+b4RzPFd1l8jSvj2GFJ6lLgnYT/ao=;
        b=SNNI4ZxKDxuSpjK6NEEJg2OqLJmus8YSXRI7UjN93NrF6eK84bId4QQm8XlbFvLiHl
         2E9oruQ0V53xmB9Aty780WAtt9PkWu2cn2bo3Eo8Tzqoqz6lIbZN611kzGjoHRq2h1fk
         g7suvAIPb/fNTs0GlXX0E9CO+ZDI51OzJiZQDlOEVdARc9nCWaVltZIYbj2+wEKgl8hc
         Lf1s6HAV+4Jb3mjItD6CAyHLTf9w1qgaFay6Dsmi2r9SgWbaeKwWC+ascVBTTOJ6eeO7
         N+ZX+9e4yIulGXi7JJ8byalnY0qAWHnaA4HQ8zlo0NHSwO/wBePHIW1xG2OPGJtCD/I0
         5jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P0EWZEq2FY/J/n+b4RzPFd1l8jSvj2GFJ6lLgnYT/ao=;
        b=Kt1BpwiUdg0VKKt6IisvuCZY+qiOf7PtQMpkSce5dSlAgPgmiTm3du8zjx2AzPMq6p
         apKse43v7pnjZxQocbYV//Om6HHjqNIs65gO21Z/uREBIYs0Mx1SPds2SnjT+TS3D3ED
         qSdzvSE0z73v7Zyrq0iwSP/BTs0O1NeQOpqRQ877ceYDAyCthehe15E/Fcxu4lbiXpj/
         NX+hrylgsY4towa6sJ/FF+AA3QUh3mOHhS0kNNpqxgKMTHRb0Z3gzdOyLQ6N1xNWAO2W
         JNSx1UDLEtnN8zC2cHaoPZUF4Wt/7SkIcaFjQJqAGzqvXezTLnBzqe/ruXnhAlcTyJAJ
         KNrg==
X-Gm-Message-State: AOAM533xbAowYgHaDceBxQil1NT3nJO7xD4XdFA2ogjydsgVYsn5hJsl
        EZurM6VQPpN8Xb2uH/O/3ytYKcG4YKuusEmpXdKF
X-Google-Smtp-Source: ABdhPJzzfmPjp9wk5SMiC7mM5NUi1gT3Zanpc6Wp3SQdhBZEnReaSg8P6naIL3YshapSHn7V5t6SQ4WnIUH/OZDwsFI=
X-Received: by 2002:a05:6402:4311:: with SMTP id m17mr157682edc.103.1639695540096;
 Thu, 16 Dec 2021 14:59:00 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Dec 2021 17:58:49 -0500
Message-ID: <CAHC9VhSxFhFBXamDZOkVxnokgBDPDWPNQDLjoZuyqJm65j3JUA@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v5.16 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A single patch to fix a problem where the audit queue could grow
unbounded when the audit daemon is forcibly stopped.  Please merge for
v5.16-rcX.

Thanks,
-Paul

--
The following changes since commit d9516f346e8b8e9c7dd37976a06a5bde1a871d6f:

 audit: return early if the filter rule has a lower priority
   (2021-10-18 18:34:37 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20211216

for you to fetch changes up to f4b3ee3c85551d2d343a3ba159304066523f730f:

 audit: improve robustness of the audit queue handling
   (2021-12-15 13:16:39 -0500)

----------------------------------------------------------------
audit/stable-5.16 PR 20211216

----------------------------------------------------------------
Paul Moore (1):
     audit: improve robustness of the audit queue handling

kernel/audit.c | 21 ++++++++++-----------
1 file changed, 10 insertions(+), 11 deletions(-)

-- 
paul moore
www.paul-moore.com
