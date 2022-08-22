Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A0059CA54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiHVUrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiHVUrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:47:14 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2C558DE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:47:14 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l18-20020a6bd112000000b0067cb64ad9b2so6347016iob.20
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=ckYm9/frTHKg5Q1caJilSY/IDUA7LKV/J33LIJTS+6o=;
        b=xlx5Shf3WIL0aBc2q5a2rtZ1tbuwsdP+zZ64/0IRSxi0e0PBGvdgJfUDWK0pzXWwf2
         fT9xRf20+5ZBkQRXRLjgsxnJ5iWODrSo0hlynszlyIxvWd9mOWgR+4SdwKS3zmZeFaPW
         6PgoiTZu7RVF+BtwhirAMXInouddunqXRKJ9Pfb1rq5Ry9f2Ddt+nH+3brRYdrQXA7ES
         rOPPJ1vtulE+LwCbJk19Pk8JWLUptEXHflLR80hQSVlUq7Vv92T7CNy2hsol7i/iNX3Q
         2TCJJFJ1ylUDf6RF2BzlBJvusQfP7zziuMrogM7ZajQ+gdyNhJTEkfB/2czzrRkR6njv
         PaTA==
X-Gm-Message-State: ACgBeo0vwqKLMZiGt3N2A4tUOh8jzc/gFpk4cOzJvmZWxmRgzLkDoAU+
        zKXxHhDlDvn1UGPWaO7BIgG2X+FtRxXwgak5fk6fGbUwL3x6
X-Google-Smtp-Source: AA6agR6YKQu5Soa4+q0bPpVeFbN8zg4kkMp/JQTJsc3IEH4Oq0YU6kHxNZ9NCy4plQ/ZFex72UUsvPyPZFK9XSwxn+cG2NVsEMVN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1683:b0:345:9e65:cd07 with SMTP id
 f3-20020a056638168300b003459e65cd07mr10403135jat.128.1661201233559; Mon, 22
 Aug 2022 13:47:13 -0700 (PDT)
Date:   Mon, 22 Aug 2022 13:47:13 -0700
In-Reply-To: <000000000000b5187d05e6c08086@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d456105e6da8d58@google.com>
Subject: Re: [syzbot] INFO: task hung in scsi_remove_host
From:   syzbot <syzbot+bafeb834708b1bb750bc@syzkaller.appspotmail.com>
To:     bvanassche@acm.org, dsterba@suse.com, hch@lst.de, hdanton@sina.com,
        jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        ming.lei@redhat.com, nborisov@suse.com,
        syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit ae643a74ebdb150b004601d0d5fe5a1faba9b04d
Author: Qu Wenruo <wqu@suse.com>
Date:   Sun May 22 11:47:48 2022 +0000

    btrfs: introduce a data checksum checking helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176ef485080000
start commit:   e3f259d33c0e Merge tag 'i2c-for-6.0-rc2' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14eef485080000
console output: https://syzkaller.appspot.com/x/log.txt?x=10eef485080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bd9363f7b80ef9c
dashboard link: https://syzkaller.appspot.com/bug?extid=bafeb834708b1bb750bc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108e1a3d080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154720f3080000

Reported-by: syzbot+bafeb834708b1bb750bc@syzkaller.appspotmail.com
Fixes: ae643a74ebdb ("btrfs: introduce a data checksum checking helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
