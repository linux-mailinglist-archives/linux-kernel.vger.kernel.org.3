Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148675B0B94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIGRit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIGRiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:38:46 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC7A80F7E;
        Wed,  7 Sep 2022 10:38:46 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1278a61bd57so19289306fac.7;
        Wed, 07 Sep 2022 10:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jrbDME+3IknpwK7T80xrbsU1d+5VCb9CXfVWDJjbDgQ=;
        b=j8xsYkhLvBrDxwqQ0n2Canlahf+hWyYkkqRxOVqC2mXM4y/eRAmA/qI3KqajTqrXCF
         HXqWm0zqpLu0rxPD3ID0c9VurAYAAZmM8N5H2GAt0R1iP9Ed8UUViPW81+m1vUHO6gPP
         KjMwHi5Bdq3HJRRJTcSRZ0jSYdLrNH9Iiw5CTsrI/javlJXEaP0HMlsTuUYB/9KJrbhz
         IWRsM34AJ6hGV2ssblTRAnMmiIJnx1mNolJHXpUEK1cLzJoU/6437+KD+lfm3c1OC6uX
         XnBqZTHh4PZytK90T4JvJo4l5CftBLUj/B2LM92IpSJy/eCyQME/biig/Z4LSLQZU/N+
         Ojwg==
X-Gm-Message-State: ACgBeo0ZMGIRFIYDV9yheD9xQ1QOYrPugkVm7ka4Q7ssB6DETS0snDsS
        2uUolOr0IlBMMMy2LqpwBnRtEcIBhDmy48DC3dMqqROy
X-Google-Smtp-Source: AA6agR7H9RtmXrxAWSU01huuRXY46j6q/NAqpkmfxgS1t91X3ic8OCvPFAuqLMdNvHhPew0USxOyyQfgMCptjfIQd1s=
X-Received: by 2002:a05:6808:d46:b0:345:7b42:f987 with SMTP id
 w6-20020a0568080d4600b003457b42f987mr2016690oik.92.1662572325466; Wed, 07 Sep
 2022 10:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220907064645.1197894-1-namhyung@kernel.org> <20220907064645.1197894-3-namhyung@kernel.org>
 <eea20a5c-df2a-979b-ff85-a7e2b978a4b8@intel.com>
In-Reply-To: <eea20a5c-df2a-979b-ff85-a7e2b978a4b8@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Sep 2022 10:38:34 -0700
Message-ID: <CAM9d7cgKwidyjWOH5uf-Y2BHF0VACOrR=fdXLz5szuzbHdVaaQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf test: Use a test program in perf record tests
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
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

Hi Adrian,

On Wed, Sep 7, 2022 at 3:45 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 7/09/22 09:46, Namhyung Kim wrote:
> > If the system has cc it could build a test program with two threads
> > and then use it for more detailed testing.  Also it adds initial delay
> > of 3ms to profile a multi-threaded target.  This change make the test
> > failing but that's what we want to check for now.
>
> So the delay is just to get a separate dummy event?

No, it's actually to wait for the new thread.

>
> I hit the issue from this patch:
>
> https://lore.kernel.org/lkml/20220711180706.3418612-1-kan.liang@linux.intel.com/
>
> That is, if I apply the patch above then the test passes, otherwise it fails always.

It's good to find/verify the bug with this :)

Thanks,
Namhyung
