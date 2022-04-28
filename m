Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7394F513BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351195AbiD1Soj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiD1Sof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C55636472A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651171279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1eSTHLEiN1paqO9iGNNDPabWBPzx8Xt+gOXMQOER74=;
        b=ez3Z9u9Mpfqw010z1BCXW36fMptzajS81z2fh5qjHiYI9iubNzvc4CdKbvg94lhqkQRpwm
        4NNrZ4R5yKuHCaOKBeAoycHbUerdlDrwOxC1+BpKqUQYr6wxAjURf00r9AHjZtv+SQt8Fy
        83lXyQk8PP648tU1Awuca2JcmIr1Jj0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-dkygz_wRNXqO_tkaGXj99A-1; Thu, 28 Apr 2022 14:41:17 -0400
X-MC-Unique: dkygz_wRNXqO_tkaGXj99A-1
Received: by mail-il1-f200.google.com with SMTP id u11-20020a056e021a4b00b002cc315db462so2296502ilv.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l1eSTHLEiN1paqO9iGNNDPabWBPzx8Xt+gOXMQOER74=;
        b=sbEgjtAvQcVtji2jUFjx3UzzE/8QTwCR2eC664ERnhpeceUf8JME/iB5peAL8U96CO
         4MxlRKDAmsbKRzvJCzQZ6xQwr0oJdG3oJu3TioStsCYVw433oaLDHfM+aIvuK5ppl+0x
         1JY60s4ZL1NzSBzx2rHutoJMCKqq9fifOPnf+SHtvQehfWhe2/AM4zFF0UPrEriLLc7w
         hDoU90Jp/FtDiIdutIaZ0NxUbN519zte4MWd4R4cTOSpfJcscAWOHSjYmFRh0ES/oAfZ
         BJqiBhBhQPuhDmxB2JOzgM/Dcrjv/VfUjKpgqgwFAhdKXD9NSWBYZLPYNa189BqjyYaA
         KIEQ==
X-Gm-Message-State: AOAM533D0+nli8imSl87jk+ALciW7k+8IpKYDNBemSu8O6lnSqIfO/nW
        4bySMSnGWj3XHy1r30QzAkEFpFJBcPnAkT5zVoNPTQMjPGWQ09rJ2D90nFTKS4/9NWc2a+Cnmon
        I8NlE7LOq6Ayx5kUhO1Wc1Hx6
X-Received: by 2002:a05:6e02:1608:b0:2cc:1bf8:bf2f with SMTP id t8-20020a056e02160800b002cc1bf8bf2fmr14374252ilu.219.1651171276635;
        Thu, 28 Apr 2022 11:41:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg4TV7qKv8m0oowXtuXR6dA2kz2uqlrKzgU0aJCpxAntLnfCLoA0UWoCI6q0SssO4tErCb0Q==
X-Received: by 2002:a05:6e02:1608:b0:2cc:1bf8:bf2f with SMTP id t8-20020a056e02160800b002cc1bf8bf2fmr14374243ilu.219.1651171276381;
        Thu, 28 Apr 2022 11:41:16 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id z18-20020a05660229d200b0064c719946a8sm476253ioq.34.2022.04.28.11.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 11:41:15 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:41:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swapops: make is_pmd_migration_entry more strict
Message-ID: <YmrfynZf7bU0Uoys@xz-m1.local>
References: <1651131333-6386-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651131333-6386-1-git-send-email-zhanghongchen@loongson.cn>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 03:35:33PM +0800, Hongchen Zhang wrote:
> a pmd migration entry should first be a swap pmd,so
> use is_swap_pmd(pmd) instead of !pmd_present(pmd).
> 
> On the other hand, some architecture (MIPS for example)
> may misjudge a pmd_none entry as a pmd migration entry.
> 
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>

The change looks reasonable,

Acked-by: Peter Xu <peterx@redhat.com>

Two more pure questions..

  (1) is there a real issue to be fixed with it?  Asked because I see most
      calls to is_pmd_migration_entry() should already make sure it's not
      none, and,

  (2) why it matters with MIPS?  Firstly this function is not used in arch
      specific code, and iiuc thp migration is not enabled at all for mips.

Thanks,

> ---
>  include/linux/swapops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index d356ab4..1d16569 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -304,7 +304,7 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
>  
>  static inline int is_pmd_migration_entry(pmd_t pmd)
>  {
> -	return !pmd_present(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
> +	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
>  }
>  #else
>  static inline void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
> -- 
> 1.8.3.1
> 

-- 
Peter Xu

