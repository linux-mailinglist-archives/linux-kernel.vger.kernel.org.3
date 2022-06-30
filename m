Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAD6562623
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiF3WdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiF3WdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B16681172
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656628390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XHy4PvEmAkmPOfd1mGpcH63ILnu1M8TgxJfIKYx6Bpo=;
        b=RE+WibXLssBmT7pYNbQsMeTvne7Ay8JDMnKFJD9//Mx0rGz8pX3CCvqW7g74UpBN1AiuSB
        eJxkqwV6xRWGjE/K0Ms9taExtF/sDSAkpKeTEYw3ZXNyhvOKaIDVaEGLOipDGzFc6NYA+d
        lTVlnRPzw4HuIbSXxToG8NwJ2zmLBwc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-410-LyeKeaQUOpihdqaZXfTmgw-1; Thu, 30 Jun 2022 18:33:09 -0400
X-MC-Unique: LyeKeaQUOpihdqaZXfTmgw-1
Received: by mail-wr1-f69.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so51671wra.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHy4PvEmAkmPOfd1mGpcH63ILnu1M8TgxJfIKYx6Bpo=;
        b=NQbMBgvDXGdhkuAOJTlLKKgZKGxEWLspuRE2gQt+XjsDkZaUc6LVpxEfAQqWs9fF4s
         AE+ZxqMaPOYbRS0g/v2Zhqr+zpSbyfe/YgPTi3kGya2qYs8YLGiYjFGbECPNyGLSstWC
         mt0083MUZJb5AeEWAUfAxr9hHc+A0ds/MYqmfv2jzJl2v1n1Mq6cs0iGhlpqM/V6Xxhf
         HOzooTLJFLyZLG0IWOYCdzEVz13UQDlNgX4Qea2fM+0u8EqeWqt/nn33akqQOQAzWjhN
         GUPvYTdh5eX1byVnGbVJhzy37IxbksSZGbp2BM5jz7EJMg53hLyF6l/6snD+10JgaZXm
         uxMA==
X-Gm-Message-State: AJIora8TMD+aTWR9uTLvyowQJWinAsrXNRSyG5Rn1ORa691QpPsCcj1p
        sNVwT3k30Q21jix8P3HcUlAm0KxNStrjk52Pqd2vAksN1slM9bVZTsrcXTZg8wbCLWT+exsDi1s
        XBV5M0DEkXuLudbU84tjHhxec
X-Received: by 2002:a05:6000:1acf:b0:21d:1067:a1df with SMTP id i15-20020a0560001acf00b0021d1067a1dfmr10899678wry.198.1656628388219;
        Thu, 30 Jun 2022 15:33:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u3PqN+NRcFXDnGhZ2NA2TII+IW79iuDR0NwK+AO+7xudHAIrGuC9tQuCcswJWzhtr32IlB/A==
X-Received: by 2002:a05:6000:1acf:b0:21d:1067:a1df with SMTP id i15-20020a0560001acf00b0021d1067a1dfmr10899650wry.198.1656628387992;
        Thu, 30 Jun 2022 15:33:07 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b0020c5253d907sm4308387wrz.83.2022.06.30.15.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:33:07 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     kexec@lists.infradead.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
Date:   Thu, 30 Jun 2022 23:32:56 +0100
Message-Id: <20220630223258.4144112-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Here's ~v3~ v4 where we now completely get rid of kexec_mutex.

o Patch 1 makes sure all kexec_mutex acquisitions are trylocks. This prevents
  having to add any while(atomic_cmpxchg()) loops which I'd really hate to see
  here. If that can't be done then I think we're better off with the combined
  mutex+atomic var approach.
o Patch 2 does the mutex -> atomic var switch.

Revisions
=========

v3 -> v4
++++++++

o Someone forgot to Cc LKML on v3...

v2 -> v3
++++++++

o Dropped kexec_mutex entirely and made the atomic variable the one true lock
  for kexec (Eric)

v1 -> v2
++++++++

o Changed from Peterson-like synchronization to simpler atomic_cmpxchg
  (Petr)
o Slightly reworded changelog
o Added Fixes: tag. Technically should be up to since kexec can happen
  in an NMI, but that isn't such a clear target

Cheers,
Valentin

Valentin Schneider (2):
  kexec: Turn all kexec_mutex acquisitions into trylocks
  panic, kexec: Make __crash_kexec() NMI safe

 include/linux/kexec.h   |  2 +-
 kernel/kexec.c          | 11 ++++-------
 kernel/kexec_core.c     | 28 ++++++++++++++++------------
 kernel/kexec_file.c     |  4 ++--
 kernel/kexec_internal.h | 15 ++++++++++++++-
 kernel/ksysfs.c         |  7 ++++++-
 6 files changed, 43 insertions(+), 24 deletions(-)

--
2.31.1

