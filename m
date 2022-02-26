Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672E14C55D3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 13:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiBZMj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 07:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiBZMj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 07:39:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A916D1DDFFC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 04:39:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v21so8317066wrv.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 04:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vJQYYoc8JevLxaR53UNZSRH967gie6KVAELV8qUGv5k=;
        b=CuBKW7FmZncTaVEJR4uMoB5+7in9yKEfwRe0FQ8Y7RknSIdaF4gS4sZ4GCe7R1F4CQ
         OWU69lvCKymDONW6yM937QqdmvRd8Ta0Xw9gK9Jy+KHL0vAb+SX8nLXLrAQU7Ao+Rjnu
         TjbvNBqhjijegaUPpmzF+51nubY4mcobZEp9js1WeKirBiweptwl727JHIZOjbIDOHgC
         phppqb9cIEHji7tW6uQQmwPYa7cyibjyNYswSa91v2p0NLPOO2Rt0S6WatduG4rQwoYO
         8P4hqDRD9I3sOJU56TECk4OIZ7FEzl/qeMqbSxl8EHjAXyRAzcRr6xqhdaI8caUTUNaj
         ywcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vJQYYoc8JevLxaR53UNZSRH967gie6KVAELV8qUGv5k=;
        b=lhPd2oD9PVK9mt2On/KKoGsBzYPaELAggZCXbA3hPfnlsX/pmjGk3qV0/5Tr8Zbtw3
         MoYB+IV5SL1jB2WORi9YkbSBhkfRxQOFSUDQ4KZt2IbSSTn8iDestb0PZylU/Ohe2Njr
         mrkFWwRnfRRFrMJcuYZgxoOJnsThq1siLb+qJ4c89SkQTzkoraJT31wCmdXTrkzcogR0
         HHVOzFDQpi2ecaiA+J99o+DJMmWTVno9spwVtKMnPK7Ec2k1iN2Al0EE1lV0Fl/1asev
         9i7Y6lZBKmya8MYrQmVOAC+ZEXWEg8juD3vlcanmvXfbICxmlwWw4WJhR8o/pCmr9VaJ
         LxLA==
X-Gm-Message-State: AOAM531x9Im7q5WemGoB9sFgQMEFU2Thee/Q3k9mMhPC9U0qShh0EH1D
        Zvnt5MWfcR+na9HauU+mDT0=
X-Google-Smtp-Source: ABdhPJzM8qWVgLDr6AJE7BNZEFwtDvAPnToL2Gwpq13kzNFB0g1GtPZrpQHWwqSIsB+tiKy5z6irgg==
X-Received: by 2002:a05:6000:188f:b0:1eb:7c15:588c with SMTP id a15-20020a056000188f00b001eb7c15588cmr9758773wri.619.1645879161113;
        Sat, 26 Feb 2022 04:39:21 -0800 (PST)
Received: from debian (host-78-145-97-89.as13285.net. [78.145.97.89])
        by smtp.gmail.com with ESMTPSA id r42-20020a05600c322a00b00380dc2e0d63sm8237627wmp.1.2022.02.26.04.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 04:39:20 -0800 (PST)
Date:   Sat, 26 Feb 2022 12:39:18 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: regression: Build failure of mainline kernel with qcom_defconfig
Message-ID: <YhofdlzadzRmy7tj@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, All,

We recently noticed that arm "qcom_defconfig" failed to build with the error:

arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-edp.o: in function `panel_edp_probe':
drivers/gpu/drm/panel/panel-edp.c:843: undefined reference to `drm_panel_dp_aux_backlight'

I have done a bisect and it points to:
9d6366e743f3 ("drm: fb_helper: improve CONFIG_FB dependency")

Here is the complete bisect log:

# bad: [df0cc57e057f18e44dac8e6c18aba47ab53202f9] Linux 5.16
# good: [8bb7eca972ad531c9b149c0a51ab43a417385813] Linux 5.15
git bisect start 'v5.16' 'v5.15'
# good: [2219b0ceefe835b92a8a74a73fe964aa052742a2] Merge tag 'soc-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 2219b0ceefe835b92a8a74a73fe964aa052742a2
# good: [206825f50f908771934e1fba2bfc2e1f1138b36a] Merge tag 'mtd/for-5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
git bisect good 206825f50f908771934e1fba2bfc2e1f1138b36a
# bad: [4e1fddc98d2585ddd4792b5e44433dcee7ece001] tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows
git bisect bad 4e1fddc98d2585ddd4792b5e44433dcee7ece001
# good: [dbf49896187fd58c577fa1574a338e4f3672b4b2] Merge branch 'akpm' (patches from Andrew)
git bisect good dbf49896187fd58c577fa1574a338e4f3672b4b2
# bad: [0ecca62beb12eeb13965ed602905c8bf53ac93d0] Merge tag 'ceph-for-5.16-rc1' of git://github.com/ceph/ceph-client
git bisect bad 0ecca62beb12eeb13965ed602905c8bf53ac93d0
# bad: [304ac8032d3fa2d37750969cd4b8d5736a1829d9] Merge tag 'drm-next-2021-11-12' of git://anongit.freedesktop.org/drm/drm
git bisect bad 304ac8032d3fa2d37750969cd4b8d5736a1829d9
# good: [f78e9de80f5ad15719a069a4e6c11e2777122188] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git bisect good f78e9de80f5ad15719a069a4e6c11e2777122188
# good: [806acd381960008700c15c3dc616d578e9558853] Merge tag 'amd-drm-fixes-5.16-2021-11-03' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
git bisect good 806acd381960008700c15c3dc616d578e9558853
# bad: [f8ca7b74192b2e64bdfb89fb63c1d33b92bc899d] Merge tag 'drm-misc-next-fixes-2021-11-10' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
git bisect bad f8ca7b74192b2e64bdfb89fb63c1d33b92bc899d
# good: [cecbc0c7eba7983965cac94f88d2db00b913253b] drm/i915/hdmi: Turn DP++ TMDS output buffers back on in encoder->shutdown()
git bisect good cecbc0c7eba7983965cac94f88d2db00b913253b
# bad: [14d9a37c952588930d7226953359fea3ab956d39] Revert "drm/imx: Annotate dma-fence critical section in commit path"
git bisect bad 14d9a37c952588930d7226953359fea3ab956d39
# good: [5591c8f79db1729d9c5ac7f5b4d3a5c26e262d93] drm/udl: fix control-message timeout
git bisect good 5591c8f79db1729d9c5ac7f5b4d3a5c26e262d93
# bad: [9d6366e743f37d36ef69347924ead7bcc596076e] drm: fb_helper: improve CONFIG_FB dependency
git bisect bad 9d6366e743f37d36ef69347924ead7bcc596076e
# good: [e0e6d1ea18c804de51b47fa65092c4cf2000604c] MAINTAINERS: dri-devel is for all of drivers/gpu
git bisect good e0e6d1ea18c804de51b47fa65092c4cf2000604c
# first bad commit: [9d6366e743f37d36ef69347924ead7bcc596076e] drm: fb_helper: improve CONFIG_FB dependency


And, indeed reverting "9d6366e743f37d36ef69347924ead7bcc596076e" on top of
9137eda53752 ("Merge tag 'configfs-5.17-2022-02-25' of git://git.infradead.org/users/hch/configfs")
fixes the build.

I will be happy to test any patch fxing this issue.


--
Regards
Sudip
