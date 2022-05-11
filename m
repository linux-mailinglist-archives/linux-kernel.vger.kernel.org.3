Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B05523BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345742AbiEKRma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiEKRm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:42:27 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BE521A957;
        Wed, 11 May 2022 10:42:26 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2f7c57ee6feso30056367b3.2;
        Wed, 11 May 2022 10:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqQEfmUOxEoKhZuqO9SUs7ykPGMa11we1uD8EpZuUrM=;
        b=oRJbhv44scWvji3LPDirPqzaKf3er+x/UgzeEbjFNHeELDLy9o8Jh+Wv504YiLliRN
         oBQ7061lxR3tiMN0Y2zAJ/byB85xq0X90/Ok7G+LoXRIwQL4HuIhe+2FvgMn8JJVzNRo
         6nccu85cPM0nlI0v0tDawFVARc3C0B3MgzuDeM8Q7yJHMjB//5KGZSSQK5ANgPV4H4Or
         BfjJQHv9mUXcZMuZoKNBU9HjGOI02V3cI0hHAfRaHqSfay2a8sWN13C5X0guFS0W/xLM
         K+gRzYM5o6H4ZY85ORaiKgW7KTJN2tBYIxAQ8IURR20PHqj7FFYpRe2qRZHV4hCygQR6
         R6Fw==
X-Gm-Message-State: AOAM533gNNmu8Qr4JZHFcJzNp3+4WXSX6SFoAAT+ABfb2+LLIY5JpIpc
        dgmktp4Ci8v1zsapuLM2n8DEtQkPFbaWu4DiASkkPT4A
X-Google-Smtp-Source: ABdhPJxNK5W1RzVC6npP/iYVW+ODznFZpQ04sFEN216pHzVWk+PZuzwiPqhNzZ9GhECrAl/pfnmc/p4R/72BCOhC+cQ=
X-Received: by 2002:a0d:edc7:0:b0:2f8:f300:df2b with SMTP id
 w190-20020a0dedc7000000b002f8f300df2bmr26313215ywe.515.1652290946149; Wed, 11
 May 2022 10:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220506135009.22246-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20220506135009.22246-1-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 19:42:15 +0200
Message-ID: <CAJZ5v0hmQAobWte1-zeVS8_e8Dw2uL9eHat875d9UzuHYdmAgQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/thermal/intel: Add TCC cooling support for
 RaptorLake platform
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 3:52 PM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Add TCC cooling support for the RaptorLake platform
>
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/thermal/intel/intel_tcc_cooling.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
> index cd80c7db4073..a9596e7562ea 100644
> --- a/drivers/thermal/intel/intel_tcc_cooling.c
> +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> @@ -81,6 +81,7 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
>         X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
>         {}
>  };
>
> --

Applied as 5.19 material with some edits in the subject and a new changelog.

Thanks!
