Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B751249B5A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiAYOEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239920AbiAYOAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:00:38 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335B1C061765
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:00:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a13so20094011wrh.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DxC0SfD7b4QSaFUwrb5yoO+HoqsYqRFZODxnrnI3Q+8=;
        b=U+y638/HB1Eu+c4jhV933cF5Pnnsa4RGOrIB+QuvEwIeA6HUBOIiLNsYnbHpzCLDwL
         F8V2VSa/v6rNAxArnBwPukcwTxhj0M1Gsjca6EKTH3Tu7ysg3fdURQvMAlj4wzBQj06b
         V++/xO4xR52shxwOmSb1DkFUAqBIrbvzBzsWFCAjnu0C6zsyXX5GcAsPmQfyXA5Jtq2n
         9C7t0RQEse93jnisvNpVKlsvZPWc4IWS82G3t9qy/WHsOWD9dRAsGV3eQQo2rWzKbTHI
         0nmya+vzJHPExL2h/JRtxD51z1zsUiY48fu58VU6jeT8RKZHw1GztTQ+ocWjZcuMZG/w
         HcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DxC0SfD7b4QSaFUwrb5yoO+HoqsYqRFZODxnrnI3Q+8=;
        b=rFuvUBzUGeTCMpt5lc3PmNWmErGJnuAcxkNUavPFCg5/hOY99DeXm2Cn3cXtf5ZAWF
         85y8X/iG69h0VoO8ljZNqDNYKosRVJFOpgqnUjReb84eyFFLYkYaocTttstp/9W4s/lN
         SsjNJlJiXXOAaqV898OleTV+QqITHeDmtxnU1ThiArCG5B3YrP37JvvzgJrjAaeWxb81
         eJ4BeoIdewsM2Ydq1YTevSFrj1KnXJ8MWTu87yVHMidD9N4UE38+g3oX+b3yKVmN31lJ
         W1V5XLjBfYEVotwxfzvyBEi3Fej0v9gyJEFSISlPkzpDH5iH4J/1bWuYa7bzHwlztuLj
         opzw==
X-Gm-Message-State: AOAM532ASc6s9r9SZ0cgST517HX9kRr5p2TVZpb/EmbiBKXmg6aEvOHp
        kIP19fxD5D5SWqnhchp6xy0nnA==
X-Google-Smtp-Source: ABdhPJyltCoImzab2bUefhlJ4kWXgLYsM0Ty2HEsWNCpCOldR21d2BMUDd330pv29T7S758XIQFtgA==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr19506010wrq.96.1643119235416;
        Tue, 25 Jan 2022 06:00:35 -0800 (PST)
Received: from axion.fireburn.co.uk.lan ([2a01:4b00:f40e:900::64c])
        by smtp.gmail.com with ESMTPSA id t1sm3714608wre.45.2022.01.25.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:00:34 -0800 (PST)
From:   Mike Lothian <mike@fireburn.co.uk>
To:     heikki.krogerus@linux.intel.com
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pmalani@chromium.org, rafael@kernel.org,
        sakari.ailus@linux.intel.com
Subject: 'Re: [PATCH v5 4/5] usb: typec: port-mapper: Convert to the component framework'
Date:   Tue, 25 Jan 2022 14:00:33 +0000
Message-Id: <20220125140033.1403-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20211223082422.45637-1-heikki.krogerus@linux.intel.com>
References: <20211223082422.45637-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This patch is stopping my ASUS G513QY from booting correctly

BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 116 Comm: kworker/1:1 Not tainted 5.16.0-rc6-tip+ #2991
Hardware name: ASUSTeK COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.316 11/29/2021
Workqueue: events_long ucsi_init_work
RIP: 0010:component_master_add_with_match+0x11/0x190
Code: cc cc 00 00 cc cc 00 00 cc 49 89 c9 49 89 d0 31 d2 31 c9 e9 c1 fe ff ff 00 55 41 57 41 56 41 54 53 48 89 d3 49 89 f4 49 89 ff <48> 8b 72 08 48 89 d7 e8 73 01 00 00 89 c5 85 c0 0f 85 55 01 00 00
RSP: 0018:ffff8881029f7d48 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff83095658 RDI: ffff888117658c08
RBP: 0000000000000000 R08: ffff88810158e258 R09: ffffea00045d9e00
R10: 0000001000000000 R11: ffffffff81be3720 R12: ffffffff83095658
R13: ffff888117630a68 R14: ffff888117658c08 R15: ffff888117658c08
FS:  0000000000000000(0000) GS:ffff888fde440000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 00000000ac20c000 CR4: 0000000000150ee0
Call Trace:
 <TASK>
 ? typec_link_ports+0x45/0x50
 ? typec_register_port+0x20f/0x260
 ? ucsi_register_port+0x33c/0x700
 ? __kmalloc+0x14e/0x2a0
 ? ucsi_init_work+0x15a/0x330
 ? process_one_work+0x1dd/0x380
 ? worker_thread+0x26d/0x4a0
 ? kthread+0x182/0x1a0
 ? worker_clr_flags+0x40/0x40
 ? kthread_blkcg+0x30/0x30
 ? ret_from_fork+0x22/0x30
 </TASK>
Modules linked in:
CR2: 0000000000000008
---[ end trace 9c7dfbb7c9eaa418 ]---
RIP: 0010:component_master_add_with_match+0x11/0x190
Code: cc cc 00 00 cc cc 00 00 cc 49 89 c9 49 89 d0 31 d2 31 c9 e9 c1 fe ff ff 00 55 41 57 41 56 41 54 53 48 89 d3 49 89 f4 49 89 ff <48> 8b 72 08 48 89 d7 e8 73 01 00 00 89 c5 85 c0 0f 85 55 01 00 00
RSP: 0018:ffff8881029f7d48 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff83095658 RDI: ffff888117658c08
RBP: 0000000000000000 R08: ffff88810158e258 R09: ffffea00045d9e00
R10: 0000001000000000 R11: ffffffff81be3720 R12: ffffffff83095658
R13: ffff888117630a68 R14: ffff888117658c08 R15: ffff888117658c08
FS:  0000000000000000(0000) GS:ffff888fde440000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 00000000ac20c000 CR4: 0000000000150ee0

Is it due to the USB-C port on the Radeon 6800M?

Thanks

Mike
