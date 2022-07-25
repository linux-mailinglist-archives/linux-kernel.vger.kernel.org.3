Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3B580654
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiGYVUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiGYVU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:20:29 -0400
X-Greylist: delayed 311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jul 2022 14:20:27 PDT
Received: from forward101o.mail.yandex.net (forward101o.mail.yandex.net [37.140.190.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FB4186D8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:20:27 -0700 (PDT)
Received: from iva1-dcde80888020.qloud-c.yandex.net (iva1-dcde80888020.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7695:0:640:dcde:8088])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id 2ECB3369B50D;
        Tue, 26 Jul 2022 00:15:15 +0300 (MSK)
Received: by iva1-dcde80888020.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id ZXho2Z3dGu-FCh4KT0f;
        Tue, 26 Jul 2022 00:15:14 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1658783714;
        bh=kAhlQFCfWhrWOTesABzSAGCxFIgasBuWCk2ikQwkOAw=;
        h=Cc:References:Date:Message-ID:In-Reply-To:From:To:Subject;
        b=a7+K89XMIQp31FWkZzoPIemd6vfXr+vHqwHgBtS4m/bzkyi/EYQtofn2uuUCzuxaA
         Hf4kCrj87gbytIcL3w7tp2E0ai84alujiOiPi7SJxeEs1n31ugUxDSoJsNaclJ6QG+
         YJAxA4Z5VYsL5IyLgtdoRBy8OndxHTvtpH1jleLY=
Authentication-Results: iva1-dcde80888020.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Subject: Re: Attaching qcow2 images to containers
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Kirill Tkhai <kirill.tkhai@openvz.org>
Cc:     qemu-devel@nongnu.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
        hreitz@redhat.com, Xie Yongji <xieyongji@bytedance.com>,
        sgarzare@redhat.com, tkhai@ya.ru
References: <YoSSkOQaGL0sBNOI@stefanha-x1.localdomain>
From:   Kirill Tkhai <tkhai@ya.ru>
Message-ID: <d4aafde8-1686-4423-e9b1-c1cc825236e6@ya.ru>
Date:   Tue, 26 Jul 2022 00:15:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YoSSkOQaGL0sBNOI@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stefan,

sorry for the late reply. I missed your message since I don't use that email address anymore.
Sent a patch to fix the stale address in .mailmap.

On 18.05.2022 09:30, Stefan Hajnoczi wrote:
> Hi Kirill,
> I saw your "[PATCH 0/4] dm: Introduce dm-qcow2 driver to attach QCOW2
> files as block device" patch series:
> https://lore.kernel.org/linux-kernel/YkME5ZS2CpXuNmN6@infradead.org/T/
> 
> There has been recent work in vDPA (VIRTIO Data Path Acceleration) to
> achieve similar functionality. The qemu-storage-daemon VDUSE export
> attaches a virtio-blk device to the host kernel and QEMU's qcow2
> implementation can be used:
> https://patchew.org/QEMU/20220504074051.90-1-xieyongji@bytedance.com/
> 
> A container can then access this virtio-blk device (/dev/vda). Note that
> the virtio-blk device is implemented in software using vDPA/VDUSE, there
> is no virtio-pci device.
> 
> As a quick comparison with a dm-qcow2 target, this approach keeps the
> qcow2 code in QEMU userspace and can take advantage of QEMU block layer
> features (storage migration/mirroring/backup, snapshots, etc). On the
> other hand, it's likely to be more heavyweight because bounce buffers
> are required in VDUSE for security reasons, there is a separate
> userspace process involved, and there's the virtio_blk.ko driver and an
> emulated virtio-blk device involved.

The main idea is to reach the best performance and density. This is possible only,
if driver's hot path is implemented in kernel. Comparing to NBD the driver shows
much better results in these criteria.

This has a continuation, and I mean DAX here. IO handling with any userspace-based
implementation will be slower, than DAX in case of kernel-based implementation. So,
in my driver IO handling is done in kernel, while DAX support is a subject of
the future development.

And this driver and advantages of QEMU block layer are not mutually exclusive.
This driver *does not implement* snapshot or backup support, here is only hot-path
doing IO handling.
 
> Another similar feature that was recently added to QEMU is the
> qemu-storage-daemon FUSE export:
> 
>   $ qemu-storage-daemon \
>         --blockdev file,filename=test.img,node-name=drive0 \
> 	--export fuse,node-name=drive0,id=fuse0,mountpoint=/tmp/foo
>   $ ls -alF /tmp/foo
>   -r--------. 1 me me 10737418240 May 18 07:22 /tmp/foo
> 
> This exports a disk image as a file via FUSE. Programs can access it
> like a regular file and qemu-storage-daemon will do the qcow2 I/O on the
> underlying file.
> 
> I wanted to mention these options for exposing qcow2 disk images to
> processes/containers on the host. Depending on your use cases they might
> be interesting. Performance comparisons against VDUSE and FUSE exports
> would be interesting since these new approaches seem to be replacing
> qemu-nbd.
> 
> Can you share more about your use cases for the dm-qcow2 target? It
> could be useful for everyone I've CCed to be aware of various efforts in
> this area.

The use case is containers, and they are the requestor for high density.
The userspace-based implementation overhead will be noticeable on nodes
running a lot of containers (just because of any overhead is noticeable
there :)). Also, it's very useful to use the same disk image for VMs and
containers giving people to choose what they want in the moment.

Best wishes,
Kirill
