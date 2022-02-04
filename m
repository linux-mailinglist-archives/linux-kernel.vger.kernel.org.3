Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CE24A99C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352852AbiBDNPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350186AbiBDNPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:15:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B80CC061714;
        Fri,  4 Feb 2022 05:15:02 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m11so13078635edi.13;
        Fri, 04 Feb 2022 05:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wlf/9/9pC1/FBmXcXyBT4VyTkvuSdtfrd6W4gAtkuYY=;
        b=ffPb315I/3bwNF2HMPkoa2aCMni5mGXcD2a50QtmHSVJyV3Q0V+sAAk8bU6CvZdSWG
         VJddLmCSy2+7Ww8mc1sHz1IrOp+HIduGuRqSDLAxVLAwnGE/Ux4equHwBsO7rE2VHR56
         9XJZ8Cq7+SU6wdgJLqpyRWWy9dUFqXV9M/AV6W0UPPJmzNlDZNr7WzJoJx2PQ586mg59
         bfP+lrUFMgPDIzar5Kv4BkxHUCkTtbjcvCiIL9ECzIGg79NuRnVL8fgRnVlKwfCSEblN
         HNHvh/lE8pTWXXl+k77ctfNbJJZkPw6P9yAUbtYQYQxA7DiZKO2cJ0/YzY6OVbaJ87Z6
         PKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wlf/9/9pC1/FBmXcXyBT4VyTkvuSdtfrd6W4gAtkuYY=;
        b=tGMqvzzT0lpGh6Jg+eamr0XTU4Tovrfs7lc3z5/RihQe9XzSfI989w30Xkc9dZsw+4
         XSbiRsHg8dyvY8kjkxBSD2nHHb+2kuFmBp4Y4csZE+qk01ofu7u75ViYo8GDJZC7Oevh
         RRXZB9rB+ST8FdEEiAflHSdKoLk69Mohdog9q3IiBjY9oadIW0U/EH1wdmVzdLVcmWeW
         ezYSrg5Q4R4NpQT5+572ujjSJEcl7X9GXUlfKkqJvRFnS6iBOgFSy9ziqjko+SACL7d5
         mTm2ZnYnrOxEE2MmGNB5WzheLUFeWeXeamJ5flHMT4qrRcsp1qKDNLG1V52JmsvY6S7l
         ml9g==
X-Gm-Message-State: AOAM531WiodUaReOqTdO3i2BpNcwh5o16GvRToGcc4lNrxBJiqGf4o/h
        2QbMluwA/MZ72Se/YomXDYw=
X-Google-Smtp-Source: ABdhPJwsVYGu3pqboKYhFBhnfnS2t7meLiUDAYHcpfj8EeYrCAkgIiO+Jge6E5oUfCxeN/L6rO3DzA==
X-Received: by 2002:a05:6402:520d:: with SMTP id s13mr2958767edd.132.1643980500495;
        Fri, 04 Feb 2022 05:15:00 -0800 (PST)
Received: from kwango.redhat.com (ip-89-102-68-162.net.upcbroadband.cz. [89.102.68.162])
        by smtp.gmail.com with ESMTPSA id z6sm655157ejd.35.2022.02.04.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:15:00 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 5.17-rc3
Date:   Fri,  4 Feb 2022 14:15:18 +0100
Message-Id: <20220204131518.13859-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-5.17-rc3

for you to fetch changes up to 038b8d1d1ab1cce11a158d30bf080ff41a2cfd15:

  libceph: optionally use bounce buffer on recv path in crc mode (2022-02-02 18:50:36 +0100)

----------------------------------------------------------------
A patch to make it possible to disable zero copy path in the messenger
to avoid checksum or authentication tag mismatches and ensuing session
resets in case the destination buffer isn't guaranteed to be stable.

----------------------------------------------------------------
Ilya Dryomov (2):
      libceph: make recv path in secure mode work the same as send path
      libceph: optionally use bounce buffer on recv path in crc mode

 include/linux/ceph/libceph.h   |   1 +
 include/linux/ceph/messenger.h |   5 +
 net/ceph/ceph_common.c         |   7 ++
 net/ceph/messenger.c           |   4 +
 net/ceph/messenger_v1.c        |  54 ++++++++-
 net/ceph/messenger_v2.c        | 250 ++++++++++++++++++++++++++++++-----------
 6 files changed, 251 insertions(+), 70 deletions(-)
