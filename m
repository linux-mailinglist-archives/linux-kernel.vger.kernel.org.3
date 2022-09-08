Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAEA5B2678
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiIHTJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIHTJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:09:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AF15C948
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:09:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8854EB821A0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 19:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226D2C433C1;
        Thu,  8 Sep 2022 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662664150;
        bh=vNzljt5FMICCsVcWg3WJzFLSG2fTvM/8p1t/BZOu1O4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0+KWW5p0jaqbvbWr9brr+SmzmcO6SDRe/V+rnrPpKqCS6P5IHhN/XgwnkLTpaDgd
         QBYzmVKyjDPUG9lojow2p9y9G06cXK8XXAfQeP7lMKQBw2ffmp1JZeguYDdaAbUqHp
         HF3HGaYe0eYJgkZ43zzsofxm3GvN+HyV0OSqEsucDWnDhlln/fMPb0ECpZiYJAkqv+
         2xwVWYK/nQufY5hOP3CRXwkMGPlfT8Z4DZ/88dphIlmA58RUHlFRDvDTO8Xw/UbmyH
         00PsWhQxIU34/9OSkX582uTBKKVu0Zr0ZrT8yq3FEVFOOJW0zHSI76F05Exa2UMkN0
         uGjfPRCc0rqHQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D2E23404A1; Thu,  8 Sep 2022 16:09:07 -0300 (-03)
Date:   Thu, 8 Sep 2022 16:09:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 0/6] perf intel-pt: Support itrace option flag d+e to
 log on error
Message-ID: <Yxo903EQ74Xl94DR@kernel.org>
References: <20220905073424.3971-1-adrian.hunter@intel.com>
 <YxdFfVbDcwnT7DXm@kernel.org>
 <CAM9d7cg8fTPTSzcZiwgQE4eF6HdpkuZ+YkQ=fAb+iB80V8nQEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg8fTPTSzcZiwgQE4eF6HdpkuZ+YkQ=fAb+iB80V8nQEw@mail.gmail.com>
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

Em Tue, Sep 06, 2022 at 10:24:03AM -0700, Namhyung Kim escreveu:
> HI Arnaldo,
> 
> On Tue, Sep 6, 2022 at 6:05 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Mon, Sep 05, 2022 at 10:34:18AM +0300, Adrian Hunter escreveu:
> > > Hi
> > >
> > > Here are a few patches to add the ability to output the decoding debug log
> > > only when there are decoding errors.
> > >
> > > This is motivated by the fact that a full log can be very large, so just
> > > getting interesting bits is useful for analyzing errors.
> > >
> > > If necessary, the size of output on error is configurable via perf config,
> > > and perf_config_scan() was added in the 1st patch to make that simpler.
> > >
> > > The 2nd patch adds the new option flag to auxtrace.
> > >
> > > There are a couple of very minor and essentially unrelated changes in
> > > patches 3 and 4.
> > >
> > > The main Intel PT change is in patch 5 and there is a small example in the
> > > commit message.
> > >
> > >
> > > Changes in V2:
> > >
> > >       perf intel-pt: Support itrace option flag d+e to log on error
> > >       Ensure log_buf is defined before use
> > >
> > >       perf intel-pt: Remove first line of log dumped on error
> > >       Remove first line only if the buffer has wrapped
> >
> > Applied locally, Namhyung: I think your review comment was addressed,
> > right? If so can I add your Reviewed-by to all the patches in this
> > series?
> 
> Sure,
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks, added.

- Arnaldo

