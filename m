Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782225638BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiGARtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGARtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:49:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E1A38DB1;
        Fri,  1 Jul 2022 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JKTGayWcHy1CRY5akoOpVqKPvu3lbbkaXvrXRBSaOY8=; b=D7BeEFa01MXEbrmVsMP7njCwS7
        vwZubJZnPr6xb2EL/94sSz+dg0Cnhchm0ZVNk0uAJq6thBRmQ8IwCtIDhMqtNxaqG4zdExk9+6m4a
        4GWXpfQ3s7CEce69EdP3XXG5wwFFYiBlMEUNKXnW14z37a3Am5JrfoFv7TPAxOeU7fi9UiDna906g
        MxRG02tAKoYAdGEKnRd068+G0a8EPLYdY4b5m6s0mXyT55RYgxvSeOWpXfRO72P3hAf7SxuCVceFI
        R8sdiKrcMfBUcXau93UyeC2kSRy/kqMLiIdB0jUc5A/rHAMpZShtXV3Pu362d1mm0aSPPHQo0lW1V
        qJK09ulA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7KlS-006HP9-8e; Fri, 01 Jul 2022 17:49:10 +0000
Date:   Fri, 1 Jul 2022 10:49:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] kmod 30
Message-ID: <Yr8zlqicFErzw0dc@bombadil.infradead.org>
References: <20220630153621.3fggpqrbyvunhwfu@ldmartin-desk2>
 <Yr4fHBR08VAVbs2E@bombadil.infradead.org>
 <20220630223323.2hko2imx62embtsj@ldmartin-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630223323.2hko2imx62embtsj@ldmartin-desk2>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 03:33:23PM -0700, Lucas De Marchi wrote:
> On Thu, Jun 30, 2022 at 03:09:32PM -0700, Luis Chamberlain wrote:
> > Sorry for the super late review, I was swamped. OK so the only issue
> > I can think of is that rmmod *used* to support the kernel wait support
> > with $(rmmod --wait) so wouldn't this be odd?
> 
> any reason not to use modprobe -r? 

I was referring to old scripts which may have used $(rmmod --wait) before.
But since support for that was ripped, then yeah I can see that should
not be an issue.

However I can think of *one* issue, did we ever support `modprobe--wait`?

Because the way fstests / blktests would implement this feature
detection is with something like this now:

_has_modprobe_patient()
{
	modprobe --help >& /dev/null || return 1
	modprobe --help | grep -q -1 "remove-patiently" || return 1
	return 0
}

> > It is why I had gone with:
> > 
> > -p | --remove-patiently   patiently removes the module
> > -t | --timeout            timeout in ms to remove the module
> > 
> > You would know better though.
> > 
> > Also just curious, is it really terrible to just support waiting
> > forever?
> 
> is there a use case for that? If we are trying to cover some races, I
> imagine a small timeout would be sufficient. Also notice that if the
> timeout is too big, so will be the interval between the retries.  On
> your v2 I had suggested polling the refcnt so we would get notificed
> on changes, but as you also noticed, that didn't work very well.  So I
> went back to a time-based retry solution.
> 
> if there is a use-case, should we cap the interval between retries?

I really can't think of a use case except for catching glaring
unexpected bugs in test suites where the kernel developer would
really like to know something really bad happened, but even then
a timeout is likely desirable.

So just a heads up the timeout I'll use for fstests / blktests will be
of 100 seconds.

Thanks for this work!

  Luis
