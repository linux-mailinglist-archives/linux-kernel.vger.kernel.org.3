Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED85A9FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiIATWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIATWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:22:14 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C3479A43;
        Thu,  1 Sep 2022 12:22:13 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11e9a7135easo31542508fac.6;
        Thu, 01 Sep 2022 12:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=Y89vYbEAxsWb+1ZDJFWg2uUHgxtCG9Q3KJcrNvnBlRg=;
        b=OqbBdudWOlJKDdyXqfRI4Y7jYKdkKRVJCgsrikzySwNjU2q3iLXKxLeMmkA0AiVw6G
         q1T0qJ9Q0OUtBYTS/R4BDpJbO+gfVmhvDZl7LF91WLt3soROJpHmZeEtDmPgq82Ukzdj
         KL2avHXoz5TtvFkwDKAIaoYud7xAiAfBI3Hi9MW3ZxzGFY/sRzDadOKrJ/l5+1de0v4p
         nbSlV7rCSiBJ/pL4rZD4MT+GpvJZCWaqoaskpJ5CB6BwqY1x/fhrMR1ehPxKdUWlX4oH
         PBpPrnSmJAvPg61GnkgAHEPWNC4i5KZZj62qoMjvwYLFutig8gYfkW2rm3t8vb3ENQn2
         hDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Y89vYbEAxsWb+1ZDJFWg2uUHgxtCG9Q3KJcrNvnBlRg=;
        b=4pzcU7iksUkYDpYQTtePWiamrVLnpBZ0a3dhT565MN36fp5mhprONXDoWBQ4mixLgL
         J2TKeGhgNFTuRh5SOGiJ0K0yjSQSG4vdbVVsMGLrTEETLx1J0zDR0CqqMeZcOdcfUAn5
         reP8OKRkXnLLwBIgKXTDXXKR/Plvk03Vt+HBsE17kwfMkS9c36Khrr1zEhjzy/R4QKqf
         6i8sW7iGZvjaWlzlQsiIHA/MEKzMGNf0Np1WBgTp4hfl/YOtAYs6CfqN3ytHPDItzGvM
         NezzEcZ/AuoZ071u1lrD7bqn5k2Jji+Q+vKAyzpLhbCyiRqvGZCRFkoSadEPqniE8O+l
         cR7A==
X-Gm-Message-State: ACgBeo00DdJ4ORN7gsHhKts/oLTOw9TZr2BOnfJ4ObKxXbfdWgBqSyQI
        HG7PmzYYBabLWGmHhQVna7k=
X-Google-Smtp-Source: AA6agR7lTwZh0of2MhBqOumf9bQYjM9TxDQw1VW0UKJVxgrs5iHj/LvuIR0E66iTLGAt1LHrLB7L7Q==
X-Received: by 2002:a05:6808:3096:b0:342:ff93:4672 with SMTP id bl22-20020a056808309600b00342ff934672mr342473oib.174.1662060132274;
        Thu, 01 Sep 2022 12:22:12 -0700 (PDT)
Received: from [127.0.0.1] ([187.19.239.21])
        by smtp.gmail.com with ESMTPSA id cj12-20020a0568081b8c00b00342ded07a75sm43227oib.18.2022.09.01.12.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 12:22:11 -0700 (PDT)
Date:   Thu, 01 Sep 2022 16:22:06 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
CC:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_perf=3A_Ignore_format_attribut?= =?US-ASCII?Q?es_with_an_unknown_perf=5Fevent=5Fattr_field?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20220901184709.2179309-1-robh@kernel.org>
References: <20220901184709.2179309-1-robh@kernel.org>
Message-ID: <3361AE1E-778E-46F7-A51B-D143DF29FEAD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On September 1, 2022 3:47:10 PM GMT-03:00, Rob Herring <robh@kernel=2Eorg>=
 wrote:
>If the kernel exposes a new perf_event_attr field in a format attr, perf
>will return an error stating the specified PMU can't be found=2E For
>example, a format attr with 'config3:0-63' causes an error if config3 is
>unknown to perf=2E This causes a compatibility issue between a newer
>kernel and an older perf tool=2E
>
>The addition here makes any attr string up to the ':' ignored, but
>still checks the 'bits' portion=2E

So, can you please show what is the behavior of the tool, with an actual c=
ommand line and it's output, before and after your patch?

- Arnaldo

>
>Signed-off-by: Rob Herring <robh@kernel=2Eorg>
>---
>This is the YACC mud I threw and seems to stick=2E Maybe there's a better=
=20
>way to handle this=2E It doesn't seem like there's a way to do wildcards=
=20
>(i=2Ee=2E config=2E*) in YACC=2E
>
>This is needed for this series[1]=2E Unfortunately the best we do to avoi=
d=20
>the issue is applying this to stable=2E I think there's some time before=
=20
>v8=2E7 h/w is deployed, too=2E
>
>Rob
>
>[1] https://lore=2Ekernel=2Eorg/all/20220825-arm-spe-v8-7-v1-0-c75b8d92e6=
92@kernel=2Eorg/
>
> tools/perf/util/pmu=2Ey | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/tools/perf/util/pmu=2Ey b/tools/perf/util/pmu=2Ey
>index bfd7e8509869=2E=2E3096864ec9b9 100644
>--- a/tools/perf/util/pmu=2Ey
>+++ b/tools/perf/util/pmu=2Ey
>@@ -60,6 +60,9 @@ PP_CONFIG2 ':' bits
> 				      PERF_PMU_FORMAT_VALUE_CONFIG2,
> 				      $3));
> }
>+|
>+error ':' bits
>+{}
>=20
> bits:
> bits ',' bit_term
