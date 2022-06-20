Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CD2551210
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbiFTICM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbiFTICK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1CA1114D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AFBC6122A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183D7C3411B;
        Mon, 20 Jun 2022 08:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655712128;
        bh=DwhU0/KxtnYlqxZj35So4aWeWj3iqMidFqPyuGEWOsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCl1xAjYaSjiD2yiORDCzx4gxd/Q1ObwVxYAlnPd4KDTvk4uR3JvCEfiAaigmwOHh
         kboBiyjYZDBKr1ti6TSy02x09OWEoPtBDztSNmtdC+Lgu/+mCHlh7vdItt0U9X3ZCp
         8ITi4zITqaFhkBANt3N8buI2jQoI1XKRnQEdr+KM=
Date:   Mon, 20 Jun 2022 10:02:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        alexandre.belloni@bootlin.com, rafael@kernel.org,
        mathieu.poirier@linaro.org, u.kleine-koenig@pengutronix.de,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] vme: Added NULL check for bridge
Message-ID: <YrApfbtMD56WwpIm@kroah.com>
References: <20220619070645.100947-1-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619070645.100947-1-jrdr.linux@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 12:36:45PM +0530, Souptick Joarder wrote:
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> 
> Kernel test robot throws below warning ->
> drivers/staging/vme_user/vme.c:662:20: warning: dereference
> of NULL 'bridge' [CWE-476] [-Wanalyzer-null-dereference]
> 
> Added a NULL check.
> 
> Reported-by: Kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index b5555683a069..ede774f2fe5a 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -659,7 +659,7 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
>  	struct vme_master_resource *image;
>  	size_t length;
>  
> -	if (!bridge->master_read) {
> +	if (bridge && !bridge->master_read) {

How can bridge ever be NULL here?

thanks,

greg k-h
