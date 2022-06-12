Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91E1547CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 00:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbiFLWTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 18:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiFLWSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 18:18:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F4C522DE;
        Sun, 12 Jun 2022 15:18:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so1250867wml.2;
        Sun, 12 Jun 2022 15:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0thwiCYGeXFypOTTdMenKsaCFbmk82Gcr6TnyVmb8yA=;
        b=pZWYIp2o5jCFoBnPd0Oq1Gia588evVxHniD8D40IWBC8rjn6+MwbMY2vvWTZkQ8ELf
         ayB4JSMONkqNN7VeGju1hmlZRR0m2sSKiMaP+XmwJqFXqciSx4m+GaNm/jWmC7oGqO/r
         mu4b9rEhjQ0syyFvpa7Nw6/4DP5P+Rp0sVZ831vnW3g6muxyXU3zoXPQ4SEiFX3P8Y6Q
         1CzWe3z8uCDZVZUSivsoUYe9SzauxPeKc7ZPVywanIKFsLAMVTRaECmAB+9whak1VM7i
         VmvScyZBYcWosp6d6+48KAcMdYRl4Hhv0s9XmheyVdG+dsLOIr/RcHJ5du0F7FiM2WSK
         w3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0thwiCYGeXFypOTTdMenKsaCFbmk82Gcr6TnyVmb8yA=;
        b=e5ejjc1PzaXpNpzHSWK7oswIEhdeu44Azz2mMGGqCJpJVGesnFzLjRoDIV2h5HzT+d
         hP65uNDASKVprO5X6oEyaguHfj/faMDX+YrsbCvPpeSjzcqgkZdZK54tCdoTZILZrDX4
         KcrwbZ2KuelWsbqCEahTvgvuiBjI6De5tMH731l1EqQRJUtOzmHmDKle3pAHtb/x8H6F
         VNyv+fAzZs7NsC1mu3O1Q/Ay9mEQXgsuP1bQ1AFNQ/ucrSgLIB22JBW4dlXoUVf38fSu
         mG56KvVV+DSpwlA1/LKZBgY+L5ZLWAmZqAzvWDmtBZMMUaN/leJO+s+ZfHO30oyeBWeC
         UVig==
X-Gm-Message-State: AOAM530TFLWHsRpJQA0keotAnwNphsyuK/8mh+HpTTnbRBxEj7b+qUpF
        j98st6LC74FJU+sgZW1eF00=
X-Google-Smtp-Source: ABdhPJy4r9gHhbJ80DPs5mRwEFIbQTdpXEVCPUijeTzMFrvkeKvn2p7VagcUJMQLXv58cR/kG7l4KA==
X-Received: by 2002:a7b:cc0d:0:b0:381:220e:a3a0 with SMTP id f13-20020a7bcc0d000000b00381220ea3a0mr11181132wmh.59.1655072332987;
        Sun, 12 Jun 2022 15:18:52 -0700 (PDT)
Received: from krava ([83.240.60.46])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d4247000000b0021018642ff8sm6602167wrr.76.2022.06.12.15.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 15:18:52 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 13 Jun 2022 00:18:49 +0200
To:     Blake Jones <blakejones@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Add a "-m" option to "perf buildid-list".
Message-ID: <YqZmSRS8UPQJzWFE@krava>
References: <20220607191550.4141024-1-blakejones@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607191550.4141024-1-blakejones@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 12:15:50PM -0700, Blake Jones wrote:
> This new option displays all of the information needed to do external
> BuildID-based symbolization of kernel stack traces, such as those collected
> by bpf_get_stackid(). For each kernel module plus the main kernel, it
> displays the BuildID, the start and end virtual addresses of that module's
> text range (rounded out to page boundaries), and the pathname of the
> module.
> 
> When run as a non-privileged user, the actual addresses of the modules'
> text ranges are not available, so the tools displays "0, <text length>" for
> kernel modules and "0, ffffffffffffffff" for the kernel itself.
> 
> This patch has been rebased as of this afternoon, but is otherwise
> identical to the version I sent out last month.
> 
> Sample output:
> 
> root# perf buildid-list -m
> cf6df852fd4da122d616153353cc8f560fd12fe0 ffffffffa5400000 ffffffffa6001e27 [kernel.kallsyms]
> 1aa7209aa2acb067d66ed6cf7676d65066384d61 ffffffffc0087000 ffffffffc008b000 /lib/modules/5.15.15-1rodete2-amd64/kernel/crypto/sha512_generic.ko
> 3857815b5bf0183697b68f8fe0ea06121644041e ffffffffc008c000 ffffffffc0098000 /lib/modules/5.15.15-1rodete2-amd64/kernel/arch/x86/crypto/sha512-ssse3.ko
> 4081fde0bca2bc097cb3e9d1efcb836047d485f1 ffffffffc0099000 ffffffffc009f000 /lib/modules/5.15.15-1rodete2-amd64/kernel/drivers/acpi/button.ko
> 1ef81ba4890552ea6b0314f9635fc43fc8cef568 ffffffffc00a4000 ffffffffc00aa000 /lib/modules/5.15.15-1rodete2-amd64/kernel/crypto/cryptd.ko
> cc5c985506cb240d7d082b55ed260cbb851f983e ffffffffc00af000 ffffffffc00b6000 /lib/modules/5.15.15-1rodete2-amd64/kernel/drivers/i2c/busses/i2c-piix4.ko
> [...]
> 
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  .../perf/Documentation/perf-buildid-list.txt  |  3 ++
>  tools/perf/builtin-buildid-list.c             | 33 ++++++++++++++++++-
>  tools/perf/util/dso.c                         | 23 +++++++++++++
>  tools/perf/util/dso.h                         |  2 ++
>  tools/perf/util/machine.c                     | 13 ++++++++
>  tools/perf/util/machine.h                     |  5 +++
>  6 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-buildid-list.txt b/tools/perf/Documentation/perf-buildid-list.txt
> index 25c52efcc7f0..a82e92c2667d 100644
> --- a/tools/perf/Documentation/perf-buildid-list.txt
> +++ b/tools/perf/Documentation/perf-buildid-list.txt
> @@ -33,6 +33,9 @@ OPTIONS
>  -k::
>  --kernel::
>  	Show running kernel build id.
> +-m::
> +--modules::
> +	Show buildid, start/end text address, and path of kernel and modules.

why 'modules' ? it shows all maps (including kernel)
so perhaps -m/--maps would be better?

also please state that it's from running kernel

SNIP

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 5ac13958d1bd..7c490b5ce449 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1227,6 +1227,19 @@ void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
>  	dso__set_long_name_id(dso, name, NULL, name_allocated);
>  }
>  
> +void dso__get_long_name(const struct dso *dso, char *name, size_t len)
> +{
> +	if (len == 0)
> +		return;
> +	if (dso->long_name == NULL) {
> +		name[0] = '\0';
> +		return;
> +	}
> +
> +	strncpy(name, dso->long_name, len);
> +	name[len - 1] = '\0';
> +}
> +
>  void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
>  {
>  	if (name == NULL)
> @@ -1359,6 +1372,16 @@ void dso__set_build_id(struct dso *dso, struct build_id *bid)
>  	dso->has_build_id = 1;
>  }
>  
> +void dso__get_build_id(struct dso *dso, struct build_id *bid)
> +{
> +	if (dso->has_build_id) {
> +		*bid = dso->bid;
> +	} else {
> +		bid->size = 0;
> +		memset(bid->data, 0, sizeof(*bid->data));
> +	}
> +}

any reason why not use the dso fields directly?

thanks,
jirka
