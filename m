Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130A348F0C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 21:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbiANUMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 15:12:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244139AbiANUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 15:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642191169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7iTzTn2n67utbixR5b6YXHlQ+XdyXgKqOT9cBufKBdM=;
        b=N3W2HaqlnIcpnA8wvXXDuIJy5nZtLaefHh/bcQ+DjI+zmlcWawXTFPdElFTaoKsX3EwI3G
        JUqoIdIqj3XPqn9kcrVfYIQMD95aDEKi/A82JvI3j3vKfAM+XSOyxlK/ek4ldoM3JoD1vP
        cwhBD4DNMhOyEDu8LoF+9096dViVLtE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-jw_JHW5kOjaojuzUnIVRGg-1; Fri, 14 Jan 2022 15:12:48 -0500
X-MC-Unique: jw_JHW5kOjaojuzUnIVRGg-1
Received: by mail-ed1-f71.google.com with SMTP id c8-20020a05640227c800b003fdc1684cdeso9103223ede.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 12:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7iTzTn2n67utbixR5b6YXHlQ+XdyXgKqOT9cBufKBdM=;
        b=w9QniMkYeNkUiGpXH71R97LrvCH6eK1LilAVIUNvKxJpAqt9tPgK04dcuL0yKIM4lw
         9iYd2XQQy7LkNCnu/TXCaq7cVC8SwAt/128YBUbGPPoSD8o8gOhZ/z1O4DkLq0idYxNA
         96qopCojH/zsVXYCtgwzhbx/se9kWwpG2+u0FgQfYqlgvR52tyQvT9m3rHVgqN46nLXe
         Ia64XswFYl5Y6ItUsk5Hdza9MlhbMtFPY67167bYHo29gYnGDUhBGkugvxAtc+Sta0py
         fwaLPBB/Inw37NDosUAjF6fNXCAecC8gHkRAuei1Xj3jHNm9Si75Gw4edrWQ6w0soRLD
         AWNg==
X-Gm-Message-State: AOAM532HbDltJYo4meXjpaINb6l3bk5VtAmoDo/0oC847xmUmbEvidd0
        EavIfmo/2CstqCuuZL2CRlyox5gIpIT0pHKlsi89zzN8f7IQZ9Mn64cjEkoj+iUc/3DrhN+KnCk
        HnM+PQ5SIJZCuaHqi9gbgLGll
X-Received: by 2002:a17:906:4998:: with SMTP id p24mr8386860eju.131.1642191167098;
        Fri, 14 Jan 2022 12:12:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlRk5849FD9Gb0CZqUKAe6WWwoBJIyORKH5tTXEVe14wdHDHsknTapvCgDiW0DJ1AVlgt6pg==
X-Received: by 2002:a17:906:4998:: with SMTP id p24mr8386847eju.131.1642191166939;
        Fri, 14 Jan 2022 12:12:46 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
        by smtp.gmail.com with ESMTPSA id u12sm1884500eda.56.2022.01.14.12.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 12:12:45 -0800 (PST)
Date:   Fri, 14 Jan 2022 15:12:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20220114151142-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
 <20211209162149-mutt-send-email-mst@kernel.org>
 <20211213054357-mutt-send-email-mst@kernel.org>
 <20211213185620-mutt-send-email-mst@kernel.org>
 <FF8BA713-6DD2-485B-9ADC-02006126BC60@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FF8BA713-6DD2-485B-9ADC-02006126BC60@holtmann.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:58:31PM +0100, Marcel Holtmann wrote:
> Hi Michael,
> 
> >>>>> Device removal is clearly out of virtio spec: it attempts to remove
> >>>>> unused buffers from a VQ before invoking device reset. To fix, make
> >>>>> open/close NOPs and do all cleanup/setup in probe/remove.
> >>>> 
> >>>> so the virtbt_{open,close} as NOP is not really what a driver is suppose
> >>>> to be doing. These are transport enable/disable callbacks from the BT
> >>>> Core towards the driver. It maps to a device being enabled/disabled by
> >>>> something like bluetoothd for example. So if disabled, I expect that no
> >>>> resources/queues are in use.
> >>>> 
> >>>> Maybe I misunderstand the virtio spec in that regard, but I would like
> >>>> to keep this fundamental concept of a Bluetooth driver. It does work
> >>>> with all other transports like USB, SDIO, UART etc.
> >>>> 
> >>>>> The cost here is a single skb wasted on an unused bt device - which
> >>>>> seems modest.
> >>>> 
> >>>> There should be no buffer used if the device is powered off. We also don’t
> >>>> have any USB URBs in-flight if the transport is not active.
> >>>> 
> >>>>> NB: with this fix in place driver still suffers from a race condition if
> >>>>> an interrupt triggers while device is being reset. Work on a fix for
> >>>>> that issue is in progress.
> >>>> 
> >>>> In the virtbt_close() callback we should deactivate all interrupts.
> >>>> 
> >>>> Regards
> >>>> 
> >>>> Marcel
> >>> 
> >>> So Marcel, do I read it right that you are working on a fix
> >>> and I can drop this patch for now?
> >> 
> >> ping
> > 
> > 
> > If I don't hear otherwise I'll queue my version - it might not
> > be ideal but it at least does not violate the spec.
> > We can work on not allocating/freeing buffers later
> > as appropriate.
> 
> I have a patch, but it is not fully tested yet.
> 
> Regards
> 
> Marcel

ping

it's been a month ...

I'm working on cleaning up module/device removal in virtio and bt
is kind of sticking out.

-- 
MST

