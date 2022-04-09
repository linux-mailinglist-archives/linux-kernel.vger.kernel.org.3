Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D36E4FA92C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbiDIPOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDIPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:14:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7885E205DB;
        Sat,  9 Apr 2022 08:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DC28B80025;
        Sat,  9 Apr 2022 15:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9E4C385A0;
        Sat,  9 Apr 2022 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649517159;
        bh=UFt6d+nDavXkqAbzhdwyRWgMrNoPlcPEvcy0Athveww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSp0Ol0j6f4brdIvMwXtvU9jQGAXTuQ8DfcR/VqOccK8ygkdACqNY2FK8XVVz9vPI
         /Y75iIIThKW1s4teFOeX1ZUdAyOsNQHIwhiZjPEhBKyO6JCWVQH6a+pDhPO0ytdEHv
         OUJn7lEsreOtikxhUwLqdQE1Ni9YnimQ54SSjsO4aZkvZc1nlj7lEFj2PCsh7poRFy
         OIogR3n4ZgrCLabMboEMvEraReJ5dVZwJcoAMhbXX1q/dSohuHLmUlEvTHdqV1K7aI
         Y+PXhQZ15SpZH7eznEpsFOC2QgX8xWHfgq78tM/67Kh8jMOlft0zILoF3MbpjZWRkL
         IKp2Cl6LnLvlQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0EB0240407; Sat,  9 Apr 2022 12:12:37 -0300 (-03)
Date:   Sat, 9 Apr 2022 12:12:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        leo.yan@linaro.com, German Gomez <German.Gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: arm-spe: Fix perf report --mem-mode
Message-ID: <YlGiZRZlrBCmO+YG@kernel.org>
References: <20220408144056.1955535-1-james.clark@arm.com>
 <CAM9d7cji=xSAy673sXGf2GXFsKKsR7=pNKJceLtHX1sFFUZcKg@mail.gmail.com>
 <20220409095941.GA1000846@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409095941.GA1000846@leoy-ThinkPad-X240s>
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

Em Sat, Apr 09, 2022 at 05:59:41PM +0800, Leo Yan escreveu:
> On Fri, Apr 08, 2022 at 11:13:09AM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > On Fri, Apr 8, 2022 at 7:41 AM James Clark <james.clark@arm.com> wrote:
> > >
> > > Since commit bb30acae4c4d ("perf report: Bail out --mem-mode if mem info
> > > is not available") "perf mem report" and "perf report --mem-mode" don't
> > > allow opening the file unless one of the events has PERF_SAMPLE_DATA_SRC
> > > set.
> > >
> > > SPE doesn't have this set even though synthetic memory data is generated
> > > after it is decoded. Fix this issue by setting DATA_SRC on SPE events.
> > > This has no effect on the data collected because the SPE driver doesn't
> > > do anything with that flag and doesn't generate samples.
> > >
> > > Fixes: bb30acae4c4d ("perf report: Bail out --mem-mode if mem info is not available")
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>
> 
> It's a bit awkward that after the commit bb30acae4c4d we cannot be
> backward compatible and any old perf data file will be failed to
> support by 'perf mem report' tool.

oh well, I think we should put in place a mechanism to run perf record
before some change, then make sure that a new perf is able to process
it after a rebuild.

If its something unsurmountable, then a proper explanation should be
done with a workaround to process those older files, even if pointing
out  to the perf version that is able to process the old file.

Anyway, applying this pa tch.

- ARnaldo
