Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D8C57B051
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 07:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiGTF22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 01:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiGTF21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 01:28:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD0C6B241
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:28:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f24-20020a1cc918000000b003a30178c022so607903wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 22:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6GpOS7yPPdpiDanEtmqcioSPAAQoL6+VbYEZbAErRGw=;
        b=HTMTnak9BAylaPkRkwboisWFAMLEJREglplPi7vQMxA/yTltlqg6OG0PI5twEWUaLx
         BmRYE4m7kr7XBbLDfjpyWr08nchTxtgxrCIYn9YQA7aW7kQz/pbdJsLfNFP9KLQhx/ao
         SvMpduG5XRtnV7lgUnautJd7f24QiEReno2ziVvDMOXzHBvL0BRPfNy5oDl46Mkzc4FM
         fVl9ZsPXiKyGShwX9mvj+YXKLQZ/mF+VUz26rnuZEaRMwNrOMc/KH8LG3yXjjhkw6w/n
         4RU6C+mF+2rQSPv9F0QMVmhjIXETADl/8V/FKoA0tEMzAMfGujnEruOq5OVxqDrhVG3u
         M7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GpOS7yPPdpiDanEtmqcioSPAAQoL6+VbYEZbAErRGw=;
        b=LULkE4aByx+jYTcw5gvDx9FwoEmSAsJynrNJyWMv6aUy/TsmK2Cmvxs1kG6ssu/I4Z
         L30JNhko7I4EyvUaDZYr+6aBwi/VSOvP6yBzXcLyVJIDwD8CHq0LvdQJTJ34IBON0B0j
         Zjjx4bzDlsJAe8Ozj2pKdFoVMoyPA8TWwYGnvkW11kOALVFC7EATgvLsv+dbPlAdEqMm
         IqPv72ksCwAS67ufXT02A2/UiLBULyn9z2VPicoaK1of7W6KOCPIvoMxkyvyLJY4bfL1
         UbA58tvcTmd6oE548e38M8/oQcRTTmbQ2Dl9QWfYbbWkB5BwmNmKC7KrC4wPJIMG0QCj
         z8Jw==
X-Gm-Message-State: AJIora9kOjuOlfsKnRYccN+ymMaTKuYGNjS2Dzk+aMURu7MTXHO/INaQ
        nhByVJ9W2HUo11Nea+mi0d0ZHSFGT4HD24icckuUqQ==
X-Google-Smtp-Source: AGRyM1vmmvElpZMAthmJWCPddBgXaw+xZdf1HZXC7ASOs4UA0bgYcqbL+gkOphuecqdp8p/4p8X1WEqoTGKA7wzANJM=
X-Received: by 2002:a05:600c:2854:b0:3a3:1551:d7d with SMTP id
 r20-20020a05600c285400b003a315510d7dmr2034551wmb.174.1658294900628; Tue, 19
 Jul 2022 22:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220711093218.10967-1-adrian.hunter@intel.com> <20220711093218.10967-35-adrian.hunter@intel.com>
In-Reply-To: <20220711093218.10967-35-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 19 Jul 2022 22:28:08 -0700
Message-ID: <CAP-5=fWYA_dX3PMH7wpvYyJY=dgjnJEAopqJazkDaOyRg0cBug@mail.gmail.com>
Subject: Re: [PATCH 34/35] perf intel-pt: Use guest pid/tid etc in guest samples
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 2:34 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> When decoding with guest sideband information, for VMX non-root (NR)
> i.e. guest events, replace the host (hypervisor) pid/tid with guest values,
> and provide also the new machine_pid and vcpu values.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/intel-pt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 143a096b567b..d5e9fc8106dd 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1657,6 +1657,17 @@ static void intel_pt_prep_a_sample(struct intel_pt_queue *ptq,
>
>         sample->pid = ptq->pid;
>         sample->tid = ptq->tid;
> +
> +       if (ptq->pt->have_guest_sideband) {
> +               if ((ptq->state->from_ip && ptq->state->from_nr) ||
> +                   (ptq->state->to_ip && ptq->state->to_nr)) {
> +                       sample->pid = ptq->guest_pid;
> +                       sample->tid = ptq->guest_tid;
> +                       sample->machine_pid = ptq->guest_machine_pid;
> +                       sample->vcpu = ptq->vcpu;
> +               }
> +       }
> +
>         sample->cpu = ptq->cpu;
>         sample->insn_len = ptq->insn_len;
>         memcpy(sample->insn, ptq->insn, INTEL_PT_INSN_BUF_SZ);
> --
> 2.25.1
>
