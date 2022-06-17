Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C420554F210
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380620AbiFQHiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380565AbiFQHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:38:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D93550005
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:38:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w5-20020a17090aea0500b001ec7c45794bso240214pjy.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0JRZE0Z29r4UlodpfRtV08NQRTnigdJxgN3DP8hXpHY=;
        b=NEY2iKtHtUL4IQc6zDdgegvPzcuaw41bP35nUj4lBy/tvaeYi7elW4M+N690lLhGq2
         0rJfaSTXaD/T7z4qm+9e6kKlfFQlLg9rDkuMl4K8VoAZI8D9f/xlUf78quh946+BOpsD
         qWyWBO4LGd/dmaYObpXd2Yttb5VUc766BKpIpyhI25Lbwh5ZkazF29qI1oBEL6FHlSSB
         ohtbxmFYvqtW0Gi3MsDd1MW2rF1sTusEgoaTQKuAxO93n8+q9S16xOvtdu199048/KUN
         jzKT9FYQpIMikudcJA71wbR9YJceiV8xJP6AGrJiw2KJ2/uavXGJMAJ4YWWhOWraM8lm
         ZDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0JRZE0Z29r4UlodpfRtV08NQRTnigdJxgN3DP8hXpHY=;
        b=dZXXxSpHeJgrrcJLL0uBnKCB4GBawWFF1yl5Q5wOCv6WMPO2UgNVNDn537ar096xZA
         YZNmI+u5TVi2x+FkaXrYKa/d+zFSShTVgXqV550SJKCT0mfJm8Pofwt5B045MXnOBzzB
         xgbEKr8Qn/iIOZQ2445KyTOYIurla9LocnkA3Qgh8BI44xmkAFcslfbkGAQ6p2Fs9hZ/
         GQgb3vcuFt0RitdpO+SAIU9t8GhjFPo7uc1ZWl3p2sZ1AcCRhP8LTis8nly6cm592oTX
         DzmrrzAEuS5D+4WD5wyDUWAKZG3CMmOOOjjnwaK/J6yLuEqnWhrdhHliCFXFEo/Rmw70
         DI9A==
X-Gm-Message-State: AJIora8CElmcY/V3CVUGmPZ89qJiiPpnEDBsIrtDbrPRxLy1Yb7uTBoo
        LkmNrjDx70KSKX17w2bnLF54iw==
X-Google-Smtp-Source: AGRyM1tUyfYz20VN7BXvpIfxhhyVOdn7+NV09gMOWoEO8ZHM10dORUVqR3B883OKoeWHwEhkbW7ejw==
X-Received: by 2002:a17:902:ba8d:b0:168:ff8f:c1f with SMTP id k13-20020a170902ba8d00b00168ff8f0c1fmr8039334pls.6.1655451525503;
        Fri, 17 Jun 2022 00:38:45 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077154.netvigator.com. [58.152.77.154])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001676f87473fsm2827966plk.302.2022.06.17.00.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 00:38:45 -0700 (PDT)
Date:   Fri, 17 Jun 2022 15:38:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        German Gomez <german.gomez@arm.com>
Subject: Re: [PATCH v2] perf test: Add ARM SPE system wide test
Message-ID: <20220617073840.GA45710@leoy-ThinkPad-X240s>
References: <20220616230546.1390813-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616230546.1390813-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Thu, Jun 16, 2022 at 04:05:46PM -0700, Namhyung Kim wrote:

[...]

> +arm_spe_system_wide_test() {
> +	echo "Recording trace with system-wide mode $perfdata"
> +	perf record -o ${perfdata} -e arm_spe// -a \
> +		-- dd if=/dev/zero of=/dev/null count=100000 > /dev/null 2>&1
> +
> +	if [ $? != 0 ]; then
> +		arm_spe_report "SPE system-wide testing" 2
> +		return
> +	fi

I am awared the root permission issue after I saw German's suggestion.

If the snapshot test is passed, no matter the system wide test is passed
or not, we will always return 0 for 'passed' result.  But we might miss
to capture the system-wide testing failure.

How about use 'dummy' event to verіfy the root permission?
(actually I referred to intel-pt test):

        perf record -o ${tmpfile} -B -N --no-bpf-event -e dummy:u -a true 2>&1 >/dev/null
        if [ $? != 0 ]; then
        	arm_spe_report "SPE system-wide testing" 2
        	return
        fi

        perf record -o ${perfdata} -e arm_spe// -a \
                  -- dd if=/dev/zero of=/dev/null count=100000 > /dev/null 2>&1

Thanks,
Leo

> +	perf_script_samples dd &&
> +	perf_report_samples dd
> +
> +	err=$?
> +	arm_spe_report "SPE system-wide testing" $err
> +}
> +
>  arm_spe_snapshot_test
> +arm_spe_system_wide_test
> +
>  exit $glb_err
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 
