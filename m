Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE79515EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380252AbiD3PiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbiD3PiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420D480223;
        Sat, 30 Apr 2022 08:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDB6260DEF;
        Sat, 30 Apr 2022 15:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0436AC385AA;
        Sat, 30 Apr 2022 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651332895;
        bh=mHqTfyw1rl5o0qunHYn2UM5Ou+e7UGSlfQd4cbqtYV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1RThICwPSkH8Fe4YfZtPOzVvtPKBQQ4yZWdx+z8HGgO6jOajbL6JKq06/QQc7Aru
         BT9SSU89N6aglReKaHj0NoUTE8p1XUquR+9qHjjLbkKdbegd2qNuUT6rDbqdlirv9X
         MaLjns8EVN46ni1wJmOYr1L6R7Ow74mMvhSLWbP6hlf2I1C14it0MXXpeT6xXL2MTd
         CGzrj4zBW8fEEIXuV/q/0S7NXrDKTTd4KIH7SanakJKP/aMFsMYMF6udcZWvGIY1FM
         0xfUVujzwEEp03O2f9v3wuWX2ndWMUOtZl8ivqxpHxnfw2yPztSFt6LcwxlGZMTuI4
         5j6FWVoXMxTQQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A3641400B1; Sat, 30 Apr 2022 12:34:52 -0300 (-03)
Date:   Sat, 30 Apr 2022 12:34:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests: Fix coresight `perf test` failure.
Message-ID: <Ym1XHMSoPHZicbTa@kernel.org>
References: <20220428151947.290146-1-jeremy.linton@arm.com>
 <93e36dac-47d4-1e2b-6cb1-0092a5371810@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93e36dac-47d4-1e2b-6cb1-0092a5371810@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 28, 2022 at 05:14:09PM +0100, James Clark escreveu:
> 
> 
> On 28/04/2022 16:19, Jeremy Linton wrote:
> > Currently the `perf test` always fails the coresight test like:
> > 
> > 89: Check Arm CoreSight trace data recording and synthesized samples: FAILED!
> > 
> > That is because the test_arm_coresight.sh is attempting to SIGINT the
> > parent but is using $$ rather than $PPID and it sigint's itself when
> > run under the perf test framework. Since this is done in a trap clause
> > it ends up returning a non zero return. Since $PPID is a bash ism and
> > not all distros are linking /bin/sh to bash, the alternative
> > parent pid lookups are uglier than just dropping the kill, and its
> > not strictly needed, lets pick the simple solution and drop the sigint.
> > 
> > Fixes: 133fe2e617e4 ("perf tests: Improve temp file cleanup in test_arm_coresight.sh")
> > Cc: James Clark <james.clark@arm.com>
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > ---
> >  tools/perf/tests/shell/test_arm_coresight.sh | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> > index 6de53b7ef5ff..e4cb4f1806ff 100755
> > --- a/tools/perf/tests/shell/test_arm_coresight.sh
> > +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> > @@ -29,7 +29,6 @@ cleanup_files()
> >  	rm -f ${file}
> >  	rm -f "${perfdata}.old"
> >  	trap - exit term int
> > -	kill -2 $$
> >  	exit $glb_err
> >  }
> >  
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied.

- Arnaldo

