Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3501E5AA860
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiIBGxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiIBGxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:53:09 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675FAA345;
        Thu,  1 Sep 2022 23:53:08 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so844080oth.10;
        Thu, 01 Sep 2022 23:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kljxdECqJZOyxDQ4X50tiBQvLj6Z7Laiz45KlKlPDwQ=;
        b=l65GnPEmcapIn3yiJbFuiMxY9PWnTdMsMHmzhh2oNl87iws/HeS4+hJRv008kx2OEt
         N9gorSrf7eWLp7GjZphzz0I++jc9cOEmF/+dnJWqSYTr+chEmHy1nuhWFu4mfRGObyIt
         hxRlCUxm4iqLJSHiYcQdpz2FlkP2aaAwm6ezX9hrGG5ZX+CbGifoVd9H0JsOgSkSVakN
         enn8AS4B4ffxHxsobpokpqFlCvzyG2Ifce3h+/sRbkhLCHoFqv3IrHc7zZET8CNWoxso
         9lERHM1Ld5kJCizw02pGXPmg34iypFoX/tCb7W6+KcAY5erR9KqRK/RL02x9ZU5zxyca
         OckA==
X-Gm-Message-State: ACgBeo38ympLDTx8f2/VFJAAb7UaN3pPGjHzWKZIORRrq1LVLMHx7cpf
        t2R336YX3vNsJ1NCK/omTx7M3qno0gMSivm8+p4=
X-Google-Smtp-Source: AA6agR7g4fE4+zjF6i7bVAuoDrD/9iAOk6+5sznzlRtEp2vResweR9Tp4Gy6BghWD7ig/WCzk0IXUv8+O5774F2ZxmM=
X-Received: by 2002:a9d:6a59:0:b0:638:92fd:d5b4 with SMTP id
 h25-20020a9d6a59000000b0063892fdd5b4mr14306119otn.247.1662101587717; Thu, 01
 Sep 2022 23:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220901184709.2179309-1-robh@kernel.org>
In-Reply-To: <20220901184709.2179309-1-robh@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Sep 2022 23:52:56 -0700
Message-ID: <CAM9d7chY6T-EAN3BT487MUK0LbfGp27X+2Dd_+S0azgh2GQn9w@mail.gmail.com>
Subject: Re: [PATCH] perf: Ignore format attributes with an unknown
 perf_event_attr field
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 1, 2022 at 11:55 AM Rob Herring <robh@kernel.org> wrote:
>
> If the kernel exposes a new perf_event_attr field in a format attr, perf
> will return an error stating the specified PMU can't be found. For
> example, a format attr with 'config3:0-63' causes an error if config3 is
> unknown to perf. This causes a compatibility issue between a newer
> kernel and an older perf tool.
>
> The addition here makes any attr string up to the ':' ignored, but
> still checks the 'bits' portion.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> This is the YACC mud I threw and seems to stick. Maybe there's a better
> way to handle this. It doesn't seem like there's a way to do wildcards
> (i.e. config.*) in YACC.
>
> This is needed for this series[1]. Unfortunately the best we do to avoid
> the issue is applying this to stable. I think there's some time before
> v8.7 h/w is deployed, too.

Maybe you could change the format_term rule to take an identifier instead
of PP_CONFIG* directly and pass it to perf_pmu__new_format().  Then
it could check the string and create an appropriate PERF_PMU_FORMAT_VALUE_*
or ignore it according to the PERF_ATTR_SIZE_VER*.

Thanks,
Namhyung


>
> Rob
>
> [1] https://lore.kernel.org/all/20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org/
>
>  tools/perf/util/pmu.y | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
> index bfd7e8509869..3096864ec9b9 100644
> --- a/tools/perf/util/pmu.y
> +++ b/tools/perf/util/pmu.y
> @@ -60,6 +60,9 @@ PP_CONFIG2 ':' bits
>                                       PERF_PMU_FORMAT_VALUE_CONFIG2,
>                                       $3));
>  }
> +|
> +error ':' bits
> +{}
>
>  bits:
>  bits ',' bit_term
> --
> 2.34.1
>
