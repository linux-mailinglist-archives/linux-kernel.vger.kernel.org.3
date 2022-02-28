Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521C54C77E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbiB1SfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbiB1SfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:35:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A0C57673
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646072417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=orhGTYdV3Bv/raBfU/TMPJNTKkeJWFEFU6gUy29N18Q=;
        b=TMUWNc6WzqKle+LeS7BVmMYl72moS976znNxUIYSy8JwrwlG6AwUNzmZjiEosYKpJ5lm7l
        p/XhebX+RoDBkJj0N7UbttUzPfP1Ejql9TFRhNgEXXFgajewmRLwrYi2G49KJUFJXV9BsP
        nsJeyzVNa/LKyhdseoNto04aIQVwUqs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-sw0r6USGPkS6UxguNNtX4g-1; Mon, 28 Feb 2022 13:20:15 -0500
X-MC-Unique: sw0r6USGPkS6UxguNNtX4g-1
Received: by mail-wr1-f71.google.com with SMTP id m3-20020adfa3c3000000b001ea95eb48abso2408146wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=orhGTYdV3Bv/raBfU/TMPJNTKkeJWFEFU6gUy29N18Q=;
        b=GiZzMFGOp536ILd5gI3nMMR43jrnkMr1GG97/5Ai9iBVm1sRIvfriJtrgJUrLHp3vi
         NAqWFbB5/Rf+yL1dudxG8gvVxtJVFhM676T+vJSvyK3xiLr/CHXaJ2vAeBw55it+oxR5
         YR+Feg5RqeW2B0bMBIZNCMIzLUu6QdeDW+KTNM75SMbDhanDIWsD/lPN5RYjPuUgZgUq
         Dq/cOTPo70ylAd5Dfpmqk/tY46wXOJc/FheeWaFIcYvLjm1sIPnLcHnd0jR/X938/XlE
         LJ/s2zYi3E7uh/v6hkQ2tEMakqhiJha3xaodlTKMZPQR9xIrzv6nE7m9+Le86GrwtGz7
         lhJA==
X-Gm-Message-State: AOAM531e3pziG1z8ysnbESKJeewFne5y0UkY0cIOnib27thrzoOhgNng
        uFqUkyaVeqLKHL+6tt6OBTq9mbx6t7icnkMznEnQRkZgSyqcYTRv8/qbTjPDHz4onM9C4QybEiw
        T/WrGre+WUBgiKHR0IFGLrilx
X-Received: by 2002:a5d:6ace:0:b0:1ed:89dc:a456 with SMTP id u14-20020a5d6ace000000b001ed89dca456mr16584017wrw.114.1646072414692;
        Mon, 28 Feb 2022 10:20:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwX6LCwjM3rRS9iR38UBNnioqX1YITtz59t3yxfMc4WXmec4vPtTM6aVb5tg0CqwdJ+750kqw==
X-Received: by 2002:a5d:6ace:0:b0:1ed:89dc:a456 with SMTP id u14-20020a5d6ace000000b001ed89dca456mr16584005wrw.114.1646072414441;
        Mon, 28 Feb 2022 10:20:14 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8? ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id d6-20020a5d4f86000000b001ea8119512bsm11177560wru.55.2022.02.28.10.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:20:14 -0800 (PST)
Message-ID: <9194bc573ec0ccd2d3842ffd4a76894d683a197d.camel@redhat.com>
Subject: Re: [RESEND PATCH 2/2] tracing: Avoid isolated CPUs when queueing
 fsnotify irqwork
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     kernel test robot <lkp@intel.com>, mingo@redhat.com,
        peterz@infradead.org, frederic@kernel.org, rostedt@goodmis.org
Cc:     kbuild-all@lists.01.org, tglx@linutronix.de, mtosatti@redhat.com,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Date:   Mon, 28 Feb 2022 19:20:13 +0100
In-Reply-To: <202203010138.m94KpMH3-lkp@intel.com>
References: <20220228141550.260119-2-nsaenzju@redhat.com>
         <202203010138.m94KpMH3-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-01 at 02:07 +0800, kernel test robot wrote:
> Hi Nicolas,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/sched/core]
> [also build test ERROR on next-20220225]
> [cannot apply to rostedt-trace/for-next linus/master v5.17-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Nicolas-Saenz-Julienne/sched-isolation-Use-raw_smp_processor_id-in-housekeeping_any_cpu/20220228-221742
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 6255b48aebfd4dff375e97fc8b075a235848db0b
> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220301/202203010138.m94KpMH3-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/e3ec0b4adfed05db0d559d2d5234d6d8f1034985
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Nicolas-Saenz-Julienne/sched-isolation-Use-raw_smp_processor_id-in-housekeeping_any_cpu/20220228-221742
>         git checkout e3ec0b4adfed05db0d559d2d5234d6d8f1034985
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash kernel/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/trace/trace.c: In function 'latency_fsnotify':
> > > kernel/trace/trace.c:1728:71: error: 'HK_FLAG_MISC' undeclared (first use in this function); did you mean 'HK_TYPE_MISC'?
>     1728 |         irq_work_queue_on(&tr->fsnotify_irqwork, housekeeping_any_cpu(HK_FLAG_MISC));
>          |                                                                       ^~~~~~~~~~~~
>          |                                                                       HK_TYPE_MISC
>    kernel/trace/trace.c:1728:71: note: each undeclared identifier is reported only once for each function it appears in
>    kernel/trace/trace.c: In function 'trace_check_vprintf':
>    kernel/trace/trace.c:3827:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>     3827 |                 trace_seq_vprintf(&iter->seq, iter->fmt, ap);
>          |                 ^~~~~~~~~~~~~~~~~
>    kernel/trace/trace.c:3894:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>     3894 |                 trace_seq_vprintf(&iter->seq, p, ap);
>          |                 ^~~~~~~~~~~~~~~~~
> 
> 
> vim +1728 kernel/trace/trace.c
> 
>   1718	
>   1719	void latency_fsnotify(struct trace_array *tr)
>   1720	{
>   1721		if (!fsnotify_wq)
>   1722			return;
>   1723		/*
>   1724		 * We cannot call queue_work(&tr->fsnotify_work) from here because it's
>   1725		 * possible that we are called from __schedule() or do_idle(), which
>   1726		 * could cause a deadlock.
>   1727		 */
> > 1728		irq_work_queue_on(&tr->fsnotify_irqwork, housekeeping_any_cpu(HK_FLAG_MISC));
>   1729	}
>   1730	

It seems my patch conflicts with:

04d4e665a609 ("sched/isolation: Use single feature type while referring to housekeeping cpumask")

I'll rebase and send a v2.

-- 
Nicolás Sáenz

