Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E3E4DCAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiCQQCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbiCQQCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9473F1B60BF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647532855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBbDy367kWrGSBoXbYBN/Kvf/xHJKwcAv/IFsfAX7P8=;
        b=TZEzVtM8/PX3hl7emlanY8d+RwA2ZOgHPxjV9+fuM2+fw5eMOzv6m5CMkFLHXw1dtjQ3oO
        bBV5sCWfQpQnSYvAOUWxI8oYJSJ6VlyfLYDGHfdjeWosxtF3q0yIPwZ8iGyVgP2EuKgZe+
        Im9iPNP/ejmO8p9HcsUmcdGCIfduMsk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-JE4YIapuNd-nwL5Tot9ISA-1; Thu, 17 Mar 2022 12:00:52 -0400
X-MC-Unique: JE4YIapuNd-nwL5Tot9ISA-1
Received: by mail-io1-f70.google.com with SMTP id z10-20020a056602080a00b00645b9fdc630so3426626iow.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 09:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=RBbDy367kWrGSBoXbYBN/Kvf/xHJKwcAv/IFsfAX7P8=;
        b=trBUPZY7iskez5PP1fjC03RBAWtXbEgYHSIR7DwnY0i3s6+19nqNPqK83jfpgw8bjH
         GFtwuVIrAcJlkylfWrkcfZ5kg3e4N0IfA3og1bRJ4NQQIl+nbZRAfTaInp01/8lEKRaO
         KBtjwI+x5VZuQc5ji5KaR7hfG+oFVtJfWhTWfy3L2BErfAprfIeKS9ueG72w9JSFLyZo
         brbxhZyeWBQioM6OZRRqtFOB425XC9WUIoyaGzwKCFCDgpMRRUDPeJYzr6FaeaOV7xXT
         OjrixIiMVBx+PrFbpposFuGliC/bMDEKeQnmBvJM1n/70tJIsd1DUequmQOvUJAkTqan
         QvCg==
X-Gm-Message-State: AOAM532VaOGLfHDDKDJB0nQn6W77gEJUxExaOPLX/VtNUxKdlDBU93/g
        mEXO5uFy28It3SektRgiVcyGMhzzgqiWWiQBHXiQtu6iG5cMkTHzOjWst9DCj3Qu4U1qurtKKEW
        4QCfkKysNtHaWE6YbF8EnRNKJ
X-Received: by 2002:a05:6e02:216f:b0:2c7:7a3f:2a94 with SMTP id s15-20020a056e02216f00b002c77a3f2a94mr2462962ilv.267.1647532851084;
        Thu, 17 Mar 2022 09:00:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxq6DeC5RvP84Jp8XIKwkiiRG7CXxw/wSac9zA/J5rHz7wKILVwB0AdOAiqXkXniBbu4npQaQ==
X-Received: by 2002:a05:6e02:216f:b0:2c7:7a3f:2a94 with SMTP id s15-20020a056e02216f00b002c77a3f2a94mr2462938ilv.267.1647532850763;
        Thu, 17 Mar 2022 09:00:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id r15-20020a056e0219cf00b002c77a3f2a85sm3677624ill.6.2022.03.17.09.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 09:00:50 -0700 (PDT)
Date:   Thu, 17 Mar 2022 10:00:49 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust entry for header movement in
 hisilicon qm driver
Message-ID: <20220317100049.27d7a476.alex.williamson@redhat.com>
In-Reply-To: <20220316124224.29091-1-lukas.bulwahn@gmail.com>
References: <20220316124224.29091-1-lukas.bulwahn@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 13:42:24 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit ff5812e00d5e ("crypto: hisilicon/qm: Move the QM header to
> include/linux") moves drivers/crypto/hisilicon/qm.h to
> include/linux/hisi_acc_qm.h, but misses to adjust MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Adjust the file entry in the HISILICON QM AND ZIP Controller DRIVER
> following this file movement.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Alex, please pick this minor clean-up on your -next tree on top of the
> commit above.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 845b36c0f0f5..963d7001f2ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8852,9 +8852,9 @@ L:	linux-crypto@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/debugfs-hisi-zip
>  F:	drivers/crypto/hisilicon/qm.c
> -F:	drivers/crypto/hisilicon/qm.h
>  F:	drivers/crypto/hisilicon/sgl.c
>  F:	drivers/crypto/hisilicon/zip/
> +F:	include/linux/hisi_acc_qm.h
>  
>  HISILICON ROCE DRIVER
>  M:	Wenpeng Liang <liangwenpeng@huawei.com>

Applied to vfio next branch for v5.18 with Shameer's R-b.  Thanks,

Alex

