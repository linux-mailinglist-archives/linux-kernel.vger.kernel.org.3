Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E5252C1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbiERRvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241132AbiERRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E93A622534
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652896274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49hW2Lgkit3FFJ0TGEQAkc/9Izoyz7QsMkLjDXmi4AY=;
        b=fzpt5aMYtzcQUknWNpFa6KdePQOcD7ZS5BqxJzhnhXL7ywqj9ZDUECE/qWLwVllipcz1yK
        e8NJNFnN3FEOXyGDtZloOKf1QFXogkeHDKZCDULswOlT9adcQKvEJ3VIH9aik7v6myq4t7
        hNZWAXNyvEWzTwbhiCjY7pgv8z63Rak=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-c-Hi_WEaMG-hMiKPX-hTbA-1; Wed, 18 May 2022 13:51:13 -0400
X-MC-Unique: c-Hi_WEaMG-hMiKPX-hTbA-1
Received: by mail-io1-f72.google.com with SMTP id n5-20020a056602340500b0065a9f426e7aso716153ioz.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=49hW2Lgkit3FFJ0TGEQAkc/9Izoyz7QsMkLjDXmi4AY=;
        b=DwHowxCq5o2J96OVvN4FmDVmSxN1hEbBkMDzmlXXHaoO190AR+R9MhIfUJZmABRUTQ
         dtgIh4rl0wpGDxlLVulQtjMrx410nLv9/Q03lEg9Gn47PGHRP+49qwwAPec76x+Wd4Z8
         yag3rwBO1AStUD3FZOvcQb1uRp+fm+1OJ90wyHQF5a6x2wF8KJLNSfy3FyxJa4nYk5PA
         uKRpR3QXGfQ3xRWMe+t98yhUg3lK2aVutKpjTvg8vsZ3Vfqj88T6LKGUKkG5KAVVOCE8
         9e+YAhuj48YmyXbqJGKnuFc3QuKsNLhR2wrij9bkzHRRqDwGF1s8Trx/b8Cl7A87ZJ/X
         ipVg==
X-Gm-Message-State: AOAM530Yn7voCSBKfSfPpM7C8sYcw9VxNUEQd9KZNduNGXjzKbym1MV0
        fE1nTSgg7MTBpErWdQO6SzXYt7neVBv6JQbp8x3JpgFYwTAUKnW+jEGI2bVvbrPD9vWrxlwc0Ux
        ckrB7hpM2n0iT1hEz1QVb1Mo+
X-Received: by 2002:a05:6638:dc7:b0:32b:a483:16b8 with SMTP id m7-20020a0566380dc700b0032ba48316b8mr423070jaj.66.1652896272819;
        Wed, 18 May 2022 10:51:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4yot0L8H1GFnxd+jBFDsw6Yt7jnmhEuw0qSATO4iI9tLeFnhC04lgVq81N4r1GIYOBFpfHg==
X-Received: by 2002:a05:6638:dc7:b0:32b:a483:16b8 with SMTP id m7-20020a0566380dc700b0032ba48316b8mr423057jaj.66.1652896272606;
        Wed, 18 May 2022 10:51:12 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g15-20020a92dd8f000000b002cf5aae6645sm727757iln.2.2022.05.18.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 10:51:12 -0700 (PDT)
Date:   Wed, 18 May 2022 11:51:10 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm/vfio: Fix potential deadlock problem in vfio
Message-ID: <20220518115110.23a0e929.alex.williamson@redhat.com>
In-Reply-To: <20220517023441.4258-1-wanjiabing@vivo.com>
References: <20220517023441.4258-1-wanjiabing@vivo.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 10:34:41 +0800
Wan Jiabing <wanjiabing@vivo.com> wrote:

> Fix following coccicheck warning:
> ./virt/kvm/vfio.c:258:1-7: preceding lock on line 236
> 
> If kvm_vfio_file_iommu_group() failed, code would goto err_fdput with
> mutex_lock acquired and then return ret. It might cause potential
> deadlock. Move mutex_unlock bellow err_fdput tag to fix it. 
> 
> Fixes: d55d9e7a45721 ("kvm/vfio: Store the struct file in the kvm_vfio_group")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  virt/kvm/vfio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 8f9f7fffb96a..ce1b01d02c51 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -252,8 +252,8 @@ static int kvm_vfio_group_set_spapr_tce(struct kvm_device *dev,
>  		break;
>  	}
>  
> -	mutex_unlock(&kv->lock);
>  err_fdput:
> +	mutex_unlock(&kv->lock);
>  	fdput(f);
>  	return ret;
>  }

Applied to vfio next branch for v5.19.  Thanks!

Alex

