Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAD45267F8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382788AbiEMRNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382776AbiEMRNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:13:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846664A3FF;
        Fri, 13 May 2022 10:13:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l18so17445930ejc.7;
        Fri, 13 May 2022 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JbY4j1EuGlbNZ3UpU6/RsHBbYoZXAqWvVtwc53vMS0M=;
        b=G4rENm+LNXceQFCrHGXlXV9L4f624fQ/c8LFZt/OwW10ZBarnGJ1Nj/Pkf+EIsZHv+
         8t2AWEso96oYtmUizhkTePfxxqjqGRcRIPRIHsPp9kFseG1HeFagCD9ztBNYIP1i/EV6
         P+CHAv+ltYVEr5Xs5t0D7P7hmq/h70+uV7iPMK48IHJhRTKikLHv3tYrC1CaXgzlk8Mu
         oFedWbq2NSWBSuWPMwkXRxEcFM3ttR2bIhXN5TRCxlrdXuap/lOsJ5WOX8RzJuQXvsi8
         LNPbTEnzrUuy+CIGsi+OPsdo8X/gs92CMSEzQNvMdkLowgEdwnLtPBkvjiYJBab5QbiH
         W/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JbY4j1EuGlbNZ3UpU6/RsHBbYoZXAqWvVtwc53vMS0M=;
        b=W9c/cRcHCD41aAeMALimFSTCHar7rVL7PNWuIkOHhq2lSmrjP9+CIfpiYzeAJCK7ep
         aiv7QILm+7tFTMrBGBuOeAIyv7TohYNFlAw682uGdfBbBniF1desPrfLHsqiJVJJaDyJ
         xyIcjOUW1bKLowrWoBKBuYAeRICfrFUq5+DhDYJ8BcVRW/E5sjE776uCJlqxw7aoswh7
         Kf+1kTAUhNC+YGMdrJAO6XafS2TcWvAM4/Ol/SF7VtIwa+mu2ObY1E17fOxr2WBBuITF
         1Tt1Tc99iAZg8pqFmwY9F8af/5io9QRD3x3dIPHBm1lzzoC9WYViAJ8IZ37X1h1DIPPP
         F5fQ==
X-Gm-Message-State: AOAM533EQfipxVlS4TQ6mvjsjwetcq6RQnzJ6tJcvNIN/rJr0vmd/mku
        vi2a+nbooS2u2BrLbtBGFLFlD/3StVZYhA==
X-Google-Smtp-Source: ABdhPJwSUdwQwSpPAytXdDwbMLLBE33ehb1xconZN/4kV671WY4xwP2n2b/UJPP6fZW+76Tdakm1BQ==
X-Received: by 2002:a17:907:972a:b0:6f4:f456:50a7 with SMTP id jg42-20020a170907972a00b006f4f45650a7mr5067382ejc.431.1652461992003;
        Fri, 13 May 2022 10:13:12 -0700 (PDT)
Received: from kwango.local (ip-89-102-68-162.net.upcbroadband.cz. [89.102.68.162])
        by smtp.gmail.com with ESMTPSA id yl16-20020a17090693f000b006f4c82c2b12sm981043ejb.19.2022.05.13.10.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:13:11 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 5.18-rc7
Date:   Fri, 13 May 2022 19:12:59 +0200
Message-Id: <20220513171259.30821-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a:

  Linux 5.18-rc6 (2022-05-08 13:54:17 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc7

for you to fetch changes up to 642d51fb0775a41dd6bb3d99b5a40c24df131c20:

  ceph: check folio PG_private bit instead of folio->private (2022-05-10 09:48:31 +0200)

----------------------------------------------------------------
Two fixes to properly maintain xattrs on async creates and thus
preserve SELinux context on newly created files and to avoid improper
usage of folio->private field which triggered BUG_ONs, both marked for
stable.

----------------------------------------------------------------
Jeff Layton (1):
      ceph: fix setting of xattrs on async created inodes

Xiubo Li (1):
      ceph: check folio PG_private bit instead of folio->private

 fs/ceph/addr.c | 11 +++++++----
 fs/ceph/file.c | 16 +++++++++++++---
 2 files changed, 20 insertions(+), 7 deletions(-)
