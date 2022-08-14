Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1296591EB7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240237AbiHNGoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHNGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:44:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC2E5FAD3;
        Sat, 13 Aug 2022 23:44:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d10so4008483plr.6;
        Sat, 13 Aug 2022 23:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=Xb/TvLIPNQ1Q7yT+wH5Qn+6xUg5lLXhDYGklPc6cImE=;
        b=TTSjB+WP8lgIusxW7eFyOqBHFqrZccwIwa8UV4IVn2jTzV3bq+WqORCR3JF+gczG76
         h03+pHKtrk4c9xx9+M6i03huzVeAnGYi2WL5G8gaXoeS7MGuBwr5pYnHDdtTiJiBm3qp
         ky2N/yKX9rBcrqBOdX5QqKYkAQDku/WK6I6WmVony9B41/+hbMlQS0EfNKjMkCzt5/y3
         OSNfRhj4e0qbiTCeyZPta/pqJj+hvDhXOQz2EG0zT/8HVJjU2EHIYB5hVC5UiCcw+Uk4
         9n4hWIF7pLgUb5694MzfSGJnTxsrReTYD8L0uYxNxfPk8ujZPSGJAYuZqevbIQi8n68H
         Ek0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Xb/TvLIPNQ1Q7yT+wH5Qn+6xUg5lLXhDYGklPc6cImE=;
        b=FKO9T8RYYmQ6NuYTN12x0ub+XkNVzWOQyaHTJYH9QZ4Os4AkzD62ic5sY7MK3EShVB
         I/MCOvl9WpJEndP8KSGtvviDJUi88HgaabZ9y80mgLwIoe1bjRO70fMrSEUB3zwxfqRR
         aeFbqBTfa2NiPJshek2ozDCmqaGjEAjo9Nwoez4wZ4x3pitr8n+fsv+2Ig0s4t2zN7bM
         0ODAGUi3HcytcVPrryWpQl7Y57yve/opWoVf1V88wYA+TR9WrZrmNLd9DxHDZRAV+yHq
         ovAO+zNPzMpNvQ5x0ve0lAx9eCF38CbHDuGNSV/0pH+eicoHru0TQdHE5s599Hlk0vI8
         6R1w==
X-Gm-Message-State: ACgBeo2CtyEXCApcNW7p9Nxx8VH+jqtREhjDjjMOgpKHOu4mmCvsBDsM
        82lJWutKYJaduzMq8ivlCxs=
X-Google-Smtp-Source: AA6agR4uuuVONLZKHR1vqPYh/NaSjNONwZ567sdcX2nkK1DTPAzeSPtSbVap5je+pEI7EiAkz0F0Lg==
X-Received: by 2002:a17:903:31c9:b0:16c:3024:69c4 with SMTP id v9-20020a17090331c900b0016c302469c4mr11323987ple.81.1660459461748;
        Sat, 13 Aug 2022 23:44:21 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0052d481032a7sm4593778pfp.26.2022.08.13.23.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:44:21 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        khalid@gonehiking.org, willy@infradead.org, hare@suse.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH 0/9] move spin_lock_irqsave to spin_lock in interrupt handler
Date:   Sun, 14 Aug 2022 14:43:28 +0800
Message-Id: <20220814064337.32621-1-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it is unnecessary to call spin_lock_irqsave in a interrupt handler.

Tuo Cao (9):
  scsi: 53c700: move spin_lock_irqsave to spin_lock in interrupt handler
  scsi: a100u2w: move spin_lock_irqsave to spin_lock in interrupt
    handler
  scsi: a2091: move spin_lock_irqsave to spin_lock in interrupt handler
  scsi: a3000: move spin_lock_irqsave to spin_lock in interrupt handler
  scsi: BusLogic: move spin_lock_irqsave to spin_lock in interrupt
    handler
  scsi: advansys: move spin_lock_irqsave to spin_lock in interrupt
    handler
  scsi: aha1542: move spin_lock_irqsave to spin_lock in interrupt
    handler
  scsi: aha1740: move spin_lock_irqsave to spin_lock in interrupt
    handler
  scsi: bfad: move spin_lock_irqsave to spin_lock in interrupt handler

 drivers/scsi/53c700.c   |  5 ++---
 drivers/scsi/BusLogic.c |  5 ++---
 drivers/scsi/a100u2w.c  |  5 ++---
 drivers/scsi/a2091.c    |  5 ++---
 drivers/scsi/a3000.c    |  5 ++---
 drivers/scsi/advansys.c |  5 ++---
 drivers/scsi/aha1542.c  |  7 +++----
 drivers/scsi/aha1740.c  |  5 ++---
 drivers/scsi/bfa/bfad.c | 20 +++++++++-----------
 9 files changed, 26 insertions(+), 36 deletions(-)

-- 
2.17.1

