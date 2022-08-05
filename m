Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4BF58A9AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiHEKuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHEKuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:50:06 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662BD20F5C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 03:50:04 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id o123so2082867vsc.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 03:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DkJfNS8yu9hTLN+5Phv/RPZtG4O7PFVXdu2NG3JF7+A=;
        b=hwN2Bhk0h3DRVhy+82Xaj56myDpZ4Cvd4KpIoXH5dzub4cFkBIwdRKDm3auedTXxK6
         ZWjap5gcOyQg53wpCNw7OaT1ttVMzCVfZhssDhHpuNmvcydmARzwHwu2VIJ7EZTWTKdX
         z7IBaGwoQD7+gr2MkvJOO9ULItZzZ9uEfRuWmvE+3bei3YEZOiNgnCj23Wgqpvgb7eRk
         7pTzBViQemKU80gd+ptozXMqh7WlJST57Os/hBpI9pXA1roPT55dg5sDtV2L0vRiN1LC
         VWLPJJa03OhPvQKJU6F0YgNPDe1GSLTAn1lvFDdVyVpIHWZVEAJnCG9LM/dGRrPyauTz
         4kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DkJfNS8yu9hTLN+5Phv/RPZtG4O7PFVXdu2NG3JF7+A=;
        b=caOCWe+/pPViJrAS+rBFz0d228QoQJDbUFV7h6LCGXh6rNrBUKjQ3+Dbxdc7ZOtaNh
         6/VO6ixOkipUWNODymJmwyxgK6FgVkSvEEl/WsD6+EMLjTBQx2V3f3Y+H5NEN71V+rzz
         MSddMvYG4jtcXVgs9++c+lkLUWtZdLclJVn1bbL4CXNSTW1h0Q+qjzeGDUpX/aDVeY0O
         Vgj5mgewmve9U99TzwlpvsxPneXEjY03d7rJ2Ainuu9j6s5fzZncaTiBO/aoW/XDQUWt
         tEgAdbn2QQvPuAeegsaiE4LpMm/wwI+z8tlUtTSdMyyIFqHdQ9MXoqumGBkzAK+Z4Kbj
         dmow==
X-Gm-Message-State: ACgBeo1BLnA/lodmGf6zTK7QiZfPf49c08r2cP25aF+2DYgfR59XCkzJ
        TAnleCYE/TlB5fbuRp/Z/rtX9w5L5oQazk8q6o7Qum7UjQRyTYKY
X-Google-Smtp-Source: AA6agR4Iln9FYL4FJEiKi2rrDzfCuq40KAAkgkE347IH34UjWvKSkZHP2hdyvydw4BEDF1kGNO2dQ7/kxq8zIjvwL10=
X-Received: by 2002:a1f:b60f:0:b0:377:4f57:fb19 with SMTP id
 g15-20020a1fb60f000000b003774f57fb19mr2757585vkf.26.1659696592173; Fri, 05
 Aug 2022 03:49:52 -0700 (PDT)
MIME-Version: 1.0
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 5 Aug 2022 13:49:40 +0300
Message-ID: <CABPqkBTqQaaYH+ySu3reLm5i+X6P4BsqKycp8NBOP1gW3ZV4QA@mail.gmail.com>
Subject: [BUG] perf/x86/intel/pebs: PEBS timestamps overwritten
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com
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

Hi,

I was alerted by an internal user that the PEBS TSC-based timestamps
do not appear
correctly in the final perf.data output file from perf record.

After some investigation, I came to the conclusion that indeed the
data->time field setup
by PEBS in the setup_pebs_fixed_sample_data() is later overwritten by
perf_events generic
code in perf_prepare_sample(). There is an ordering problem here.

Looking around we found that this problem had been uncovered back in
May 2020 and a
patch had been posted then:
https://lore.kernel.org/lkml/e754b625-bf14-8f5f-bd1a-71d774057005@gmail.com/T/

However this patch was never commented upon or committed.

The problem is still present in the upstream code today.

1. perf_sample_data_init()
2. setup_pebs_fixed_sample_data(): data->time =
native_sched_clock_from_tsc(pebs->tsc);
3. perf_prepare_sample(): data->time = perf_event_clock(event);

The patch from 2020 (Andreas Kogler) fixes the problem by making the
assignment in 3.
conditioned to the value of data->time being 0. Andreas also suggested
an alternative which
would break up the call to perf_event_ouput() like this is done in the
BTS code allowing
the prepare_sample() call to be made before PEBS samples are
extracted. That would
generate some code duplication. Although this approach appears more
robust, the one
issue I see is that prepare_sample may need data that would be filled
by PEBS and
therefore it would  need to be called afterwards.

Any better ideas?
Thanks.
