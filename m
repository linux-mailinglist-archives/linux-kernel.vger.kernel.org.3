Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A036858B9BA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 07:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiHGFoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 01:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiHGFoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 01:44:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DDBB1FF
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 22:44:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso6403536pjd.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 22:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qEhg68YRniOXq5BKbBv0ex6VPSZORGkaXrhNztya/B4=;
        b=Sc/8ey8sZqSGNmWo+eLf/3NzmUldsolv4qWckQyNaayzHsb6V1U0BfsibytFHJcmap
         o1jMrIcLe6YwSHIL2Wl6iFXtsCHRLgYJ4wpNHIa828eloffF8bxv3SP4CWIbWYwSmFZE
         noR5YSbnGq3p+qjh5Pn3xU95ezQkXeq82bBxxat4jeQE+LTBXQ4Z9TLF3CyGbUAGmtBN
         TWynf9Tx9IEs3Q7pSpcucjqL5YWyJ778edLMEjTAt7kzqre6pp/+92pPYoa5p6Zd7YCi
         dqIwuhfsGRDFApLJb70gSNilRL8i2UODj60nTr51ygmx+HcXnoIhzIKohPdSRi/XeQ97
         TpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qEhg68YRniOXq5BKbBv0ex6VPSZORGkaXrhNztya/B4=;
        b=OWYmW7+C0fWtThwePNg86DLeikLwUiY1wORKnO2Hk1Zi9HXiRGIxk/qUOJhsdxa4T5
         1GJnsddlq7zAgIDx0qtNMPBaFXdkwZbphPAMJMMwsTz31qXoDIWii2YVUnvv9j/g/NP0
         QJYcoA82MsJlPpODrDLL77leGdMh2k3jbRL5ApTngHI5fR7UfHGhHgj/+kwQxHfmRI0z
         IvbJcQgWJd2RtrrmfcTzndpAZV59uqLL91nhHk3aG2qMmzmeb3rPlva6MKAyzcTLYnUQ
         zAzzk+dv3RgxW1OgnjdqX8UP1gwM1JkR+Xlnd8rfdIMJ6aCi/f7DmPc3gEm59vMabb0W
         d4mA==
X-Gm-Message-State: ACgBeo3ayQM6gq62GxBGqlkQ9jozgKErdgxmjACILKZxW80VAQFPwbgP
        GROgU3LWKUtI8glvMPdJBDBMZQ==
X-Google-Smtp-Source: AA6agR7hx420YhP8MRZ2DGDvVzPLjRztAOnOEBMxZgU3XCasqf7UjkBrUstin0r2QxYJ8IVTMYClOw==
X-Received: by 2002:a17:90a:c58e:b0:1f3:1ab5:22ae with SMTP id l14-20020a17090ac58e00b001f31ab522aemr23684577pjt.45.1659851050706;
        Sat, 06 Aug 2022 22:44:10 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b0015e8d4eb2easm5977893plg.308.2022.08.06.22.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 22:44:10 -0700 (PDT)
Date:   Sun, 7 Aug 2022 13:44:06 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 12/14] perf test: Add unroll thread test shell script
Message-ID: <20220807054406.GJ34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-13-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-13-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:54PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> This adds scripts to drive the unroll thread tests to compare perf
> output against a minimum bar of content/quality.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  .../shell/coresight/unroll_loop_thread_10.sh   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100755 tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
> 
> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
> new file mode 100755
> index 000000000000..f48c85230b15
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh -e
> +# CoreSight / Unroll Loop Thread 10
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +
> +TEST="unroll_loop_thread"
> +. $(dirname $0)/../lib/coresight.sh
> +ARGS="10"
> +DATV="10"
> +DATA="$DATD/perf-$TEST-$DATV.data"
> +
> +perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
> +
> +perf_dump_aux_verify "$DATA" 10 10 10

Just minor comments for checking the trace data quality:

The unroll program loops for 10000 times per thread, and this test
creates 10 threads; so if we pass the parameter "10 10 10" for
perf_dump_aux_verify, seems to me this is very conservative?

I would like hear Mike's opinion for these quality metrics; the
patch itself is fine for me, you could add my review tag:

Reviewed-by: Leo Yan <leo.yan@linaro.org>


P.s. it's off-topic, just want to remind to use the "b4" tool when you
spin for next version's patch set, e.g. you could use below commands:

  $ b4 am 20220728145256.2985298-1-carsten.haitzler@foss.arm.com
            ^
            ` I get the message ID from the page:
              https://lore.kernel.org/lkml/20220728145256.2985298-1-carsten.haitzler@foss.arm.com/
  $ git am ./v5_20220728_carsten_haitzler_a_patch_series_improving_data_quality_of_perf_test_for_coresight.mbx

We can benefit from this due "b4" can automatically append tags in
patches; this can help us to track which patches have been reviewed
and tested in previous versions.

Thanks,
Leo

> +
> +err=$?
> +exit $err
> -- 
> 2.32.0
> 
