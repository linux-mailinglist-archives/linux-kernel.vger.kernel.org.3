Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1C53D26B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349316AbiFCTgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbiFCTgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:36:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCD15C849;
        Fri,  3 Jun 2022 12:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF90619F3;
        Fri,  3 Jun 2022 19:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AB5C385A9;
        Fri,  3 Jun 2022 19:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654284993;
        bh=PIipzCaYUn8jR/p6zXFkr1WsMrGrkodj8HKg3HxhL2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NORF1TZtM0F4PZpUQA0ypmcp7EIVWVAuznfaVmmITGmpcrPRoeI7V33uVG36myLiX
         BfxIXESwuSYCtkAagct0bOoLAZy7vz9Am0XQRKasp/77ZKOtNbkVa5X+cZhLPwsIyy
         I/xiWl13NiFiv/xWEZmfiFRUlSsnrro9OXypFNMIZT+eVT+IQ+OtkX61tSxWgDosxo
         cPO5NkMK76/PER63KTsdIBOcwwU6QXpuafcnFzw19ju87h0Wbd2WKXIR/sqgSW0WL4
         iabIbC3SfsAH9ep0XcjCsZwPD8zTBsAUQPsXOgN1s8Mu0WRaGpNcCDCs5KONAql4zj
         SPAytw0syC4yg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 07C354096F; Fri,  3 Jun 2022 21:36:30 +0200 (CEST)
Date:   Fri, 3 Jun 2022 21:36:30 +0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH 1/2] perf list: Add IBM z16 event description for s390
Message-ID: <Yppivn4QJngi3t/o@kernel.org>
References: <20220530105657.2700635-1-tmricht@linux.ibm.com>
 <CAP-5=fVhNkG=Sg1RyCc4Lmgitnxw0xQOBpfpaxVOim+RBs+KiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVhNkG=Sg1RyCc4Lmgitnxw0xQOBpfpaxVOim+RBs+KiA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 31, 2022 at 07:56:04AM -0700, Ian Rogers escreveu:
> On Mon, May 30, 2022 at 3:57 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Update IBM z16 counter description using document SA23-2260-07:
> > "The Load-Program-Parameter and the CPU-Measurement Facilities"
> > released in May, 2022, to include counter definitions for IBM z16
> > counter sets:
> >   * Basic counter set
> >   * Problem/user counter set
> >   * Crypto counter set
> >
> > Use document SA23-2261-07:
> > "The CPU-Measurement Facility Extended Counters Definition
> >  for z10, z196/z114, zEC12/zBC12, z13/z13s, z14, z15 and z16"
> > released on April 29, 2022 to include counter definitions for IBM z16
> >   * Extended counter set
> >   * MT-Diagnostic counter set
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied the series.

- Arnaldo

