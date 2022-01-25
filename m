Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6856749B64F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351109AbiAYOck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579565AbiAYO3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:29:19 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8947C061770
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:26:30 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b13so63515874edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=uLYc4GfafSgmS5JKXh594CfMmA35aGk/ExImBcGXGtA=;
        b=BPZNM5pbakpa9qw5XOCXOKrlaT4P9JONtPfzzI/7EDuxL4xpG+WKl+4zQnPUjLHZsT
         Fv0+hgvomdk5YBgw5iGdrwsHBVadEjSJEmB8Ybq8xUdddfzTFwbyQrGOC/gJsq5gGvua
         LSKmSiGeq+Q1vdI+h3FiVdMSdh0v41mU/BFs65s3NTwyxy2r45gZO8LGNVPgxgRmoCAc
         MrM2MpHuU7VY1NedoW3dxukCX9kjDguDEhYU3NRjc71Z8RIdTIrxt5SfXkse6EWM/9iu
         TxKfm5uo2Mp80h02QawdPVsIjPXF2SIoCYQdjR5k4kKYddR2vfaMhmY4DiV901Tf0beq
         82ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=uLYc4GfafSgmS5JKXh594CfMmA35aGk/ExImBcGXGtA=;
        b=XA1QHSQBZlaKOJRhDoE/+cFiMYcxC/OFJ2+Qyms2NhAS4kKmu2413RMWW8vnWPy56T
         Qq5P6+LgVHko9jGuD+EJtegp51Lh/JsoTzd9mNcenFkg/CC/8FqzxYbj50IpkIxFH0Xh
         hgi85UR0mcrY3Vw+rcYGRQwJHJrV/BTyi7ZqlG52JUV0APyLnU+rHQYGPeyWXu44a6vE
         L69fn/aKl/9ewnNPDcLVFwF7rwuz5ZpPQ3gtt+VyHy0/ci5jmoZ22gMi7ito2k1sAMXk
         3KPjxrUpu0Yda7uSumWuyIgoLPe2XwwChnKZw5MyIZljDao6xly/rJcvP60aela3EYl3
         7NxA==
X-Gm-Message-State: AOAM533H9BA5PwIPDxpLZyzivwwIZ8/paHNSDwKRYijsQtFh3RJ1hKcH
        w1CNjCxdgEeNsyu41m/p8/3Trsg7bI0d0E8sepGEdQ==
X-Google-Smtp-Source: ABdhPJweYum/ZG0CXLwcWx/cLh6hSzOrvhiqGj8hBYQ0eR5iW7lIA8q2idFX0Mg3J25eq6LZ46gmxJ6XpwWSSMv5SQs=
X-Received: by 2002:a17:906:c116:: with SMTP id do22mr16628213ejc.592.1643120789060;
 Tue, 25 Jan 2022 06:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20220124150209.22202-1-bgeffon@google.com> <20220124151434.GB20331@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
 <CADyq12ykDCswWZw05OdyYfP-zT6afuhXbckii1m1egQ2fSwB4w@mail.gmail.com> <20220125002025.GA21887@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
In-Reply-To: <20220125002025.GA21887@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 25 Jan 2022 09:25:52 -0500
Message-ID: <CADyq12zS5ZP+0DBdiVWq0_kt4-n0ykdwH_Nw=kJj0V7oF=3OdQ@mail.gmail.com>
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

Yes, this is the primary reason I'm exploring this. I tried to find an
implementation that might be useful in other situations which is why I
landed on this approach.

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

Thanks for explaining and providing that context.

>
> But if the reason for this is basically "make it harder for
> anything else to access my encrypted swap" and to deliberately
> prevent access, then let's approach the requirement from that angle.
> Are there alternative implementations with interventions at different
> points?

Absolutely, we could perhaps create a new ioctl which allows the
caller to specify the maximum open count, and when the open count hits
that value it fails any new opens with -EBUSY. Perhaps this would be
enforced in dm_get_device? This type of behavior could theoretically
mimic the patch I mailed when used in conjunction with deferred
removal. Is this an approach you think might make more sense with the
existing design? Are there any implementation points you believe might
make more sense for such a feature?

>  Are there similar requirements for devices that don't need
> deferred remove?

I cannot immediately think of a situation where you'd do this without
deferred removal.

>  If this is indeed the best place to insert this type
> of restriction, then we should label it and document it accordingly so
> people don't mistakenly use it for the 'normal' case.  (We always keep
> libdevmapper and dmsetup in sync with kernel interface extensions, so
> we'd seek a tiny patch to do that too.)

Yes, absolutely. I'll happily send patches for userspace libraries,
applications, and documentation once we converge on an acceptable
approach.

Thanks again for spending your time discussing this,
Brian
