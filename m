Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED3498381
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbiAXP00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiAXP0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:26:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0CEC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:26:25 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m4so22412215ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 07:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Q8tro22vmfvtv1qHxEcfE1lk9LIniWBhqByQR/FGqp4=;
        b=mSseQoA2/Nw6gRVgkLwKAZdbXStcF73ez6RhVeCcO38WnQVMSeEyBecUTR1L86/O6I
         uwGSUx9jq8WMYQKuq97M1S6PWW7mlkmxBb6cu9mrFIDsGJpuiPt2l24/H1T6uMazOq68
         Te+8TzVvBUxIt1ZJeZw2DY7BunK2EYQS3pmMNqIL487Gs4S7xiUE6eSWcuTQ69DNLLCz
         Zqj/DX38v2zDx75WPxVgI6LmBVhwR3G1S+u61czJHFXlvVHrrOphIgl16P6tKrVZgPNC
         1Vy5kZuZn1fCTxNECZznpspQuQgOFXk/E0fFdPFJE3omWINnxvwCkpeStgN9U9yaYkRn
         Tiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Q8tro22vmfvtv1qHxEcfE1lk9LIniWBhqByQR/FGqp4=;
        b=IelJ1YD1eF20XOJF1sz/qarUWuObsxMxqojQnuBStIwTKcOSknuPCsW4q4Z7JueUc3
         4rSS8pXT8jDNwBuLLB/ifxC8oeQWVQTMidsdSHb8nm94QXRz4GwMS3VjlbyjeQ20vx6h
         6/1Lrn3H3sfoLXYUIqIn7HiPF7qJUdjYgmnbzM59qLiPuKWtOSoQOFqamrTpu3zPD1N8
         eHALcsI24OfzCNIOhUIJ7fgmjThhzb+Mrkcx+O5rgJ7eUUA3egwqnRkoW3QUf8Z/lf/F
         u5a07dzdAppL87je3deyO27wtajd2DlJ1aFtksbFIoDzfTGGZhY2SOvIrUOU3x4kbQz+
         BuwQ==
X-Gm-Message-State: AOAM5339BWoFckqwH2geeaGzOk5utZNiMfHE86RopUkgsHqFavVlGwUM
        EMvPyg9KF10LTO9U0uFh82Wt9PcRNFojsEvxXdXKclSC3W7zfw==
X-Google-Smtp-Source: ABdhPJzrhkH8rGDmJsc0J8PWfIRm2laAoDaGHEsQrYfJKnTZ+Y8iIFX0dfliY3hfTYS0qBJieSHzX4KYb0hlsIxdJ2s=
X-Received: by 2002:a17:907:e8f:: with SMTP id ho15mr13141064ejc.481.1643037983390;
 Mon, 24 Jan 2022 07:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20220124150209.22202-1-bgeffon@google.com> <20220124151434.GB20331@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
In-Reply-To: <20220124151434.GB20331@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 24 Jan 2022 10:25:47 -0500
Message-ID: <CADyq12ykDCswWZw05OdyYfP-zT6afuhXbckii1m1egQ2fSwB4w@mail.gmail.com>
Subject: Re: [PATCH] dm: introduce a no open flag for deferred remove
To:     Brian Geffon <bgeffon@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:14 AM Alasdair G Kergon <agk@redhat.com> wrote:
>
> On Mon, Jan 24, 2022 at 07:02:09AM -0800, Brian Geffon wrote:
> > When a device is being removed with deferred remove it's
> > still possible to open and use the device. This change
> > introduces a flag called DM_DEFERRED_REMOVE_NO_OPEN_FLAG
> > which when used with DM_DEFERRED_REMOVE will cause any
> > new opens to fail with -ENXIO.
>
> What is the need for this?

Hi Alasdair,
Thank you for looking at this. There are a few reasons this might be
useful, the first is if you're trying to speed up a graceful teardown
of the device by informing userspace that this device is going to be
removed in the near future. Another might be on systems where it might
be worthwhile to not have users with CAP_DAC_OVERRIDE be able to open
the device. The logic on this second case is that, suppose you have a
dm-crypt block device which is backing swap, the data on this device
is ephemeral so a flow might be to setup swap followed by dmsetup
remove --deferred /dev/mapper/encrypted-swap. This will guarantee that
as soon as swap is torn down the encrypted block device is dropped,
additionally with this new flag you'll be guaranteed that there can be
no further opens on it.

> Does it break any semantics assumed by userspace?

No, this is fully backwards compatible with the current deferred
remove behavior, it's not required. Additionally, since on the actual
remove userspace would receive an -ENXIO already once the remove
process has started it seems reasonable to return -ENXIO in the
deferred remove case when this flag is enabled.

Brian
