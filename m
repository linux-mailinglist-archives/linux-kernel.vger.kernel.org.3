Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F101472A82
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhLMKoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235035AbhLMKoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639392256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHL+BcRj/pmK+hyLHDbkPYvC+IuJaADgZcfi3kBucvo=;
        b=T2f6ML266JmCizc1hiVnlvZTQy8Gu2R7gQQ1Qt7PNgZsD0P1eJUN3IeDJl4G3Pf6iIQkEL
        Zzf/3KpLTgullAXBb13ypLESUz+6l+c28TSda4pfD7tXHyz4eJ8ocljbw3kP8QAVrI1eBA
        72TWDVR46KTMfZX2l+IBz5Jrk5aUbwU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-zW_PmBR3MgOPvXqx_rOG0g-1; Mon, 13 Dec 2021 05:44:14 -0500
X-MC-Unique: zW_PmBR3MgOPvXqx_rOG0g-1
Received: by mail-ed1-f71.google.com with SMTP id w4-20020aa7cb44000000b003e7c0f7cfffso13595010edt.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SHL+BcRj/pmK+hyLHDbkPYvC+IuJaADgZcfi3kBucvo=;
        b=fBGBq8cdilrEtMJU8X5OQbx8SHLMA2v2YjBIzJ+DePBnz6LYJGZvgL766SXyhsGcAy
         0mRF6AUXPU601/w04dcn066gWsw0U5jcrXNsyUQl9Wft+tmb41QFRvh4ojVHy0RCY2GR
         trBfjjRXgpTAjR41J+HR51fdjsYe+xPFW3azjQW4FG2+QG/DrVV6HBKqfdbRmgP7PtO+
         NqaD8Dkx4B3aUb6xTAQVV1NRILGGb/LNeR1kphAMBEh7Bd6/GsMFF3fv+rgjFOvNDOzs
         TwwEIjBO2C/1GvCLb8nd3o1Fcw9JlwZd5V+4ifk0/6rWgyJAMcze8/loVPuW1b/XxVVf
         aIWA==
X-Gm-Message-State: AOAM530Zd+hhigtmlcCkmNWbKnBCsLmxR2QO+x5C7JaWxa912w42HDjq
        eDu0fbPYzsGN9gTJr18gXtk0GnxCaN9VBK/JIdFkqY4VEuDW62kTiQnCnhQQ8oZJyrcarBpNVB2
        0yYBj7PVcZfpr+/X8+14f+4Bf
X-Received: by 2002:a05:6402:3459:: with SMTP id l25mr64590536edc.137.1639392253445;
        Mon, 13 Dec 2021 02:44:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNOaEpqXN+b3HAuKmJouNEtF+PGIf4t0ZSl55UBSuLUkEDHpoVO/YC9kejLGFYbRvvWZpNHg==
X-Received: by 2002:a05:6402:3459:: with SMTP id l25mr64590503edc.137.1639392253233;
        Mon, 13 Dec 2021 02:44:13 -0800 (PST)
Received: from redhat.com ([2.55.148.125])
        by smtp.gmail.com with ESMTPSA id cw5sm5741448ejc.74.2021.12.13.02.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:44:12 -0800 (PST)
Date:   Mon, 13 Dec 2021 05:44:09 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211213054357-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211209162149-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:22:58PM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 25, 2021 at 09:02:01PM +0100, Marcel Holtmann wrote:
> > Hi Michael,
> > 
> > > Device removal is clearly out of virtio spec: it attempts to remove
> > > unused buffers from a VQ before invoking device reset. To fix, make
> > > open/close NOPs and do all cleanup/setup in probe/remove.
> > 
> > so the virtbt_{open,close} as NOP is not really what a driver is suppose
> > to be doing. These are transport enable/disable callbacks from the BT
> > Core towards the driver. It maps to a device being enabled/disabled by
> > something like bluetoothd for example. So if disabled, I expect that no
> > resources/queues are in use.
> > 
> > Maybe I misunderstand the virtio spec in that regard, but I would like
> > to keep this fundamental concept of a Bluetooth driver. It does work
> > with all other transports like USB, SDIO, UART etc.
> > 
> > > The cost here is a single skb wasted on an unused bt device - which
> > > seems modest.
> > 
> > There should be no buffer used if the device is powered off. We also don’t
> > have any USB URBs in-flight if the transport is not active.
> > 
> > > NB: with this fix in place driver still suffers from a race condition if
> > > an interrupt triggers while device is being reset. Work on a fix for
> > > that issue is in progress.
> > 
> > In the virtbt_close() callback we should deactivate all interrupts.
> > 
> > Regards
> > 
> > Marcel
> 
> So Marcel, do I read it right that you are working on a fix
> and I can drop this patch for now?

ping

> -- 
> MST

