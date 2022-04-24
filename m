Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A250D046
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 09:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiDXHrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 03:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiDXHrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 03:47:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C20C1EC58
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:44:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s21so1985250wrb.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=JCfw56DqPD63IN1Jtn8E5wnFILfOiHHBUq1n8WYVzHc=;
        b=jwjZMLIYgtKG7DUBm7h0R4oVkjX+Nlf/fiFoM57mxWNaQxgyv5k1P2ZkJsNFBa6cR/
         vDlCKFwOn/U+C7/4P+c8hJpWz15EcNxgvqAX17uDD+2fuBTQduYNklN2jsspa3/QzzB3
         La3MgvN5QXSKGaWSjc04FAcC0B3o14J/irK7UalJTIv3M8/fwq1XPiVqujgvCMNqJt+2
         CSyGHABvxEGzxZyZmV67UYVSvTeYrK01L8JU/2CxATzrMWDr0GjCuAdDtkiLmWdlIk9q
         2XrdTVI6u9fAMtrrFgEO1x/hoAmau7TNTD76ScVHEiOFngU9gxJfCgvM64ruLYAPGGUT
         n5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=JCfw56DqPD63IN1Jtn8E5wnFILfOiHHBUq1n8WYVzHc=;
        b=kjBdXpFGcXxePnouez5Qah6yawfdRwYuTfMg/IlqRMMLZzRfSfEmbouKWfH5DUWWqy
         kFaQvxXNJ/t56ay2KqT5De2tMf3F4IOWq+3NQ7oJm3DIFt/PdBF4Pf81rLvFjD1EDtmk
         YszZx77QgTz3iarbfGaCP9YsOqWrisp8JYSwB3Ow/EZO/T3scSF0pCXgzHnjpyU6ZqIQ
         XVqDjfzEIvVNvCEl9P7RYlzqGOawQzkKmwtbylwH5zDxlxM+c4yf6ofX3icItaEERf3X
         LeP7AlsuC3lE37jsZaC7WHVYfk9tZWdRFdACz+EdspTlypDM/HA9Qj/h7ofah8lMUd5T
         Qs6Q==
X-Gm-Message-State: AOAM530dXV+xINOq8Aq4/XbaLIjUCR6XGVhASVN5WrkP4bkgmrzhT0t3
        oo2AopJ4hSz224WqQuazHEGGviJkUVQ=
X-Google-Smtp-Source: ABdhPJw6WooW9KRevKn7VmHoE+mR1uaPHvUWRg05gO1BqTUHssCYxFowPJ3izZuTTVbIv6rCwa4boA==
X-Received: by 2002:adf:f481:0:b0:205:b814:887b with SMTP id l1-20020adff481000000b00205b814887bmr9902652wro.472.1650786242749;
        Sun, 24 Apr 2022 00:44:02 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b0039291be4573sm8742638wmq.1.2022.04.24.00.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 00:44:02 -0700 (PDT)
Date:   Sun, 24 Apr 2022 09:44:00 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] staging: vt6655: Replace macro VNSvInPortW,D with
 ioread16,32()
Message-ID: <cover.1650784817.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvInPortW with ioread16 and VNSvInPortD with ioread32.
Avoid cast of the return value is possible with one exception.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Since there are more than one checkpatch issue per line,
more steps are rquired to fix all issues.

This patch series is new but the first and last patch are already in V4.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (5):
  staging: vt6655: Replace VNSvInPortW with ioread16
  staging: vt6655: Replace MACvReadMIBCounter with VNSvInPortD
  staging: vt6655: Replace MACvReadISR with VNSvInPortD
  staging: vt6655: Replace two VNSvInPortD with ioread64_lo_hi
  staging: vt6655: Replace VNSvInPortD with ioread32

 drivers/staging/vt6655/card.c        |  4 ++--
 drivers/staging/vt6655/device_main.c |  6 +++---
 drivers/staging/vt6655/mac.h         | 28 +++++++++++-----------------
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/upc.h         |  6 ------
 5 files changed, 17 insertions(+), 29 deletions(-)

-- 
2.25.1

