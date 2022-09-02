Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB4A5AB8CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiIBTRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiIBTRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:17:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DCEF32C5;
        Fri,  2 Sep 2022 12:17:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36B5B622A6;
        Fri,  2 Sep 2022 19:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736C1C433D6;
        Fri,  2 Sep 2022 19:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662146266;
        bh=sOsKQGQG/JU/8JEqfY8COImteIEYSw1VOSMiywIl1iE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a28bxLGeVEp7adLLiC0vKLzoSnEyXo36lWyYMpquXd2Sr+m6xcyJOy/tgqYKQh+9n
         1gYMir/O/WsntCkz/F1y5o0NGfEfeCcJR6SRQDtUFoyrLNRSFsdatGizE6zEV1EBe0
         z1vjTTr5omAJz48vtbYy+PpxfIAlGK0djD/QI2HitWCy+EgF8InWN3ZY3qJ/YDP6QH
         CYDpcklPOHWZOrGkWAASIN9am4Gs5cJhU143wk4/U8ytQBLMxJx4tlTHFTiWV7y6u3
         FMFmt+KiYlynztcaleWEqfZYS06F69+ROm4xxvW2oGPR1HwEFrrDgHfRPGyM9HA/6d
         lHNfaZxbgyO7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C4917404A1; Fri,  2 Sep 2022 16:17:43 -0300 (-03)
Date:   Fri, 2 Sep 2022 16:17:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     =?utf-8?B?VG9tw6HFoQ==?= Trnka <trnka@scm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: perf top -p broken for multithreaded processes since 5.19
Message-ID: <YxJW19MwaMOb8D30@kernel.org>
References: <10137382.nUPlyArG6x@mintaka.ncbr.muni.cz>
 <2fd9b620-e9a8-9cd9-1b4a-6b13d829b2ae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fd9b620-e9a8-9cd9-1b4a-6b13d829b2ae@intel.com>
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

Em Fri, Sep 02, 2022 at 05:50:22PM +0300, Adrian Hunter escreveu:
> On 2/09/22 17:46, Tomáš Trnka wrote:
> > Hello,
> > 
> > A bug in perf v5.19 and newer completely breaks monitoring multithreaded
> > processes using "perf top -p". The tool fails to start with "Failed to mmap
> > with 22 (Invalid argument)". It still seems to work fine on single-threaded
> > processes. "perf record" is also unaffected.
> 
> It has been reported here:
> 
> 	https://bugzilla.kernel.org/show_bug.cgi?id=216441

If I do:

⬢[acme@toolbox perf-urgent]$ git log -2
commit dfeb0bc60782471c293938e71b1a1117cfac2cb3 (HEAD -> perf/urgent)
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Sep 2 16:15:39 2022 -0300

    Revert "libperf evlist: Check nr_mmaps is correct"

    This reverts commit 4ce47d842d4c16c07b135b8a7975b8f0672bcc0e.

    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 78cd283f6b8ab701cb35eafd5af8140560a88f16
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri Sep 2 16:13:41 2022 -0300

    Revert "libperf evlist: Allow mixing per-thread and per-cpu mmaps"

    This reverts commit ae4f8ae16a07896403c90305d4b9be27f657c1fc.

    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
⬢[acme@toolbox perf-urgent]$

It works again, Tomáš can you please try doing this to see if this works
for you?

- Arnaldo
