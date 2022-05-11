Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CCE52298D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbiEKCUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241063AbiEKCUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:20:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19A61F7E03
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:20:14 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a19so339998pgw.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+O1DI8iNjAZn8PsQoBk4pwjX1aYVH8igGYI2zY2FbWg=;
        b=S90BK2NKh3s0l4hPcjya0nRrxzwLOtSHenL75N1j9KfG9H2LlxjyHO/miA4g96YBbR
         fjxe3We4CFn8hCBd97r5oZdHo/MQg+OlOrjQ7e5taW/vALXXaRejSP0+nmOCMM9tAMLf
         LWGG/yjoVjQPmctnWljKkCmX4LDRixi4mJzpyuoSsWyLhtDDhbiiTc5bMZnEUMHtkYGt
         6OjZIAKxOrryYfjfO1Pn81RMqffAhyc3gQoby13CHgHa0lq+6rEzlStfmszmVuKqX18T
         ivMlpjtTDASlUVLaFRwz6CQhvayGXBjelCa4GDFQGHSkH16J5vHZocFKcBIVxP0caPv/
         AVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+O1DI8iNjAZn8PsQoBk4pwjX1aYVH8igGYI2zY2FbWg=;
        b=U0AEN4NOO390/NjYMcSl1hP75GT6PfZN3TtS8oExlrimSO8ZBuUjS9uKYfYq1JMf3B
         dg867R6JxBRF8e5hYze8k29aIxIhlN1Bi7mVRok/Aik5ksXrc4WMnmLQC+lbSIsrKzzI
         ElBGrDOel+Sfx2YueQieWaROenEhg0SiPC6THnYaKWYQapu3G4SlAFpz9P3lsVf17pm2
         DGtCKmc+qmeTyocn4hAchtUvNWLEAzSoZWVyQxDXhTlbQbh6eD5sA1SQwdlDUaSdhSTb
         yB2x+aVEtfQL/jI65YrjXbQhgQFckYV0RUQrTvnAf9PL89GvU6Z3cvKObN7cYfmwBZND
         gwyQ==
X-Gm-Message-State: AOAM530fq6bCf571h6GNi+16HXbWaNMRyJVwxjiyVLDCsSeFvTQ9RnEJ
        8zkcic71zwwf9X1c/3/XZhIeSg==
X-Google-Smtp-Source: ABdhPJwzRJprhZH2evJMiPwJT0Jpt3Ji57iSehdQOH1LNSR1cgVL130KN51K1W0+KiKeOpORuCRpzg==
X-Received: by 2002:a05:6a00:4486:b0:50d:fc41:a9a with SMTP id cu6-20020a056a00448600b0050dfc410a9amr22732738pfb.71.1652235614344;
        Tue, 10 May 2022 19:20:14 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id v24-20020a170902e8d800b0015e8d4eb272sm307061plg.188.2022.05.10.19.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 19:20:13 -0700 (PDT)
Date:   Wed, 11 May 2022 10:20:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v8 2/5] perf tools: sync addition of PERF_MEM_SNOOPX_PEER
Message-ID: <20220511022004.GA956170@leoy-ThinkPad-X240s>
References: <20220504184850.24986-1-alisaidi@amazon.com>
 <20220504184850.24986-3-alisaidi@amazon.com>
 <YnqStjaWInPqLnsX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnqStjaWInPqLnsX@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 01:28:38PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 04, 2022 at 06:48:47PM +0000, Ali Saidi escreveu:
> > Add a flag to the perf mem data struct to signal that a request caused a
> > cache-to-cache transfer of a line from a peer of the requestor and
> > wasn't sourced from a lower cache level.  The line being moved from one
> > peer cache to another has latency and performance implications. On Arm64
> > Neoverse systems the data source can indicate a cache-to-cache transfer
> > but not if the line is dirty or clean, so instead of overloading HITM
> > define a new flag that indicates this type of transfer.
> > 
> > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> Was this already merged on the ARM kernel tree?

No, I don't think this patch has been merged on Arm kernel tree.  I searched
Arm and Arm64 git repos, none of them has merged this patch.

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?qt=author&q=Ali+Saidi
http://git.armlinux.org.uk/cgit/linux-arm.git/log/?qt=author&q=Ali+Saidi

P.s. Ali missed to include German's review tag, see:
https://lore.kernel.org/lkml/458a2de1-dc93-7e2d-5dc5-fbcd670572b6@arm.com/

Do you want us to resend the patch set for adding tags?

Thanks,
Leo
