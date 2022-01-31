Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9D34A4EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357560AbiAaSqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357347AbiAaSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:46:06 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E0BC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:46:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l5so28529689edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9dXwpk6wAe/UIqkCjkGhpmRcw0FfDad1iBeSqfICEHE=;
        b=lFBLP5vxcOYZdMlPJY4zXR4+mPsL1N8ov5qN6oPhx8FKyoSQFVJvgf01oYJa4erw8K
         rneSim0lqpu5TfsyNCJQsm709gEEJyYsCSp/bsbXkDkYcAzX61injUXcUWPFSD5c7x5H
         OBPE9olO95xF9C0sZAjbY6AQB9N8Zp42lm/rZz36YJ8GwO9Vveu7go79YtvSAm65HZTN
         4rKMSkLPdJxK0bI+n8eEp5v6GM4X3Nue5H5c/KwOgK7XqgQl11CZQkTlMSVURbW7LcvS
         68nZZsbqtL0i4op9VVLe6UKqmf1rUtzZjkrl6LOUnA99RDySN9QmJLXo1jFYPNdEuCXs
         o7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9dXwpk6wAe/UIqkCjkGhpmRcw0FfDad1iBeSqfICEHE=;
        b=6ZBriGWop5V78dXWyh+CWM3QhlpRBWEpVBcroO8jjc3aG1hb79cnNXBBvAdpc2cmCh
         KHW+GFAr9VUQ7XI8BGvWFcbbSy+Hz1Ub1Wli6n54ZdtZKcyiPuDxB/CvWNQ+QAj1ETnj
         QwjPBWfdApTLpGb6/x/aFEwxa8Lo+5tMKooroIuA0AtEmU7SXOBvHhDMglnNKuAIqudQ
         TZo6GDqrQlhbueQbTrr2/VuBxXgzHFWLLrR+o0hBZJDDdRtrkuvBZRme9nu2W2zHG+ZP
         A30VVosHmZ7m2+pbZaxf71VcaObazkCMuMi8iHla9Hld10230uNKIby4RlO9GGTtuYLd
         TREw==
X-Gm-Message-State: AOAM530v6I3NBrj3sQ0EWmsKL1QYsDwH7jq0pZa30MsXrJg8vQtiRvxZ
        mybpttJfjxJks7YNnU5MIqldMZ4jJvs6BvRyyRMS
X-Google-Smtp-Source: ABdhPJwVrcevtxKnPl2+Rsgm2jz2mtpIEJNYi88kW1zGjXs+dRo1dNiLC5YT3P2IVzKGVOehThMqVQgmzCL3AFBKYFc=
X-Received: by 2002:a05:6402:345:: with SMTP id r5mr22319539edw.269.1643654764453;
 Mon, 31 Jan 2022 10:46:04 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 31 Jan 2022 13:45:53 -0500
Message-ID: <CAHC9VhTL-4iPmW+eg3Q==tWBJf2Zc3nOzJVa6Ba0_R6k1sohKw@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v5.17 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

A single audit patch to fix problems relating to audit queuing and
system responsiveness when "audit=1" is specified on the kernel
command line and the audit daemon is SIGSTOP'd for an extended period
of time.  Please merge for v5.17-rcX.

Thanks,
-Paul

--
The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

 Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20220131

for you to fetch changes up to f26d04331360d42dbd6b58448bd98e4edbfbe1c5:

 audit: improve audit queue handling when "audit=1" on cmdline
   (2022-01-25 13:22:51 -0500)

----------------------------------------------------------------
audit/stable-5.17 PR 20220131

----------------------------------------------------------------
Paul Moore (1):
     audit: improve audit queue handling when "audit=1" on cmdline

kernel/audit.c | 62 +++++++++++++++++++++++++++++++++++++---------------
1 file changed, 43 insertions(+), 19 deletions(-)

-- 
paul-moore.com
