Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF446446B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbhLABK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhLABKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:10:21 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D840C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:07:01 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so94206511edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDTZQO1s0l0nQ4okwAIdEoHQ0YiyLaeFzWFpDGXURhI=;
        b=aKNAM/hTD2iyToIfqhdvNElGlNz9s4c/KoEOloKnsDnBEqXyqyhwYtC2k4V2Z29Ggn
         +lCXAtuOpk0iQ5eDzn4kskDCc8OBWFvZ9JqVFA5JLxu1TSSG/YxssrYsCO8FWCfa6qcM
         +z4U//Z4fsc3N5DwKeNMvUZdr2y6nHv+6d8iEYXb8tGncg6XmtgLZVXqK39wY3N63duR
         HCle84xmK41sYwEp0AQj2ovjVB2X/++iufFILpVt1GA9iC5em/e6g1rjyY9bf2VgSG5T
         vWocu4b0nzqES5H+XLSYywAOR/GNZYkfeYyv13c2VG30g6TdJDNddeC+wgPeuRcm45/o
         PBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDTZQO1s0l0nQ4okwAIdEoHQ0YiyLaeFzWFpDGXURhI=;
        b=uD5GPv6GQGez2OMOX33iEHsgD1KF20GAo7iVM1eYQS8YVcV/DSConIg6Ty15Wx5f7U
         VbJhJBZWMXPzX9vmKQQ0vP/D0A/3cj05uewNok8F0ZKX0HenNF9L5qtfmJMF7SnC+gFf
         yn5eVkz2SBujpVNl88VyUY+reJQlfvhe8QRgBuEqhoRRoSVyP78zEem5H6mT8iq13O15
         7sMb32jsbSas3fLqARgpWmAC/E81P5oTHCWl+Ypu0VX5yG6bFps7jI3ZWbwn6qXwP1Tf
         GvieL6BlcVxfytUuGCeQz/xjB9mN5fgxBeukjXn9i5RsNoUWJyRKKP2nnwGtE2PROBgK
         wO/A==
X-Gm-Message-State: AOAM530vC941PCZqLkxWvXbxo+e6jR/T2W+e/lOygJbe4Yr45HY4KAhf
        GI8h9WD06/uocHoI8KQvl1bkTaArYCZwFkgkgPNT
X-Google-Smtp-Source: ABdhPJxty9SzAkb0v8cwbtS2kkFtq94PrIqZjihhoj6I/Aj1LVnCBLmzhnBqErP0r0YUKFdEbazwCMhiZXkezaGEjsU=
X-Received: by 2002:a17:906:d96e:: with SMTP id rp14mr3105756ejb.104.1638320819895;
 Tue, 30 Nov 2021 17:06:59 -0800 (PST)
MIME-Version: 1.0
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
In-Reply-To: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Nov 2021 20:06:49 -0500
Message-ID: <CAHC9VhTJG24iG=U0geO-ZhC6OogxOu4icBrNY22+qRNpWd5PBQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
To:     Ross Philipson <ross.philipson@oracle.com>,
        trenchboot-devel@googlegroups.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 9:20 AM Ross Philipson
<ross.philipson@oracle.com> wrote:
>
> The larger focus of the Trechboot project (https://github.com/TrenchBoot) is to
> enhance the boot security and integrity in a unified manner. The first area of
> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
> Trust for Measurement).

My apologies for such a late reply, but I'm just getting around to
looking at this and I have a few questions on the basic design/flow
(below) ...

> The basic flow is:
>
>  - Entry from the dynamic launch jumps to the SL stub

So I'm clear, at this point the combined stub+kernel+initramfs+cmdline
image has already been loaded into memory and the SL stub is
executing, yes?

As TrenchBoot seems to be focused on boot measurement and not
enforcing policy, I'm guessing this is considered out-of-scope (not to
mention that the combined stub+kernel image makes this less
interesting), but has any thought been given to leveraging the TXT
launch control policy, or is it simply an empty run-everything policy?

>  - SL stub fixes up the world on the BSP
>  - For TXT, SL stub wakes the APs, fixes up their worlds
>  - For TXT, APs are left halted waiting for an NMI to wake them
>  - SL stub jumps to startup_32
>  - SL main locates the TPM event log and writes the measurements of
>    configuration and module information into it.

Since the stub+kernel image are combined it looks like the kernel
measurement comes from the ACM via the MLE measurement into PCR 18,
while the stub generated measurements are extended into PCR 19 or 20
depending on the configuration, yes?

I realize that moving the TXT code into the kernel makes this
difficult (not possible?), but one of the things that was nice about
the tboot based approach (dynamic, early launch) was that it could be
extended to do different types of measurements, e.g. a signing
authority measurement similar to UEFI Secure Boot and PCR 7.  If that
is possible, I think it is something worth including in the design,
even if it isn't initially implemented.  The only thing that
immediately comes to mind would be a section/region based approach
similar to systemd-boot/gummiboot where the (signed) kernel is kept in
a well known region and verified/measured by the stub prior to jumping
into its start point.

>  - Kernel boot proceeds normally from this point.
>  - During early setup, slaunch_setup() runs to finish some validation
>    and setup tasks.
>  - The SMP bringup code is modified to wake the waiting APs. APs vector
>    to rmpiggy and start up normally from that point.
>  - SL platform module is registered as a late initcall module. It reads
>    the TPM event log and extends the measurements taken into the TPM PCRs.

I'm sure there is some issue with passing data across boundaries, but
is there any reason why the TPM event log needs to be updated
out-of-sync with the TPM PCRs?  Is is possible to pass the
measurements to the SL platform module which would both extend the
PCRs and update the TPM event log at the same time?

>  - SL platform module initializes the securityfs interface to allow
>    asccess to the TPM event log and TXT public registers.
>  - Kernel boot finishes booting normally
>  - SEXIT support to leave SMX mode is present on the kexec path and
>    the various reboot paths (poweroff, reset, halt).

It doesn't look like it's currently implemented, but it looks like
eventually you plan to support doing a new DRTM measurement on kexec,
is that correct?  I'm sure that is something a *lot* of people
(including myself) would like to see happen.

-- 
paul moore
www.paul-moore.com
