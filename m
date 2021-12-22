Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A8247D7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345245AbhLVTdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:33:47 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:35822 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhLVTdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:33:46 -0500
Received: by mail-qk1-f173.google.com with SMTP id 131so3370629qkk.2;
        Wed, 22 Dec 2021 11:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RfUosveW4tPMKOFRdTv8lZwv8YHtumNVeL61eaPcSTE=;
        b=WvLa9mo2fm0I+2+bsgM6GO9vAgA5ANMBDmb6OcTGkOArJOtt8WM+l1JLC56LKjnWLS
         qMKCFyUR4i0dFJpzyu6RLMr7Ezn58vxUNjuASSIdELIqHpHJ4D2ATGBpVo/qreoWwbSQ
         AyDrDJxuHJshagoEj6tx0l4H8LhpCMX+SkcRh2zP4iur42IfRlbq9kXTTs9aN8tAfJaR
         efbwGPVynKFhOe9IFxXiiy+q7kXgMPGkmrHk+1pp/d/z6ujXao+G+4sdRZ3UdSWJyIFY
         vSqEfrDicntETZgTF88BNW5Yl58SxnOpTB7oPWwrPqZ+0wVdIJaCZJFZrdCVrUKbniyF
         +PCA==
X-Gm-Message-State: AOAM533KP8JKaLGzDrs4qOMWT+Be+ZsUEC6eIEZC+lOfjkmr9psWJPBO
        RE5h4FhGpYY0IX8tUsxLdg==
X-Google-Smtp-Source: ABdhPJzJNJlDDCa0+UOXe9azUIDoUn8DABtzCzM90mIYT03z73tX7YCWI8LWh5ySSv4c0TJ0MsjQRg==
X-Received: by 2002:a05:620a:3193:: with SMTP id bi19mr3083716qkb.296.1640201625369;
        Wed, 22 Dec 2021 11:33:45 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id y17sm2415617qtj.75.2021.12.22.11.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:33:44 -0800 (PST)
Received: (nullmailer pid 2570137 invoked by uid 1000);
        Wed, 22 Dec 2021 19:33:43 -0000
Date:   Wed, 22 Dec 2021 15:33:43 -0400
From:   Rob Herring <robh@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] misc: open-dice: Add driver to expose DICE data
 to userspace
Message-ID: <YcN9lzDMPjkvRDAZ@robh.at.kernel.org>
References: <20211221174502.63891-1-dbrazdil@google.com>
 <20211221174502.63891-3-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221174502.63891-3-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 05:45:02PM +0000, David Brazdil wrote:
> Open Profile for DICE is an open protocol for measured boot compatible
> with the Trusted Computing Group's Device Identifier Composition
> Engine (DICE) specification. The generated Compound Device Identifier
> (CDI) certificates represent the hardware/software combination measured
> by DICE, and can be used for remote attestation and sealing.
> 
> Add a driver that exposes reserved memory regions populated by firmware
> with DICE CDIs and exposes them to userspace via a character device.
> 
> Userspace obtains the memory region's size from read() and calls mmap()
> to create a mapping of the memory region in its address space. The
> mapping is not allowed to be write+shared, giving userspace a guarantee
> that the data were not overwritten by another process.
> 
> Userspace can also call write(), which triggers a wipe of the DICE data
> by the driver. Because both the kernel and userspace mappings use
> write-combine semantics, all clients observe the memory as zeroed after
> the syscall has returned.
> 
> Cc: Andrew Scull <ascull@google.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  drivers/misc/Kconfig     |  12 +++
>  drivers/misc/Makefile    |   1 +
>  drivers/misc/open-dice.c | 188 +++++++++++++++++++++++++++++++++++++++
>  drivers/of/platform.c    |   1 +

Acked-by: Rob Herring <robh@kernel.org>

>  4 files changed, 202 insertions(+)
>  create mode 100644 drivers/misc/open-dice.c
