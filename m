Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1E5533F35
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244848AbiEYO2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244658AbiEYO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:27:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B32F1209D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:27:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p10so11741140wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vJ1ZHRktroNtOl8H5m5yxZpwDkzeUzNeSS+Jn6yJC/E=;
        b=RDQviVNxwnDPtpi7oegoJoeczxVptCjhjqG3k7e2MVyRfnEPXQK1Yh1mUiyt6PZWOT
         D5kGdb6hYRbfoJVXaQstxQAn4TVO0B4oPNhT5dYC075z4MKUbkwAqLV0yqr71Xn16XQX
         igoPgt+UJjSW3+kK+cSA/cwXZauSDLvZzvLrQTCHp2bR8oG1WtTDjgC4ZMXM64P5Q75P
         tCKHM37n6SFwIm3i5s7e2NLzGbZXghMVU7vk+S/fXnvquPunmZUEFClnPbEBtKnHF4aH
         K7luMHASgIXULLWtjmwvJKmEZmtnQwrgskARoSUNu69cp3HYxDrpSj2e70W5lhfNRAnK
         vhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vJ1ZHRktroNtOl8H5m5yxZpwDkzeUzNeSS+Jn6yJC/E=;
        b=dRuExfg5mEMjkTpiB2IEXMmnbKUa/hyIDdwtuHBKuDJNHycDFRptmeartWGA5bM4HY
         9cfZkN0DT97RzEqEfxj5qTLP7YqMyAm44dkCTbkID8rKFAZ0GRgO1yWwt0FGaXBGAkgo
         XFtvEPkBycu7RwF/o2dIsodmiAMcepZAHAixiBtB2kQttYOyhw4b2Ret/FPMW9DAvmu1
         2WyaxxHdZC4dNXJX2K8PYhCHBH8uQbpIYPjaVE1LqcW5qepo4u5lhWUB6jaGL5p6IPVb
         EONkeVHOx8nHcRFNddM4Yef/G/zP/TRUph0m7Es66FtA5UGPpyFkGS5G69qEiIEHNaC5
         dFXA==
X-Gm-Message-State: AOAM533FoozTwnFZWrr/qZr6bfERqENnAhvQ4WNsFNhTx9OWom8Aeai4
        Nne1TVdGy0mtvW1I++pbShX4gLR9PiHpwDcWyPWdNg==
X-Google-Smtp-Source: ABdhPJwO71e56s9S6gZVeAgxZJG9PM+AF+DSN8b3zz0J1VjD/KFjwSYVgU2nlpO1Jp//jjlGO0e0mGWReG0/0XrUcdc=
X-Received: by 2002:a5d:448d:0:b0:20d:744:7663 with SMTP id
 j13-20020a5d448d000000b0020d07447663mr27630902wrq.654.1653488840849; Wed, 25
 May 2022 07:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220525140410.1706851-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220525140410.1706851-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 25 May 2022 07:27:08 -0700
Message-ID: <CAP-5=fUm4G043v6-pToBiT-psxt-_r4kxtsWwkjLh=ARmhmP_A@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Fix event syntax error caused by ExtSel
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 7:04 AM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> In the origin code, when "ExtSel" is 1, the eventcode will change to
> "eventcode |=3D 1 << 21=E2=80=9D. For event =E2=80=9CUNC_Q_RxL_CREDITS_CO=
NSUMED_VN0.DRS",
> its "ExtSel" is "1", its eventcode will change from 0x1E to 0x20001E,
> but in fact the eventcode should <=3D0x1FF, so this will cause the parse
> fail:
>
>   # perf stat -e "UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS" -a sleep 0.1
> event syntax error: '.._RxL_CREDITS_CONSUMED_VN0.DRS'
>                                   \___ value too big for format, maximum =
is 511
>
> On the perf kernel side, the kernel assumes the valid bits are continuous=
.
> It will adjust the 0x100 (bit 8 for perf tool) to bit 21 in HW.
>
> DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
>
> So the perf tool follows the kernel side and just set bit8 other than bit=
21.
>
> Fixes: fedb2b518239 ("perf jevents: Add support for parsing uncore json f=
iles")
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/jevents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jeve=
nts.c
> index cee61c4ed59e..e597e4bac90f 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -605,7 +605,7 @@ static int json_events(const char *fn,
>                         } else if (json_streq(map, field, "ExtSel")) {
>                                 char *code =3D NULL;
>                                 addfield(map, &code, "", "", val);
> -                               eventcode |=3D strtoul(code, NULL, 0) << =
21;
> +                               eventcode |=3D strtoul(code, NULL, 0) << =
8;
>                                 free(code);
>                         } else if (json_streq(map, field, "EventName")) {
>                                 addfield(map, &je.name, "", "", val);
> --
> 2.25.1
>
