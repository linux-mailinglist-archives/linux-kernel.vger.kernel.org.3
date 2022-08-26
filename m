Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A05A21D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbiHZH3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiHZH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:29:20 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8213793536
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:29:19 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-334dc616f86so15496307b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=6zClePGdSrmNHE+Zydb35j5M023LVnuqH4ddTSBSLs0=;
        b=ZVgljG11h3Cbor6dD4xuriIAFqPgI9J2pzaK/B5sLA+1nTmuqZLMEo1NHWWEoV7/cV
         NQwxhVKGregYumzo0MgnVTZDSDNOv6OXDJ47OgLKzDYTTov7XVpu2w940v7MOtev7i4p
         Ro7Z3FYJzVogAKoMgWrjdQPyUdQFbFT2JjwCa6JOBZgtFZgbh18Wi8xDQpONMcdPL32V
         M7tJVNLbPv04q0uBQNq2RP3uQR1haMcql+hb3D5Dw6dEueEEEBNk7eH/rrMmsh7Fy+cS
         3mZgGOlStujexqlLiBTe+ySfEPZya/Q42ye3v7IZ/++GNYT5YrUA4rg0yaVEQZDkJNC6
         jDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=6zClePGdSrmNHE+Zydb35j5M023LVnuqH4ddTSBSLs0=;
        b=KstUnYn0b3d5s84BVAXaQCbpRcQHl1grVx4khMDzcBW0eL3nr/eV1PCuPO+qR8MQii
         mZ5hJM8CZge8lZFyHHziPR9YJtFiixts5/fovYC32eva20ntjCdQq6evva2WSME2AWmp
         jzi1aB1jWntSayWA70X32s1cEW0fVjmJpqt/rtmJECMXLMv5NCgPntDRuCRHzkFqMm8A
         AT+ZTIOLquCS8bpFNTcZo/cO7CM1mtm4TaApp+R7xmVqSnFwc/x7JgPAp1QVfhxyYLqc
         Afw+hEOt1TNyfNCDYX/VCXN/o4yMDQtYz0DIOVQpeCXFFW1ZszdUtX1QuO/rH7rndu6N
         oxQg==
X-Gm-Message-State: ACgBeo3SrmowwwO/kRLATE3PcNxqfSKyWtxMy+CUSv3CRZi7HfCxu877
        SColfOEpVs9XojXiDznmz2Ybd8oBogvg8r1ggLaClyNygg==
X-Google-Smtp-Source: AA6agR6Li9lZ0FLFxeRJ6XC8voY4czmMwBj9i+ohWGMxbwmdIlvIqEVJUuV3B//ymiWOzRfP5cbrxIaZcsxheuAKD1o=
X-Received: by 2002:a0d:f144:0:b0:33d:a554:b9b6 with SMTP id
 a65-20020a0df144000000b0033da554b9b6mr7524658ywf.172.1661498958417; Fri, 26
 Aug 2022 00:29:18 -0700 (PDT)
MIME-Version: 1.0
From:   Fabio Comolli <fabio.comolli@gmail.com>
Date:   Fri, 26 Aug 2022 09:28:42 +0200
Message-ID: <CAC8pb096of7ddN1YepfnKCpbNtUv1Au5EHq7=b5z9bL4f83Y_w@mail.gmail.com>
Subject: [BISECTED][REGRESSION] Kernel 6.0-rcX hangs on resume on Sony Vaio VPCM13M1E
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My old Sony Vaio hangs on resume, either from suspend or from
hibernation, when running the latest 6.0-rc kernels. All is fine with
all the previous releases, 5.19.x included.

I bisected to:

commit 88f1669019bd62b3009a3cebf772fbaaa21b9f38
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Thu Jun 30 12:57:03 2022 -0700

    scsi: sd: Rework asynchronous resume support

This commit reverts cleanly even with yesterday's git tree and the
resulting kernel works as expected.

Bisection log:

git bisect start
# status: waiting for both good and bad commits
# good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
# status: waiting for bad commit, 1 good commit known
# bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
# good: [b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1] Merge tag
'drm-next-2022-08-03' of git://anongit.freedesktop.org/drm/drm
git bisect good b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
# bad: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag
'mm-stable-2022-08-03' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 6614a3c3164a5df2b54abb0b3559f51041cf705b
# good: [c040862bfbd9c5f3cb64e1df1c623e20e38fe656] Merge tag
'xtensa-20220804' of https://github.com/jcmvbkbc/linux-xtensa
git bisect good c040862bfbd9c5f3cb64e1df1c623e20e38fe656
# bad: [746fc76b820dce8cbb17a1e5e70a1558db4d7406] Merge tag
'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect bad 746fc76b820dce8cbb17a1e5e70a1558db4d7406
# good: [36001a2fa6cc63d58664a2a99b90a864f9eb587a] Merge tag
'clk-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect good 36001a2fa6cc63d58664a2a99b90a864f9eb587a
# good: [eff0cb3d91c06acbb957be1134a07afa2c4978e3] Merge tag
'pci-v5.20-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect good eff0cb3d91c06acbb957be1134a07afa2c4978e3
# bad: [4ecc9b0271a7623deabcbe8fcb39f065701d8f74] scsi: lpfc: Fix
uninitialized cqe field in lpfc_nvme_cancel_iocb()
git bisect bad 4ecc9b0271a7623deabcbe8fcb39f065701d8f74
# good: [bc602ae977f3e6d47cd4c9c7aebc431019206712] scsi: ufs:
ufs-mediatek: Support flexible parameters for SMC calls
git bisect good bc602ae977f3e6d47cd4c9c7aebc431019206712
# good: [cc06af0bbc21bcee40d57e3ee569d3a09741dafd] scsi: trace: Print
driver_tag and scheduler_tag in SCSI trace
git bisect good cc06af0bbc21bcee40d57e3ee569d3a09741dafd
# good: [bcec04b3cce4c498ef0d416a3a2aaf0369578151] scsi: ufs:
ufs-qcom: Remove unneeded code
git bisect good bcec04b3cce4c498ef0d416a3a2aaf0369578151
# good: [34bd1dcacf0dd86ab8c35f703bc237723fee354c] scsi: target:
Detect UNMAP support post configuration
git bisect good 34bd1dcacf0dd86ab8c35f703bc237723fee354c
# good: [158da6bcae7a66e631bbec458f35ea3bd0ac5d71] scsi: gvp11:
Convert m68k WD33C93 drivers to DMA API
git bisect good 158da6bcae7a66e631bbec458f35ea3bd0ac5d71
# good: [90552cd2d1f962478f1bb426c686540cbd145bec] scsi: core: Move
the definition of SCSI_QUEUE_DELAY
git bisect good 90552cd2d1f962478f1bb426c686540cbd145bec
# bad: [11e50ed239b5b7f383874dd737283ae93f62ece3] Merge branch
'5.19/scsi-fixes' into 5.20/scsi-staging
git bisect bad 11e50ed239b5b7f383874dd737283ae93f62ece3
# bad: [88f1669019bd62b3009a3cebf772fbaaa21b9f38] scsi: sd: Rework
asynchronous resume support
git bisect bad 88f1669019bd62b3009a3cebf772fbaaa21b9f38
# first bad commit: [88f1669019bd62b3009a3cebf772fbaaa21b9f38] scsi:
sd: Rework asynchronous resume support

Please let me know if you need more details and CC: me as I'm not
subscribed to linux-kernel.

Fabio Comolli
