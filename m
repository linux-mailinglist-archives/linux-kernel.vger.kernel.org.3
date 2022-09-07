Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AC05B0BB7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiIGRoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiIGRoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:44:32 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6195BFDD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:44:24 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-11e9a7135easo37861177fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lqZyZGmrh/rn893VNBpt4UlIfU6KNr8EF05UjLPCWhY=;
        b=DdNuNiBxlY37uQPhLRrmtkrcrshRTEzsmGz1F3daor52CJvJ1tUEVsC+1DwM6iVIdv
         7j0AxHaENf+vvaad1ZI38CDADNxCsGAmspru5v3E6gGESWhDIT6+2KDYKgZtZLIkzcAk
         +d6CAFS1ltohJPiZb+8O4c+bLk7SEUrGDwKEsYnXrtJtqAu5dYf3LirF1AcmTb2aj9eb
         V1PIVAqy7vaE6FMYQ1fAOIyVnpC7lyqGcftkA8sYm+VJMlijxvhTBYLdzJe1sJJMrnl5
         3vdeMeeOC/dciIASKY5SQ0RfA119WR0p2OUZn6O5jqjxkjdQp2mYfXK/4E19oDD+Q/E2
         ZK/Q==
X-Gm-Message-State: ACgBeo3MTgbhLjVZbggbzr/av8/0T90UYHLRb0Re9ISmiaBR8AL964rX
        UkF396/oyspJg2Mno3xQaLtDPBGHtBxEBxBQKZlxfq7xzAU=
X-Google-Smtp-Source: AA6agR5Tww5c9RcGH1b4fX5WRnDJKMvbV4jvwF0oYF5Y5fvxoW3ltF8vCs0ZaGyqj9sGysrlpdBcGDOHUv0Di0MdeLw=
X-Received: by 2002:a05:6870:a184:b0:116:bd39:7f94 with SMTP id
 a4-20020a056870a18400b00116bd397f94mr15322436oaf.5.1662572664089; Wed, 07 Sep
 2022 10:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220907154904.70883-1-adrian.hunter@intel.com>
In-Reply-To: <20220907154904.70883-1-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Sep 2022 10:44:13 -0700
Message-ID: <CAM9d7cjFMSxA_E_EqAVpJeCYy0+78jsi2W1+cX-e7YAZuDKV3Q@mail.gmail.com>
Subject: Re: [PATCH] perf script: Fix sample type validation of dummy events
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 8:49 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Dummy events need the sample type only for ID samples and we expect perf
> to set up their sample type correctly for that purpose. Consequently
> there is no reason to attempt to validate the sample type against
> user-specified fields like 'iregs'.
>
> So skip sample type validation for dummy events.
>
> Example:
>
>  Before:
>
>    $ perf record --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p,dummy -c 1000 uname
>    Linux
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.017 MB (18 samples) ]
>    $ perf script -F ip,sym,iregs
>    Samples for 'dummy' event do not have IREGS attribute set. Cannot print 'iregs' field.
>
>  After:
>
>    $ perf script -F ip,sym,iregs
>     ffffffffabf816f0 perf_iterate_ctx ABI:2    CX:0x0    DX:0xffffab5802bbfb60    DI:0xffff9f5e8a2a0800    R8:0x1
>     ffffffffabe034a0 x86_pmu_filter_match ABI:2    CX:0x0    DX:0xffffab5802bbfc68    DI:0xffff9f5fc7ad0ba0    R8:0xffff9f5fbf0504a0
>     ffffffffabe315c0 fpregs_assert_state_consistent ABI:2    CX:0x0    DX:0x0    DI:0xffffffffad0e77f1    R8:0x0
>     ffffffffabf90260 perf_event_mmap ABI:2    CX:0x0    DX:0xffffffffabfcedc0    DI:0xffff9f5fbf050540    R8:0x0
>     ffffffffabee76c0 __rcu_read_unlock ABI:2    CX:0x70    DX:0xffff9f5e812a300c    DI:0x7    R8:0xffffffffadc93aa0
>     ffffffffac85a1a0 debug_smp_processor_id ABI:2    CX:0x0    DX:0xffffab5802bbfd28    DI:0xffffffffad0e77f1    R8:0xffff9f5f69b869e0
>     ffffffffac0178e0 policy_nodemask ABI:2    CX:0x7fc123152000    DX:0xffffffffadc8ac80    DI:0x100cca    R8:0x0
>         7fc1231880d0 add_to_global_resize ABI:2    CX:0x7fc1231b7650    DX:0x7ffd7e896168    DI:0x5635ea713b0c    R8:0x7fc12317aa50
>     ffffffffabfcecc0 vmacache_update ABI:2    CX:0xffff9f5f69ab8000    DX:0xffff9f5f69b861a0    DI:0x7fc123055480    R8:0x0
>     ffffffffac85a1a0 debug_smp_processor_id ABI:2    CX:0x0    DX:0x0    DI:0xffffffffad0e77f1    R8:0x1
>     ffffffffac85a1a0 debug_smp_processor_id ABI:2    CX:0x0    DX:0xffffab5802bbfdb8    DI:0xffffffffad0e77f1    R8:0xffff9f5f69b86e60
>     ffffffffac00c120 PageHeadHuge ABI:2    CX:0x53    DX:0xf    DI:0xffffe312c47c1740    R8:0xffff9f5e83cb66c8
>     ffffffffabea1530 preempt_count_add ABI:2    CX:0xffffe312c886aa40    DX:0x5635eb38a    DI:0x1    R8:0x0
>     ffffffffabfedb90 flush_tlb_batched_pending ABI:2    CX:0x103a68067    DX:0x1    DI:0xffff9f5e80262c00    R8:0xffffab5802bbfd90
>     ffffffffabfe7340 __tlb_remove_page_size ABI:2    CX:0x25    DX:0x1000    DI:0xffffab5802bbfe00    R8:0x33f905025
>     ffffffffabfee490 page_remove_rmap ABI:2    CX:0x25    DX:0x0    DI:0xffffe312c4581e00    R8:0x116078025
>     ffffffffac85a1a0 debug_smp_processor_id ABI:2    CX:0x40    DX:0x8    DI:0xffff9f622042a540    R8:0x1
>     ffffffffabe6be00 vm_area_free ABI:2    CX:0x8015000f    DX:0x80000000    DI:0xffff9f5fbf050000    R8:0x1
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Please see https://lore.kernel.org/all/20220831124041.219925-1-jolsa@kernel.org/

Thanks,
Namhyung


> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 585171479876..eb263cdf51ee 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -411,7 +411,7 @@ static int evsel__do_check_stype(struct evsel *evsel, u64 sample_type, const cha
>         int type = output_type(attr->type);
>         const char *evname;
>
> -       if (attr->sample_type & sample_type)
> +       if (evsel__is_dummy_event(evsel) || attr->sample_type & sample_type)
>                 return 0;
>
>         if (output[type].user_set_fields & field) {
> --
> 2.25.1
>
