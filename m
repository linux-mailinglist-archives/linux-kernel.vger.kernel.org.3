Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F9535662
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349519AbiEZXZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbiEZXZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E4E9E64C7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 16:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653607508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9X8JUoVO3ItYFMP0lxBdt9F+7PIN+J/Kt3iw5v3WE2U=;
        b=FV79u2Ot+BRUau6iUpMOPgquetsClJTMU4+q74Aws8dfCaSILTIiFD65zR9N1iC1dQmf51
        PdT7LAVUE4419tr+cC7fbIQwesxLUzBMiz+Z+geqMuzh8eNvW83m1pJiu0FvIuK90BG+Vj
        Xdo6k0n4MESzy/saNWdn1xebSSixPF0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-C-7MkAPdMM2G_EtT5a-g0g-1; Thu, 26 May 2022 19:25:07 -0400
X-MC-Unique: C-7MkAPdMM2G_EtT5a-g0g-1
Received: by mail-wm1-f70.google.com with SMTP id j14-20020a05600c1c0e00b003973bf0d146so1729182wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 16:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9X8JUoVO3ItYFMP0lxBdt9F+7PIN+J/Kt3iw5v3WE2U=;
        b=jabI4rdkjek9VzDL4TFBaaXoP7x5DPD8z3wtqXmzEAxzXh7IZ2OsFl5+gS7V3sFIIA
         +ASp+K0vrzcu+6vVg3cOjVgbM2QiXPgf6kX6EZaxvPnrwZXu/BNhy/deCJ3J75EGk1BH
         ocgb73LMJMiyvIwC/pWeVAlGajLT9NLYZEX00aqQDYkKnbB5loe3ok2igBCchS/znWdy
         tIRu1ro8eyc3vRhxfBQe5wh4rQ/xN0KKXVd5KMzTdIB8DkXlRShDmqE5hckwh3Z+44M5
         QK+HM3AyS5/CE9KSJN+I2fcDui1RAd7+sGk/wUoPGy016v1yqosbOmb/mIXj4hhcpC0y
         i2gg==
X-Gm-Message-State: AOAM533BadFaNiw6jMIcqsBJJl7gLnKzdY7OaWqpTShaoNr340u90W07
        SLDJ+1X6yYmOYEP7Oa2Y280sUtSwbHqOlkd2duZJnQCviPjP+xrrq2C3C6SBf1BcUSdhKp4pvmn
        dRa4/pDCIDBGh6FRBxNVuclG6
X-Received: by 2002:a5d:6d8c:0:b0:20e:72ce:c9d9 with SMTP id l12-20020a5d6d8c000000b0020e72cec9d9mr29002637wrs.598.1653607505621;
        Thu, 26 May 2022 16:25:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6jLtwn+a7vihIpXB+X9zxsi4oW40VzxI37oPu2ky+U6YhL+3ESFEOquhhiPVK7ZSiEhjghw==
X-Received: by 2002:a5d:6d8c:0:b0:20e:72ce:c9d9 with SMTP id l12-20020a5d6d8c000000b0020e72cec9d9mr29002625wrs.598.1653607505366;
        Thu, 26 May 2022 16:25:05 -0700 (PDT)
Received: from redhat.com ([2.55.29.191])
        by smtp.gmail.com with ESMTPSA id 8-20020a1c0208000000b003942a244ed1sm466085wmc.22.2022.05.26.16.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 16:25:04 -0700 (PDT)
Date:   Thu, 26 May 2022 19:25:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.carpenter@oracle.com, Jason Wang <jasowang@redhat.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: Fix some error handling path in
 vhost_vdpa_process_iotlb_msg()
Message-ID: <20220526192401-mutt-send-email-mst@kernel.org>
References: <89ef0ae4c26ac3cfa440c71e97e392dcb328ac1b.1653227924.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89ef0ae4c26ac3cfa440c71e97e392dcb328ac1b.1653227924.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 03:59:01PM +0200, Christophe JAILLET wrote:
> In the error paths introduced by the commit in the Fixes tag, a mutex may
> be left locked.
> Add the correct goto instead of a direct return.
> 
> Fixes: a1468175bb17 ("vhost-vdpa: support ASID based IOTLB API")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> WARNING: This patch only fixes the goto vs return mix-up in this function.
> However, the 2nd hunk looks really spurious to me. I think that the:
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto unlock;
> should be done only in the 'if (!iotlb)' block.
> 
> As I don't know this code, I just leave it as-is but draw your attention
> in case this is another bug lurking.
> ---
>  drivers/vhost/vdpa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 1f1d1c425573..3e86080041fc 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1000,7 +1000,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>  		if (!as) {
>  			dev_err(&v->dev, "can't find and alloc asid %d\n",
>  				asid);
> -			return -EINVAL;
> +			r = -EINVAL;
> +			goto unlock;
>  		}
>  		iotlb = &as->iotlb;
>  	} else
> @@ -1013,7 +1014,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>  		}
>  		if (!iotlb)
>  			dev_err(&v->dev, "no iotlb for asid %d\n", asid);
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto unlock;
>  	}
>  
>  	switch (msg->type) {
> -- 
> 2.34.1

