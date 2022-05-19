Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A8852CF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiESJYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbiESJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7385D5EDF5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652952252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hrzM/tU7AW7fzp6ZTPFIPv0ZgmNmcU4f6OeaVEaoW64=;
        b=Qf5aFX5cd+/kG1PqJAVfOW731RisQOVy3UVnlngUIi7u0ApnyQ5AIAs4x+07jxXneaYJXk
        u+KQjATUl8CcDD/JsJlSQwBM0QfjbxJQX/SXpr+kmOJd3BK5Ezjc0TMOCcX6zCrqsTH2q/
        Pj6HGz0mltga44faHM2qnpD0UPS/EA4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-lLdial0zNseOTrNbng-uyA-1; Thu, 19 May 2022 05:24:11 -0400
X-MC-Unique: lLdial0zNseOTrNbng-uyA-1
Received: by mail-wr1-f69.google.com with SMTP id w20-20020adfd1b4000000b0020cbb4347e6so1346971wrc.17
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hrzM/tU7AW7fzp6ZTPFIPv0ZgmNmcU4f6OeaVEaoW64=;
        b=e0CTL8zIAMNbL7Eo2AOV5RkdsvskhCm/qnOksL14+YVfIKVcZBkzme0gd+PP3zC1v6
         b97rWItyTs+pUpf6PfR6sRgGp2t4tch0MoJuBUD4Qsvg7YF5W2h2EEfNlUD3WTpTgUZw
         7xtlJg+vI/kMIXDi5hpGe2iUDVZjUSm6Iro7UeyHs2PNTCPCxecDtijBUJy0gVu6I001
         ydcH36uzyH3ydwDNjsyxqPnr4RKVNiQnGU/88E+hAKmLP98HG1eXSq44xamSrYKtZAVB
         60ap4BLkgmiUK//ty2ATedbQGig5bCJvvQdUkge/t5NblGgZZS941oFIVGwrvTkqALSy
         cj2w==
X-Gm-Message-State: AOAM531KjI7YinfCvsZH0Ej6todzGPe08uVgf9cx2A/yUX0oQxqrFpYO
        tejedtHnj6EZpF8RQ99yovfQmODz5Rtvgv6R6Tp3odJhqyMi+VJZ/69YbKvC0cHv3VxSfwjEIX8
        8DOtvl5o5pqAIPMnCu3Cnkcy1+jXe5EhD6kgB/N8DZnL5D+x7A8lNpuYZkrGn/Gi4SZ+XP659pa
        0=
X-Received: by 2002:adf:d1cd:0:b0:20c:51c6:5d9f with SMTP id b13-20020adfd1cd000000b0020c51c65d9fmr3228291wrd.244.1652952249482;
        Thu, 19 May 2022 02:24:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaHoONv38R2sfYbYYfdj55s184jaaTcZJjO0wlpMG3de/EGqr/Ap2E0apr1jSAW1ryJpW1qA==
X-Received: by 2002:adf:d1cd:0:b0:20c:51c6:5d9f with SMTP id b13-20020adfd1cd000000b0020c51c65d9fmr3228259wrd.244.1652952249207;
        Thu, 19 May 2022 02:24:09 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d6b8a000000b0020c5253d8fasm4104647wrx.70.2022.05.19.02.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 02:24:08 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/3] fat: add support for the renameat2 RENAME_EXCHANGE flag
Date:   Thu, 19 May 2022 11:23:40 +0200
Message-Id: <20220519092343.2776414-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series add support for the renameat2 system call RENAME_EXCHANGE flag
(which allows to atomically replace two paths) to the vfat filesystem code.

There are many use cases for this, but we are particularly interested in
making possible for vfat filesystems to be part of OSTree [0] deployments.

Currently OSTree relies on symbolic links to make the deployment updates
an atomic transactional operation. But RENAME_EXCHANGE could be used [1]
to achieve a similar level of robustness when using a vfat filesystem.

Patch #1 is just a preparatory patch to introduce the RENAME_EXCHANGE
support in patch #2 and finally patch #3 adds some kselftests to test it.

This is my first contribution to the fs/* subsystem, so I'm marking this
set as RFC, in case I got anything wrong with the patches. But they work
correctly on my local testing.

[0]: https://github.com/ostreedev/ostree
[1]: https://github.com/ostreedev/ostree/issues/1649


Javier Martinez Canillas (3):
  fat: add a vfat_rename2() and make existing .rename callback a helper
  fat: add renameat2 RENAME_EXCHANGE flag support
  selftests/filesystems: add a vfat RENAME_EXCHANGE test

 MAINTAINERS                                   |   1 +
 fs/fat/namei_vfat.c                           | 172 +++++++++++++++++-
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fat/Makefile        |   7 +
 .../testing/selftests/filesystems/fat/config  |   2 +
 .../filesystems/fat/rename_exchange.c         |  37 ++++
 .../filesystems/fat/run_fat_tests.sh          |  80 ++++++++
 7 files changed, 293 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fat/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fat/config
 create mode 100644 tools/testing/selftests/filesystems/fat/rename_exchange.c
 create mode 100755 tools/testing/selftests/filesystems/fat/run_fat_tests.sh

-- 
2.35.1

