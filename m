Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7978B5808DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 03:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiGZBFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 21:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiGZBFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 21:05:05 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F7727CF9;
        Mon, 25 Jul 2022 18:05:03 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w204so15469458oie.7;
        Mon, 25 Jul 2022 18:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=5fDiK95WVSGHAQWg0sKq28MpBdhlxA9jjHAwB8K8aHs=;
        b=arsMmeYdNZ2EJuqA0306HWyT5FUDjWgPLQDS/licYhmLdwh0bnRgVYQ+PznMji9+iP
         7EeyQXc5juYYShrM+8UcwOHSSC6cdXlKeGSXRVRGqTbUhB6gfFfAoC/2xoJZ/jgnQ2jg
         lI5Y4mYE5N3JdSjB/RMtrae+rgqbM6/VxhjTOwXi/rUIxa9BoUj3Q/r8Vy3oycadF4Qp
         sA3GOU6ANu9lwsREabxWNtQCIGRlnOlCz6Xsmx8LblujwlCsUuYXSG+996Nf+EpInC4A
         FVWygwrtVu+a4Nb23kFZZXchv7jIUftceWkOcgkNlT9mm4uOoowlmGnwdo5Sdarza2Tw
         Lnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=5fDiK95WVSGHAQWg0sKq28MpBdhlxA9jjHAwB8K8aHs=;
        b=MqTWHqVRHHxJQ054CTbfwcodMTnfJviAXObQcS9q+A1B/pbJnFUkiTUhKKBrpPH0cr
         qy2lejgMPdwq7pqDMjhSORZNTXegKz13BoNTn+1KO10ztLLbCKxjNez2QoNdDLHfn2LC
         kJHps84nwLPZ5D6pX4F3YS2115u71ERDSmFT/Cj7MVYTVqS4GQ73A3cRzeVWbNbhAEIS
         grCnzvfPLq9x+h9/qgn9Go2NTUipXWDeDXKgkfmFjJS5uleooWjhZ5GdOmYHRAWpS6MI
         9J6GaZMiAtpwJ4r/Bw5C6HC8bLdZB4PL4xjRZTpiVloiz8EMdDfsEEKwhG0+tn6DTIoB
         zEyQ==
X-Gm-Message-State: AJIora8EsMw8C+f0FbaJaNeJ6U+/p3kdyb17KkKxiuQ9bJvLibU1bkdJ
        dH7PPxt0jViTX90zTxnRC8c=
X-Google-Smtp-Source: AGRyM1tm8WijvSEGL2/qcESBzvVuU7D87TC4LmpQJXPFgI57bmM9yMWoQG5Z72GJkuFJOIJ90pQu6Q==
X-Received: by 2002:a05:6808:1885:b0:33a:74ac:8b79 with SMTP id bi5-20020a056808188500b0033a74ac8b79mr14481157oib.237.1658797502755;
        Mon, 25 Jul 2022 18:05:02 -0700 (PDT)
Received: from [127.0.0.1] ([187.19.239.32])
        by smtp.gmail.com with ESMTPSA id l6-20020a05687040c600b0010c5005d427sm6826125oal.33.2022.07.25.18.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 18:05:02 -0700 (PDT)
Date:   Mon, 25 Jul 2022 22:04:58 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf symbol: Correct address for bss symbols
User-Agent: K-9 Mail for Android
In-Reply-To: <20220726005307.GA36862@leoy-ThinkPad-X240s>
References: <20220724060013.171050-1-leo.yan@linaro.org> <20220724060013.171050-2-leo.yan@linaro.org> <Yt7hGepLBAJJuvII@kernel.org> <20220726005307.GA36862@leoy-ThinkPad-X240s>
Message-ID: <2A971E59-21F0-4DD2-9E62-F1E7F481C8AF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 25, 2022 9:53:07 PM GMT-03:00, Leo Yan <leo=2Eyan@linaro=2Eorg> wr=
ote:
>Hi Arnaldo,
>
>On Mon, Jul 25, 2022 at 03:29:45PM -0300, Arnaldo Carvalho de Melo wrote:
>
>[=2E=2E=2E]
>
>> > First we used 'perf mem record' to run the test program and then used
>> > 'perf --debug verbose=3D4 mem report' to observe what's the symbol in=
fo
>> > for 'buf1' and 'buf2' structures=2E
>> >=20
>> >   # =2E/perf mem record -e ldlat-loads,ldlat-stores -- false_sharing=
=2Eexe 8
>>=20
>> Can you share the source code for your false sharing proggie? We need t=
o
>> have something in 'perf test' exercising these routines :-)
>
>Sure, I am using the false sharing test case:
>https://github=2Ecom/joemario/perf-c2c-usage-files/blob/master/false_shar=
ing_example=2Ec
>
>=2E=2E=2E with build command:
>
>$ gcc -g false_sharing_example=2Ec -pthread -lnuma -o false_sharing=2Eexe
>
>Do want me to proceed for adding test case?=20

Yes, go ahead, that will be really nice of you to add it :)

- Arnaldo=20

> Otherwise, it's fine if
>you will work on the enabling test case :)
>
>Thanks,
>Leo
