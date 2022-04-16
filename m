Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A74050350F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiDPIDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiDPIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:03:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A070B22BDB
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:00:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg10so18830844ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Dy9NVvNam0L8zHglHXPoxAqQ3OYdtJr8sHvqtEWsj7k=;
        b=ktsgcYkQAwOFPWBEz6P2RO8QjhkB79KJFA7pd/hA8x8lU9SHfoMz72UVoA+6/dvR+q
         Bp6edyUgQsEaEbucpcrfRSmwO6A9hdOz1nQho3xtPSNpLov5u5KOAOKDJ/Nx1A6XnIm0
         cnA71hN8kUY9FqYpSMpZJLkboDhAolECYQAUx03VkMylpzTXo/jQoEvl1bSc3LHhMUsx
         xU/LfhLpz1evmpbybqR3Qe40ymNPPyuq2Mm7wy5ZST2LhZI9JAsHxZfgkSWVRYJ+wBTE
         6g+rrtfmOKpwuWzuMUSZYWI6w0fVDpvzWGCBFZc11XiZ17oTxRQipdWm60O+ygnuTIjS
         R5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Dy9NVvNam0L8zHglHXPoxAqQ3OYdtJr8sHvqtEWsj7k=;
        b=jWyQCEJYI8RzxY9T8Uu4vVMnmZvRODM0dakpOgsC0r6JeqpK5XATAiM5XRU+3o5+2r
         EYWLc4lIWghQCLt45wU24sbEtRhIyKAgMvhedQ66hhyl3XS/VHVeSX2/rGY9TeKD5HM3
         LpJKniZoz0Q6J8WDVz+b7ZReL0jI3a5X5mHrXABnsYmosUbCZbEO+sxsGdeLmOJLGzjk
         aQN5PSD9QyPddS+6Rn9lValgMbZWJyZRYFHQVHJCMtDoHIUd+Qm8zje6nMzMhTZMZLu8
         ewtErrN3guAjk0am34GWs+BUISpLR+KFMGqKw+y3r1j7TTYaiz/vib1TWG38rpBnKvFq
         vD8g==
X-Gm-Message-State: AOAM531scOOWA4zZwt7E5qgUj0P+WJwMls/CnpbsqpYQ3D1CJP7UW6VQ
        VSSVPHgY5pOoLlv3TH2hymn3/Yw/ryc=
X-Google-Smtp-Source: ABdhPJyINHqIoWCUDaodGqw8eYSp15m+NxhmN74xmmEiqsc4AU/GpazlL2EzjDYBqDktR0Inrly8oQ==
X-Received: by 2002:a17:907:97cc:b0:6da:a8fb:d1db with SMTP id js12-20020a17090797cc00b006daa8fbd1dbmr1993714ejc.267.1650096048164;
        Sat, 16 Apr 2022 01:00:48 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm2413084ejb.220.2022.04.16.01.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 01:00:47 -0700 (PDT)
Date:   Sat, 16 Apr 2022 10:00:45 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: vt6655: Replace macro VNSvInPortB with ioread8()
Message-ID: <cover.1650094595.git.philipp.g.hortmann@gmail.com>
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

Replace macro VNSvInPortB with ioread8. Avoid cast of the return
value is possible with one exception.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

The one casting exception could be removed by changing
bb_read_embedded. Instead of having a unused return value bool
the return value could be an unsigned char.

Since there are more than one checkpatch issue per line,
more steps are rquired to fix all issues.

This patch series is new but the second patch is already in V4.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (2):
  staging: vt6655: Replace MACvGPIOIn with VNSvInPortB
  staging: vt6655: Replace VNSvInPortB with ioread8

 drivers/staging/vt6655/baseband.c    |  6 +++---
 drivers/staging/vt6655/card.c        |  2 +-
 drivers/staging/vt6655/device_main.c |  6 +++---
 drivers/staging/vt6655/mac.h         | 27 +++++++++------------------
 drivers/staging/vt6655/srom.c        |  6 +++---
 drivers/staging/vt6655/upc.h         |  3 ---
 6 files changed, 19 insertions(+), 31 deletions(-)

-- 
2.25.1

