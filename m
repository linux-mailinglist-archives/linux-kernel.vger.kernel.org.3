Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143F149B443
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384098AbiAYMqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453176AbiAYMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:42:47 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:42:29 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so2425463oos.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=PR6uwgDgL7aChE501knvgOsvQhUSV8GT+c6/3WqDTls=;
        b=nEcDwqikpSLn+ljJFPPhKo9EGtJYfxAUheWug68vPrtfCrIM+nZIdSfeEWYoMJvdiM
         nqhebEsJCoMBqiBfK14DOXM1OugAP3nX2FT+qcr7AvsSgNaRjZyJ3bfZ5uRa6cyxUfWH
         eDZrwvQrnDQjssuv98D6z8iAOhuF2PYhFNXVCBFZxCUggW8tEb7oo8JwuHLLskPkRflR
         NJG1lr68guCOpMGIzvgj/ZrF4OQCLQahunWMcfckBjrd7IEATn67z9yJtkoZL3FXRy8g
         OFm/m0WvuSXLCV76gTYHctRxTq5QlY172VBUh4CfNcUmSSV7xw0lkIdbFmuTKX06oUVS
         RNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=PR6uwgDgL7aChE501knvgOsvQhUSV8GT+c6/3WqDTls=;
        b=e2M2NXcIogCiz9BpovjohXVXAEFahrOTzLxbZ1Q+ripYzt/6H2eI/6EVRko2nXZDcv
         Ys7n9KV1yKE1cB30j+ybBAL+28WNAIif29pICTCzUI22/QY+NiiAqSCgpTkOcndMo6HL
         lr1+6DPnnlkl91LnQW6nqyRIAFhi5ua0l+Ma1p1DpyVAabzqtVf/iOBywsTUKeLsZ78g
         iZ2DbU/K3462HXBRWeTqdfHVJUm7JkKvMelOLYQadUmzuT3cHyiw8WTu/RV5WGdL/7cU
         5Gi9bGVdBNzsYjKO0+KqFyFF+b0hVDiV3Qy5ML+qpgKBdLimUhwpOrZ11/U+PZBxEyZO
         T0EA==
X-Gm-Message-State: AOAM531wcogj6kGbcYNpL4UyiLj9TgiMtDBqsttIkFFs6ZFIcXkIUEPZ
        FnTaN3nNnyWl4I41tjg1WRizuRtHz1U=
X-Google-Smtp-Source: ABdhPJzD1t3ysYnPgFeUAVR9XgJU9cxf441ONHzMhSwNWg3McCBkbNlhkdVAUPluS7ZUzNHBH+/zpA==
X-Received: by 2002:a4a:c593:: with SMTP id x19mr13206268oop.52.1643114549052;
        Tue, 25 Jan 2022 04:42:29 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c26sm5851110oov.22.2022.01.25.04.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 04:42:28 -0800 (PST)
Date:   Tue, 25 Jan 2022 09:41:49 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "irogers@google.com" <irogers@google.com>
Subject: Re: [PATCHv3 0/4] perf tools: Add support for user defined metric
User-Agent: K-9 Mail for Android
In-Reply-To: <2e2da73a-7085-b488-4764-705adbff70cc@huawei.com>
References: <20200511205307.3107775-1-jolsa@kernel.org> <2e2da73a-7085-b488-4764-705adbff70cc@huawei.com>
Message-ID: <0DF6E63D-C359-4D81-8F87-A64D30D75BCA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On January 25, 2022 9:34:19 AM GMT-03:00, John Garry <john=2Egarry@huawei=
=2Ecom> wrote:
>On 11/05/2020 21:53, Jiri Olsa wrote:
>
>+
>
>Hi jirka,
>
>Did you a plan to continue to work? I don't think that this support was=
=20
>ever merged=2E
>
>We have a requirement to be able to tune parameters of metrics, and=20
>support here seems suitable=2E

John,=20


Have you tried to apply that series to see if it still applies?

- Arnaldo

>
>Thanks,
>John
>
>> hi,
>> Joe asked for possibility to add user defined metrics=2E Given that
>> we already have metrics support, I added --metrics-file option that
>> allows to specify custom metrics=2E
>>=20
>>    $ cat metrics
>>    # IPC
>>    mine1 =3D instructions / cycles;
>>    /* DECODED_ICACHE_UOPS% */
>>    mine2 =3D 100 * (idq=2Edsb_uops / \ (idq=2Ems_uops + idq=2Emite_uops=
 + idq=2Edsb_uops + lsd=2Euops));
>>=20
>>    $ sudo perf stat --metrics-file =2E/metrics -M mine1,mine2 --metric-=
only -a -I 1000
>>    #           time       insn per cycle                mine1          =
      mine2
>>         1=2E000536263                0=2E71                   0=2E7    =
             41=2E4
>>         2=2E002069025                0=2E31                   0=2E3    =
             14=2E1
>>         3=2E003427684                0=2E27                   0=2E3    =
             14=2E8
>>         4=2E004807132                0=2E25                   0=2E2    =
             12=2E1
>>    =2E=2E=2E
>>=20
>> v3 changes:
>>    - added doc for metrics file in perf stat man page
>>    - reporting error line number now
>>    - changed '#' style comment to C way with '//'
>>=20
>> v2 changes:
>>    - add new --metrics-file option
>>    - rebased on current perf/core expression bison/flex enhancements
>>=20
>> Also available in:
>>    git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/jolsa/perf=2Egit
>>    perf/metric
>>=20
>> thanks,
>> jirka
>>=20
>>=20
>> ---
>> Jiri Olsa (4):
>>        perf expr: Add parsing support for multiple expressions
>>        perf expr: Allow comments in custom metric file
>>        perf stat: Add --metrics-file option
>>        perf expr: Report line number with error
>>=20
>>   tools/perf/Documentation/perf-stat=2Etxt | 77 +++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tools/perf/builtin-stat=2Ec              |  7 +++++--
>>   tools/perf/tests/expr=2Ec                | 18 ++++++++++++++++++
>>   tools/perf/util/expr=2Ec                 |  6 ++++++
>>   tools/perf/util/expr=2Eh                 | 21 +++++++++++++++++++--
>>   tools/perf/util/expr=2El                 | 34 +++++++++++++++++++++++=
+++++++++++
>>   tools/perf/util/expr=2Ey                 | 21 +++++++++++++++++----
>>   tools/perf/util/metricgroup=2Ec          | 70 +++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++-------
>>   tools/perf/util/metricgroup=2Eh          |  3 ++-
>>   tools/perf/util/stat=2Eh                 |  1 +
>>   10 files changed, 242 insertions(+), 16 deletions(-)
>>=20
>> =2E
>>=20
>
