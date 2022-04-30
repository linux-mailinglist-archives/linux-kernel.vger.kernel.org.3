Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D748B515AE1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381833AbiD3Gwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiD3Gwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:52:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A70795A3F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:49:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i27so19051220ejd.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=SsreJQYKQ3osOJJ7R4XJPTSnpgPqyNjlOrOA93ltxMg=;
        b=EbXh4L4wrahZY13aJEmPgKPSkgpoKL+X8sfKTUiZtpRW/SOWLkuKb1Dvssh5xVuZGL
         dkChXT4qwRPSKNy6wR3BfCj62j6ljqdg921BpJ3lAP/tJKUGw+SQmYEki2EMIZGUefip
         8/g61Y35vzTFfEhM/SEeue9vO+yTxzFCfNJ+cAt++iP5aOunZrZ4ZkwkU1IzsLaJinKr
         fEVXSJMkoIXPMfBsEX1ui2aWdh7hDRcqKL9KAbdCrJZOLPWs3LggDPrx4tycM9YY6g1q
         SiSqj1slHRViBnz4+UGVgVinSCVHi9393BS+SC3tw4Nlp5GRXWswlh46MMihqw0KSSt/
         hU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=SsreJQYKQ3osOJJ7R4XJPTSnpgPqyNjlOrOA93ltxMg=;
        b=iWuafpsozMpxHhrpVCVfBjfSyWWw4aJ9NVzkCQntHuOd6zTl6WqZd9OPsvP4tbWJRL
         xbYA3TfrdoLAgTENfg9+GaNc0s0hT6s/BPxMLVUMTeFfCM5rJvJpHv8oVUn+DiH/JFtE
         W7UGky9YmRflj4Cj9P8b6B4gcF8gQ5qTrWd7f4EJXzY9/HZIWz6599vHvA/QkVXKcVIk
         OQ1WSojw7S7QAzIaO+WaMyrEkl0h58I8IWRzrJl0NxG4JiWmiQInwAnRr9L8zHuDAYBK
         BtbfTMW2zWd6twIM1r7FwLfRWh74pOm07b22qfbB8LtJvFIqE9FpChZySF15dkqyYiOJ
         iGqA==
X-Gm-Message-State: AOAM532hgUDcGJmIXXFsd7Yjw+O2a9K5m//usyxnGQxlbkYs4mrrVDLE
        fLkmWL1q50CKIEvW8GjZBVpQsGq8XjnULA==
X-Google-Smtp-Source: ABdhPJzRjYImVzS8NrAIxdImHcj4dQ5BvLZRRujZ8brjvtLn+5gQ8yzypws2mYIh+ztKw7OClCR/cA==
X-Received: by 2002:a17:907:6e1e:b0:6f3:e850:2453 with SMTP id sd30-20020a1709076e1e00b006f3e8502453mr2672599ejc.147.1651301358750;
        Fri, 29 Apr 2022 23:49:18 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id l24-20020a056402029800b0042617ba63a7sm3848157edv.49.2022.04.29.23.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 23:49:18 -0700 (PDT)
Date:   Sat, 30 Apr 2022 08:49:16 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v4 0/2] staging: vt6655: Replace macro VNSvInPortD with
 ioread32()
Message-ID: <cover.1651300094.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvInPortD with ioread32.
Avoid cast of the return value as much as possible.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Added missing big-endian support in CARDbGetCurrentTSF.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

V1 -> V2: Removed patch "staging: vt6655: Replace VNSvInPortW with ioread16"
          as it was already accepted.
          Joint patch "Replace two VNSvInPortD with ioread64_lo_hi" with 
          patch "Replace VNSvInPortD with ioread32" and changed ioread64 to 
          two ioread32 as ioread64 does not work with 32 Bit computers.
          Shorted and simplified patch descriptions.          
V2 -> V3: Added missing version in subject lines
          Added change history in cover letter
          Removed remark in cover letter "This patch series is new.."
          as it is obsolet.
V3 -> V4: Added patch: "Added missing BE support in CARDbGetCurrentTSF"
          Removed testing example from cover letter and placed it to the
          patches.

Philipp Hortmann (2):
  staging: vt6655: Replace VNSvInPortD with ioread32
  staging: vt6655: Added missing BE support in CARDbGetCurrentTSF

 drivers/staging/vt6655/card.c        | 10 ++++++++--
 drivers/staging/vt6655/device_main.c |  6 +++---
 drivers/staging/vt6655/mac.h         | 18 +++++++++---------
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/upc.h         |  3 ---
 5 files changed, 21 insertions(+), 18 deletions(-)

-- 
2.25.1

