Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DBB5150B7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379045AbiD2Q3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379069AbiD2Q3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:29:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F67E2F3B4;
        Fri, 29 Apr 2022 09:25:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j6so16378568ejc.13;
        Fri, 29 Apr 2022 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34ayCITa8dYXGWWB8WPXJjeaFblJYmeptb2kr7f4iU0=;
        b=TVUvbwegaQnGqR701zJMdkgQYCmrWcgThTVJv525MgEI7D8In96qWO3QbDarjNy2pc
         ff+RskPVhDbyoZqNw8Max195h9GW3cih/zFhlP+mV792xxgMGDa2a2pBTbCU7A1vHsY5
         L0KQKWBdn/Ta9cG1qicPqtWiF4T5i/iIEnMPdnUBLO7hznutdRBS3NYPE+rVYRNmWeYk
         OWIKm5v+Jk4DmrLxu/vDI7WdjcJcNJs1+NX/lnOId/bBFY8zKApua1hFwxqX/AaBClq+
         oIJMhU7qn6cQ3kYuRfyGNRRpPCl+W+7PQf6hfHcau3mTPEm7ZtEdzO54uzqqcpTjrmC8
         BQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34ayCITa8dYXGWWB8WPXJjeaFblJYmeptb2kr7f4iU0=;
        b=rhTfUtR44mWTzoHGWNw6GVwYUbXWlHgvjzv9cvyPfRM3jU4Ae8HKkF2EjhNDoSvq06
         wXmGIcEhdd07ceb6v1xJgSMvOj4fMcd+l4zRIwRzMWtNnEJKpbFOJE8C3o5ZVsgMZe1v
         ogfz5DxzTDYsyd+m+XQfbAfbrZIDb6brDNLcgg+HRiF7T9DfG4kYHyWBTP8t/xkVHB0q
         up3aXs24Cn6zIMnKm0wW/IEeDqFTpC+KbmUfE3ZHMIjSTfqgwuc0shp/av51feT36R++
         AWnfVi5//u8BuLpAf1E7KDbiy4pCXPgUSS8wI5lxdEaX6Nz2exBoBRm7ozLcBIy7VXes
         cUMw==
X-Gm-Message-State: AOAM531zISht4DUkDzsiMyXygqAgDJVxMGlYqKdgUSkutF4VeqPrQB3C
        JD847npuxS/njl0Dzz0A2Lufxf4E4z8=
X-Google-Smtp-Source: ABdhPJygZpqG8r2RdCHY31zc347HxwMs8a69/wpgogUHXVsdaCEvTah0m2+kRKpqMoR5eYoHCbInaQ==
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr91511ejc.287.1651249542790;
        Fri, 29 Apr 2022 09:25:42 -0700 (PDT)
Received: from kwango.local (ip-89-102-68-162.net.upcbroadband.cz. [89.102.68.162])
        by smtp.gmail.com with ESMTPSA id hf27-20020a1709072c5b00b006f3ef214e33sm779584ejc.153.2022.04.29.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:25:42 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 5.18-rc5
Date:   Fri, 29 Apr 2022 18:26:32 +0200
Message-Id: <20220429162632.29934-1-idryomov@gmail.com>
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

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.18-rc5

for you to fetch changes up to 7acae6183cf37c48b8da48bbbdb78820fb3913f3:

  ceph: fix possible NULL pointer dereference for req->r_session (2022-04-25 10:45:50 +0200)

----------------------------------------------------------------
A fix for a NULL dereference that turns out to be easily triggerable
by fsync (marked for stable) and a false positive WARN and snap_rwsem
locking fixups.

----------------------------------------------------------------
Ilya Dryomov (1):
      libceph: disambiguate cluster/pool full log message

Niels Dossche (1):
      ceph: get snap_rwsem read lock in handle_cap_export for ceph_add_cap

Xiubo Li (2):
      ceph: remove incorrect session state check
      ceph: fix possible NULL pointer dereference for req->r_session

 fs/ceph/caps.c        | 7 +++++++
 fs/ceph/mds_client.c  | 6 ------
 net/ceph/osd_client.c | 6 +++++-
 3 files changed, 12 insertions(+), 7 deletions(-)
