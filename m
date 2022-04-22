Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF25950B640
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbiDVLje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbiDVLjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5197AD4E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650627399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfEjtIKSL4He+pHPZ91gOLL5Y9n9DhaWPlm2XzzRFok=;
        b=ZzUM+QKTJ5WomG47FuJ7beAw/qy4JTyQqsPHlU7RvRfmDWLaogVn0fZ3E3JNXm9VJFgA/4
        /m8/Jt2x9y93KThjOdUsiXeTeb20C+B/FCqxHd8CPdOKbWfYY0VUrIVOJGNqS5eaZlSnQJ
        I+wwboVI1RdBf+c6Xr5c56ddE8OfUIY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-6QWFjratOfaLFVp71jX6Cw-1; Fri, 22 Apr 2022 07:36:38 -0400
X-MC-Unique: 6QWFjratOfaLFVp71jX6Cw-1
Received: by mail-qk1-f198.google.com with SMTP id bk23-20020a05620a1a1700b0067b32f93b90so5179908qkb.16
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rfEjtIKSL4He+pHPZ91gOLL5Y9n9DhaWPlm2XzzRFok=;
        b=H31L3q+eoBR7CUYfvM6395jqRI+r06AZ0sejaDbSRHLxmS08RBZY/eObdufVlWHfda
         1/Eau0hf9FXtBgNV2SwwZcxKDJDZb0nGUEj42CLEKVIviS/CwFI+X/rwTqYiNRsaxw6I
         1HdKDpotNuy7ksELnAfzeHNAQ+AvvraU49EtwOix2KABpPKgji4cQ1HNRPDdr1QvFkyX
         yleOLAAUgbJufQpxS5es208o8ZH9OJD+GTAcbpH48XDTci4pFr5XuAUR5/3iKt5nnffD
         Dj8ZjL0QCIL+6S2RNwo7F7WZDJEiKooAOgkKJeSz6mu/20X3ngdATeUgtIebbmPS7EZN
         i1Fg==
X-Gm-Message-State: AOAM530ibor4o7q41yXZAOapbutOpXqPr8M3rc1vnJFHIOdN7z8ssTc+
        02umH8kyn+4wtCorLlE6ehz6/g581Br/7z7uHOc8vXBVrvXzEG2yYxnZ0BBCeON+MH6qr1+wRCg
        pdfuifgxjepROmRYM3+tD7HpD
X-Received: by 2002:a05:620a:1654:b0:69c:7035:b31f with SMTP id c20-20020a05620a165400b0069c7035b31fmr2297898qko.546.1650627397808;
        Fri, 22 Apr 2022 04:36:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGQvyIHXFTiMJN4w9uTECim1QktNe4yTDbMmuBGoP1GUhkjlyryqtd5m7Ebl2PkbUXwitfjA==
X-Received: by 2002:a05:620a:1654:b0:69c:7035:b31f with SMTP id c20-20020a05620a165400b0069c7035b31fmr2297886qko.546.1650627397596;
        Fri, 22 Apr 2022 04:36:37 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h75-20020a379e4e000000b0069db8210ffbsm791750qke.12.2022.04.22.04.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 04:36:37 -0700 (PDT)
Subject: Re: [PATCH] kernel/irq/matrix.c: remove redundant assignment to
 variable 'end'
To:     Colin Ian King <colin.i.king@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220422110418.1264778-1-colin.i.king@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8016b196-6a39-8808-b1ff-286aacb2c8ca@redhat.com>
Date:   Fri, 22 Apr 2022 04:36:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220422110418.1264778-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/22/22 4:04 AM, Colin Ian King wrote:
> Variable end is being initialized with a value that is never read, it
> is being re-assigned later with the same value. The initialization is
> redundant and can be removed.
>
> Cleans up clang scan build warning:
> kernel/irq/matrix.c:289:25: warning: Value stored to 'end' during its
> initialization is never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   kernel/irq/matrix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
> index bbfb26489aa1..1698e77645ac 100644
> --- a/kernel/irq/matrix.c
> +++ b/kernel/irq/matrix.c
> @@ -286,7 +286,7 @@ void irq_matrix_remove_managed(struct irq_matrix *m, const struct cpumask *msk)
>   int irq_matrix_alloc_managed(struct irq_matrix *m, const struct cpumask *msk,
>   			     unsigned int *mapped_cpu)
>   {
> -	unsigned int bit, cpu, end = m->alloc_end;
> +	unsigned int bit, cpu, end;
Reviewed-by: Tom Rix <trix@redhat.com>
>   	struct cpumap *cm;
>   
>   	if (cpumask_empty(msk))

