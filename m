Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D35B25BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiIHS2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIHS2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41B5F2D77;
        Thu,  8 Sep 2022 11:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 530EE61DA2;
        Thu,  8 Sep 2022 18:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82810C433C1;
        Thu,  8 Sep 2022 18:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662661715;
        bh=3AXjNts7Tbdp8pO716rrzrAZGO4quDSRXH9N7rRJviw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KrZz6L/ogWWO4c6AMpWK3rmHOJVLTjjJOlSDv0VnDKwaMjQkLJ0Wd9VfFb9biqsN6
         IyqKkAAspUF6ZMqmggHgxq8t1BC2IeBYBcwf/Rrr1w5FV6y3O/OcBG/PtURD8Cw/cn
         q6tHPzKM3wqxKbskIE6jiYtT9gQGhwV01tJkqZDCsqm0XdRPQcjnMI+Q0MO6NkTBRN
         Es3IRgrbIWoPMYRWFcHXJPmAWnoucUJhyVhR6d6Wz3r5xKTrdyRO12aRUNJQSWTbzv
         HP0nx31pVN495IzdRrjnqB7y9yn4cYd9fctCpknBtlSInczDGcrdDKN2Ag1L3/4Eml
         eacZdKfnfU2FQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 20613404A1; Thu,  8 Sep 2022 15:28:33 -0300 (-03)
Date:   Thu, 8 Sep 2022 15:28:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     zhengjun.xing@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        ak@linux.intel.com, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf script: Fix Cannot print 'iregs' field for hybrid
 systems
Message-ID: <Yxo0URZAZeZ0LsvS@kernel.org>
References: <20220908070030.3455164-1-zhengjun.xing@linux.intel.com>
 <Yxmmu6eyO/baR0Vo@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxmmu6eyO/baR0Vo@krava>
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

Em Thu, Sep 08, 2022 at 10:24:27AM +0200, Jiri Olsa escreveu:
> On Thu, Sep 08, 2022 at 03:00:30PM +0800, zhengjun.xing@linux.intel.com wrote:
> > From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > 
> > Commit b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems to
> > collect metadata records") adds a dummy event on hybrid systems to fix the
> > symbol "unknown" issue when the workload is created in a P-core but runs
> > on an E-core. The added dummy event will cause "perf script -F iregs" to
> > fail. Dummy events do not have "iregs" attribute set, so when we do
> > evsel__check_attr, the "iregs" attribute check will fail, so the issue
> > happened.
> > 
> > The following commit [1] has fixed a similar issue by skipping the attr
> > check for the dummy event because it does not have any samples anyway. It
> > works okay for the normal mode, but the issue still happened when running
> > the test in the pipe mode. In the pipe mode, it calls process_attr() which
> > still checks the attr for the dummy event. This commit fixed the issue by
> > skipping the attr check for the dummy event in the API evsel__check_attr,
> > Otherwise, we have to patch everywhere when evsel__check_attr() is called.
> > 
> > Before:
> > 
> >  #./perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf script -F iregs |head -5
> > Samples for 'dummy:HG' event do not have IREGS attribute set. Cannot print 'iregs' field.
> > 0x120 [0x90]: failed to process type: 64
> > 
> > After:
> > 
> >  # ./perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf script -F iregs |head -5
> >  ABI:2    CX:0x55b8efa87000    DX:0x55b8efa7e000    DI:0xffffba5e625efbb0    R8:0xffff90e51f8ae100
> >  ABI:2    CX:0x7f1dae1e4000    DX:0xd0    DI:0xffff90e18c675ac0    R8:0x71
> >  ABI:2    CX:0xcc0    DX:0x1    DI:0xffff90e199880240    R8:0x0
> >  ABI:2    CX:0xffff90e180dd7500    DX:0xffff90e180dd7500    DI:0xffff90e180043500    R8:0x1
> >  ABI:2    CX:0x50    DX:0xffff90e18c583bd0    DI:0xffff90e1998803c0    R8:0x58
> > 
> > [1]https://lore.kernel.org/lkml/20220831124041.219925-1-jolsa@kernel.org/
> > 
> > Fixes: b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems to collect metadata records")
> > 
> > Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo

