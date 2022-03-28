Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8744E9815
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbiC1N2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbiC1N2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 108594CD72
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648474027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aY3sYkjLuM3RlptN8oBvpx75lErsnsQyc7EGZhr+deA=;
        b=Ejr1U0ONFqxLqr26VlaRoBAvxdvnbPVaWPffLZIJ45RvQOiUxAa96iR5NI5maPZiaYF0FZ
        k0MWQTCpG95vLLQ60K3j8IjmqNlawlnuek6Ry1hjHkICCt4XslX9yprH/ZRQU9IxQwyxle
        KmozbGBZrqtvTRVGdoE7W03Xnur+/hM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-aW-x8SgaMnGoATNPLmmOcg-1; Mon, 28 Mar 2022 09:27:05 -0400
X-MC-Unique: aW-x8SgaMnGoATNPLmmOcg-1
Received: by mail-qt1-f197.google.com with SMTP id f22-20020ac840d6000000b002dd4d87de21so12127775qtm.23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aY3sYkjLuM3RlptN8oBvpx75lErsnsQyc7EGZhr+deA=;
        b=dV5TULxY+2tfvKCI8SR9l1vjjzkCwKmfxYlvLwdj2lW4Q+QZSUimlobeDdRB2tGqEr
         9xl3IdRGjf52uzRxr5bNBYSZi2kjuB0vpGarnFS8oquPDFxVNvowzCY4iba9kx5/BUWK
         6NjfKQAgm5gkBUXYZUf7S7jjKwKEMg4zk/u/YEfmhWyNiEV/O2HAHvDyXWI6ESB6gZ87
         vq+XHJfpp55YRqeFUE1vfDTG6HQVB7m3d9M/bsRwkdHLGl7xYpPi+Q/G/WTH+O50Mm41
         /gAo3+wjBT4iG/v+kAnuCR2mqERlbAkkqA96ily4Njo9fFs9ZltF9UuLWOZzKtbD0lXP
         1ryA==
X-Gm-Message-State: AOAM531FqveZou8CP3Gm/d33oG0jYCNABe0a4PscPA3RfO9Uh2SoM4Os
        ClGeJCRiEDrj5gd0QgKfQVTknQF+ma4DO8sEPhwVcZd08rtKtB9XzMah26jFvGMHY5hQouHKSuu
        63y/YaiB9zhu6O11x/ihhxMpn
X-Received: by 2002:ac8:7c4d:0:b0:2e1:fef5:e41f with SMTP id o13-20020ac87c4d000000b002e1fef5e41fmr21459110qtv.577.1648474024457;
        Mon, 28 Mar 2022 06:27:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdRi3nr6+vA/ALSykiqh7W/MIIzT9PdQHtKR62/0GYejwiyda6Z0HY6KyKlRs4hkHNeUHzoA==
X-Received: by 2002:ac8:7c4d:0:b0:2e1:fef5:e41f with SMTP id o13-20020ac87c4d000000b002e1fef5e41fmr21459088qtv.577.1648474024223;
        Mon, 28 Mar 2022 06:27:04 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002e06aa02021sm13072251qta.49.2022.03.28.06.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 06:27:03 -0700 (PDT)
Subject: Re: [RESEND PATCH v1 1/8] firmware_loader: Clear data and size in
 fw_free_paged_buf
To:     Russ Weight <russell.h.weight@intel.com>, mcgrof@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, basheer.ahmed.muddebihal@intel.com,
        tianfei.zhang@intel.com
References: <20220323233331.155121-1-russell.h.weight@intel.com>
 <20220323233331.155121-2-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <5ec3e671-53aa-b8cc-1360-c454f3db277d@redhat.com>
Date:   Mon, 28 Mar 2022 06:27:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220323233331.155121-2-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/22 4:33 PM, Russ Weight wrote:
> The fw_free_paged_buf() function resets the paged buffer information in
> the fw_priv data structure. Additionally, clear the data and size members
> of fw_priv in order to facilitate the reuse of fw_priv. This is being
> done in preparation for enabling userspace to initiate multiple firmware
> uploads using this sysfs interface.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v1:
>    - No change from RFC patch
> ---
>   drivers/base/firmware_loader/main.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 94d1789a233e..2cc11d93753a 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -253,6 +253,8 @@ void fw_free_paged_buf(struct fw_priv *fw_priv)

Why isn't a vfree needed or realloc done?

Tom

>   	fw_priv->pages = NULL;
>   	fw_priv->page_array_size = 0;
>   	fw_priv->nr_pages = 0;
> +	fw_priv->data = NULL;
> +	fw_priv->size = 0;
>   }
>   
>   int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed)

