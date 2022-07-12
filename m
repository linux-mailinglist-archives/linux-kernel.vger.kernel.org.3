Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4272571F84
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiGLPgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiGLPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:36:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C4BFAF4;
        Tue, 12 Jul 2022 08:36:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91E4361752;
        Tue, 12 Jul 2022 15:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C75C3411C;
        Tue, 12 Jul 2022 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657640207;
        bh=qtHaRSfZTHMEwwuzvARLAnIh5Am3Y972u2Ic/uJNmA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/AJS7EQ3QF6ZTocHNUdSdYVg7J0zP5gQRChcpjD9Z2BcGTZCCdG6JuT6YwsWBlyR
         kQDi9tVjKS2unLh2luTRWtyWIPcwehAr7nOwTvu1KQQm9UIQiX56KjWPHIU0RiHkWB
         495g9ghFerD4A3RHGi9gDvMBsm4qM0+mKMKGSgcLfD7lP2yGzvR0CTYEjyGvUSB6Un
         KIp82UEo3rdJ99xM34x7bBBPJ+45ViUgHH80aEP7TVD5HGJLKnFOYpWtaIDRH8+o98
         TLavrhHqUsEi52Ck4khR1mU2YCh645+hM/zhQo5RiL1xkXHEXrLfu2jhMw1N+v7h2a
         PHyVzm6E3ZCbQ==
Date:   Tue, 12 Jul 2022 08:36:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     hch@lst.de, dchinner@redhat.com, kelulanainsley@gmail.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] xfs: fix for variable set but not used warning
Message-ID: <Ys2VDv7Q29GYmQjV@magnolia>
References: <20220712123852.813904-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712123852.813904-1-sunliming@kylinos.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 08:38:52PM +0800, sunliming wrote:
> Fix below kernel warning:
> 
> fs/xfs/scrub/repair.c:539:19: warning: variable 'agno' set but not used [-Wunused-but-set-variable]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  fs/xfs/scrub/repair.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/xfs/scrub/repair.c b/fs/xfs/scrub/repair.c
> index a02ec8fbc8ac..2c8d7e7ef9af 100644
> --- a/fs/xfs/scrub/repair.c
> +++ b/fs/xfs/scrub/repair.c
> @@ -533,14 +533,11 @@ xrep_reap_block(
>  {
>  	struct xfs_btree_cur		*cur;
>  	struct xfs_buf			*agf_bp = NULL;
> -	xfs_agnumber_t			agno;
>  	xfs_agblock_t			agbno;
>  	bool				has_other_rmap;
>  	int				error;
>  
> -	agno = XFS_FSB_TO_AGNO(sc->mp, fsbno);
>  	agbno = XFS_FSB_TO_AGBNO(sc->mp, fsbno);
> -	ASSERT(agno == sc->sa.pag->pag_agno);

...by removing debugging assertions?  IDGI, why wouldn't you change the
assertion?

--D

>  
>  	/*
>  	 * If we are repairing per-inode metadata, we need to read in the AGF
> -- 
> 2.25.1
> 
