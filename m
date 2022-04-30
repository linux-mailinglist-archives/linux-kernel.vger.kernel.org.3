Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1D1515EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbiD3PbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbiD3PbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:31:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB997C16C;
        Sat, 30 Apr 2022 08:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1213BB801BB;
        Sat, 30 Apr 2022 15:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D99C385AA;
        Sat, 30 Apr 2022 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651332460;
        bh=ktq6ArWYPGudC0rcXaYJ0qmScMGjIlhCR6GGEPH25Y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQJgYvk7yMNItAYVxK43lg6tBeTnI1Sv3SuZEzmVQ+lY1PCdiqizU8JbJO7kyuCkz
         XFh1vASdqdvd8s5ympKDPkIA7l6gq6yP9Twq0b6V4RHauXMbPlHd4GNE9B5p4eqfUE
         ZAeSeGw8EoAPuh0KZybqCBTRnNynp4MppMrk5B2gcse0aFTzIzN9XhFihmtbkyxgfn
         K+oNglLymG2t63MnD1TmL06hMsAenxq0oFsp/6TfO3BsAtaoU/0xnfbOaUbInaA3aT
         uYxSadkuRT3Y03njdVRuke0oAQ6GQEnNjPxdPrj+otLyuxJT19gz73egkUgq67D5qw
         kZ+OBs8omMQCg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 832AB400B1; Sat, 30 Apr 2022 12:27:37 -0300 (-03)
Date:   Sat, 30 Apr 2022 12:27:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf bench: Fix two numa NDEBUG warnings
Message-ID: <Ym1VaeThOhHHkW8h@kernel.org>
References: <20220428202912.1056444-1-irogers@google.com>
 <FDBE8FEC-CC4B-43C2-B2AA-3ECCFF95A98E@linux.vnet.ibm.com>
 <CAP-5=fVr2Egp=_vw1nHc1QN4T4uLaGygQGQuvTRpaA-hFR8uOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVr2Egp=_vw1nHc1QN4T4uLaGygQGQuvTRpaA-hFR8uOg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 29, 2022 at 06:58:22PM -0700, Ian Rogers escreveu:
> On Fri, Apr 29, 2022 at 2:21 AM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
> >
> >
> >
> > > On 29-Apr-2022, at 1:59 AM, Ian Rogers <irogers@google.com> wrote:
> > >
> > > BUG_ON is a no-op if NDEBUG is defined, otherwise it is an assert.
> > > Compiling with NDEBUG yields:
> > >
> > > bench/numa.c: In function ‘bind_to_cpu’:
> > > bench/numa.c:314:1: error: control reaches end of non-void function [-Werror=return-type]
> > >  314 | }
> > >      | ^
> > > bench/numa.c: In function ‘bind_to_node’:
> > > bench/numa.c:367:1: error: control reaches end of non-void function [-Werror=return-type]
> > >  367 | }
> > >      | ^
> > >
> > > Add return statements to cover this case.
> >
> > Looks fine to me
> >
> > Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >
> > Thanks
> > Athira
> 
> Thanks Athira :-) Arnaldo, could we get this in the 5th batch for 5.18
> to keep NDEBUG building? It looks like there is a missing build test
> for NDEBUG too.

Applied to perf/urgent.

Thanks,

- Arnaldo
