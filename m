Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C58E4FAC6C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 08:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiDJGcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 02:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiDJGcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 02:32:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E0165B5;
        Sat,  9 Apr 2022 23:30:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b2-20020a17090a010200b001cb0c78db57so10398403pjb.2;
        Sat, 09 Apr 2022 23:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ncG+jtFpe49P5+x9lukkdAAx/bzdN/sE+TZcQS1YBDk=;
        b=W+uTw6hWWwtLRw9G/0iHBZ93ORAzjGxSschsrTfMBj1FVqeltc7Q5vdlZF9yl0k7JQ
         Kq4BgwOg5+DTfiQZZbMBGuGKpm3ZUkNgFQk7XUVod6QFJ1ussZTbZhLw84LbHHF2wspI
         iORT2aCBpA4/i/kc7n9yMORG+70bn7rlgolKVlGHyyqb5mMQZ5WEeWScMVbmOylIT/42
         jPqX/QVHZk3menKt8R10H2PW2PnJFY1rLqfefd2JS+Ted1XI9RfdDqu0rA8N8JhpOsYK
         2R7xUdSH1oWPnqVqKLvIRJ5Dgqy9OZLHfLxrXDz5GAK3Otad1DWzb76pLgtmpcaWr/9l
         4mAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ncG+jtFpe49P5+x9lukkdAAx/bzdN/sE+TZcQS1YBDk=;
        b=OsKfx6pDDFT8eJD0ZCeBbCNnHoZLQ5C4+f0aznLt/i/mTcbaZY3CX0Zs5P8CTCo3pr
         M9/KRPrDWaslXDl0M/7GLJcXCS22EHbsVjEOXiBWXvhPAs1mEgfVGRRl+rhfARhoQ2et
         6TakLP/XaRAqmaFosOWkiKq3Pw8sbbVU/9FFjNVtAFQCrmaOdhRA8UzhdBCNVyyVoNrz
         fL+YdqclNCUb5QxqeJpvLF9iv6MMlIvOb9BGBtZ+xIDeuVDTlYr7R7Wlee9DEaEyjPJX
         jXH3l9wNydpbBEEjFHjLif74mMQev1e/kz7lJ/nIdKciAWCm1+lziCCDKluk2O6mztTE
         /81w==
X-Gm-Message-State: AOAM533oToet0UR+BLwemf7CTANtjonaUPeGrNx8wE84byg9hIXj89/A
        S65kx2QA3RCkzvp1G/+jly0+6/2qKyXhxDfFYA==
X-Google-Smtp-Source: ABdhPJyoJHCfyA07cC8oekHU1rPwnGyu13N+dmg6eZwOCo6s6wIYquj7Le+PwulGHqxVCAN1HU4ipsZsu7+UTG3duig=
X-Received: by 2002:a17:902:a404:b0:14b:1100:aebc with SMTP id
 p4-20020a170902a40400b0014b1100aebcmr27301941plq.133.1649572231576; Sat, 09
 Apr 2022 23:30:31 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Sun, 10 Apr 2022 14:30:18 +0800
Message-ID: <CAMhUBjkVME8D5KsHvT=uddBsW_Bh6wr7qeXS=UpQD4LgPmHffQ@mail.gmail.com>
Subject: [BUG] ata: pata_marvell: Warning when probing the module
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a bug in the pata_marvell module.
When probing the driver, it seems to trigger the error path and
executes the function marvell_cable_detect(), but the
'ap->ioaddr.bmdma_addr' is not initialized, which causes a warning.

The following log can reveal it:

[    3.453943] Bad IO access at port 0x1 (return inb(port))
[    3.454430] WARNING: CPU: 7 PID: 291 at lib/iomap.c:44 ioread8+0x4a/0x60
[    3.457962] RIP: 0010:ioread8+0x4a/0x60
[    3.466362] Call Trace:
[    3.466572]  <TASK>
[    3.466756]  marvell_cable_detect+0xad/0xf0 [pata_marvell]
[    3.467699]  ata_eh_recover+0x3520/0x6cc0
[    3.473262]  ata_do_eh+0x49/0x3c0
[    3.473906]  ata_scsi_port_error_handler+0xd96/0x1d00
[    3.474355]  ata_scsi_error+0x243/0x290
[    3.475428]  scsi_error_handler+0x2ff/0xea0
[    3.477244]  kthread+0x262/0x2e0
