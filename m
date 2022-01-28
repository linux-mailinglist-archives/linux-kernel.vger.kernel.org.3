Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061EA49FDA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349694AbiA1QIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiA1QIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:08:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7B7C061714;
        Fri, 28 Jan 2022 08:07:59 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w25so9908508edt.7;
        Fri, 28 Jan 2022 08:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+lHTLlCRlUm1Db0jAwMxGUYnRNC9a/ghBV9Pq129fk=;
        b=FilC8zHHgdaE0ekoOrYBkoraOrMc7OHWabxb0ZhY8PsaAJ2wgt4pt8bd8pRDG5LTsr
         3N66G+VRmMd1gx/G5pUWvWof3TGwW/RmzREPIIP66diRKOtpW36bFkLXH7zpxUIAhRTl
         gHyzLxdbj2cA3yCjC921PkLaryv4BIOP51msYxDj/QAiWH89vvKAlV0e2TS6zlQqE+kL
         +OJcVG77D9nEQyIr70wKv3Y+p059ew7dmcFtmZJj2vh4bxjoYvaES5jZA/uDobaEvmi0
         G8ZSwC9WCrWz30pTu3sTJLIOmXGNpigF22plWEAwDPG+spAJLH965XKYelx8PkLTpSat
         5qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H+lHTLlCRlUm1Db0jAwMxGUYnRNC9a/ghBV9Pq129fk=;
        b=pJ1B3C0NRCZPXmuQbf2kJVRwJDkEbM3FHcwAKVxlhvMjRRobPqz/IXdlgWGwM1ijka
         Uq4THKofHAt9TxMtEt5NST8agMnSGfO8RPeMvfcI0Ayu1c1QnqOm9KROX3Wb1bUSII3q
         B5GsdbWLpYrMoAL3jRRbRq1OYuHGLLKacHYKYWEdOtkldcsSkCS636KNnax9mJLe2eqt
         bLKqxXqaD3tzwiAYj9xl41YiOg34og2n2oZg0APfsR+WxXOvNT1fU6csr0O06w8U4rmU
         2r6g74A8BeZ4wqexoW8bI+vTa+QxlCbJ6gAprFU/K/Au4LK41m+be6iji+8Xg5lu77Z9
         DglQ==
X-Gm-Message-State: AOAM530dJiezYVJ5tkozBRFH4QANpDrkovWP2eW72AhkGqXWbWJFUwrF
        5svgOu/LK1TPuiWjBFEJruE=
X-Google-Smtp-Source: ABdhPJyiRiLKianxknedMfGo3TQ9nW/xNFQ9AjiFwILFeDoDV1NbWM9rghAOc/9igx07gawFigKDvQ==
X-Received: by 2002:a05:6402:2071:: with SMTP id bd17mr8957867edb.330.1643386078206;
        Fri, 28 Jan 2022 08:07:58 -0800 (PST)
Received: from kwango.redhat.com (ip-89-102-68-162.net.upcbroadband.cz. [89.102.68.162])
        by smtp.gmail.com with ESMTPSA id u17sm10136089ejj.130.2022.01.28.08.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:07:57 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 5.17-rc2
Date:   Fri, 28 Jan 2022 17:08:05 +0100
Message-Id: <20220128160805.15166-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.17-rc2

for you to fetch changes up to 4584a768f22b7669cdebabc911543621ac661341:

  ceph: set pool_ns in new inode layout for async creates (2022-01-26 20:17:50 +0100)

----------------------------------------------------------------
A ZERO_SIZE_PTR dereference fix from Xiubo and two fixes for async
creates interacting with pool namespace-constrained OSD permissions
from Jeff (marked for stable).

----------------------------------------------------------------
Jeff Layton (2):
      ceph: properly put ceph_string reference after async create attempt
      ceph: set pool_ns in new inode layout for async creates

Xiubo Li (1):
      ceph: put the requests/sessions when it fails to alloc memory

 fs/ceph/caps.c | 55 +++++++++++++++++++++++++++++++++++++------------------
 fs/ceph/file.c |  9 +++++++++
 2 files changed, 46 insertions(+), 18 deletions(-)
