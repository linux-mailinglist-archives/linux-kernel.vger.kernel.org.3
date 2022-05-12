Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BD5525235
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356322AbiELQL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356308AbiELQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:11:47 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB4316669F;
        Thu, 12 May 2022 09:11:42 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1npBPf-0001Vm-01; Thu, 12 May 2022 18:11:39 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B6208C01DC; Thu, 12 May 2022 18:08:53 +0200 (CEST)
Date:   Thu, 12 May 2022 18:08:53 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: VR41xx: Drop redundant spinlock initialization
Message-ID: <20220512160853.GB14475@alpha.franken.de>
References: <1652176527-4507-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652176527-4507-1-git-send-email-baihaowen@meizu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 05:55:27PM +0800, Haowen Bai wrote:
> slot_errbuf_lock has declared and initialized by DEFINE_SPINLOCK,
> so we don't need to spin_lock_init again, drop it.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  arch/mips/vr41xx/common/cmu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/mips/vr41xx/common/cmu.c b/arch/mips/vr41xx/common/cmu.c
> index b59ee5479313..e4cbe116b26d 100644
> --- a/arch/mips/vr41xx/common/cmu.c
> +++ b/arch/mips/vr41xx/common/cmu.c
> @@ -236,8 +236,6 @@ static int __init vr41xx_cmu_init(void)
>  	if (current_cpu_type() == CPU_VR4133)
>  		cmuclkmsk2 = cmu_read(CMUCLKMSK2);
>  
> -	spin_lock_init(&cmu_lock);
> -
>  	return 0;
>  }
>  
> -- 
> 2.7.4

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
