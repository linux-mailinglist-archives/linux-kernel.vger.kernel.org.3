Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E944AB429
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351713AbiBGFxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350415AbiBGDb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:31:26 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE77C043180
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 19:31:25 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c3so10148660pls.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 19:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X8O4SjgVdS5SunuH2EEc/jocTlfs6Jf+CUub2i63z1U=;
        b=lBs6XhEfsFsuOE3WNWg2BT0Jyc2nmdOyinZtvlBztKfWbOxzqL8X9E3b4SyNqE0Tvm
         jtIo8mDN01tpjq7oVr7OCKI1prUml3i98glWaL1pwAsEET0rel4CVJhAgSE+XwJw8hjx
         x5w8KybVk7IvQS1Z7b/cLBfPDhYgZ5StGnn3m1aBVzqgmQ06lCtKhLKCdpeO8eU9T5Gv
         iaK9w/QlIrzCL6ppjKhSVDdER8rGF64is0tdXnp8DynI23a+NnLLnKX6+QJH245IaFbj
         Mj7SrGtmd3PZEnLzVDMO5o1qEijES+UIiHT1HpvHqDbzy2+4YmObrJzK7zLcXjBM9LCg
         DHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X8O4SjgVdS5SunuH2EEc/jocTlfs6Jf+CUub2i63z1U=;
        b=dOEa6g50rtdIIsBtAFR6F7EKjL+nZbYWIi6xFYHzKK18bOJaee1HWIz5SNPCfElqvn
         O8opChvlhhW+yOJg6Q0NcjYtaMrhialXOP/CcLmzg4o0mLoyqIiS31jc9AT+Lkd8IlHd
         iHan8fCCZXNyuoUHH7NGCUTLguowShb6KnT7+uMqhLWxdA0AoYhgRplHNDEAebIDAbLy
         v5c9LwG3uhEBudY1D9Q+m50L85vDSI8pA7R1x2ulPLG7ossUiKrd7OzGWHle5BJXau+V
         74MUbjmCbAY1eiw6crYeM42+aT6GPEsRnGU5VmGjh2w/k0D7WN3oehWK2hGVwrQI3YZ7
         wcLQ==
X-Gm-Message-State: AOAM530TqBlPMUy7ee5hZMV/u6O4wlEApXIn8SsvZkETDzazytzRmjTM
        5u0xn+2KCD15xlL4D9koOW2eDw==
X-Google-Smtp-Source: ABdhPJwEQXNbmG3jgYfTVG3BtqUk2B62Q1FY7AdDYz8KoNic3DRlZsUpTPdBTY+Eja0b4x7JYBdkxA==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr14619566pln.18.1644204684551;
        Sun, 06 Feb 2022 19:31:24 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id lb3sm20635240pjb.47.2022.02.06.19.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 19:31:24 -0800 (PST)
Date:   Mon, 7 Feb 2022 11:31:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf synthetic-events: Return error if procfs isn't
 mounted for PID namespaces
Message-ID: <20220207033117.GA1240868@leoy-ThinkPad-X240s>
References: <20211224124014.2492751-1-leo.yan@linaro.org>
 <e5f242c4-fe64-e214-4b28-c99af684751a@arm.com>
 <20220204124849.GB2040169@leoy-ThinkPad-X240s>
 <Yf+1HQ9+7TPmSSr7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf+1HQ9+7TPmSSr7@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 08:46:37AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 04, 2022 at 08:48:49PM +0800, Leo Yan escreveu:
> > On Fri, Jan 07, 2022 at 02:27:57PM +0000, James Clark wrote:
> > > On 24/12/2021 12:40, Leo Yan wrote:
> > > > For perf recording, it retrieves process info by iterating nodes in proc
> > > > fs.  If we run perf in a non-root PID namespace with command:
> > > > 
> > > >   # unshare --fork --pid perf record -e cycles -a -- test_program
> > > > 
> > > > ... in this case, unshare command creates a child PID namespace and
> > > > launches perf tool in it, but the issue is the proc fs is not mounted
> > > > for the non-root PID namespace, this leads to the perf tool gathering
> > > > process info from its parent PID namespace.
> > > > 
> > > 
> > > I had some concerns that this would prevent use of perf in docker, but docker
> > > does mount /proc so it is still working. And you've added a warning about how
> > > to fix the unshare command so I think this is ok.
> > > 
> > > Reviewed-by: James Clark <james.clark@arm.com>
> > 
> > Thanks a lot for review, James.
> > 
> > Arnaldo, Jiri, could you take a look for this patch?  Thanks!
> 
> Looks sane, there was discussion, a detailed set of steps to reproduce
> the problem was provided, thanks, applied.

Thank you, Arnaldo!
