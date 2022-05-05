Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3204651C346
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiEEPHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380993AbiEEPHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:07:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA244EDD2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:03:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 7so3817640pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p0XNlCKvooGrV6ZMU6Sx6KooJcpJYfdyWRaV1ZQKDyw=;
        b=j2gOTIjdhU49vCuH4bvANW0D2xEdXz+Hv/xxPwPfVz4er/W7q6MoZtuCLs9FH8B7c2
         9eN79nbubAVfalNtMVdlpOiZ2beCpSG8pFgmafwf3UsHhlR2nf7Hy74UZJk+fZSRFBe2
         rz+wsblLYwIjouA3h9ozwqgbmfUoB3qYhcefaDReX1vKY1ZqxMYX9BWuWfF3CEzCi0Qi
         zVJqg15YYfX4rvtdRIQT8Q7JGReHpgJeHnywMZ89S8M1TQhCCHOEGWPKFbgVHywm/cME
         mBim89F5oTeIjiiuhMHwg3AIEkkrRYeInzeeZPktcY1yZr9uMtyGaDHc74UxB5zbgZLm
         hOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p0XNlCKvooGrV6ZMU6Sx6KooJcpJYfdyWRaV1ZQKDyw=;
        b=mloiAhblzWPZNpCaRXnyXI8CNCwYE3qY4a/bibpHKhUe1PtIJAayGYeEA0lvPYouwR
         AF3ZYazrQt3krvQpiVHI2Qsxbdz7hsHgNl31cAFX27dwd3qk3qU6t/6LIx+YyUb8oq8x
         x1tL1NJCpq+jribFJ8Fx+Nlbvm1Oa66BzIXM4bVN/ST14R67jSbvV5IW73dBMBy9UkTF
         5yUTq7Q69mazh5AGWnZ2+CCqZe/+zNUx1yjLyVydtHjDeZkQ+yew1uqu/J9VViGpSvyv
         Yi0ehuHfHM5Bpx5pizJg4jbahbiDiV5+TjiGMWfVZIgPNC+vYvv1cK6p04/7zP5BK9Kz
         GCGA==
X-Gm-Message-State: AOAM5338W1GMq4EhSJqQsCQxgDo80Oml8wHG64wU9AzNduSrAAGgc8KX
        mgvF5Q+bBgxmkx7fy1Q+qvZraw==
X-Google-Smtp-Source: ABdhPJxiH+FkIAuJwVrFmog9f4EK41Ai/cvuej2w2ZV659GETH3wON3TUUEyR6MODJaxPaGqJUwKBw==
X-Received: by 2002:a62:be14:0:b0:505:a43b:cf6e with SMTP id l20-20020a62be14000000b00505a43bcf6emr26439454pff.33.1651763024375;
        Thu, 05 May 2022 08:03:44 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id bb10-20020a170902bc8a00b0015e8d4eb2c5sm1620624plb.271.2022.05.05.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 08:03:43 -0700 (PDT)
Date:   Thu, 5 May 2022 23:03:30 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        acme@kernel.org, benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v8 5/5] perf arm-spe: Use SPE data source for neoverse
 cores
Message-ID: <20220505150330.GB136333@leoy-ThinkPad-X240s>
References: <20220504184850.24986-1-alisaidi@amazon.com>
 <20220504184850.24986-6-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504184850.24986-6-alisaidi@amazon.com>
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 06:48:50PM +0000, Ali Saidi wrote:
> When synthesizing data from SPE, augment the type with source information
> for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
> the same encoding. I can't find encoding information for any other SPE
> implementations to unify their choices with Arm's thus that is left for
> future work.
> 
> This change populates the mem_lvl_num for Neoverse cores as well as the
> deprecated mem_lvl namespace.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> Reviewed-by: German Gomez <german.gomez@arm.com>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks for updating, Ali.  It looks good to me.

Since the store operations have been set as PERF_MEM_LVL_NA and
PERF_MEM_LVLNUM_NA, this is right thing for me, I will update perf c2c
patch set for statistics of store operations with PERF_MEM_LVL_NA.

Thanks,
Leo
