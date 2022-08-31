Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A015A8317
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiHaQXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiHaQXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:23:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA31FB8F17;
        Wed, 31 Aug 2022 09:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86FE6B821E9;
        Wed, 31 Aug 2022 16:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B16C433C1;
        Wed, 31 Aug 2022 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661963019;
        bh=s4ZnyYFgcInCvOCjgne4QMp3TXQXWzIDpG5ht9awzQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQgFp1yHlNlnmr52zVf/DzIVvIWI8nMKw5/Wd5j9W7VjkldvEz8XUVE2IfSSYRIue
         Kj+U8w/pytPp+7R+FmScuSmjZ6+upZ0eQJIKHhagz/MkDrH3X6wT3Ea/2+1ZN+dCDH
         sBCfDAsmofDnQe/5e5LduszeDhL3z++N3aOIpXmV2F7wnCd7n1DtAzkVsJCPQpOC5J
         Foc6+xstN4S6b6mZPi085eW9j0QJena618nWbqxSX5y/0xxzUBJlaxn9q99GJboKHU
         v1PWY2fDU2DJRZ6PlpP43ua7vpXNfRNWhSorwoMeOtd/vFXjXb44ixDaCHL9GSiG2x
         ltmOJMU6K8/uQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 67AB6404A1; Wed, 31 Aug 2022 13:23:36 -0300 (-03)
Date:   Wed, 31 Aug 2022 13:23:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Hongtao Yu <hoy@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf script: Skip dummy event attr check
Message-ID: <Yw+LCN2cX9peweWV@kernel.org>
References: <20220831124041.219925-1-jolsa@kernel.org>
 <CAP-5=fX-=ph8g3VKbQXSRT8SiOZ3XqQLd3T9-ZTNZ5L+ye5L-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX-=ph8g3VKbQXSRT8SiOZ3XqQLd3T9-ZTNZ5L+ye5L-A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 31, 2022 at 09:02:46AM -0700, Ian Rogers escreveu:
> On Wed, Aug 31, 2022 at 5:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Hongtao Yu reported problem when displaying uregs in perf script
> > for system wide perf.data:
> >
> >   # perf script -F uregs | head -10
> >   Samples for 'dummy:HG' event do not have UREGS attribute set. Cannot print 'uregs' field.
> >
> > The problem is the extra dummy event added for system wide,
> > which does not have proper sample_type setup.
> >
> > Skipping attr check completely for dummy event as suggested
> > by Namhyung, because it does not have any samples anyway.
> >
> > Reported-by: Hongtao Yu <hoy@fb.com>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf/urgent.

- Arnaldo
