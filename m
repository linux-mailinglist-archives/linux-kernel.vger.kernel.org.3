Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D8E4707E7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbhLJR7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245073AbhLJR7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:59:15 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0A8C061746;
        Fri, 10 Dec 2021 09:55:39 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id a24so8686355qvb.5;
        Fri, 10 Dec 2021 09:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=1wtvNcOdkbKIyNXdwFNs06IFmsjU6gWbejdXvtZbfgs=;
        b=R8DUHYY4CEUvoGJf0fYI3YwuKddeDeV1uozdv2ZFKmbSEmbDElBpwJgC4k1KHCPWW2
         B+1iXji/PkL2aavGlKTyNZd8yLzordol90wmGaE/P0Hcsn3/jfWC5beh4Vl0IgeNxQeN
         GCgnGpsIDjvrCslI/HF5EBobR3zt7j/MpqJZTH7tfNsCtgwJX0EYWIHC2RUDlpRYP/s1
         wo8cKKku49yIs/J9/5Yitw86NmmUiavwHGM6JgFn+z9rNfGoRK/4huTHs2k1jYkyFYbo
         U6IKaQDTDhBIRswQDSn8+ZXS93PBr+fxNLB0SspTLVTlruyY2IAFAzg4K81/07PPEvck
         kvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=1wtvNcOdkbKIyNXdwFNs06IFmsjU6gWbejdXvtZbfgs=;
        b=qiPC29bUu1O4J9s6bgp5xwLIVP3sVyA3ljAHmuXCYNTE0zV/ymwVMZ67Wg/mDS/oVp
         PsuIEt0/m05t8TqPS6SaIGvwbwfEKfpOrQ1zr6e68LKUrU1CrK4HrEvO8zJPMWvXPmRO
         iCiFNdsnEpSksTim86wdsR3Tcd8syU+UQL8MHosVKWGbIGkTcovbPbYF6cqwyJiMcLkR
         0xjD6/4ZyDkn0pmYbuZ9/gFvvWyEZPI/EwoBEMv2/IwzE31dnD0QsuiyzymclXPqAhe9
         i7Bg1ZUMsIB2+x6ljJ7WIohigAxnwm8YApH+VvLJSNgPrXll9VyCUch54lpxH3XtB1Tg
         Z6ZQ==
X-Gm-Message-State: AOAM5331ZCSSf4VwsnUrR5ylpso8wcT/eBG88JIwCX75hfPsQMO6P7sx
        DqanGXyl4MT97iyljQjXG94=
X-Google-Smtp-Source: ABdhPJzFnXKUAFn/kChcD4UaKYPmAqPgLJb7FmFJSAxtuVX8JsA6C7iCgJ3Z5dWk+55zp/UjDHKlYg==
X-Received: by 2002:ad4:5bac:: with SMTP id 12mr27871888qvq.63.1639158938893;
        Fri, 10 Dec 2021 09:55:38 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i16sm2465161qtx.57.2021.12.10.09.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 09:55:38 -0800 (PST)
Date:   Fri, 10 Dec 2021 14:55:32 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Clark <james.clark@arm.com>
CC:     Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_perf_cs-etm=3A_Remove_dup?= =?US-ASCII?Q?licate_and_incorrect_aux_size_checks?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20211210165436.GA1236662@p14s>
References: <20211208115435.610101-1-james.clark@arm.com> <20211208131753.GC273781@leoy-ThinkPad-X240s> <269d2f14-0594-c73e-97b5-82e72f76e826@arm.com> <20211209134413.GA622826@leoy-ThinkPad-X240s> <6a7fd600-91f3-5feb-d21f-ec7cb704f84c@arm.com> <20211210165436.GA1236662@p14s>
Message-ID: <B3677362-D2A0-4341-A6C1-53E50A3B8C49@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On December 10, 2021 1:54:36 PM GMT-03:00, Mathieu Poirier <mathieu=2Epoir=
ier@linaro=2Eorg> wrote:
>On Thu, Dec 09, 2021 at 02:16:43PM +0000, James Clark wrote:
>>=20
>>=20
>> On 09/12/2021 13:44, Leo Yan wrote:
>> > On Wed, Dec 08, 2021 at 02:08:04PM +0000, James Clark wrote:
>> >> On 08/12/2021 13:17, Leo Yan wrote:
>> >>> Hi James,
>> >>>
>> >>> On Wed, Dec 08, 2021 at 11:54:35AM +0000, James Clark wrote:
>> >>>> There are two checks, one is for size when running without admin, =
but
>> >>>> this one is covered by the driver and reported on in more detail h=
ere
>> >>>> (builtin-record=2Ec):
>> >>>>
>> >>>>   pr_err("Permission error mapping pages=2E\n"
>> >>>>          "Consider increasing "
>> >>>>          "/proc/sys/kernel/perf_event_mlock_kb,\n"
>> >>>>          "or try again with a smaller value of -m/--mmap_pages=2E\=
n"
>> >>>>          "(current value: %u,%u)\n",
>> >>>
>> >>> I looked into the kernel code and found:
>> >>>
>> >>>   sysctl_perf_event_mlock =3D 512 + (PAGE_SIZE / 1024);  // 512KB +=
 1 page
>> >>>
>> >>> If the system have multiple cores, let's say 8 cores, then kernel e=
ven
>> >>> can relax the limitaion with:
>> >>>
>> >>>   user_lock_limit *=3D num_online_cpus();
>> >>>
>> >>> So means the memory lock limitation is:
>> >>>
>> >>>   (512KB + 1 page) * 8 =3D 4MB + 8 pages=2E
>> >>>
>> >>> Seems to me, it's much relax than the user space's limitaion 128KB=
=2E
>> >>> And let's imagine for Arm server, the permitted buffer size can be =
a
>> >>> huge value (e=2Eg=2E for a system with 128 cores)=2E
>> >>>
>> >>> Could you confirm if this is right?
>> >>
>> >> Yes that seems to be the case=2E And the commit message for that add=
ition
>> >> states the reasoning:
>> >>
>> >>   perf_counter: Increase mmap limit
>> >>  =20
>> >>   In a default 'perf top' run the tool will create a counter for
>> >>   each online CPU=2E With enough CPUs this will eventually exhaust
>> >>   the default limit=2E
>> >>
>> >>   So scale it up with the number of online CPUs=2E
>> >>
>> >> To me that makes sense=2E Normally the memory installed also scales =
with the
>> >> number of cores=2E
>> >>
>> >> Are you saying that we should look into modifying that scaling facto=
r in
>> >> perf_mmap()? Or that we should still add something to userspace for
>> >> coresight to limit user supplied buffer sizes?
>> >=20
>> > I don't think we should modify the scaling factor in perf_mmap(), the
>> > logic is not only used by AUX buffer, it's shared by normal event
>> > ring buffer=2E
>> >=20
>> >> I think it makes sense to allow the user to specify any value that w=
ill work,
>> >> it's up to them=2E
>> >=20
>> > Understand, I verified this patch with below steps:
>> >=20
>> > root@debian:~# echo 0 > /proc/sys/kernel/perf_event_paranoid
>> >=20
>> > leoy@debian:~$ perf record -e cs_etm// -m 4M,8M -o perf_test=2Edata -=
- sleep 1
>> > Permission error mapping pages=2E
>> > Consider increasing /proc/sys/kernel/perf_event_mlock_kb,
>> > or try again with a smaller value of -m/--mmap_pages=2E
>> > (current value: 1024,2048)
>> >=20
>> > leoy@debian:~$ perf record -e cs_etm// -m 4M,4M -o perf_test=2Edata -=
- sleep 1
>> > Couldn't synthesize bpf events=2E
>> > [ perf record: Woken up 1 times to write data ]
>> > [ perf record: Captured and wrote 0=2E607 MB perf_test=2Edata ]
>> >=20
>> > So this patch looks good for me:
>> >=20
>> > Reviewed-by: Leo Yan <leo=2Eyan@linaro=2Eorg>
>> >=20
>> Thanks Leo!
>
>Arnaldo is not on the recipient list and as such he won't see this patch=
=2E=2E=2E
>

I saw it now, can I take this as an acked-by: Matthieu too?

- Arnaldo
