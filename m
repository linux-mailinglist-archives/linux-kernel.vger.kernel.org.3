Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA495A9AF9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiIAOzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbiIAOzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:55:35 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2409137F95
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:55:31 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k17so9171810wmr.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc;
        bh=Qm7z+n9v24oP6zpPgqQul26KMHD50paO2Y9IVMFiRhQ=;
        b=dd+Zsnugr8tFEBhl38/jbIsJ0BodE3L0d6on+MXP5Gp/QC92iSbt90u+oraLzgx0iP
         chX8O52Z11VUfusvEYE06r25mQwVDyBw/hwgmJ8scDQb6qlWx8H6L1n+h/IgpHkisROE
         TvBY9xGjVEDYq8aipQJ54wC0EyalZ3OWVNYKeqQepIPeX1FT+0zLOIAokKToNo2u5qcq
         PT6NS8ANAUJ1QpZ3tSoBW+gIIU2QUUIOWzG1G56x+KDOddNrzJiyiqtnRqOVnfROLXph
         YkbuF6dazdnIRYZe6gjQhJX5hi3YiTYVDswYAlYr1KZsuR0QKzH505dJHQvZJPyTXjng
         fvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Qm7z+n9v24oP6zpPgqQul26KMHD50paO2Y9IVMFiRhQ=;
        b=yAqMEyTIyllRqA7HEgqFELRLbt+oScjmItEMLFq1DilH4rF5SM6dLgJTFpEgFglCDm
         8aPYVE3v4dsQ7+vqFwXyghQ0EAWGPztcPKFQIG6ShBruHjXZY7LaL5XT76o/NJHQzFzr
         gwd7r86Mc3D8ebRBd7Gwe+h09HgaQEqPrJxvb2SZaPdtOFq+/1IE3RnWob3BnP58kWOl
         cWyFt+wC/CPGwBISdVS+z7VPkowOkYCnIrL2SNzCRWMVxPuxAyoGrw9bAO6QfHNX39DW
         N6luEpkbEmwv4nrRLeybinWRdQNHwBRY3sMVxgEvm2s2jN9Y+EiRc6a/RVuhIqSqAtln
         Uf/A==
X-Gm-Message-State: ACgBeo1Gw63WwFw4AR6Dqv50pkuaEM2P/ZrQhj2d0KZmCg8l3+zJGhLg
        tdoDm04kNhNVTi6o8UoD3bF7fg==
X-Google-Smtp-Source: AA6agR44HpRoT6gpp2fWtRApwrHYPW65PMjZqe5oGuSrovokUtg4BrlR9Cjq87AC1M2f/BCYYIqWag==
X-Received: by 2002:a05:600c:35d0:b0:3a8:3f16:2c38 with SMTP id r16-20020a05600c35d000b003a83f162c38mr5695050wmq.162.1662044129389;
        Thu, 01 Sep 2022 07:55:29 -0700 (PDT)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4e5400b003a5bd5ea215sm5559533wmq.37.2022.09.01.07.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:55:28 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Deepak.Sharma@amd.com>,
        <Mario.Limonciello@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Jinzhou.Su@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] cpufreq: amd-pstate: cleanup the unused and
 duplicated headers declaration
In-Reply-To: <20220901062339.2357552-1-Perry.Yuan@amd.com> (Perry Yuan's
        message of "Thu, 1 Sep 2022 14:23:39 +0800")
References: <20220901062339.2357552-1-Perry.Yuan@amd.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Thu, 01 Sep 2022 15:55:27 +0100
Message-ID: <87y1v3cffk.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perry,

Perry Yuan <Perry.Yuan@amd.com> writes:

> Cleanup the headers declaration which are not used
> actually and some duplicated declaration which is declarated in some
> other headers already, it will help to simplify the header part.
>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 9ac75c1cde9c..9cf7bc162e7c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -31,19 +31,15 @@
>  #include <linux/compiler.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> -#include <linux/acpi.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
>  #include <linux/uaccess.h>
>  #include <linux/static_call.h>
>  
> -#include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
>  
>  #include <asm/msr.h>
>  #include <asm/processor.h>
> -#include <asm/cpufeature.h>
> -#include <asm/cpu_device_id.h>
>  #include "amd-pstate-trace.h"
>  
>  #define AMD_PSTATE_TRANSITION_LATENCY	0x20000

The patch has the same issue as mentioned in the previous version.

Please don't remove any header includes whose definitions are directly
used in amd-pstate.c. Look at example from my previous comment.
