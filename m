Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55064510089
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351653AbiDZOgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351058AbiDZOgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:36:05 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82765B6E6E;
        Tue, 26 Apr 2022 07:32:57 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1njMFK-0004FF-02; Tue, 26 Apr 2022 16:32:54 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 888B6C01C7; Tue, 26 Apr 2022 16:30:50 +0200 (CEST)
Date:   Tue, 26 Apr 2022 16:30:50 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Stijn Tintel <stijn@linux-ipv6.be>
Cc:     linux-mips@vger.kernel.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: Octeon: support all interfaces on CN66XX
Message-ID: <20220426143050.GC18291@alpha.franken.de>
References: <20220403025950.837085-1-stijn@linux-ipv6.be>
 <20220403025950.837085-2-stijn@linux-ipv6.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403025950.837085-2-stijn@linux-ipv6.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 05:59:50AM +0300, Stijn Tintel wrote:
> CN66XX_PASS1_0 has 7 interfaces, other revisions have 8 interfaces.
> 
> Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>
> ---
>  arch/mips/cavium-octeon/executive/cvmx-helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> index b22f664e2d29..6f49fd9be1f3 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> @@ -61,6 +61,12 @@ int cvmx_helper_get_number_of_interfaces(void)
>  {
>  	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
>  		return 9;
> +	if (OCTEON_IS_MODEL(OCTEON_CN66XX)) {
> +		if (OCTEON_IS_MODEL(OCTEON_CN66XX_PASS1_0))
> +			return 7;
> +		else
> +			return 8;
> +	}
>  	if (OCTEON_IS_MODEL(OCTEON_CN56XX) || OCTEON_IS_MODEL(OCTEON_CN52XX))
>  		return 4;
>  	if (OCTEON_IS_MODEL(OCTEON_CN7XXX))
> -- 
> 2.35.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
