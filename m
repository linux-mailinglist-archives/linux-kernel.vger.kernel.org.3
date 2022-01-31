Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447C14A4AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379662AbiAaPdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:33:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379575AbiAaPdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643643187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MqkwAw4wuOZd8apS0xcc2rXhPmZK3L0to+YK8fdXzXQ=;
        b=RHasLybC9fZjdhEXw0DhS7ZTUJgqXUSOBQme9PyyjYlmSpuzPfTL3mqDiCEotNuS89sqjv
        8oiY5g0AhKmEhhhy4VpyvLTFLiCgzO+1zAou1/tRKvP6TgcXwV8N268CwBd0h70M+oJVxY
        XHBRIND5AoJkhWJOz94SI1+fCaIKcQw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-WaVWqpWUOUCi6W8R4y4oUQ-1; Mon, 31 Jan 2022 10:33:03 -0500
X-MC-Unique: WaVWqpWUOUCi6W8R4y4oUQ-1
Received: by mail-ot1-f69.google.com with SMTP id w25-20020a9d70d9000000b0059fa6c78406so8105722otj.22
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 07:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MqkwAw4wuOZd8apS0xcc2rXhPmZK3L0to+YK8fdXzXQ=;
        b=6yyThtozUx9ke5RGEWTp9fx3fBKxtNPnDUJBRUtqeer3ESPx/g6BDBuw9IH0Gu02cE
         1XuuTaZA/XoFFawNJ4HoYrnXaKPyuNVssRxAK9PkZBaFkNvtSwZgCrJ942NQp8Alm1wK
         lACO/ysNF1VXZs1xsTGeLAKgUBI6aCI49YRrA7PYNEZ0XRLvtv27UUwsG0zNdpEHYMo9
         +0b13H+WGBEHVrGELFV/xBqCtTwcEOjhc3I3GTe7o/M8MRqRH8QzFLZCKH7zdPIGC6ZG
         7Gq/2CgSPQ0VOcQf3cseTB+OQ+oUzTNoDLBWr7t2jCHxpaCAyxRlDtOsdblrUwjFnPyk
         fdYA==
X-Gm-Message-State: AOAM5301b9PqMSSxalBbzxw0M5awb3cWwZGcufmQmZI5GRyJYZG52Ocq
        7PWqYAtSg/YLmNSxWHNhYZBk1kiW/7TI1k9ZgG6M4y9QAl0E65YMuL8GyZORZyGkncLeCFA18jH
        YHCbwI4+JgNHYwmb3gUMnedoJ
X-Received: by 2002:aca:aa96:: with SMTP id t144mr19411039oie.132.1643643182464;
        Mon, 31 Jan 2022 07:33:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymr2dsBCKlgP7OeGj6aD5XCERLPQYOTSNplzQW6dStWy8SIH9lqk49likkpXiG7dI3/kwJvw==
X-Received: by 2002:aca:aa96:: with SMTP id t144mr19411018oie.132.1643643182208;
        Mon, 31 Jan 2022 07:33:02 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id bb16sm1343181oob.42.2022.01.31.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:33:01 -0800 (PST)
Date:   Mon, 31 Jan 2022 08:33:00 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/5] vfio/pci: fix memory leak during D3hot to D0
 tranistion
Message-ID: <20220131083300.50045695.alex.williamson@redhat.com>
In-Reply-To: <b0f25525-362a-c2dc-f255-22fa533fda26@nvidia.com>
References: <20220124181726.19174-1-abhsahu@nvidia.com>
        <20220124181726.19174-4-abhsahu@nvidia.com>
        <20220127170525.51043f23.alex.williamson@redhat.com>
        <b0f25525-362a-c2dc-f255-22fa533fda26@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 17:04:12 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:

> On 1/28/2022 5:35 AM, Alex Williamson wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, 24 Jan 2022 23:47:24 +0530
> > Abhishek Sahu <abhsahu@nvidia.com> wrote:
> >   
> >> If needs_pm_restore is set (PCI device does not have support for no
> >> soft reset), then the current PCI state will be saved during D0->D3hot
> >> transition and same will be restored back during D3hot->D0 transition.
> >> For saving the PCI state locally, pci_store_saved_state() is being
> >> used and the pci_load_and_free_saved_state() will free the allocated
> >> memory.
> >>
> >> But for reset related IOCTLs, vfio driver calls PCI reset related
> >> API's which will internally change the PCI power state back to D0. So,
> >> when the guest resumes, then it will get the current state as D0 and it
> >> will skip the call to vfio_pci_set_power_state() for changing the
> >> power state to D0 explicitly. In this case, the memory pointed by
> >> pm_save will never be freed.
> >>
> >> Also, in malicious sequence, the state changing to D3hot followed by
> >> VFIO_DEVICE_RESET/VFIO_DEVICE_PCI_HOT_RESET can be run in loop and
> >> it can cause an OOM situation. This patch stores the power state locally
> >> and uses the same for comparing the current power state. For the
> >> places where D0 transition can happen, call vfio_pci_set_power_state()
> >> to transition to D0 state. Since the vfio power state is still D3hot,
> >> so this D0 transition will help in running the logic required
> >> from D3hot->D0 transition. Also, to prevent any miss during
> >> future development to detect this condition, this patch puts a
> >> check and frees the memory after printing warning.
> >>
> >> This locally saved power state will help in subsequent patches
> >> also.  
> > 
> > Ideally let's put fixes patches at the start of the series, or better
> > yet send them separately, and don't include changes that only make
> > sense in the context of a subsequent patch.
> > 
> > Fixes: 51ef3a004b1e ("vfio/pci: Restore device state on PM transition")
> >   
> 
>  Thanks Alex for reviewing this patch.
>  I have added Fixes tag and sent this patch separately.
> 
>  Should I update this patch series or you are planning to review the
>  other patches first of this patch series first. 

Thanks for splitting this out.  I'll keep the remainder of the series
on the review queue, I expect I'll have some comments and it will be
easy enough to imagine vfio_pci_core_device.power_state being declared
in another patch if there's still a worthwhile use for it.  Thanks,

Alex

