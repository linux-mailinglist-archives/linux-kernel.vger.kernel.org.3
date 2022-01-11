Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D1048B61A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350171AbiAKSuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbiAKSuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:50:14 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0043C06173F;
        Tue, 11 Jan 2022 10:50:13 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id h16so5116225qkp.3;
        Tue, 11 Jan 2022 10:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=sn1JhLv3sDVH++En/Gju5fSNPX0ZThDoZa5taxT8mwI=;
        b=aFDLA7ZikNOdyM5etGJRLIGzNBvGGz0Avjc4eXknutMEBm4Fd1GQS5wRhmo8lvPHbv
         hClCKpCq2nic1AYYQ3/mD6iwCnAdd4ikIh3QGfh6Rw2mR8t92wo9TDdb9mIUjCNtE+20
         3yyWgJZqP+eHOCrzcRFXE1oa+CGmmY+vrVzykgOJXxbxURVVw1lmxHqrc0SJ26Q8EXXn
         6E/C4DhhvlXsP76zCr5VFV4LM9S6gf5j4baHILCn+jLddCtVmfYuYoYLn/tmzIzK9ApM
         ViAmTp3wtUZZVPQW2iRFPgt5n7q9iImNlo0mVY/X5YT6/JMNVASWFWT950WE3wjf4UPV
         Q4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=sn1JhLv3sDVH++En/Gju5fSNPX0ZThDoZa5taxT8mwI=;
        b=dNdx7TbVz3LLoU9EYVHH3Ms91rUJmtQTVvEHyEceemL9DI3ousjPOqMJfOYODRArS3
         Myu6w4Is8LOhEISPf5iGuB4ovVqfELfUegJrL1xi4CNhSoz5s+dsGQUhfWzy2VB/Eqy6
         J+ul7ZHcC8nvbH9N4pniGZNHuhKXFu/fRLXkArXvBiXPo3yCGrpEZ1+fBBlSSsZjYRhk
         IT68JLLAXugwBZvcAKU8MG2lmh3VapLs6+IUmaXnDe/AtvF9pI3VZL9nQGXqtOt3I7Ex
         ardO1DbBO6uATcCXLZlxjY+BL2IJG34kkFFCRpliN0ohDJSgL3p35ysO196r2imfz3qW
         QhRQ==
X-Gm-Message-State: AOAM533tphFSBcd3MkHO+EHA2x/vG8wtqSnIvjq2ZU8D60ju37yUbbPN
        pr+wCLbFQZ8TsKtNMjU0pXI=
X-Google-Smtp-Source: ABdhPJxPRkUsnWDgCU4mYdWe9q2fhtXRVpsE2D+P2U2u+w6agRumNP9dRPTAlJ/9ihuJb/p1QWb3Jg==
X-Received: by 2002:a05:620a:2699:: with SMTP id c25mr3955731qkp.473.1641927013032;
        Tue, 11 Jan 2022 10:50:13 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id q7sm7045559qkl.72.2022.01.11.10.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 10:50:12 -0800 (PST)
Date:   Tue, 11 Jan 2022 15:50:07 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Ian Rogers <irogers@google.com>, John Garry <john.garry@huawei.com>
CC:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
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
Subject: Re: [PATCH v4 05/48] perf stat: Switch to cpu version of cpu_map__get
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP-5=fW2JzePV=rQG=Ww1Omub0_r2gi38FUVyaG+a3L=44R9XA@mail.gmail.com>
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-6-irogers@google.com> <64d64526-7d3e-0c31-f43e-f03810f72ac2@huawei.com> <CAP-5=fW2JzePV=rQG=Ww1Omub0_r2gi38FUVyaG+a3L=44R9XA@mail.gmail.com>
Message-ID: <F6E1C874-F64D-4563-915B-F6420F987264@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On January 11, 2022 3:46:41 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom=
> wrote:
>On Mon, Jan 10, 2022 at 11:04 AM John Garry <john=2Egarry@huawei=2Ecom> w=
rote:
>>
>> On 05/01/2022 06:13, Ian Rogers wrote:
>> > Avoid bugs where the wrong index is passed with the cpu_map=2E
>>
>> nit: Don't you mean possible bugs?
>
>You are right=2E I'll watch myself doing this in the future=2E

I'll update the comment,

I'm still testing it and giving more time for review, including to the adj=
ustments I made=2E=2E

- Arnaldo

>
>Thanks,
>Ian
>
>> >
>> > Reviewed-by: James Clark <james=2Eclark@arm=2Ecom>
>> > Signed-off-by: Ian Rogers <irogers@google=2Ecom>
