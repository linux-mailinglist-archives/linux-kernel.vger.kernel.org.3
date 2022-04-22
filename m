Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7985B50AFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiDVFpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiDVFpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:45:32 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21294F46A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:42:39 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3E5213F19A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650606156;
        bh=hWerQpQZlUf6tJ3oEQBKDh+uBBIZTIztZC7wzThBamE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Q7+1a/8gM/eL4iLPaWUCxpzsnrFL5jSxImAp8SvHSOWxlkIyXrnWi3sjXGm8Umnz/
         rNOLYJN0UTzW+a2jWF847yDPi95fX1wE3bJQ11TBzt6Of40WH3HhLMVRnMcrXMqfXT
         mP3zkan3kBSZXFWyKaOrqSVDrUowmeJXHuEs1PlpdUa8mAHD7EI+7E/i4pWzLq/uKe
         NWTc2xDKlO9+OLTDIKuAi79JB1V3l4Kk3otNnVWdDNV63E8fm+NmbGxC7TVjdwir0u
         016gBmCfOj5rEX+5svRH7fuCZNJz1zKyvjNtOqstWrn+d3KwUJTj6lEvW//KhMjwcT
         1waKHsMtnRXjA==
Received: by mail-pf1-f200.google.com with SMTP id n10-20020a056a00212a00b0050aba994ee7so4493837pfj.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hWerQpQZlUf6tJ3oEQBKDh+uBBIZTIztZC7wzThBamE=;
        b=KuKywvm8SEkVowdQNWM3aJY0F2p0MPPcqBvLUT95PMEgxAqFnFFVj/gmqRaCZ4bvUm
         5CQ2xL73h8gnPHvKVHB+WQ4ytBQhYo0qXZiuAjr1gsaMaCVv572FIXUR9gzInbScv0Bp
         g2MT1QO8lOdhvebLQLepNSV5OBmHNMIzsd4a7P4eqFHoqRobRGevKzMDpXzsUR+Wu9tL
         ywLCpUSlEKjoY+KbbohFCRyG21mAW6qPMEh9ArsI+jR0gkMNIxgqkEASpBb6p7Bmj98Z
         t9CfwwnIqKj4cGKtgxlFMgvKKi/7JHb8SkTRK/yyIcHCoxosHaNrW9BXSsnvDF3yzbbZ
         tFdw==
X-Gm-Message-State: AOAM5324vj8jpVaXVtDg9HxBLrTsI91TsSJ7V6jYQkkCRI+UB7hY8qTc
        A0LZf8n3APKaKi5pPhgyTJ2u6NHUN6Q8aNmKOvSZLE2Zo5pZH7gqm+qAOif8EiRbOK/Ww6ktFxk
        UifB57o1DgBYj5nZzPkp61W00rKyRq01ZHd7kQJjLQg==
X-Received: by 2002:a63:2ad0:0:b0:3aa:c8d5:c7b9 with SMTP id q199-20020a632ad0000000b003aac8d5c7b9mr521906pgq.306.1650606154926;
        Thu, 21 Apr 2022 22:42:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRsYMLjMdP/oCRdsW7JcxBBna5VFVNb2T+2REufL2x1MY+dEqZKv+dVqN/g4A2C83rrU4MUA==
X-Received: by 2002:a63:2ad0:0:b0:3aa:c8d5:c7b9 with SMTP id q199-20020a632ad0000000b003aac8d5c7b9mr521895pgq.306.1650606154661;
        Thu, 21 Apr 2022 22:42:34 -0700 (PDT)
Received: from desktop.. (125-239-17-100-fibre.sparkbb.co.nz. [125.239.17.100])
        by smtp.gmail.com with ESMTPSA id m13-20020a62a20d000000b004fe0ce6d7a1sm1018633pff.193.2022.04.21.22.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 22:42:34 -0700 (PDT)
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
To:     josef@toxicpanda.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: [PROBLEM] nbd requests become stuck when devices watched by inotify emit udev uevent changes
Date:   Fri, 22 Apr 2022 17:42:24 +1200
Message-Id: <20220422054224.19527-1-matthew.ruffell@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear maintainers of the nbd subsystem,

A user has come across an issue which causes the nbd module to hang after a
disconnect where a write has been made to a qemu qcow image file, with qemu-nbd
being the server.

The issue is easily reproducible with the following:

Ubuntu 20.04, 22.04 or Fedora 36
Linux 5.18-rc2 or earlier (have tested 5.18-rc2, 5.15, 5.4, 4.15)
QEMU 6.2 or earlier

Instructions to reproduce:
==========================

$ sudo apt install qemu-nbd

$ cat << EOF >> reproducer.sh
#!/bin/bash

sudo modprobe nbd

while :
do
        qemu-img create -f qcow2 foo.img 500M
        sudo qemu-nbd --disconnect /dev/nbd15 || true
        sudo qemu-nbd --connect=/dev/nbd15 --cache=writeback --format=qcow2 foo.img
        sudo mkfs.ext4 -L root -O "^64bit" -E nodiscard /dev/nbd15
        sudo qemu-nbd --disconnect /dev/nbd15
done
EOF

$ chmod +x reproducer.sh
$ ./reproducer.sh

On Ubuntu, the terminal will pause within a minute or two, and dmesg will report
a lot of I/O errors, followed by hung task timeouts. On Fedora, it takes a 
little longer, but it will break in the same way within 10 minutes.

An example kernel log is below:

https://paste.ubuntu.com/p/5ZjC5b8MR7/

Debugging done:
===============

Looking at syslog, it seems systemd-udevd gets stuck, and enters D state.

systemd-udevd[419]: nbd15: Worker [2004] processing SEQNUM=5661 is taking a long time

$ ps aux
...
419    1194 root     D     0.1 systemd-udevd   -

I rebooted, and disabled systemd-udevd and its sockets, with:

$ sudo systemctl stop systemd-udevd.service
$ sudo systemctl stop systemd-udevd-control.socket
$ sudo systemctl stop systemd-udevd-kernel.socket

When running the reproducer again, everything works fine, and nbd subsystem does
not hang.

Looking at udev rules, I looked at the differences between those in Ubuntu 18.04
where the issue does not occur, and 20.04, where it does, and came across:

/usr/lib/udev/rules.d/60-block.rules

In 18.04:
# watch metadata changes, caused by tools closing the device node which was opened for writing
ACTION!="remove", SUBSYSTEM=="block", KERNEL=="loop*|nvme*|sd*|vd*|xvd*|pmem*|mmcblk*", OPTIONS+="watch"

In 20.04:
# watch metadata changes, caused by tools closing the device node which was opened for writing
ACTION!="remove", SUBSYSTEM=="block", \
  KERNEL=="loop*|mmcblk*[0-9]|msblk*[0-9]|mspblk*[0-9]|nvme*|sd*|vd*|xvd*|bcache*|cciss*|dasd*|ubd*|ubi*|scm*|pmem*|nbd*|zd*", \
  OPTIONS+="watch"
  
The difference is the OPTIONS+="watch" being added to nbd* any event not remove.

When I deleted nbd* and retried the reproducer again, everything works smoothly.

Looking at the manpage for udev:

> watch
>   Watch the device node with inotify; when the node is closed after being 
>   opened for writing, a change uevent is synthesized.
>
> nowatch
>   Disable the watching of a device node with inotify.

It appears that there is some sort of problem where systemd-udevd uses inotify
to watch for updates to the device metadata, and it blocks a subsequent
disconnect request, causing it to fail with:

block nbd15: Send disconnect failed -32

After which we start seeing stuck requests:

block nbd15: Possible stuck request 000000007fcf62ba: control (read@523915264,24576B). Runtime 30 seconds

All userspace calls to the nbd module hang, and the system has to be rebooted.

Workaround:
===========

We can workaround the issue by adding a higher priority udev rule to not watch
nbd* devices.

$ cat << EOF >> /etc/udev/rules.d/97-nbd-device.rules
# Disable inotify watching of change events for NBD devices
ACTION=="add|change", KERNEL=="nbd*", OPTIONS:="nowatch"
EOF

$ sudo udevadm control --reload-rules
$ sudo udevadm trigger

Help on debugging the problem:
==============================

I need some help debugging the problem, as I am not quite sure how to trace
the interactions between inotify and nbd.

I am happy to help debug the issue, or try any patches that gather debugging
data or any potential fixes.

Thanks,
Matthew
