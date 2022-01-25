Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F33749AC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbiAYGSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S251802AbiAYEXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:23:53 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB4C055A9A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:00:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id m4so26991048ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDfcMnt1ZIQSIpldkMR2YGoR++JF8Hl0uMJZ3mgF3iY=;
        b=S9E1edi4iAkbpoJ+Y0W1HzlmRTnQHoOVMmp52n5V0GF6fHlHMM4a+MZlAhd2vQVolE
         gBNHQO9G95AU6El8yYP+9K3U0j6H+9dEeqes2bv5Ou90d9Zmh2QlPtfT4eQ95yQjQqu1
         xTuZ+anWtCg0c5ZqvdnxrWvcJ1M/JvO6p4saH2DieiVcQ48tmbAE1LcmiQfoeJfxCeBz
         AgExhWjkDueju4N0H4vL0WEYNmLv9FDmq/c4wA3+1c/Y6QFD6QID6E6t54DVjjBui3fX
         o6TpqUJQDbGHhh+ly41BVgzMzFEQnzjuuJwPAUXez1Zam6u9VHvEWUY/8pK2npJegX4B
         iWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDfcMnt1ZIQSIpldkMR2YGoR++JF8Hl0uMJZ3mgF3iY=;
        b=dXJ1ALcxc07e6mp46S42hgCZP+Iw09XVEDWzQlglDKyz+kc7sknuuzVSB0H/0lvoXW
         /+LaidLa1WOvLCR9VdqttB9DUfyT4UpcQpWwgJv1MSUEZZ0AokKYoyGZgRbx/MfA8TU/
         +FHqgcpSii/B8lTI6TLfxj7apUjwmzcPMxVovjy95U045usw56u33fxq6WMrNhCKNsb9
         1Aqi74T36D38OL7N2Df1euooeGTsD2WVcrg6s2NXmzWlMsUTp3qBmlNUJBGyquL2bUMA
         TW6LERokUx6aCL12iBgY6r5j5+xcDNe9fPqM45HLPRQ4nW3hR8vjkVMEKHmMAmNx/88C
         li4A==
X-Gm-Message-State: AOAM532n3XeVmCITrVjl/8O1RvrRPcaicTxMKCk0lUIBjMwzeBQ2MFC1
        c2K9Fc0aKbEhjr9Dop1gGTThx1Et5wONZHgwMpGgYw==
X-Google-Smtp-Source: ABdhPJwSbjPkXOC0WNl3nA/m/jbSakBXomokfM2F4pnK0jGKb+qnJjxSs6ue0f5eJmhwXSqQigIKuRUHo0JdGXBOh7U=
X-Received: by 2002:a17:907:3da1:: with SMTP id he33mr8344074ejc.250.1643079610110;
 Mon, 24 Jan 2022 19:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20220122072644.92292-1-khuey@kylehuey.com> <Ye6Z31keWVPrsNWU@hirez.programming.kicks-ass.net>
 <3c35dc76-c187-8d3f-7fc9-75de32e7cbf6@linux.intel.com>
In-Reply-To: <3c35dc76-c187-8d3f-7fc9-75de32e7cbf6@linux.intel.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 24 Jan 2022 18:59:58 -0800
Message-ID: <CAP045ArbX7cYKyv0H4X2SxUJWycB1VoLZWLME=_RXttBFBfP3A@mail.gmail.com>
Subject: Re: [PATCH] x86/perf: Default freeze_on_smi on for Comet Lake and later.
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 8:01 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 1/24/2022 7:21 AM, Peter Zijlstra wrote:
> > On Fri, Jan 21, 2022 at 11:26:44PM -0800, Kyle Huey wrote:
> >> Beginning in Comet Lake, Intel extended the concept of privilege rings to
> >> SMM.[0] A side effect of this is that events caused by execution of code
> >> in SMM are now visible to performance counters with IA32_PERFEVTSELx.USR
> >> set.
> >>
> >> rr[1] depends on exact counts of performance events for the user space
> >> tracee, so this change in behavior is fatal for us. It is, however, easily
> >> corrected by setting IA32_DEBUGCTL.FREEZE_WHILE_SMM to 1 (visible in sysfs
> >> as /sys/devices/cpu/freeze_on_smi). While we can and will tell our users to
> >> set freeze_on_smi manually when appropriate, because observing events in
> >> SMM is rarely useful to anyone, we propose to change the default value of
> >> this switch.
>
> + Andi
>
>  From we heard many times from sophisticated customers, they really hate
> blind spots. They want to see everything. That's why we set
> freeze_on_smi to 0 as default. I think the patch breaks the principle.

The default kernel settings for perf events prioritize preventing
information leaks to less privileged code. perf_event_paranoid
defaults to 2, preventing unprivileged users from observing kernel
space. If "sophisticated customers" want to see everything they have
already needed privileges (or an explicit opt-in through decreasing
perf_event_paranoid) for some time.

The current situation on Comet Lake+ where an unprivileged user
*cannot* observe kernel code due to security concerns but
simultaneously *must* observe SMM code seems rather absurd.

> I don't think there is a way to notify all the users that the default
> kernel value will be changed. (Yes, the end user can always check the
> /sys/devices/cpu/freeze_on_smi to get the latest value. But in practice,
> no one checks it unless some errors found.) I think it may bring
> troubles to the users if they rely on the counts in SMM.

Unfortunately the new hardware has already changed the behavior
without notifying users, no matter what we do here.

> The patch only changes the default values for some platforms, not all
> platforms. The default value is not consistent among platforms anymore.
> It can bring confusion.

I don't personally object to changing freeze_on_smi for all platforms
:) I was merely trying to limit the changes.

> All in all, we have already exposed an interface for the end-users to
> change the value. If some apps, e.g., rr, doesn't want the default
> value, I think they can always change it in the app for all platforms.
> We should still keep the freeze_on_smi to 0 as default, which should
> benefit more users.

I think "people who want to just do userspace profiling like they did
before can just change the value" is an unsatisfying answer,
especially because freeze_on_smi requires root to change.


- Kyle

>
> >>
> >> In this patch I have assumed that all non-Atom Intel microarchitectures
> >> starting with Comet Lake behave like this but it would be good for someone
> >> at Intel to verify that.
> >>
> >
> > Kan, can you look at that?
> >
>
> I'm asking internally.
>
> Thanks,
> Kan
>
> >> [0] See the Intel white paper "Trustworthy SMM on the Intel vPro Platform"
> >> at https://bugzilla.kernel.org/attachment.cgi?id=300300, particularly the
> >> end of page 5.
> >>
> >> [1] https://rr-project.org/
> >>
> >> Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> >
> > Patch seems sensible enough; I'll go queue it up unless Kan comes back
> > with anything troublesome.
