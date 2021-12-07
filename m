Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBCD46BE29
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhLGOxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:53:41 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50696 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhLGOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:53:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CA881CE1AB3;
        Tue,  7 Dec 2021 14:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D137BC341C3;
        Tue,  7 Dec 2021 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638888599;
        bh=QASQ4r6wPYhYJnlffLIsiV/Atwvn7C2vRnKmQNa+YRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duaMdAUghKFj7lfWTUX9jfjTW//bHdeOkQzHGuF3HNAPLML01x71wuJROI2S0LFB/
         GqqoMIaNRjj0+VKrM0pml9vGIBeaD+VRMxys5jOWArCFG26dRDJysHHqdIEeeFKj6m
         hZt6sLD8Q6XNgs1Vs6utmKoNe9qPheZMOgsClJ/WfJrzA/5ASt/QQYowzIGWs2WF8i
         ksIIaYgs6n0nrnhCNDLB3m/VoUOkDRvy5chUdwjmL1nbRugFblYiwT8gpcm17ak+Wt
         jLOBfX6Ywyi5fP1mi1LYniF6YioU+HDj+Kwu93rvN5RC0I7qWt6lTyYhOM+3fFNgwH
         R5BE6GAPFsCPQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EC418406C1; Tue,  7 Dec 2021 11:49:56 -0300 (-03)
Date:   Tue, 7 Dec 2021 11:49:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrew Kilroy <andrew.kilroy@arm.com>
Cc:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] perf vendor events: For the Neoverse N2
Message-ID: <Ya90lK/PqJDIrXlB@kernel.org>
References: <20211203123525.31127-1-andrew.kilroy@arm.com>
 <2e1a7a96-4ec6-e1f2-5bd4-133480391053@huawei.com>
 <e7aaacd8-7972-6ab9-ff0c-e286bf23993a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7aaacd8-7972-6ab9-ff0c-e286bf23993a@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 07, 2021 at 12:13:16PM +0000, Andrew Kilroy escreveu:
> 
> 
> On 07/12/2021 09:57, John Garry wrote:
> > On 03/12/2021 12:35, Andrew Kilroy wrote:
> > > Updates the common and microarch json file to add counters
> > > available in the Neoverse N2 chip, but should also apply to other ArmV8
> > > and ArmV9 cpus.  Specified in ArmV8 architecture reference manual
> > > 
> > >    https://developer.arm.com/documentation/ddi0487/gb/?lang=en
> > > 
> > > Some of the counters added to armv8-common-and-microarch.json are
> > > specified in the ArmV9 architecture reference manual supplement
> > > (issue A.a):
> > > 
> > >    https://developer.arm.com/documentation/ddi0608/aa
> > > 
> > > The additional ArmV9 counters are
> > > 
> > >    TRB_WRAP
> > >    TRCEXTOUT0
> > >    TRCEXTOUT1
> > >    TRCEXTOUT2
> > >    TRCEXTOUT3
> > >    CTI_TRIGOUT4
> > >    CTI_TRIGOUT5
> > >    CTI_TRIGOUT6
> > >    CTI_TRIGOUT7
> > > 
> > > This patch also adds files in pmu-events/arch/arm64/arm/neoverse-n2 for
> > > perf list to output the counter names in categories.
> > > 
> > > A subsequent patch renames armv8-common-and-microarch.json and
> > > armv8-recommended.json to reflect that counters for armv9 are being
> > > added.
> > 
> > This commentary should be in a cover letter. Please do that.
> > 
> > And did you consider just adding a armv9-common-and-microarch.json and
> > armv9-recommended.json instead of adding to and renaming the v8 version?
> > I know that it creates scattered definitions, but we already have that in
> > dividing the common and the recommended JSONs.
> > 
> 
> I considered it, but I wasn't sure what was preferable.  I thought I'd get
> some feedback.  Do you consider the separation important?  Any particular
> reason?

Applied the second patch, waiting for a conclusion to this discussion to
pick the other two patches.

- Arnaldo
