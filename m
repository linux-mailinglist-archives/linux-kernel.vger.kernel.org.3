Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B96D47009B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbhLJM2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237629AbhLJM2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639139085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1x23hw8Xh2bIEhikdCCyTMnhqzuBopMfEMkyDyfoF0=;
        b=fgH8LLx/wIkycWXTNxauACy5p89icJUSSVquoKZQ+u7boD4gIxQg7nwsBwKCyAWuGMfZBK
        htuH4am/6cxHZ39E2f/uewFbpszjAfaRFZLc4Gdh5XvfR2cRcunDSfkNC7hIGCE8ILdTZp
        PFnWeXiJsHoeVjhvIQiMzan18S7R6uc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-GUr1gDBhODS-BDUnT8pWTA-1; Fri, 10 Dec 2021 07:24:44 -0500
X-MC-Unique: GUr1gDBhODS-BDUnT8pWTA-1
Received: by mail-wr1-f69.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so2218310wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 04:24:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W1x23hw8Xh2bIEhikdCCyTMnhqzuBopMfEMkyDyfoF0=;
        b=dPl7MIN5NdO97IY98/Ofmm46A4UPoSCvmWdy9Psohes82NoxUVeOPBZXNcYo1B5VN9
         h7gk92dTgGVMuvuvxeQ2QBi1FBtiqdrZlo7WOuHasJeXLiQx6PcyawOHW0EskPF7MANz
         b1FkTU/Fk3zEjAAO3JXQaUq44OZnbsp67KUeNvxd0fooEvlqgqD1Zz9fuhLLBtn+fOOQ
         kBsI1rRnmZloiylmLUNEGvxMx+B86U79D3+mVG1LhDtym/u4r0jil4xMEQlp3UnjywaH
         0D9ViXnW0CaZLnnv0NUbwyGGJKzrgA94gYYQWjMoQ0RX/ePw2MaQjv/Qgzm+E1byqUig
         MgOQ==
X-Gm-Message-State: AOAM533Q7mvYptCYDbDxR54WAePlRO2dulC68LV6kxi9OGDfywx10gxX
        qi6kTNrZSi6ep2hXpF7Ea+tj9KgkUQO38v21k43lqnXZ4y9TnHqCp4g+SfYsYRyPYuQvrQ6eYsa
        hz8SPOOW+AIQQbuZ7PptGvY/Z
X-Received: by 2002:a1c:2053:: with SMTP id g80mr16630143wmg.3.1639139083320;
        Fri, 10 Dec 2021 04:24:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRVslVuiU5VXV/8j0iX5UH7RwA4T5QNGKaFMPJ1ATyp3FM6RrhNd+8o3glX+gXHyj/MH6FxA==
X-Received: by 2002:a1c:2053:: with SMTP id g80mr16630115wmg.3.1639139083091;
        Fri, 10 Dec 2021 04:24:43 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id r17sm13135665wmq.5.2021.12.10.04.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:24:42 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:24:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC] perf record: Disable debuginfod by default
Message-ID: <YbNHCLi/OdMUfgI0@krava>
References: <20211209200425.303561-1-jolsa@kernel.org>
 <20211210080425.GO16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210080425.GO16608@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 09:04:25AM +0100, Peter Zijlstra wrote:
> On Thu, Dec 09, 2021 at 09:04:25PM +0100, Jiri Olsa wrote:
> > hi,
> > after migrating to fedora 35 I found perf record hanging on exit
> > and it's because fedora 35 sets DEBUGINFOD_URLS that triggers
> > debuginfod query which might take long time to process.
> > 
> > I discussed this briefly with Frank and I'm sending the change
> > to disable debuginfod by default in perf record.
> > 
> > Frank had other idea we could discuss here to fork or just spawn
> > "/usr/bin/debuginfod-find ...." into background after perf record.
> > 
> > Perhaps there are other ways as well, hence this is RFC ;-)
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > Fedora 35 sets by default DEBUGINFOD_URLS, which might lead
> > to unexpected stalls in perf record exit path, when we try
> > to cache profiled binaries.
> > 
> >   # DEBUGINFOD_PROGRESS=1 ./perf record -a
> >   ^C[ perf record: Woken up 1 times to write data ]
> >   Downloading from https://debuginfod.fedoraproject.org/ 447069
> >   Downloading from https://debuginfod.fedoraproject.org/ 1502175
> >   Downloading \^Z
> > 
> > Disabling DEBUGINFOD_URLS by default in perf record and adding
> > debuginfod option and .perfconfig variable support to enable id.
> > 
> >   Default without debuginfo processing:
> >   # perf record -a
> > 
> >   Using system debuginfod setup:
> >   # perf record -a --debuginfod
> > 
> >   Using custom debuginfd url:
> >   # perf record -a --debuginfod='https://evenbetterdebuginfodserver.krava'
> > 
> > Adding single perf_debuginfod_setup function and using
> > it also in perf buildid-cache command.
> 
> I'm still running with --no-buildid --no-buildid-cache or something like
> that by default. As long as that remains working I'm good.

you're good ;-) that will bypass the problem completely

jirka

