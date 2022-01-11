Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9686648B60E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350115AbiAKSq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346390AbiAKSqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:46:54 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FB0C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:46:54 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h23so82060iol.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hbXHVCLNGmYtpg85HRQj1tStndWpfHPlukM67GllcY=;
        b=PT7z42l9TocW0rBRoMNHny1aXx9qnV4VC/bduNOMV1uM84VQGJVqnX5lcR9VagMYAw
         I0E2UyKIur6ocvM9WyuX0gxyhAhZRNlzWPACPY/+8wrxLGmThPCcZ03zBy0xT1YAg2Z5
         veYdBeqwntFzyIKqsHUOqeIl/wB16tM9Q4RDcfJJWqrRj3mnKqdPM1Q+fSThdO9l3pDZ
         CzTrfuHtm3A1TqePhus9QVI/k/CrVJJA/fuzYZLA5zol/6587EnlJChEMD/vBmxAvqoa
         TTI1dip4H9cQqXGKzj1fDb6omPu4ph2vjoKBblTFXtOgPU+8B7OotpsniRSBVUn855ax
         ttXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hbXHVCLNGmYtpg85HRQj1tStndWpfHPlukM67GllcY=;
        b=WnWGk+jzrOSFmTAtmRg2eiVVoL20DHuM/nBPCACfy2bDg6K9vIoOS6Ch0dqOPcOUR+
         UHfBjYndJHDDVrJwtBnD7CFBmf2bY+MCzC/8Ik1Zr3AvJDs8N7m9FqVLOFon8lEocfRj
         8Vw57asbLqLNrEgXk0v/xnPRxj5loy89wPZTURgbhcvzsHhRR1iE6BEz4fMU/OGJOjvF
         jQ7xN64nMNBmyHDaDu4NtT8LJZGl0aD/6fp2PLWYSmMfBKNsg7KeSyx8m/GVtLOC+sgj
         Br4UCmVMI///E8y0Nry8ll65ytOzUBwBN+Wub3w7cgqU+3kxPfR5EoilhJ2WF7iasNRT
         zyNw==
X-Gm-Message-State: AOAM532ut9UFSp2/WQoi9L9EVs2mD2zfr7xy7rf3qRSPz+hvMPcyZ2JN
        xvaLuUNCbpXow/SFDOpyTEmWngAt9ArlQnbXAeg6+A==
X-Google-Smtp-Source: ABdhPJyzFsWOVvDV15+T62OelOrluGd6cLRTECTNoFDVCLTUjNK3SFCT5CQrIA0zAG3J2JESN9VGPl3PW2msrBTB2xw=
X-Received: by 2002:a5d:944a:: with SMTP id x10mr2890515ior.18.1641926813572;
 Tue, 11 Jan 2022 10:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-6-irogers@google.com>
 <64d64526-7d3e-0c31-f43e-f03810f72ac2@huawei.com>
In-Reply-To: <64d64526-7d3e-0c31-f43e-f03810f72ac2@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 11 Jan 2022 10:46:41 -0800
Message-ID: <CAP-5=fW2JzePV=rQG=Ww1Omub0_r2gi38FUVyaG+a3L=44R9XA@mail.gmail.com>
Subject: Re: [PATCH v4 05/48] perf stat: Switch to cpu version of cpu_map__get
To:     John Garry <john.garry@huawei.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 11:04 AM John Garry <john.garry@huawei.com> wrote:
>
> On 05/01/2022 06:13, Ian Rogers wrote:
> > Avoid bugs where the wrong index is passed with the cpu_map.
>
> nit: Don't you mean possible bugs?

You are right. I'll watch myself doing this in the future.

Thanks,
Ian

> >
> > Reviewed-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
