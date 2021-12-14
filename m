Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7D3474370
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhLNN0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:26:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54466 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhLNN0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:26:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC891614E3;
        Tue, 14 Dec 2021 13:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B597C34605;
        Tue, 14 Dec 2021 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639488405;
        bh=8QGHE0fK7CigJKJp2gJvyAASZ/DUh8M98aUo7jPSPek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQ7TfGCIQvFo2S76vgmZ19p4rzVNsg8h8E+r4DskC4zB+jd5btsFxzB4FT8sUOeyr
         0dieCHKB6zHkbNsUI7hBaBCT0n2GFgb0lZGA5nlev0mWNU4Md5Fl5ySNX+kUd+7dzN
         Rn4Hd0EI6QVdsdCE2coqcVtk2eUocaL9bdQ8/Y7/A9IKVwgHx9SElOLxn3SbdcdoEy
         o3BpZxvdkfX0OgnEAx5Pj/w74md3eY7wja9DzF+wSADT8G+ra4+Ajw6pCGisucBaee
         24vZiNuqbkl5Ohvfa60OviNTpnn1rQxnKkNUTv5lMNYmgxmlqZn28YB/D8GsUW2LTX
         xJkE4mGAVPv2w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 91DEF405D8; Tue, 14 Dec 2021 10:26:40 -0300 (-03)
Date:   Tue, 14 Dec 2021 10:26:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     German Gomez <german.gomez@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Support register names of all architectures
Message-ID: <YbibkI8NE81Qo5q6@kernel.org>
References: <20211207180653.1147374-1-german.gomez@arm.com>
 <EAC4AC1D-A305-42E2-B22F-8B64B0968841@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EAC4AC1D-A305-42E2-B22F-8B64B0968841@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 14, 2021 at 02:20:26PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 07-Dec-2021, at 11:36 PM, German Gomez <german.gomez@arm.com> wrote:
> > 
> > The following changeset applies some corrections to the way system
> > registers are processed and presented when reading perf.data files using
> > the various perf tools.
> > 
> > The commit message from [3/3] shows how register names aren't correctly
> > presented when performing x-arch analysis of perf.data files (recording
> > in one arch, then reading the file from a different arch).
> > 
> >  - [PATCH 1/3] Fixes a potential out-of-bounds access when reading the
> >    values of the registers in the perf.data file.
> >  - [PATCH 2/3] Fixes an issue of ARM and ARM64 registers having the
> >    same enum name.
> >  - [PATCH 3/3] Refactors the function "perf_reg_name" declared in the
> >   "tools/perf/util/perf_regs.h" header, in order to support every arch.
> > 
> > Thanks,
> > German
> 
> Looks good to me. Tested this patchset in powerpc by capturing regs in powerpc and doing
> perf report to read the data from x86.
> 
> Reviewed-and-Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks, added to the commit log message.

- Arnaldo

> > --
> > Changes since v1
> > 
> >  - Added "Reported-by" tags.
> >  - Removed [PATCH 2/4] because it's not needed (suggested by Athira
> >    Rajeev).
> >  - Removed [PATCH 3/4] which created additional header files with the
> >    register names of every arch.
> >  - Introduced [PATCH 2/3] to deal with ARM and ARM64 registers having the
> >    same enum name across "/tools/perf/".
> >  - Reworked the refactor of "perf_reg_name" function (now implemented in
> >    perf_regs.c, rather than in the header file) in [PATCH 3/3].
> > 
> > German Gomez (3):
> >  perf tools: Prevent out-of-bounds access to registers
> >  perf tools: Rename perf_event_arm_regs for ARM64 registers
> >  perf tools: Support register names from all archs
> > 
> > tools/perf/arch/arm/include/perf_regs.h       |  42 --
> > tools/perf/arch/arm64/include/perf_regs.h     |  78 +-
> > tools/perf/arch/csky/include/perf_regs.h      |  82 ---
> > tools/perf/arch/mips/include/perf_regs.h      |  69 --
> > tools/perf/arch/powerpc/include/perf_regs.h   |  66 --
> > tools/perf/arch/riscv/include/perf_regs.h     |  74 --
> > tools/perf/arch/s390/include/perf_regs.h      |  78 --
> > tools/perf/arch/x86/include/perf_regs.h       |  82 ---
> > tools/perf/builtin-script.c                   |  18 +-
> > tools/perf/util/event.h                       |   5 +-
> > tools/perf/util/libunwind/arm64.c             |   2 +
> > tools/perf/util/perf_regs.c                   | 671 +++++++++++++++++-
> > tools/perf/util/perf_regs.h                   |  10 +-
> > .../scripting-engines/trace-event-python.c    |  10 +-
> > tools/perf/util/session.c                     |  25 +-
> > 15 files changed, 709 insertions(+), 603 deletions(-)
> > 
> > -- 
> > 2.25.1
> > 

-- 

- Arnaldo
