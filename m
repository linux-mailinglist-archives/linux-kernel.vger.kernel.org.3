Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FB349BA00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573861AbiAYRQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348519AbiAYRNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:35 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55926C061787
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:12:04 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id h7so31964290ejf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nNrS4+Y2kpA/4I+O0j+MEfMovuuGqzczw7+9uw0ZYvg=;
        b=EaRGks4nbAE4mkVHSDRIbiOGDioTn/fqsLtEg9/e+4eKwfA1Ut+bLO3nDodkfPBU/f
         tVZHJQzF5S0rjo8VYXuANl90qXnPRK7AeNwqZuM08shxx0JAzuTPUy1XEkaSu60DRur/
         HjMB9zpP6IrthUKpCLH2ns7n+d7fC6GUlRJb+xNL7h5rHkGqnO6t1vbk2fDySuq0epD+
         ng0gd87ppFm2UqV51IDKbK5vF+58T6zxVXIfdutX+cV4i+ZWiDkeBP0E+EQLW2nI456X
         wve5ABcDOKMxc5mtP6S+hrUWjW7pzEtThHTmRW5iDzBMRDNb65p90Vcn5pljivBC7NnM
         GG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nNrS4+Y2kpA/4I+O0j+MEfMovuuGqzczw7+9uw0ZYvg=;
        b=QKg0VoxsdphtpPxFTZs6ev47oR4XISN19ucUOvzmhQaVYGyywn/u5QtkxI2nwoK0v5
         p//hDdw6CsB9/iABIQLdda3V3+YCJ8plwaZMitq8cT3TEOc/1NJMNRTRNFRvm+SQqi5y
         Mg2faB/pxpNweLtjmA5+5nvXqYYqS6+T5DE2UgR0aCVxi64OwG8Y2hJj9EgHjtF4F3ZP
         yruJCWh3aZDYk503Qkv3Zd7ZAvuvYVgkNAlOHDJj/uwKwn+ezcwjA7YGTouKgfNZ1Kgy
         bpb1u0U38nZ80ntdcAho6CER41FIIxNaGkpXyMCu5XyQXMdc0dpGzQDPImt3UaOa8AT5
         cwTA==
X-Gm-Message-State: AOAM533Mm32+2wCbOn8BEz/qqYVDsPpr5rhe5FFsQMDGLfXitGvXxYTT
        OgulSmMwAm2MPGKs80zKyLjPenXuS2RSfguSmXBTDQ==
X-Google-Smtp-Source: ABdhPJyLfH1HWR8h43VVS0XIc2bSN8+5RKivIAAJh8I8ticiEoS9VRmwfk9Jaw3pumNtgYCON/DHMifOOqFaP9jHNro=
X-Received: by 2002:a17:907:e87:: with SMTP id ho7mr1513006ejc.481.1643130722625;
 Tue, 25 Jan 2022 09:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20220124150209.22202-1-bgeffon@google.com> <20220124151434.GB20331@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
 <CADyq12ykDCswWZw05OdyYfP-zT6afuhXbckii1m1egQ2fSwB4w@mail.gmail.com> <20220125002025.GA21887@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
In-Reply-To: <20220125002025.GA21887@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 25 Jan 2022 12:11:26 -0500
Message-ID: <CADyq12wE7mx2tPeK0gaLhBaUStrvV7cgfXqj7vWZ4F=KfR7zzQ@mail.gmail.com>
Subject: Re: [PATCH] dm: introduce a no open flag for deferred remove
To:     Brian Geffon <bgeffon@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 7:21 PM Alasdair G Kergon <agk@redhat.com> wrote:
>
> On Mon, Jan 24, 2022 at 10:25:47AM -0500, Brian Geffon wrote:
> > Thank you for looking at this. There are a few reasons this might be
> > useful, the first is if you're trying to speed up a graceful teardown
> > of the device by informing userspace that this device is going to be
> > removed in the near future. Another might be on systems where it might
> > be worthwhile to not have users with CAP_DAC_OVERRIDE be able to open
> > the device. The logic on this second case is that, suppose you have a
> > dm-crypt block device which is backing swap, the data on this device
> > is ephemeral so a flow might be to setup swap followed by dmsetup
> > remove --deferred /dev/mapper/encrypted-swap. This will guarantee that
> > as soon as swap is torn down the encrypted block device is dropped,
> > additionally with this new flag you'll be guaranteed that there can be
> > no further opens on it.
>
> And is that the reason you propose this?
> - You want a special exclusive 'one time open' device that
>   self-destructs when closed?
>
> > No, this is fully backwards compatible with the current deferred
> > remove behavior, it's not required. Additionally, since on the actual
> > remove userspace would receive an -ENXIO already once the remove
> > process has started it seems reasonable to return -ENXIO in the
> > deferred remove case when this flag is enabled.
>
> Well I feel it does break existing semantics which is why we wrote
> the code the way we did.  The state can be long-lived, the code
> that has it open might legitimately want to open it again in
> parallel etc. - in general this seems a bad idea.
>
> But if the reason for this is basically "make it harder for
> anything else to access my encrypted swap" and to deliberately
> prevent access, then let's approach the requirement from that angle.
> Are there alternative implementations with interventions at different
> points?

I was thinking perhaps another implementation might involve using
open_count on dm_ioctl as an in param on DM_DEV_CREATE only. Using
open_count as an in parameter on DM_DEV_CREATE could be activated by a
new flag, perhaps DM_ENFORCE_OPEN_COUNT_FLAG. This would allow the
behavior to be baked into the device from the start. We would then
enforce it in dm_blk_open. What would you think about an approach like
this?

Thanks,
Brian
