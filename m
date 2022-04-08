Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E314F90DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiDHIeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiDHIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:34:16 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C74D083C;
        Fri,  8 Apr 2022 01:32:13 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nck2E-000SHh-5E; Fri, 08 Apr 2022 18:32:03 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Apr 2022 16:32:02 +0800
Date:   Fri, 8 Apr 2022 16:32:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER" 
        <linux-crypto@vger.kernel.org>,
        Kerneis Gabriel <Gabriel.Kerneis@ssi.gouv.fr>,
        Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH v3 0/4] Export PSP security attributes
Message-ID: <Yk/zAo91ztEq/qTv@gondor.apana.org.au>
References: <20220331211213.2844-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331211213.2844-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:12:09PM -0500, Mario Limonciello wrote:
> Select AMD SOCs include the ability to export capabilities that
> have been activated or detected by the platform security processor.
> 
> This information is useful for both system designers as well as system
> administrators to ensure that the system has been properly locked down
> to their expectations.
> 
> Software such as fwupd will also be modified to use this information
> as part of the calculations for a security level score that may be
> presented to a user.
> 
> This series also adds the ability to detect that TSME and SME are both
> activated simultaneously to notify a user.  Previously a user could turn
> on TSME and SME at the same time, but the kernel was unable to detect
> that TSME was enabled in the OS.
> 
> This information is evaluated "too late" right now in the kernel to stop
> the kernel from enabling SME, but if that is desirable at a later time
> some of the early code can be modified to read the same information and
> make that decision.
> 
> Mario Limonciello (4):
>   crypto: ccp: cache capability into psp device
>   crypto: ccp: Export PSP security bits to userspace
>   crypto: ccp: Allow PSP driver to load without SEV/TEE support
>   crypto: ccp: When TSME and SME both detected notify user
> 
>  Documentation/ABI/testing/sysfs-driver-ccp | 87 ++++++++++++++++++++++
>  drivers/crypto/ccp/psp-dev.c               | 49 +++++-------
>  drivers/crypto/ccp/psp-dev.h               | 22 ++++++
>  drivers/crypto/ccp/sp-pci.c                | 62 +++++++++++++++
>  4 files changed, 189 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-ccp

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
