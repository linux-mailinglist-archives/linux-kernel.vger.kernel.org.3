Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952CC4FA9CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbiDIRUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiDIRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:20:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D461E68E4;
        Sat,  9 Apr 2022 10:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DD1EB80761;
        Sat,  9 Apr 2022 17:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D644C385A0;
        Sat,  9 Apr 2022 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649524697;
        bh=U3jHc9UqvdL0OI4026ZW/QrRbZLIojegGMh2u9v87rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgF5U5FjEyAQlfJ1rxZKa815KAiFoOPnF+WI8qDhFrWa2WC7XDhcoIAXwPJG1Zx26
         hJoGd07p4baJpG+dOqtCqmukcgqQXq5bnbwqUoz+2/uz0qO8sWhY8g3sDOxvK+ELep
         dJpHqxZ8G0xL0iptyCISOBOMwbaIL2boDtCuDcJEMuGlhkC3lZnv7UmF3LFbppEOd9
         CqPM2gokNOjs8UcayPxAx6JMwWYMRe1i7lULZVHMQnvBFx3Ss0vsc6VPOrQJbUoBky
         y5r5ug+QGtmoF2XzgPJQ7eVCUzxtSnbBLsz4BJcuCUx+aotpTEWDG8QIWqgoD/LHqw
         3oUN+QGPun3yw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CC4CF40407; Sat,  9 Apr 2022 14:18:13 -0300 (-03)
Date:   Sat, 9 Apr 2022 14:18:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     jolsa@kernel.org, disgoel@linux.vnet.ibm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, linux-kernel@vger.kernel.org,
        srikar@linux.vnet.ibm.com, irogers@google.com
Subject: Re: [PATCH v2 0/4] Fix perf bench numa, futex and epoll to work with
 machines having #CPUs > 1K
Message-ID: <YlG/1cegJ3Fh/zj/@kernel.org>
References: <20220406175113.87881-1-atrajeev@linux.vnet.ibm.com>
 <YlGmAd3LEh9He6Pg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlGmAd3LEh9He6Pg@kernel.org>
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

Em Sat, Apr 09, 2022 at 12:28:01PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Apr 06, 2022 at 11:21:09PM +0530, Athira Rajeev escreveu:
> > The perf benchmark for collections: numa, futex and epoll
> > hits failure in system configuration with CPU's more than 1024.
> > These benchmarks uses "sched_getaffinity" and "sched_setaffinity"
> > in the code to work with affinity.
> 
> Applied 1-3, 4 needs some reworking and can wait for v5.19, the first 3
> are fixes, so can go now.

Now trying to fix this:

  26     7.89 debian:9                      : FAIL gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)
    bench/numa.c: In function 'alloc_data':
    bench/numa.c:359:6: error: 'orig_mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]
      ret = sched_setaffinity(0, size, mask);
      ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    bench/numa.c:409:13: note: 'orig_mask' was declared here
      cpu_set_t *orig_mask;
                 ^~~~~~~~~
    cc1: all warnings being treated as errors
    /git/perf-5.18.0-rc1/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2


Happened in several distros.

- Arnaldo
