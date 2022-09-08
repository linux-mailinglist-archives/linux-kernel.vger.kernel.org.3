Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4955B1566
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiIHHI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiIHHIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:08:23 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C79DA1D54;
        Thu,  8 Sep 2022 00:08:18 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1279948d93dso22228760fac.10;
        Thu, 08 Sep 2022 00:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RhnrPpOs8U7U5e/dDJlH9qsFhHWq2idwdbhm4KgyDo4=;
        b=lYW3S3bB/fE704zu/ErhyTkBvFw+M4YZOzIBsKsTTBUTSQeZsgEcanqEm1gbvDCgao
         3Vtl/tLIdz8pGuIu57x+oBCHoe1zNsqRAeMLFY2D+ofTEoPJR8OIsbQD8dAZd2iiLUGG
         UGaEV/cogSLnpOb/qh1GySGkXbvUGKybj16Dl+rHsHnCbBOPN45NtWScVUyXJiDbSRk4
         CIKUgWSUTAm0nvCLGbUkbyfbH20bljJu8+iownsPZLFcT+/KeR3Ak6LTbcjrqwVccqrA
         gTIBUHMnee69//hg8rYKewfcubvaWRQBU6RZtnBQoRyUnN+1vt50zsGm2M9lpj0bLVjQ
         KB4w==
X-Gm-Message-State: ACgBeo3FwqW2DcmWRAHG2GRjfFZio6Grt+WWwvyTcoFnh15tCyCDnYh1
        O9+wrpwdO31dWPh7yi7yjyeOeauUzNoC9iteHYs=
X-Google-Smtp-Source: AA6agR5OR9+PcRlakwJ5yROIppbvT89qJRBPOVNcKbTPRIqlXsnSpnWcnzUjTp+kb2uksFNQ1ock3rtw8nvbvjtuvGg=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr1158961oab.92.1662620897764; Thu, 08
 Sep 2022 00:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220908021141.27134-1-shangxiaojing@huawei.com>
In-Reply-To: <20220908021141.27134-1-shangxiaojing@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 8 Sep 2022 00:08:06 -0700
Message-ID: <CAM9d7cgOVSohQ6cLnPc3QJZ9aus_pq8xjiRf8WRy8WOuaogoTQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf: Clean up by adding helpers
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
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

Hello,

On Wed, Sep 7, 2022 at 6:37 PM Shang XiaoJing <shangxiaojing@huawei.com> wrote:
>
> Some clean up in builtin-lock.c, builtin-timechart.c, and
> builtin-trace.c.
>
> Shang XiaoJing (4):
>   perf trace: Use zalloc to save initialization of syscall_stats
>   perf lock: Add get_key_by_aggr_mode helper
>   perf timechart: Add create_pidcomm helper
>   perf timechart: Add p_state_end helper

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  tools/perf/builtin-lock.c      | 129 ++++++++++++++-------------------
>  tools/perf/builtin-timechart.c |  65 +++++++++--------
>  tools/perf/builtin-trace.c     |   5 +-
>  3 files changed, 88 insertions(+), 111 deletions(-)
>
> --
> 2.17.1
>
