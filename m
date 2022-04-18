Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC673505F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347981AbiDRVSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbiDRVSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:18:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793C82CE18
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:16:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id k14so21126981pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 14:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8XJRkQ+Ngj+SVndYkt5Kqwy78yKeKiW3fonsocHm3g=;
        b=J1vTHu7C5Uh3f4LfAcKQPO/5Pz9IYhPGuzvmzDr/r76LDgWCFm6fpTDSrrFHEEVVIx
         HoP+BhBTxIiOZ7XsJWw/ir1ytJ3YVKtGcIHkRd/zEskK37Gf+Vg1VyHaF6EzqMYxqYqD
         bUrRL1EQr8iUt/oCRE7WlIxQqTZeCfihNOTrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/8XJRkQ+Ngj+SVndYkt5Kqwy78yKeKiW3fonsocHm3g=;
        b=rI+6gMYHFLlId6NNGrlMPABgAvLj7MhTCmnl8PjF8QI9S/D87Ush6WO10LUJiwbaGY
         tqLr9HK1pUhBTnCP5E6VL4GQhECJIQRXBKZAa+hX1ut+uHKjpheIkqh4/JpspdbmX0Xa
         GE0Ofs8gH6fvtJtN5+77jY4sPdgqZsKCoiqXD26+XLwTcdLSy6Itk+yJBeJgoq56GHO9
         tPnhy2ct8KHecI7xdqoCpGqJCv0EnOjVSXzC6MvoeZIEMwfiat92B4tjXsLrpTnixkov
         wPUOEP7gAKn9MZWcPAtDZgQRSnFdmH3ugS7VEsSAU7CEkF6u3OzNGlGyyT/YwWUkraAQ
         T6iw==
X-Gm-Message-State: AOAM53220VXmKmAzdXf1uY9NHGuFJflFMl8KMVoLqNQGk3WZIrIRDicZ
        XHSP5e4QMsyUFzf1kgnkqOaFBw==
X-Google-Smtp-Source: ABdhPJy4XB+bbS97AAyRfwYXg0SHO4S5mnpEPALFnmvLrX6gjHaVLEhGa0FV74GcCXM0EQkzZfmXGg==
X-Received: by 2002:a63:1543:0:b0:39d:9729:1992 with SMTP id 3-20020a631543000000b0039d97291992mr11756352pgv.155.1650316565036;
        Mon, 18 Apr 2022 14:16:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b32:a0a5:ec32:c287])
        by smtp.gmail.com with UTF8SMTPSA id y23-20020a056a00181700b0050839558f4bsm14438421pfa.40.2022.04.18.14.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 14:16:04 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>, dm-devel@redhat.com,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/3] LoadPin: Enable loading from trusted dm-verity devices
Date:   Mon, 18 Apr 2022 14:15:56 -0700
Message-Id: <20220418211559.3832724-1-mka@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now LoadPin restricts loading of kernel files to a single
pinned filesystem, typically the rootfs. This works for many
systems, however it can result in a bloated rootfs (and OTA
updates) on platforms where multiple boards with different
hardware configurations use the same rootfs image. Especially
when 'optional' files are large it may be preferable to
download/install them only when they are actually needed by a
given board. Chrome OS uses Downloadable Content (DLC) [1] to
deploy certain 'packages' at runtime. As an example a DLC
package could contain firmware for a peripheral that is not
present on all boards. DLCs use dm-verity [2] to verify the
integrity of the DLC content.

This series extends LoadPin to allow loading of kernel files
from trusted dm-verity devices. It adds the concept of
trusted verity devices to LoadPin. Userspace can use the
new systl file 'loadpin/trusted_verity_root_digests' to
provide LoadPin with a list of root digests from dm-verity
devices that LoadPin should consider as trusted. When a
kernel file is read LoadPin first checks (as usual) whether
the file is located on the pinned root, if so the file can
be loaded. Otherwise, if the verity extension is enabled,
LoadPin determines whether the file is located on a verity
backed device and whether the root digest of that device
is in the list of trusted digests. The file can be loaded
if the verity device has a trusted root digest.

The list of trusted root digests can only be written once
(typically at boot time), to limit the possiblity of
attackers setting up rogue verity devices and marking them
as trusted.

[1] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md
[2] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html


Matthias Kaehlcke (3):
  dm: Add verity helpers for LoadPin
  LoadPin: Enable loading from trusted dm-verity devices
  dm: verity-loadpin: Use CONFIG_SECURITY_LOADPIN_VERITY for conditional
    compilation

 drivers/md/Makefile               |   1 +
 drivers/md/dm-verity-loadpin.c    |  80 ++++++++++++++
 drivers/md/dm-verity-target.c     |  34 ++++++
 drivers/md/dm-verity.h            |   4 +
 include/linux/dm-verity-loadpin.h |  27 +++++
 security/loadpin/Kconfig          |  11 ++
 security/loadpin/loadpin.c        | 168 +++++++++++++++++++++++++++++-
 7 files changed, 324 insertions(+), 1 deletion(-)
 create mode 100644 drivers/md/dm-verity-loadpin.c
 create mode 100644 include/linux/dm-verity-loadpin.h

-- 
2.36.0.rc0.470.gd361397f0d-goog

