Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A618952BAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiERMTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiERMTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:19:48 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7409A5B88B;
        Wed, 18 May 2022 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=kQKtiTZ0LH/w5S3uWV2zXb3ODADItlkkeofFb+AnfrE=; b=Wv5U2pmuhaGCoLOzHzJK+Nq6cQ
        EGJBrHRoJFiP/8QEBn6R+hA6bbpRr8oLNh5EVEtnLyyKpJePXmTEnVYtGLqGDlyKTwfy0WSbgi6My
        iSvOJjjGqikleFr50AmwdM1qnWFvIi3QyjQ786H9g1LQOYSReGILeRYHV25ojKWRg7h4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nrIeB-003K0L-QZ; Wed, 18 May 2022 14:19:23 +0200
Date:   Wed, 18 May 2022 14:19:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vivek Kumar <quic_vivekuma@quicinc.com>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, maz@kernel.org, axboe@kernel.dk,
        rafael@kernel.org, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mm@kvack.org, len.brown@intel.com,
        pavel@ucw.cz, paulmck@kernel.org, bp@suse.de,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        pasha.tatashin@soleen.com, tabba@google.com, ardb@kernel.org,
        tsoni@quicinc.com, quic_psodagud@quicinc.com,
        quic_svaddagi@quicinc.com,
        Prasanna Kumar <quic_kprasan@quicinc.com>
Subject: Re: [RFC 2/6] PM: Hibernate: Add option to disable disk offset
 randomization
Message-ID: <YoTkSx96vt1NTdZ/@lunn.ch>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
 <1652860121-24092-3-git-send-email-quic_vivekuma@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652860121-24092-3-git-send-email-quic_vivekuma@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:18:37PM +0530, Vivek Kumar wrote:
> Add a kernel parameter to disable the disk offset randomization
> for SSD devices in which such feature is available at the
> firmware level. This is helpful in improving hibernation
> resume time.
> 
> Signed-off-by: Vivek Kumar <quic_vivekuma@quicinc.com>
> Signed-off-by: Prasanna Kumar <quic_kprasan@quicinc.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
>  kernel/power/swap.c                             |  9 +++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 666ade9..06b4f10 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5192,6 +5192,17 @@
>  			Useful for devices that are detected asynchronously
>  			(e.g. USB and MMC devices).
>  
> +	noswap_randomize
> +			Kernel uses random disk offsets to help with wear-levelling
> +			of SSD devices, while saving the hibernation snapshot image to
> +			disk. Use this parameter to disable this feature for SSD
> +			devices in scenarios when, such randomization is addressed at
> +			the firmware level and hibenration image is not re-generated
> +			frequently.
> +			(Useful for improving hibernation resume time as snapshot pages
> +			are available in disk serially and can be read in bigger chunks
> +			without seeking)

Seeking is a NOP for SSD, so it seems odd you mentioned that. Is the
real problem here that the bootloader driver is very simple, it does
not queue multiple reads to the hardware, but does it one block at a
time?

Do you have performance numbers for both the bootloader and Linux?
Does Linux performance reading the snapshot increase as much as for
the bootloader?

	Andrew
