Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3AA486A87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbiAFTbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:31:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57098 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243346AbiAFTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:31:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 431EEB8236B;
        Thu,  6 Jan 2022 19:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4556C36AE3;
        Thu,  6 Jan 2022 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641497459;
        bh=m9VkCCeOS9J9JZLXoM12fx8/yYtmjC+12pg7Y/NuWOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4Cf4e1NZGE8ustwCkfwIOfX94jxYT/+Lora66GaUFUso/D0DECIuGVPaiD9aMJBs
         6dt+yhQdXeeaphLWhcSie+FRDIyNwUzRBE3JPH6V/mptYSGicB9VxCYiXRSLxdhGtU
         Ihc28to3tMu9Di2e9lZY625DAdEZOD8m6ZJFOwZGZW4gRQdJNzKUJgGSAdh8k9lBJB
         PPvqT7dl9S/5bBB0n37ZENETIao3uyZvRdw8PpGUK+6139MJmKJWcgqu4ztF4YJ4uu
         7fyoCSWrkF9UilSI5VdFTbbSZStKcHA81MsGwdsaD/J4CYF2tI6M+LNWLGekuwvoj1
         Kfa0lGHIe/bqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 325D840B92; Thu,  6 Jan 2022 16:30:58 -0300 (-03)
Date:   Thu, 6 Jan 2022 16:30:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        torvalds@linux-foundation.org, eranian@google.com
Subject: Re: [PATCH] perf build: Lower the priority of tools/lib includes
Message-ID: <YddDcqxtDrPDSAVi@kernel.org>
References: <20220106072627.476524-1-irogers@google.com>
 <YddC+lzAO1Urj0TF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YddC+lzAO1Urj0TF@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 06, 2022 at 04:28:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jan 05, 2022 at 11:26:27PM -0800, Ian Rogers escreveu:
> > tools/lib has a 1.1.0 copy of libtraceevent. If a newer system
> > version is installed then its headers will go in /usr/include. As -I has
> > priority over system headers the 1.1.0 version gets used in preference
> > to the system one, which isn't what is wanted. To make the behavior
> > match expectations use -idirafter so that any system headers have priority
> > over the tools/lib version.
> > 
> > Fixes: 08efcb4a638d ("libtraceevent: Increase libtraceevent logging when verbose")
> 
> Hi,
> 
> 	You forgot to add your Signed-off-by:, I'm adding it as you
> usually provide it, ok?

Also adding:

Reported-by: Jiri Slaby <jirislaby@kernel.org>

- Arnaldo
