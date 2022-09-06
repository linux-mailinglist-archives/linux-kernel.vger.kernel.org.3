Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D245AF6B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiIFVRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIFVRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:17:18 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10CBB8A67
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:17:17 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c9so9176922qkk.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date;
        bh=iphfHBoIMOL1lNTHRr252fzN2iLvPwqaZYRfa0FBIl0=;
        b=chgn4pbDbcOp3ZbEZ0S3NHjfUXE16m4I6KQGo5MTe7zZewnaoKHfkshoAk8SQR2Wj/
         Lf3bH9ZA+yPsCOdwrmnauTe8etrWFMzUhP/ePs9pWiM0lnoGIYNe76MgkiXNzpzgOuLQ
         p74cCqKyLqxws1X/4yHYvVnREU6i1eAM3FLHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=iphfHBoIMOL1lNTHRr252fzN2iLvPwqaZYRfa0FBIl0=;
        b=SFQ5r+WUoyMkyO4Pj2B0Rp6ekiL8RAY+uxwcicf+k6YDpLdFfDQ0uXlDXIRO2enLoh
         hpP4uZrf3M2HSsuTBlVgXs4YyetyvT6HjOlnCqzy8sz/Wz+kg+bpHdufMf9gIg6GVnmB
         z5fLTKw54bo1NjkXAY2Rr2fkyEX19jgsnbkJ2Qsr9ncAbHcu46k/f86oaJLNS5AGi/ez
         f2BjRA1s2NAdgihHlXNpmwYItdr4qR3H0XH5qDIlOOjEeyV8rdKeJXpKvm87aEmRzBsd
         9XI+qfRoDP3wcgMICOWbCXiX3sCrqCHSCiVzJRwG0HWGVdaVtyad9sFC1povoq5tfeB6
         szuw==
X-Gm-Message-State: ACgBeo2YEDez2+YkDB5DAGeACuH86hiFH6bDVKupU0o6k00ak/GGuKej
        QzJn8RxtE4vcqhwUpmORwecAbA==
X-Google-Smtp-Source: AA6agR6naAyf9NJUVt1eu65uLtRd9YOTQnBFylX4LLJ88vMlQ4yZsGYOqgew0EWn3OLhCnCBmlX5DQ==
X-Received: by 2002:a05:620a:4e1:b0:6bb:5c0e:ab58 with SMTP id b1-20020a05620a04e100b006bb5c0eab58mr504151qkh.730.1662499036977;
        Tue, 06 Sep 2022 14:17:16 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id y22-20020a37f616000000b006b893d135basm11381881qkj.86.2022.09.06.14.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:17:16 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 6 Sep 2022 17:17:14 -0400 (EDT)
To:     Ian Rogers <irogers@google.com>
cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2] libperf evlist: Fix per-thread mmaps for multi-threaded
 targets
In-Reply-To: <CAP-5=fW3MLdzA01gWRx7yH-b=J4oqUTj9KMtrB0ZDpb0wucZ4A@mail.gmail.com>
Message-ID: <69bf3c5b-e3e8-9099-bd7b-b05beea7bd1f@maine.edu>
References: <20220905114209.8389-1-adrian.hunter@intel.com> <YxdEQkmkZjBC6wGb@krava> <60b5c9bf-4ec9-957e-17dd-aa0a50411ff9@intel.com> <CAP-5=fW3MLdzA01gWRx7yH-b=J4oqUTj9KMtrB0ZDpb0wucZ4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022, Ian Rogers wrote:

> > >>                              perf_evlist__set_mmap_first(evlist, map, overwrite);
> > >>              } else {
> libperf CPU map code as I'd like to propose we start a libperf2 (with
> LPC coming up it'd be a good place to discuss this, there's also the
> office hours on Thursday). What I hope for libperf2 is that we can
> make its license the same as libbpf, so the code can be more widely
> included in projects.

If you did plan to do this, it might be nice to include some 
representatives from groups that would be likely to use such a library.  
This might include the PAPI library developers, and there are various 
other tools (especially in the HPC area) who are coding to 
perf_event_open() directly but probably would like to use a library 
instead if possible.

Vince Weaver
vincent.weaver@maine.edu
