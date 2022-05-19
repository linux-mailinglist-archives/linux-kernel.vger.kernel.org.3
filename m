Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371F052CE7F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiESIlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiESIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:41:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7B95C67B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:41:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f2so6131929wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zu6Jc6vPHdx+DLxnR1TmqxY9QoEaPYsoi3ifcQsAFPk=;
        b=zeI9nOw/qa+Ir+ahRG/199gpdKCGgQdPwFGR+2GBVeKkd9NQHKrv2Xw7orL32VuFDW
         8lEdFQ9IGR1dsccUixD1tXCDoyNhYc/J2ByQd7JJRmOG+w/X5j+drTY1AKAc2eeJHe49
         4sr4i5KYvm+qoMfX9m1iniaGMf0FR3SN2d1RYShRndhPYyGVCdaLxb/Owbvhw6oSS57w
         G7K5vhCw5vbZkFBYKicU/3OC8PcN1mXDVxynmc7ajY11jdD/koUaa8JvqLEEEGZwKetp
         QiXiyMkRK5PkGOSrnjchhLGA21lUwrWaR4wrm6YNdv/dPmCN8RtahpEb7G+tn1U7QAgf
         rIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zu6Jc6vPHdx+DLxnR1TmqxY9QoEaPYsoi3ifcQsAFPk=;
        b=YVCnVEKW+fsuJBphGJ0DaQYreum6VPZ3yp+Pc3E6I4UlRQLAcdjNN546GoZp4Zpd2h
         6sPNxbi2XfHED+XdKn+qy/zxg6Jun41aLWUEpalP+kVCTH+7Oh7voJHT3Cxof8oV4eLd
         CB3RevHKqtgJp+/LKGXHvggPVXixsa4ycJ2zTmpB3tDiFqDpQrAKiBRx0UM+ftY9befZ
         EYVWF0jZY5B/h0rq49A8WoNKt+X5W3hLKR7l2Yg6OrnLg40ZI40E1LIAltd+QMFRwM6l
         M8UwOOQgvJsNZJFa9j8s/wK/naS0En6/9bXX4C8fMT72BixK1+DrlnvPW/qwqO28MlOV
         SrLw==
X-Gm-Message-State: AOAM531/nHJpwe5eoqHOpn3CeVB5bSPZVJfdYHaxYZFWuBa+fwg/uyCm
        Qx9a8WpytiTW0vbakNc4MnJK96MIVN4+ahha
X-Google-Smtp-Source: ABdhPJzrgO0iDfpb9JSw3ooLZNe9BU6AWm/lFzSbPVM+AVlG0fAnS2+rHXjUPDoqv9BQp5C+QWdrtQ==
X-Received: by 2002:adf:a459:0:b0:20d:3c9:44a1 with SMTP id e25-20020adfa459000000b0020d03c944a1mr2865603wra.560.1652949687055;
        Thu, 19 May 2022 01:41:27 -0700 (PDT)
Received: from localhost ([46.69.19.220])
        by smtp.gmail.com with ESMTPSA id i29-20020adfaadd000000b0020c5253d8casm4599719wrc.22.2022.05.19.01.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:41:26 -0700 (PDT)
From:   Fam Zheng <fam.zheng@bytedance.com>
X-Google-Original-From: Fam Zheng <fam@euphon.net>
Date:   Thu, 19 May 2022 09:41:21 +0100
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Kirill Tkhai <kirill.tkhai@openvz.org>, qemu-devel@nongnu.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Kevin Wolf <kwolf@redhat.com>, hreitz@redhat.com,
        Xie Yongji <xieyongji@bytedance.com>, sgarzare@redhat.com
Subject: Re: Attaching qcow2 images to containers
Message-ID: <20220519084121.GA6658@fam-dell>
References: <YoSSkOQaGL0sBNOI@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoSSkOQaGL0sBNOI@stefanha-x1.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-18 07:30, Stefan Hajnoczi wrote:
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
> 
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

In addition, there was also qemu-tcmu, (more PoC compared to other options):

https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg04408.html

Fam

> 
> Can you share more about your use cases for the dm-qcow2 target? It
> could be useful for everyone I've CCed to be aware of various efforts in
> this area.
> 
> Thanks,
> Stefan


