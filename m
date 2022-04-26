Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DB45102FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352864AbiDZQRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiDZQRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:17:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431279E9CA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:14:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 037F2210E8;
        Tue, 26 Apr 2022 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650989677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTDSLnh863UbzlbjfH1D1Rn73x9IF6PCFt7xCpVb6ho=;
        b=R6skvcZn+e87Oc769JP5z5Jpp9aNYiM0jwU49znjitwJ8SK3iKXXUUFx8wF0SMYNO8Oy3i
        ZiMwtO4fwHpAmEOqqBhAwv8uftn5W2wkpK4Kz7BwoZc5FfbUSiDCfEj2+l0xscUOzWSca5
        OIQt1C0x3w7aV+yJYbwzGCnX86VHIE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650989677;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iTDSLnh863UbzlbjfH1D1Rn73x9IF6PCFt7xCpVb6ho=;
        b=mY/CNuBPFQaiKh1DmTdZq+Yeqbz3lmD7dY0TwlrNb3dZfqbOcKYC2drzRFprcPrsuZeYLI
        zl5WP7KuSuhX5qBg==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E38922C142;
        Tue, 26 Apr 2022 16:14:36 +0000 (UTC)
Date:   Tue, 26 Apr 2022 18:14:35 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: Re: ndctl tests usable?
Message-ID: <20220426161435.GH163591@kunlun.suse.cz>
References: <20220426123839.GF163591@kunlun.suse.cz>
 <CAPcyv4j66HAE_x-eAHQR71pNyR0mk5b463S6OfeokLzZHq5ezw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4j66HAE_x-eAHQR71pNyR0mk5b463S6OfeokLzZHq5ezw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:51:25AM -0700, Dan Williams wrote:
> On Tue, Apr 26, 2022 at 5:39 AM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > Hello,
> >
> > there is some testsuite included with ndctl, and when following the
> > instructions to build it most tests fail or are skipped:
> >
> > [   95s] Ok:                 3
> > [   95s] Expected Fail:      0
> > [   95s] Fail:               5
> > [   95s] Unexpected Pass:    0
> > [   95s] Skipped:            15
> > [   95s] Timeout:            0
> >
> > Is this the expected outcome or is this a problem with the ndctl build?
> >
> > Attaching test run log.
> 
> I see a few missing prerequisites:
> 
> [   78s] /usr/src/packages/BUILD/ndctl-73/test/pmem-errors.sh: line
> 64: mkfs.ext4: command not found
> [   95s] /usr/src/packages/BUILD/ndctl-73/test/security.sh: line 25:
> jq: command not found

Indeed, with those installed I get much more tests passing:

[  148s] Ok:                 13  
[  148s] Expected Fail:      0   
[  148s] Fail:               4   
[  148s] Unexpected Pass:    0   
[  148s] Skipped:            6   
[  148s] Timeout:            0   

> 
> This report:
> 
> [   51s]  1/23 ndctl:ndctl / libndctl               SKIP
> 0.02s   exit status 77
> 
> ...seems to indicate that the nfit_test modules did not appear to load
> correctly. I never expected that the nfit_test modules would be
> redistributable, so I was surprised to see them being installed by an
> actual package "nfit_test-kmp-default-0_k5.17.4_1-6.1". The reason
> they are not redistributable is because they require replacing the
> production build of the kernel provided modules libnvdimm.ko,
> nd_pmem.ko, etc... What I expect is happening is that the production
> version of libnvdimm.ko is already loaded (or is the only one on the

AFAICT neither is the case, that's why I dump the module information in
the log.

Thanks

Michal
