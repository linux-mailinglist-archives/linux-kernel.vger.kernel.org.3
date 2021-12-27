Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D5347FBC5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhL0KLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:11:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235863AbhL0KLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640599890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpi7vBYS3XnKL4Kj8OO6j7beShRGlrvlj+Yo2wkNZyE=;
        b=BWa00zW0JgO7m7zgFcgERw0VQQjYGTRnG0Peu2o2q2w24CXYtyJs1b2RgRfQrbFjHkYOgW
        eIb76HWUF4pPAO3MVlFALunyFmidizo+ecV3rEmTevGltMhlSufsYNitneVYMRS+0XW1QQ
        pKFj/G7Ltk0rV0i++vhXIc8+QiIBh6M=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-kTT4ibfuP3yKjjiOZdr7kw-1; Mon, 27 Dec 2021 05:11:29 -0500
X-MC-Unique: kTT4ibfuP3yKjjiOZdr7kw-1
Received: by mail-io1-f72.google.com with SMTP id k12-20020a0566022a4c00b005ebe737d989so6637590iov.19
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 02:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mpi7vBYS3XnKL4Kj8OO6j7beShRGlrvlj+Yo2wkNZyE=;
        b=tOpC3LI1l9teQFG3jC9Vs2GzA2g0v1y+u5B0801AKZlzHP6/4s5j2tSMojkKIT/FVH
         QTKM/RYKO1AT79eG/gW0NAwOD5fnnz46NwKna8kA5Ox6fhlW/Maqv9z2yCbCAhvWqCSJ
         0tl9UsF7fo4iJ5zB/QYHc0ad+CUQLDhXqqXmFRlYWrOLoGXGnXKmX/vd/sp7wwIJrF3S
         weL8BbdBEQEs0eKjL/ORCfRsqUxf1wYsogH3TeYBiRigVhLrtVuASqGIx1S9telTImo4
         wGb1Hzo55EjB+VBMe5aKjdhTffU3JRWPUEN+ksRXMpp2bL/1snrISsakVeDa9nAAe4XF
         wz2A==
X-Gm-Message-State: AOAM533i6oaLxrxV4FfSzcJ2WZuezeByR3OjiVTwd0W9p4bqNa0Th5eu
        gku1/E3HoRVtJe27Z66MeULmBz7gzTPvXRGtL11Q3uzOEUD75LMIV+fskTQZpYbLZ2DkjbKQE5R
        6rbKrdQMDIqDgn8DS7vRv9I06KH636hEycDscXvF1
X-Received: by 2002:a02:9f92:: with SMTP id a18mr7541315jam.4.1640599888655;
        Mon, 27 Dec 2021 02:11:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgwpN/yx9wfHEX0MHG5ZIGHNxnXz+ofFsurQNeXugutT8dbFTXjOzHu0Lbxupibwx+LAtidzn7h170SQp21dY=
X-Received: by 2002:a02:9f92:: with SMTP id a18mr7541302jam.4.1640599888485;
 Mon, 27 Dec 2021 02:11:28 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsODP8ze_mvzfJKcRYxuS-esVgHXAvDXS5KN3xFUN6bWgA@mail.gmail.com>
 <CABXGCsMc1_-s5vVv=XVuMJaAtntrfHpCeT3h7wKkK71NuY-izw@mail.gmail.com> <CABXGCsMJOfGU8axS4FdGfPCgcPL5iuedpZxa4PETSyFHDckOAg@mail.gmail.com>
In-Reply-To: <CABXGCsMJOfGU8axS4FdGfPCgcPL5iuedpZxa4PETSyFHDckOAg@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 27 Dec 2021 11:11:17 +0100
Message-ID: <CACT4oud-7rpKgcapoNY7Ywd0socwQ-5BPteOxe7S7RNCaUzN+A@mail.gmail.com>
Subject: Re: [Bug] Driver mt7921e cause computer reboot.
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        sean.wang@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        objelf@gmail.com, lorenzo@kernel.org, Soul.Huang@mediatek.com,
        nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 25, 2021 at 11:43 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
> With recent kernel 5.16.0-0.rc2 commit 5d9f4cf36721 the behavior has
> been changed for the better, but the WiFi adapter still works with
> bugs.
>
> Now spontaneous endless reboots do not occur. But if I restart the
> laptop instead of shutting down, then the next time I boot, the WiFi
> adapter disappears. In order for the WiFi adapter to appear again, it
> needs to turn off the laptop and then turn on. Can this be somehow
> fixed?
> lspci output after reboot and boot after shutdown is different:

I've been experiencing similar problems, but they're solved at v5.15
version, at least for me.

How are you installing the kernel? Custom build? Have you updated the
firmware to latest versions, as well?

> After reboot:
> Subsystem: AzureWave Device 4680
> Flags: fast devsel, IRQ 84, IOMMU group 14
> Memory at fc30300000 (64-bit, prefetchable) [size=3D1M]
> Memory at fc30400000 (64-bit, prefetchable) [size=3D16K]
> Memory at fc30404000 (64-bit, prefetchable) [size=3D4K]
> Capabilities: [80] Express Endpoint, MSI 00
> Capabilities: [e0] MSI: Enable- Count=3D1/32 Maskable+ 64bit+
> Capabilities: [f8] Power Management version 3
> Capabilities: [100] Vendor Specific Information: ID=3D1556 Rev=3D1 Len=3D=
008 <?>
> Capabilities: [108] Latency Tolerance Reporting
> Capabilities: [110] L1 PM Substates
> Capabilities: [200] Advanced Error Reporting
> Kernel modules: mt7921e
>
> After shutdown:
> 05:00.0 Network controller: MEDIATEK Corp. Device 7961
> Subsystem: AzureWave Device 4680
> Flags: bus master, fast devsel, latency 0, IRQ 85, IOMMU group 14
> Memory at fc30300000 (64-bit, prefetchable) [size=3D1M]
> Memory at fc30400000 (64-bit, prefetchable) [size=3D16K]
> Memory at fc30404000 (64-bit, prefetchable) [size=3D4K]
> Capabilities: [80] Express Endpoint, MSI 00
> Capabilities: [e0] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
> Capabilities: [f8] Power Management version 3
> Capabilities: [100] Vendor Specific Information: ID=3D1556 Rev=3D1 Len=3D=
008 <?>
> Capabilities: [108] Latency Tolerance Reporting
> Capabilities: [110] L1 PM Substates
> Capabilities: [200] Advanced Error Reporting
> Kernel driver in use: mt7921e
> Kernel modules: mt7921e
>
> Screen of a visual comparison of lspci in meld: https://postimg.cc/642NKJ=
5Y

For me, these differences seem to be the normal effect of the driver
not recognizing the device.

Regards
--=20
=C3=8D=C3=B1igo Huguet

