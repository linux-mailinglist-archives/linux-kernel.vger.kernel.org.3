Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B2E595226
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiHPFlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiHPFkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:40:53 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D13E74BB5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:28:53 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id v128so8505804vsb.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eWIMPcC8rYDUoL4i24r1Ay9EOFQlCfU2RuQLr3PwMF0=;
        b=slPWKfh1v9YKnzV3O0YOhDovrpXET34xFrRdNMmfE83qPHZTMM+ukV2bxTk5rnypPg
         Q9CNgQTqR8HdD1kdY0J/7oEFjzwyD1zs0mKN2bVCmjdYDH8zP2JeyohNQn6pQpElFxjO
         0gLCvC47W5bGpeCOJsCwEQwSN2dLdhDb34ibUDeiQOCDzIuGjzhWW81ruLPWz/UPy6SJ
         Ti1JHnDZYfo3c0uzN1Q6+D3uTFisp4gnPK19RYUSXKWyllHIFbQuGYcHx1w0C38p7y+S
         IXOPqUvyr5LC6YGerxWGTQWABIF2e/sjQZI9g0Me3f0yvV7YEeX2CWZUuOFZstnJIsSh
         EiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eWIMPcC8rYDUoL4i24r1Ay9EOFQlCfU2RuQLr3PwMF0=;
        b=zwAwOEOIs6AqSdWldmN+GRF2y2iyz53LdlgNSaqW5Oslb5OMGxpVGTxhLNMLtQy4xt
         VPqBYgM+apJKK2gzdg0SU1jlBiMLhivb7rm/d5Ybo0rrVSUcVa4gL6camfhKPnip9bhM
         lpnfpvF0OInAW3+PPHwVi/PL7/PhRKLKke+E0M2J1SSWHAYIpZxoH2u4wZyOsTTxF/uN
         YYLom1QloESNYfIc3axpVwlhUlt1MLT++JU4fpb9igIGSK661kp9CJ2o3O4F6MuUiHE+
         VtAauiVCeiaX0bB8+1wSsX97zEx5vsnK6QkDU4hBdX5W0jIaLAJN9BLnhRHQRMq7V7Az
         rs7g==
X-Gm-Message-State: ACgBeo0pQ4kT3bo8eHt5R0nQl+9gjwapFsd7RqSed5CEkjQy3Ui3u1S5
        Xf/94MP6G9RY3vC7FC6WUxteB2HIbRo+OvllbBpG4A==
X-Google-Smtp-Source: AA6agR4HPZrAIXN6EW/4MtdinTczw9qBIQC+HL3vsb7kMMNWm8akBESXxlFp8FvJSdExV4wQGFDh1RmKPo5TpcJdTtk=
X-Received: by 2002:a67:a408:0:b0:38a:dbca:760 with SMTP id
 n8-20020a67a408000000b0038adbca0760mr1767464vse.54.1660602528273; Mon, 15 Aug
 2022 15:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220803160031.1379788-1-eranian@google.com> <4cad9f06-f24d-a6e6-477b-5a00f64600ed@linux.intel.com>
In-Reply-To: <4cad9f06-f24d-a6e6-477b-5a00f64600ed@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 15 Aug 2022 15:28:36 -0700
Message-ID: <CABPqkBSGXwm_OFWt9tDq2WuXpuLtOJzekhiqH=c0_rOX6ZM2=g@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: fix broken read_counter() for SNB
 IMC PMU
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kan.liang@intel.com, ak@linux.intel.com, namhyung.kim@kernel.org,
        irogers@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 6:09 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2022-08-03 12:00 p.m., Stephane Eranian wrote:
> > Existing code was generating bogus counts for the SNB IMC bandwidth counters:
> >
> > $ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
> >      1.000327813           1,024.03 MiB  uncore_imc/data_reads/
> >      1.000327813              20.73 MiB  uncore_imc/data_writes/
> >      2.000580153         261,120.00 MiB  uncore_imc/data_reads/
> >      2.000580153              23.28 MiB  uncore_imc/data_writes/
> >
> > The problem was introduced by commit:
> >   07ce734dd8ad ("perf/x86/intel/uncore: Clean up client IMC")
> >
> > Where the read_counter callback was replace to point to the generic
> > uncore_mmio_read_counter() function.
> >
> > The SNB IMC counters are freerunnig 32-bit counters laid out contiguously in
> > MMIO. But uncore_mmio_read_counter() is using a readq() call to read from
> > MMIO therefore reading 64-bit from MMIO. Although this is okay for the
> > uncore_perf_event_update() function because it is shifting the value based
> > on the actual counter width to compute a delta, it is not okay for the
> > uncore_pmu_event_start() which is simply reading the counter  and therefore
> > priming the event->prev_count with a bogus value which is responsible for
> > causing bogus deltas in the perf stat command above.
> >
> > The fix is to reintroduce the custom callback for read_counter for the SNB
> > IMC PMU and use readl() instead of readq(). With the change the output of
> > perf stat is back to normal:
> > $ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
> >      1.000120987             296.94 MiB  uncore_imc/data_reads/
> >      1.000120987             138.42 MiB  uncore_imc/data_writes/
> >      2.000403144             175.91 MiB  uncore_imc/data_reads/
> >      2.000403144              68.50 MiB  uncore_imc/data_writes/
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
Any further comments?
Thanks.
