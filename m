Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF55D477FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbhLPWC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhLPWC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:02:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B8CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 14:02:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j18so548043wrd.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 14:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jr113sD2CvAYYaqrKJ2RFq/931IUT0YAFGFLLTKtGbE=;
        b=Wcjg5ik9dcrXPAnVnn3yL9Bzo7AhRdMp/iBvZY/qIPLoLk0v9w99kx9EylPs7yiEcO
         gN5SJkXEjUIU0/YQQNVUOt5vP7MJDNicq9qK02n7Yx0MYOJS4+xPGHMvKvqsy9y8iaeY
         bzxVUdYKKjnC6brqYUd+odEP6YA8pKLE6pF0aS5sF8TLkcnxBj/bQfJMcf1nXcHnE8kq
         d6ZoaxYAK5vekUNNjYV0gXS1Q4qLDRVZ8NzR9rQFJCmOCZtKwd44V8Lc1HbMopSw/eik
         URiF7PqdwOSfwNWHeLxuM3Dqa4aEEspEjK8BZsIysbbbhY66h5CAqODUm0g6XMFYR8um
         pI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jr113sD2CvAYYaqrKJ2RFq/931IUT0YAFGFLLTKtGbE=;
        b=42bYVYN/x3iPHfdaYY5MI7HukkcWOkBWGWfKrRTYGcG5RocvkWWR299thk1WAyiAOi
         hGUOrb2cb4ED4ipJQnkfO5nqT1KmGwiGDiP5x1+hTVVsu8nhKdf0KLIFdB5EFVWDBWUE
         BC6Who3Y73Bp451T7CL0qyQ9ZV0hQYd+BzdxCx6fFjgjggM/oC0iCdpKcZRU8Ye89c1i
         ICG8myMaec3RGJmth2r3v4p2TExFFgvUS9Eh3q4JQbx644FGjvnZ/QM9OzwfhpwBDVDa
         QL3/9KTvDuhn8uQ+g66kYAXFY53H6wJtVx0fYlwiOaVozAZBqhmnYNjqwEObXssMhNq1
         AjqQ==
X-Gm-Message-State: AOAM530w/a8/FccQGTB4p2YRQ8hfFC8YpwDWn3Q5dcv/KMklEok4Lz2G
        rfnaNOV12qxouyS53csh9KuszSMLCoU=
X-Google-Smtp-Source: ABdhPJy46xui0iaw81h/rHG30m0c96KJf69/+cIlCYxG4WAy2Gr4Rhla2NZ9aAZgaym0KofijEzPXA==
X-Received: by 2002:a5d:456e:: with SMTP id a14mr26199wrc.256.1639692173852;
        Thu, 16 Dec 2021 14:02:53 -0800 (PST)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id d2sm5543428wmb.31.2021.12.16.14.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 14:02:53 -0800 (PST)
Subject: Re: [PATCH V4 0/6] xen: Add support of extended regions (safe ranges)
 on Arm
From:   Oleksandr <olekstysh@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Wei Chen <Wei.Chen@arm.com>, Henry Wang <Henry.Wang@arm.com>,
        Kaly Xin <Kaly.Xin@arm.com>, Jiamei Xie <Jiamei.Xie@arm.com>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
Message-ID: <1428a0be-b80c-f996-1f72-6545dd66c1bf@gmail.com>
Date:   Fri, 17 Dec 2021 00:02:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.12.21 22:05, Oleksandr Tyshchenko wrote:


Hello Juergen, Boris


May I please ask, are you happy (or otherwise) with current patch series 
(I assume, especially with commits #3-4)?

For the convenience:

   1. xen/unpopulated-alloc: Drop check for virt_addr_valid() in fill_list()
- Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

   2. arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT
- Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

   3. xen/balloon: Bring alloc(free)_xenballooned_pages helpers back
- Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

   4. xen/unpopulated-alloc: Add mechanism to use Xen resource
- Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

   5. arm/xen: Read extended regions from DT and init Xen resource
- Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

   6. dt-bindings: xen: Clarify "reg" purpose
- Reviewed-by: Bertrand Marquis <bertrand.marquis@arm.com>
- Acked-by: Rob Herring <robh@kernel.org>
- Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
>
> Hello all.
>
> You can find the RFC-V3 patch series at [1],[2] and [3].
>
> The corresponding Xen support (for both Dom0 and DomU) is already committed and
> is available in mainline Xen since the following commit:
> 57f87857dc2de452a796d6bad4f476510efd2aba libxl/arm: Add handling of extended regions for DomU
>
> The extended region (safe range) is a region of guest physical address space
> which is unused and could be safely used to create grant/foreign mappings instead
> of ballooning out real RAM pages to obtain a physical address space for creating
> these mappings (which simply results in wasting domain memory and shattering super
> pages in P2M table).
>
> The problem is that we cannot follow Linux advise which memory ranges are unused
> on Arm as there might be some identity mappings in P2M table (stage 2) the guest is not
> aware of or not all device I/O regions might be known (registered) by the time the guest
> starts creating grant/foreign mappings. This is why we need some hints from the hypervisor
> which knows all details in advance to be able to choose extended regions (which won't
> clash with other resources).
>
> The extended regions are chosen at the domain creation time and advertised to it via
> "reg" property under hypervisor node in the guest device-tree [4]. As region 0 is reserved
> for grant table space (always present), the indexes for extended regions are 1...N.
> No device tree bindings update is needed, guest infers the presence of extended regions
> from the number of regions in "reg" property.
>
> Please note the following:
> - The ACPI case is not covered for now
> - patch series was created in a way to retain existing behavior on x86
>
> The patch series is based on v5.16-rc3 and also available at [5], it was fully
> tested on Arm64 and only compile tested on x86.
>
> [1] https://lore.kernel.org/all/1627490656-1267-1-git-send-email-olekstysh@gmail.com/
>      https://lore.kernel.org/all/1627490656-1267-2-git-send-email-olekstysh@gmail.com/
> [2] https://lore.kernel.org/all/1635264312-3796-1-git-send-email-olekstysh@gmail.com/
> [3] https://lore.kernel.org/all/1637787223-21129-1-git-send-email-olekstysh@gmail.com/
> [4] https://xenbits.xen.org/gitweb/?p=xen.git;a=blob_plain;f=docs/misc/arm/device-tree/guest.txt;hb=refs/heads/master
> [5] https://github.com/otyshchenko1/linux/commits/map_opt_ml7
>
> Oleksandr Tyshchenko (6):
>    xen/unpopulated-alloc: Drop check for virt_addr_valid() in fill_list()
>    arm/xen: Switch to use gnttab_setup_auto_xlat_frames() for DT
>    xen/balloon: Bring alloc(free)_xenballooned_pages helpers back
>    xen/unpopulated-alloc: Add mechanism to use Xen resource
>    arm/xen: Read extended regions from DT and init Xen resource
>    dt-bindings: xen: Clarify "reg" purpose
>
>   Documentation/devicetree/bindings/arm/xen.txt |  14 +--
>   arch/arm/xen/enlighten.c                      | 132 ++++++++++++++++++++++++--
>   drivers/xen/Kconfig                           |   2 +-
>   drivers/xen/balloon.c                         |  20 ++--
>   drivers/xen/unpopulated-alloc.c               |  87 ++++++++++++++++-
>   include/xen/balloon.h                         |   3 +
>   include/xen/xen.h                             |  16 ++++
>   7 files changed, 245 insertions(+), 29 deletions(-)
>
-- 
Regards,

Oleksandr Tyshchenko

