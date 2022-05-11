Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF07523BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbiEKRtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245396AbiEKRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:49:29 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB540BA98F;
        Wed, 11 May 2022 10:49:28 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id g28so5395629ybj.10;
        Wed, 11 May 2022 10:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5fPU4fs9BSToWLR1ZqCw42NR43AIuIEECUpwT835Pk=;
        b=C0H0HxBYLd9i0W4u7sOfDmkaq4/ZpugxlC3TYvI0nPJJQSqtoIv8NP1cfpdDXT8ACZ
         qJxfPy+VFseaMAQdjTM/GotevrB6tT/crvrRQ9Jo27zX/YK8xyvlArwRuzdbvG43eajZ
         FSdxtA3DMQQ53M3SDxWDHZDBOUoNOi8ZiC4ztkrEl+SvLCSV9QYV9Wte0kmI0jxwS53Y
         ix8yDfoJfTey1xL9y7RuVU2mHhDJ4DC2mh1Gii+yBDdvQEr7S3e08tk/5j9kiy2+UZhI
         wxoBIve6V5XwdCibJutH7P9c0xlEbFwcnwezqtFRgpiFnvoXHfYTPAehaPpOHejtVDIu
         sGAw==
X-Gm-Message-State: AOAM531HM9MVyQbjjUiE6fKIcT7u/IBfzawABwjQBqAeKKM2VEg7V/6G
        MLK97extB1pnwLkNT/8nDMcU8GTAGb7xNWsXLWM=
X-Google-Smtp-Source: ABdhPJxrRSjt0K6vzdRozK5OFwRB+jwGDdcyBje+RT6+1YwjJ63FpvkWF4idndiG7SDla6HTH7R1QBd4J7Kva7AKwIY=
X-Received: by 2002:a25:3795:0:b0:648:fa25:5268 with SMTP id
 e143-20020a253795000000b00648fa255268mr26355395yba.153.1652291368104; Wed, 11
 May 2022 10:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220506135352.22427-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20220506135352.22427-1-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 19:49:17 +0200
Message-ID: <CAJZ5v0jbP0Qo+d0j7MAUcAJ4LCbipON9EhuiRPWXwHbQOGdSCQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: Add Power Limit4 support for RaptorLake SoC
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
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

On Fri, May 6, 2022 at 3:56 PM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Add Power Limit4 support for RaptorLake SoC.
>
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/powercap/intel_rapl_msr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
> index 1be45f36ab6c..9d23984d8931 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -140,6 +140,7 @@ static const struct x86_cpu_id pl4_support_ids[] = {
>         { X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
>         { X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE, X86_FEATURE_ANY },
>         { X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L, X86_FEATURE_ANY },
> +       { X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE, X86_FEATURE_ANY },
>         {}
>  };
>
> --

Applied with a new changelog as 5.19 material, thanks!
