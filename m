Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C0B510087
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351665AbiDZOgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350376AbiDZOgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:36:05 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81CD3B6D2A;
        Tue, 26 Apr 2022 07:32:57 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1njMFK-0004FF-01; Tue, 26 Apr 2022 16:32:54 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 63378C01C7; Tue, 26 Apr 2022 16:30:38 +0200 (CEST)
Date:   Tue, 26 Apr 2022 16:30:38 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Stijn Tintel <stijn@linux-ipv6.be>
Cc:     linux-mips@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: Octeon: fix CN6640 hang on XAUI init
Message-ID: <20220426143038.GB18291@alpha.franken.de>
References: <20220403025950.837085-1-stijn@linux-ipv6.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403025950.837085-1-stijn@linux-ipv6.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 05:59:49AM +0300, Stijn Tintel wrote:
> Some CN66XX series Octeon II chips seem to hang if a reset is issued on
> XAUI initialization. Avoid the hang by disabling the reset.
> 
> Tested on SNIC10E.
> 
> Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
> ---
>  arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
> index fea71a85bb29..a92632223497 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-xaui.c
> @@ -156,8 +156,9 @@ int __cvmx_helper_xaui_enable(int interface)
>  	xauiCtl.u64 = cvmx_read_csr(CVMX_PCSXX_CONTROL1_REG(interface));
>  	xauiCtl.s.lo_pwr = 0;
>  
> -	/* Issuing a reset here seems to hang some CN68XX chips. */
> -	if (!OCTEON_IS_MODEL(OCTEON_CN68XX_PASS1_X) &&
> +	/* Issuing a reset here seems to hang some CN66XX/CN68XX chips. */
> +	if (!OCTEON_IS_MODEL(OCTEON_CN66XX) &&
> +	    !OCTEON_IS_MODEL(OCTEON_CN68XX_PASS1_X) &&
>  	    !OCTEON_IS_MODEL(OCTEON_CN68XX_PASS2_X))
>  		xauiCtl.s.reset = 1;
>  
> -- 
> 2.35.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
