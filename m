Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBFF5889DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbiHCJwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiHCJvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:51:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974528703;
        Wed,  3 Aug 2022 02:51:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z16so20826558wrh.12;
        Wed, 03 Aug 2022 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OsTucAz3U2NvqKccpgYeXLddbVzfXi3zTHHQDqTnHd8=;
        b=MZNgR4E+mQQWms7zLvTBVlgulKGD9neWeW4xIY4nszWcPHES988BnKNzgM8tQw4Z3z
         8NssehEEpEw6D4LUiwwpGm+k2B0/BM9sCPU6bz0tZlMfab9DViXvTSkv11iP+7QEKXeQ
         t1IJHebvNXg9rJslokkuRLcyrcGPs913Y/tOv5NUxtn7X7lSmhU2S75ZsqMKY/Qa3t5F
         yllFyZPIqnBBBaeDaxldq5dIiKC9OlUFx6gdQbp7Y32sC8tZ4M/HRfxE3RwI6FQwFGSy
         qQECJvxSNBsaNy7A1Xdvx8iv/LczMMeIwKSBdp2EFXeV5TUF1z8VOkFCxnbnqdWpkIrd
         nZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OsTucAz3U2NvqKccpgYeXLddbVzfXi3zTHHQDqTnHd8=;
        b=OXA+pV9DR+3BSLnXkVAOl2MEvbKwnR+tEXDaXUionzAnOWr6O8iHlIwfkq4bTB5IIe
         tVv2YmOD61y2Fd/8OqmTrtZKgCEe6/p56w3zBTCfbCENXKMnVUFPMV4N6dClLKpT30c8
         8lH2pdWrntI1/LufeoBWvHR67ZxVPWRtUQNrw00bJzxJS97/rUCrLhGQk94Pddrw+ndK
         mg0LrODsyeR/evgg8uOLfx0N319u90OBXGyaZc94nuAFhdK+sJrAD0wbdeACvU9Bt4J4
         iQCa6IHUOwtxKTPDQtOB/cMU2Hyk5tzgEQCvOMfEsSbN73WoJkPvk3abpk6+Gn0UfRec
         eCJQ==
X-Gm-Message-State: ACgBeo12TlCuGfMQyz4e0fBsR+A52RShtwdKx+rEgDZN1uiQRTufpKXI
        L6eexZNdH8aD7NYARAV65cfIzUi59DI=
X-Google-Smtp-Source: AA6agR7nRoc9deiV7oVvXs/bFBj5HKVUwDBvg4NqDlkkD/o4gxkgzoH7DaDcGw+gFtlvsTZQOVv/yQ==
X-Received: by 2002:a05:6000:1869:b0:220:639b:8337 with SMTP id d9-20020a056000186900b00220639b8337mr8331794wri.572.1659520277173;
        Wed, 03 Aug 2022 02:51:17 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b003a302fb9df7sm2022042wmq.21.2022.08.03.02.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 02:51:16 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 3 Aug 2022 11:51:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCHSET 0/6] perf lock: Add contention subcommand (v1)
Message-ID: <YupFEkzCDxpFUyeD@gmail.com>
References: <20220721043644.153718-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721043644.153718-1-namhyung@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Namhyung Kim <namhyung@kernel.org> wrote:

> Hello,
> 
> It's to add a new subcommand 'contention' (shortly 'con') to perf lock.
> 
> The new subcommand is to handle the new lock:contention_{begin,end}
> tracepoints and shows lock type and caller address like below:
> 
>   $ perf lock contention
>    contended   total wait     max wait     avg wait         type   caller
> 
>          238      1.41 ms     29.20 us      5.94 us     spinlock   update_blocked_averages+0x4c
>            1    902.08 us    902.08 us    902.08 us      rwsem:R   do_user_addr_fault+0x1dd
>           81    330.30 us     17.24 us      4.08 us     spinlock   _nohz_idle_balance+0x172
>            2     89.54 us     61.26 us     44.77 us     spinlock   do_anonymous_page+0x16d
>           24     78.36 us     12.27 us      3.27 us        mutex   pipe_read+0x56
>            2     71.58 us     59.56 us     35.79 us     spinlock   __handle_mm_fault+0x6aa
>            6     25.68 us      6.89 us      4.28 us     spinlock   do_idle+0x28d
>            1     18.46 us     18.46 us     18.46 us      rtmutex   exec_fw_cmd+0x21b
>            3     15.25 us      6.26 us      5.08 us     spinlock   tick_do_update_jiffies64+0x2c
>    ...

Wouldn't it also be useful to display a lock contention percentage value, 
the ratio of fastpath vs. contended/wait events?

That's usually the first-approximation metric to see how contended 
different locks are, and the average wait time quantifies it.

Thanks,

	Ingo
