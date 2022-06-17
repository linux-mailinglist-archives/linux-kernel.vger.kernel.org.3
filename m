Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6E254F227
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380676AbiFQHp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiFQHpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:45:24 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B05C674F5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:45:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q140so3399347pgq.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UN5wKNbB+gVz0MX2GTcg6Rw1lsEc1tgfAUNNFpXQz3Y=;
        b=Mswm1WvMrZVDLXyE4nWVJOH7IqmhFUOXGqh300G317e18kZuX1t4wJKQ2gBsonvfRB
         YwdilqV6fdJSxYgeH95yKrzKmZ+p8GxvKPDteJH6dT01eS4vNcYW5SAvLZo7qyUzCRFQ
         rZd2R40wgGsWGAcL5uCDewtjtGs5nwyODjBC138U6EF1DHtXb/Wq0m4XsdRV8LZ1QiP8
         s8r3oXWvMtj2bQmNu8OmrvHIIf2XrLv8ImrkQTtPArxqHg+iRSoIFlQZFbP2CJKEovR3
         cvzVH57cSbZinlmY8RX79059QZAiM7gflroH52frgUDpVctvoseuMzXnvuEEPNUY/5Ng
         IPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UN5wKNbB+gVz0MX2GTcg6Rw1lsEc1tgfAUNNFpXQz3Y=;
        b=zxoY7b2T2F0BwVgMV6CU2yNJ7IV5lLHHoL3q5hJRul+oYmA/tRdjAMqcC8k6K0z7UJ
         Z3bV4z3cMGJMujrp8iv8ZW2rOvJfBQsHcbBTylShFy7lxJBCnSa34ZhW0ZMwb1VOZhJc
         3+7FYlrImFQmmGTxl6wp033bRGyt9ObakcqaAw24odprCJwBAfdUo/ZTmgq2XZGQQrCT
         fNX9X48HUIx30gSgwJZDrXWYqWAOdasaUyjJ35o0EnYQYCRsZD0oosP2GmwU+cBwbWCe
         gXy9WfXN9x/42nPXLcVpMI6z1Hq0Vrs3nNAigLf3aoRqlmEo9cbNCpqoavTikW3QV5Q+
         7/cg==
X-Gm-Message-State: AJIora/XxswRCy1caZenM4A6mvstNKWwOQdnFNnO4UkrGEhGm+D7foNQ
        LR/CjBZ6xBo9AEZCkaj8QPcLbvf09Va4Gdm0
X-Google-Smtp-Source: AGRyM1s01D2BJk6yQTd7SaCXZiVMvkVhiFRGRZTdE1735521WxT0x7F3MhFT2n0cfBSNbLgJDSS4zQ==
X-Received: by 2002:a05:6a00:218c:b0:51c:c64:3f6a with SMTP id h12-20020a056a00218c00b0051c0c643f6amr8524810pfi.50.1655451922717;
        Fri, 17 Jun 2022 00:45:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077154.netvigator.com. [58.152.77.154])
        by smtp.gmail.com with ESMTPSA id c5-20020a17090ab28500b001e88c4bb3dcsm4945443pjr.25.2022.06.17.00.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 00:45:22 -0700 (PDT)
Date:   Fri, 17 Jun 2022 15:45:17 +0800
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
Message-ID: <20220617074517.GB45710@leoy-ThinkPad-X240s>
References: <20220616230546.1390813-1-namhyung@kernel.org>
 <20220617073840.GA45710@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220617073840.GA45710@leoy-ThinkPad-X240s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 03:38:40PM +0800, Leo Yan wrote:
> Hi Namhyung,
> 
> On Thu, Jun 16, 2022 at 04:05:46PM -0700, Namhyung Kim wrote:
> 
> [...]
> 
> > +arm_spe_system_wide_test() {
> > +	echo "Recording trace with system-wide mode $perfdata"
> > +	perf record -o ${perfdata} -e arm_spe// -a \
> > +		-- dd if=/dev/zero of=/dev/null count=100000 > /dev/null 2>&1
> > +
> > +	if [ $? != 0 ]; then
> > +		arm_spe_report "SPE system-wide testing" 2
> > +		return
> > +	fi
> 
> I am awared the root permission issue after I saw German's suggestion.
> 
> If the snapshot test is passed, no matter the system wide test is passed
> or not, we will always return 0 for 'passed' result.  But we might miss
> to capture the system-wide testing failure.
> 
> How about use 'dummy' event to verіfy the root permission?
> (actually I referred to intel-pt test):
> 
>         perf record -o ${tmpfile} -B -N --no-bpf-event -e dummy:u -a true 2>&1 >/dev/null

Sorry for typo, s/tmpfile/perfdata/

>         if [ $? != 0 ]; then
>         	arm_spe_report "SPE system-wide testing" 2
>         	return
>         fi
> 
>         perf record -o ${perfdata} -e arm_spe// -a \
>                   -- dd if=/dev/zero of=/dev/null count=100000 > /dev/null 2>&1
