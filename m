Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9086A55A75B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 07:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiFYF2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 01:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiFYF2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 01:28:24 -0400
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [5.45.198.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D4CB492;
        Fri, 24 Jun 2022 22:28:20 -0700 (PDT)
Received: from sas1-0e0150e31af0.qloud-c.yandex.net (sas1-0e0150e31af0.qloud-c.yandex.net [IPv6:2a02:6b8:c14:392a:0:640:e01:50e3])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 18D446CB7324;
        Sat, 25 Jun 2022 08:28:18 +0300 (MSK)
Received: from sas2-e7f6fb703652.qloud-c.yandex.net (sas2-e7f6fb703652.qloud-c.yandex.net [2a02:6b8:c14:4fa6:0:640:e7f6:fb70])
        by sas1-0e0150e31af0.qloud-c.yandex.net (mxback/Yandex) with ESMTP id lMAl9z8mXq-SGfGlZik;
        Sat, 25 Jun 2022 08:28:18 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1656134898;
        bh=olh/t8bBvdypCRtDpfeOgA30mVxtptEkmVnsLVjMzDc=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=Bp/ICzPWzLMY/gyXracYUUPZjyK9jzgM+dU+ClK8GBSj4ff43N/t2tDIg7Hvn7ow5
         utFRQA1pzsRFajGPBt3QMKTxR1jNxhiv0UgbL1ARXc1yBFN17rSfRlGVvGgAUqJw1n
         Q2rTefMzib1Tws59ZSND0T12UFKfojGaeTjOfMqs=
Authentication-Results: sas1-0e0150e31af0.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas2-e7f6fb703652.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id G8teebH6cY-SEN46qGX;
        Sat, 25 Jun 2022 08:28:15 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Sat, 25 Jun 2022 08:28:13 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        =?UTF-8?B?Sm/Do28gTcOhcmlv?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/5] perf tools riscv: Add support for get_cpuid_str
 function
Message-ID: <20220625082813.3b70727c@redslave.neermore.group>
In-Reply-To: <YrXnFAaT/B1In/+t@kernel.org>
References: <20220624160117.3206-1-nikita.shubin@maquefel.me>
        <20220624160117.3206-3-nikita.shubin@maquefel.me>
        <YrXnFAaT/B1In/+t@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnaldo!

On Fri, 24 Jun 2022 13:32:20 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > +	if (mimpid)
> > +		free(mimpid);  
> 
> just use:
> 
> 	
> 	free(mvendorid);
> 	free(marchid);
> 	free(mimpid);
> 
> fewer lines, free() accepts NULL.
> 
> > +
> > +	return cpuid;
> > +}
> > +
> > +int get_cpuid(char *buffer, size_t sz)
> > +{
> > +	char *cpuid = _get_cpuid();
> > +
> > +	if (sz < strlen(cpuid)) {
> > +		free(cpuid);
> > +		return -EINVAL;
> > +	}
> > +
> > +	scnprintf(buffer, sz, "%s", cpuid);  
> 
> You're leaking cpuid here.

Agree with both.

Thank you for pointing it out.

> 
> > +	return 0;
> > +}
> > +
> > +char *
> > +get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
> > +{
> > +	return _get_cpuid();
> > +}
> > -- 
> > 2.35.1  
> 

