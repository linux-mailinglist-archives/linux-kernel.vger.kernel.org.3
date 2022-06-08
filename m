Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C011F543FDE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiFHXad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiFHXab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFD8E6F;
        Wed,  8 Jun 2022 16:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2992B61846;
        Wed,  8 Jun 2022 23:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92428C341C0;
        Wed,  8 Jun 2022 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654731029;
        bh=JhBUJH7UJ7YzJbS5s7M5LNboVA+5JyjOC/zBZKATNP0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XoCU+zXXXJObFHcWdpOsi1WC7pW90ou+3pcF1GUhGRkhYGzvgd5DCU7iaUeXFs7BE
         izUJz4Ih8OTEC61xtxpG8Zsk5jO/pn+/erGG9IsW3aJwEZTvr8F9zmYmpZFatklVBb
         eZHlGqlrmfH/+rsN1Ybgfl1fACHRe0/M9CWldpHGKv9CWqF0x6ZsFOgeiezWCnHAX9
         9UQ7YY4t1oJ6w0jaI+fUo+TAWXsl+JaYXA1J1fLyFH/oF/xpc68SnkDO7jT7Fbd86a
         GSnqwVyzwq4U21crD+ojqldiAD9xd7YU5mgPROMc9sLoGPDeXUfp+8591RIs6B+WKX
         JvnnWDQDzGFJQ==
Received: by mail-vs1-f54.google.com with SMTP id e20so1324960vso.4;
        Wed, 08 Jun 2022 16:30:29 -0700 (PDT)
X-Gm-Message-State: AOAM531J0mZDQ7C0i3HE9yUUFyLp6VzXC5Y5mgJE3ReGXiyko1fHnaCE
        hT8CvkBQI8rveME1vho7DXZfw7STWmmGjCtIjA==
X-Google-Smtp-Source: ABdhPJz9qUkXjwNK1P6U7jMx27s8M+dGn/UdU1Q4H9qmZqoFrBE+NAbEJXT9JV3I2QLq3XIuVEbvVXRxqKUkGeWevMs=
X-Received: by 2002:a05:6102:3117:b0:34b:ea03:5664 with SMTP id
 e23-20020a056102311700b0034bea035664mr4802963vsh.53.1654731028616; Wed, 08
 Jun 2022 16:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220608224353.1176079-1-irogers@google.com> <20220608224353.1176079-4-irogers@google.com>
 <CAL_JsqLUCkF_HwCyuWNZ2dw2Aw57RRfuKS8rqgnKQwQrvBwKiw@mail.gmail.com>
In-Reply-To: <CAL_JsqLUCkF_HwCyuWNZ2dw2Aw57RRfuKS8rqgnKQwQrvBwKiw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Jun 2022 17:30:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKPZnyV==cgadeJpy4NSgGUE3A1zfywMctWVGJRo4Tm7w@mail.gmail.com>
Message-ID: <CAL_JsqKPZnyV==cgadeJpy4NSgGUE3A1zfywMctWVGJRo4Tm7w@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf test: Remove x86 rdpmc test
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 5:29 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 8, 2022 at 4:44 PM Ian Rogers <irogers@google.com> wrote:
> >
> > This test has been superseded by test_stat_user_read in:
> > tools/lib/perf/tests/test-evsel.c
> > The updated test doesn't divide-by-0 when running time of a counter is
> > 0. It also supports ARM64.
>
> Jiri objected to this when I did the same thing[1] as 'perf test'
> doesn't run libperf tests.

NM, I just saw patch 4.

Acked-by: Rob Herring <robh@kernel.org>
