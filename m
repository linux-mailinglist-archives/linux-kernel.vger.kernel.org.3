Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4828F59C0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiHVNuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiHVNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:50:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D025E26104;
        Mon, 22 Aug 2022 06:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4A5DECE12D4;
        Mon, 22 Aug 2022 13:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCD5C433D7;
        Mon, 22 Aug 2022 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661176202;
        bh=PkPJyZp0RJEudQRyQhF1AVCrZqBQGaVx6WsnuFkdofY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DaE7Ix7iJ+WK0FJur7tmTaCv1JRfa4OFhEEW4D0zxXr2yLuZ7ij78PFz7ogP1RVab
         6bNZB4LSBD8L5dD9kskxMLrzPglQc4S0sEqzVC22/XnhRxdZRc97jHMAFCiDfGHMEa
         5S55Nzj+phrBYvGv5vX7h5EZKmQrOCplwB3Cl7uwg59aL8lfrHZjg8XIQMTyGmx8Ed
         aI7nUjKiEiaOEFWYM2oqlXKHLsAk7VrT468Jqc7WkF3larrIfg56Q3HQBpSbMqvYEu
         3AolSIlNN9cjGMD2Yw48mXAGi94hb8ev8jITIIc6ucIED1opyYbWlBcBBDHwRgtNd3
         baR8iKjy7UarA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1650E404A1; Mon, 22 Aug 2022 10:50:00 -0300 (-03)
Date:   Mon, 22 Aug 2022 10:50:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: python: Fix build when PYTHON_CONFIG is user
 supplied
Message-ID: <YwOJiBG+K877d+Ou@kernel.org>
References: <20220728093946.1337642-1-james.clark@arm.com>
 <CAP-5=fXnR=LSk-bO02V7HzWTTCrsbnM1w63_YYqSMEgy0vM-PQ@mail.gmail.com>
 <YuLi14u3DQ+ShH9w@kernel.org>
 <f64f6cbf-73cf-e59a-5f6d-7303125bee66@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f64f6cbf-73cf-e59a-5f6d-7303125bee66@arm.com>
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

Em Mon, Aug 22, 2022 at 11:08:37AM +0100, James Clark escreveu:
> 
> 
> On 28/07/2022 20:26, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jul 28, 2022 at 09:37:32AM -0700, Ian Rogers escreveu:
> >> On Thu, Jul 28, 2022 at 2:40 AM James Clark <james.clark@arm.com> wrote:
> >>>
> >>> The previous change to Python autodetection had a small mistake where
> >>> the auto value was used to determine the Python binary, rather than the
> >>> user supplied value. The Python binary is only used for one part of the
> >>> build process, rather than the final linking, so it was producing
> >>> correct builds in most scenarios, especially when the auto detected
> >>> value matched what the user wanted, or the system only had a valid set
> >>> of Pythons.
> >>>
> >>> Change it so that the Python binary path is derived from either the
> >>> PYTHON_CONFIG value or PYTHON value, depending on what is specified by
> >>> the user. This was the original intention.
> >>>
> >>> This error was spotted in a build failure an odd cross compilation
> >>> environment after commit 4c41cb46a732fe82 ("perf python: Prefer
> >>> python3") was merged.
> >>>
> >>> Fixes: 630af16eee495f58 ("perf tools: Use Python devtools for version autodetection rather than runtime")
> >>> Signed-off-by: James Clark <james.clark@arm.com>
> >>
> >> Acked-by: Ian Rogers <irogers@google.com>
> > 
> > Thanks, applied.
> 
> Hi Arnaldo,
> 
> I couldn't find this change in any of your branches. Do you know if it
> got dropped somehow or was there an issue with it?

Applied it to my local perf/urgent branch, testing now. I thought I had
processed it, not really :-\

- Arnaldo
