Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BBC5B064F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiIGOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIGOVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:21:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7337332AB4;
        Wed,  7 Sep 2022 07:21:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y3so30793998ejc.1;
        Wed, 07 Sep 2022 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=GmjHydQzDqYVY9OvbE5Eqn2I6DrHbPQiC0wDwCk2Kro=;
        b=GoFA2Px6880+LWoG+/91mOILp7eQwkt9KwCEOA+XNj45hoBf9r8y2Bq6k3vwKVn7qB
         xdX3RYDKCbehUWnKwcOMLlSS395nD8C5/qO48Xiwv4twvJrQmzRYjzBOfnPaT07o+wTn
         /j4mVb0MTYRHo+I0ZU8YNlKMedcxmtUGYVBb6qOajmLT2fjmyOJdDv3KtwPLNbNzeFRb
         bNMOCsc+gO9xmxP/HtC3CvKMSzRF6/k2YcvhsAOnokjR8qxxAsMQ/0NgZjnS2NGzEQye
         IsuMm4DC+Qedl8dpRRCloaDziZQvVovnlO7+I1OwFjB8oeA515qC1tZLxBpwXozq7CgM
         X7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=GmjHydQzDqYVY9OvbE5Eqn2I6DrHbPQiC0wDwCk2Kro=;
        b=dkzgDXv/CWBYDaTmZucl7rL2D8N0hbgwaSXUxv8omR6dgY27nKSnrdjXQZAL/BP8hT
         mCLg34e1tbqsS+gieOGD3tQiOL6mFJyPxX7j38PsuIexLcWlw+EjWLvR+ir5Sm3ooUJo
         lsPbSeBVdasO9o+aFKX0h1IzB8TpOPtd34lH0prSfL+CqJ1ahJKam5jCpjZxfRwiVIyn
         p7h6cI5vsyyy7RRejqo0giU1NhPHsQSFw5rD609UCqVsK+/NxZFjG1rO91qEVPrqkXPp
         wqPXX5YjZfi5o52uekiTnhsi5/gzgf75/1HDU2ItVbyqMTZX0rcmLr/oiuLs6hsTbD2P
         oXkA==
X-Gm-Message-State: ACgBeo0BE6V/tA6ezicZHtBObOSyMjWOV7ckRSYF6ZIoO/M6dEikWMzk
        aY7F4kcTduVFHyBHqkqGGjY=
X-Google-Smtp-Source: AA6agR4FZNDDktIK/bO660wPtAu3DNWXz8BT0H8es9LQxHCV0EzEdAMCRZ4QKRdFV4a+ZLHqwVIo+A==
X-Received: by 2002:a17:907:1688:b0:730:b3ae:347 with SMTP id hc8-20020a170907168800b00730b3ae0347mr2446498ejc.756.1662560460959;
        Wed, 07 Sep 2022 07:21:00 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id h6-20020a1709060f4600b0071cbc7487e1sm8460075ejj.69.2022.09.07.07.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:21:00 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 7 Sep 2022 16:20:59 +0200
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for
 multi-threaded targets
Message-ID: <Yxioy/TXc/KDLoDL@krava>
References: <20220905114209.8389-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905114209.8389-1-adrian.hunter@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 02:42:09PM +0300, Adrian Hunter wrote:
> The offending commit removed mmap_per_thread(), which did not consider
> the different set-output rules for per-thread mmaps i.e. in the per-thread
> case set-output is used for file descriptors of the same thread not the
> same cpu.
> 
> This was not immediately noticed because it only happens with
> multi-threaded targets and we do not have a test for that yet.
> 
> Reinstate mmap_per_thread() expanding it to cover also system-wide per-cpu
> events i.e. to continue to allow the mixing of per-thread and per-cpu
> mmaps.
> 
> Debug messages (with -vv) show the file descriptors that are opened with
> sys_perf_event_open. New debug messages are added (needs -vvv) that show
> also which file descriptors are mmapped and which are redirected with
> set-output.
> 
> In the per-cpu case (cpu != -1) file descriptors for the same CPU are
> set-output to the first file descriptor for that CPU.
> 
> In the per-thread case (cpu == -1) file descriptors for the same thread are
> set-output to the first file descriptor for that thread.
> 
> Example (process 17489 has 2 threads):
> 
>  Before (but with new debug prints):
> 
>    $ perf record --no-bpf-event -vvv --per-thread -p 17489
>    <SNIP>
>    sys_perf_event_open: pid 17489  cpu -1  group_fd -1  flags 0x8 = 5
>    sys_perf_event_open: pid 17490  cpu -1  group_fd -1  flags 0x8 = 6
>    <SNIP>
>    libperf: idx 0: mmapping fd 5
>    libperf: idx 0: set output fd 6 -> 5
>    failed to mmap with 22 (Invalid argument)
> 
>  After:
> 
>    $ perf record --no-bpf-event -vvv --per-thread -p 17489
>    <SNIP>
>    sys_perf_event_open: pid 17489  cpu -1  group_fd -1  flags 0x8 = 5
>    sys_perf_event_open: pid 17490  cpu -1  group_fd -1  flags 0x8 = 6
>    <SNIP>
>    libperf: mmap_per_thread: nr cpu values (may include -1) 1 nr threads 2
>    libperf: idx 0: mmapping fd 5
>    libperf: idx 1: mmapping fd 6
>    <SNIP>
>    [ perf record: Woken up 2 times to write data ]
>    [ perf record: Captured and wrote 0.018 MB perf.data (15 samples) ]
> 
> Per-cpu example (process 20341 has 2 threads, same as above):
> 
>    $ perf record --no-bpf-event -vvv -p 20341
>    <SNIP>
>    sys_perf_event_open: pid 20341  cpu 0  group_fd -1  flags 0x8 = 5
>    sys_perf_event_open: pid 20342  cpu 0  group_fd -1  flags 0x8 = 6
>    sys_perf_event_open: pid 20341  cpu 1  group_fd -1  flags 0x8 = 7
>    sys_perf_event_open: pid 20342  cpu 1  group_fd -1  flags 0x8 = 8
>    sys_perf_event_open: pid 20341  cpu 2  group_fd -1  flags 0x8 = 9
>    sys_perf_event_open: pid 20342  cpu 2  group_fd -1  flags 0x8 = 10
>    sys_perf_event_open: pid 20341  cpu 3  group_fd -1  flags 0x8 = 11
>    sys_perf_event_open: pid 20342  cpu 3  group_fd -1  flags 0x8 = 12
>    sys_perf_event_open: pid 20341  cpu 4  group_fd -1  flags 0x8 = 13
>    sys_perf_event_open: pid 20342  cpu 4  group_fd -1  flags 0x8 = 14
>    sys_perf_event_open: pid 20341  cpu 5  group_fd -1  flags 0x8 = 15
>    sys_perf_event_open: pid 20342  cpu 5  group_fd -1  flags 0x8 = 16
>    sys_perf_event_open: pid 20341  cpu 6  group_fd -1  flags 0x8 = 17
>    sys_perf_event_open: pid 20342  cpu 6  group_fd -1  flags 0x8 = 18
>    sys_perf_event_open: pid 20341  cpu 7  group_fd -1  flags 0x8 = 19
>    sys_perf_event_open: pid 20342  cpu 7  group_fd -1  flags 0x8 = 20
>    <SNIP>
>    libperf: mmap_per_cpu: nr cpu values 8 nr threads 2
>    libperf: idx 0: mmapping fd 5
>    libperf: idx 0: set output fd 6 -> 5
>    libperf: idx 1: mmapping fd 7
>    libperf: idx 1: set output fd 8 -> 7
>    libperf: idx 2: mmapping fd 9
>    libperf: idx 2: set output fd 10 -> 9
>    libperf: idx 3: mmapping fd 11
>    libperf: idx 3: set output fd 12 -> 11
>    libperf: idx 4: mmapping fd 13
>    libperf: idx 4: set output fd 14 -> 13
>    libperf: idx 5: mmapping fd 15
>    libperf: idx 5: set output fd 16 -> 15
>    libperf: idx 6: mmapping fd 17
>    libperf: idx 6: set output fd 18 -> 17
>    libperf: idx 7: mmapping fd 19
>    libperf: idx 7: set output fd 20 -> 19
>    <SNIP>
>    [ perf record: Woken up 7 times to write data ]
>    [ perf record: Captured and wrote 0.020 MB perf.data (17 samples) ]
> 
> Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
