Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F93557AA35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiGSXFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiGSXFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643361D325;
        Tue, 19 Jul 2022 16:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA1660B9B;
        Tue, 19 Jul 2022 23:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1B9C341CA;
        Tue, 19 Jul 2022 23:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658271917;
        bh=acpogfiT0Rz/iQDq4kUYuCBJDK04Pn/8AVV/GYIONIg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Iau5OevoPImRiDNlrcokKUTDU9mSp6QAUljMLWgxFSawBStAp7FSFq9DXCjqLGnTw
         SkqEgNL6CG94b2DEfWA6t1A09Ff1mMX6TOWKYnGs9roz1LHWZjnoKBsJlrNGdc1+Jp
         W2u2MenzzWMYcLnsslAPfrRkaGGwEwemPQqy0UMIOBPXqu7F6PNDxhDgaw0WjtDPdQ
         TM/uxEuuMOlE4iLGLkzEz9PSOlc8xJCe3dxzcTTpEm4b1RqWgesbt344W5iLfVT35T
         R+serKLRKdr/y7LbcvZT3kuSsQykbWPK+L0Vv8PBxrCYOTj+Farr/ALlPPNEotAuje
         Dy/R68wEIW//w==
Received: by mail-vs1-f54.google.com with SMTP id 125so14821524vsx.7;
        Tue, 19 Jul 2022 16:05:17 -0700 (PDT)
X-Gm-Message-State: AJIora/3cUWcPlcsVDoJO+NRAYBG9lUVjZ2AaJuEP4ON6MQcYo5DW/av
        2Ejit6wqLhwoDAs/+2smB7f4iIxBXH5bdMHCbw==
X-Google-Smtp-Source: AGRyM1uiOXG2R5gTxbDB3ECA/Q3Z4+GwWJhu9FBeWD/KUjbXlrFw8bsP0Ji0ATj7KG7E7hNkkn1qmkEIfb/Ce8queD0=
X-Received: by 2002:a67:c088:0:b0:358:bb1:fdf7 with SMTP id
 x8-20020a67c088000000b003580bb1fdf7mr1604934vsi.85.1658271916380; Tue, 19 Jul
 2022 16:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220719223946.176299-1-irogers@google.com> <20220719223946.176299-2-irogers@google.com>
In-Reply-To: <20220719223946.176299-2-irogers@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Jul 2022 17:05:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK8jHLCj=iYF+qB0KsDSy-+X74Ero6c=jWMcJduk7aGeQ@mail.gmail.com>
Message-ID: <CAL_JsqK8jHLCj=iYF+qB0KsDSy-+X74Ero6c=jWMcJduk7aGeQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf: Align user space counter reading with code
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
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 4:39 PM Ian Rogers <irogers@google.com> wrote:
>
> Align the user space counter reading documentation with the code in
> perf_mmap__read_self. Previously the documentation was based on the perf
> rdpmc test, but now general purpose code is provided by libperf.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/uapi/linux/perf_event.h       | 35 +++++++++++++++++----------
>  tools/include/uapi/linux/perf_event.h | 35 +++++++++++++++++----------
>  2 files changed, 44 insertions(+), 26 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
