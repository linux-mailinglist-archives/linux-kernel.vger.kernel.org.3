Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A0350A752
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390879AbiDURrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348257AbiDURrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BD6A190
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650563090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/qrcto3C5vh3ouIKAO3cip7P94YKBPTPSMO9FpDxaVY=;
        b=fM/FNYegEechIz4GmVozgzcyH7lMfjWUm/sSUDDh1eebCRuyLIPTwaxYRj60Kjerolx1/N
        Lw9dLm1QnCTkp1MrtYl/Ce663+Ymiks30/i4BPxIPJMUXNYoGPFc8QcI+/th57godl/DPd
        3LOyktffXEN6bAyWiEWzRF800xL6fwk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-qew3Xzl5MPmqVIFQH5EaUw-1; Thu, 21 Apr 2022 13:44:49 -0400
X-MC-Unique: qew3Xzl5MPmqVIFQH5EaUw-1
Received: by mail-io1-f71.google.com with SMTP id c25-20020a5d9399000000b00652e2b23358so3782428iol.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/qrcto3C5vh3ouIKAO3cip7P94YKBPTPSMO9FpDxaVY=;
        b=L4UsOY5UFswH488w6mtYZxKia1Eq4rUuwr7STUc1hEfcK32ztJgcxxq/9gPp7VStk3
         /vwXhUtbD2Q5LIkc1fdCCdXGI/DxvWEeLvVsnaDTQ6ScqCP1m64/1IVz+D7tnwBqh32w
         jgEH6o+B6HBM8tnARxQR9Wk3XEoPvM39SckWbkLBV1WeRSQZv2ri6Obt1vXqk3G8mMsz
         lJJW8QeRKlWmpspHsJIOjpQuZXNCe34lDFV67qhrLLUjJT+PPrSpIxJEEtP7BdBdhHtC
         UOmrO8Hf1NA7I6H74kHDcje1es4mKvJrxfUSiWvWFAng4tIdEClE88f7q8Mt85dCWdIa
         xB/g==
X-Gm-Message-State: AOAM531HeiPHbqZL35SHJmjQxUke40DFO78i1NU7hf6p+pFY7xTxznRf
        dp+rOZgPi7N9DYlZHyTEeaUFUch/7zPWKTnwPfAJSiXS5e44iN5JVdiv0y5+2cvglico19hv+lz
        F/vYelnA01ZgnzBS+WBfcoYZ4
X-Received: by 2002:a05:6602:1211:b0:654:94db:fa48 with SMTP id y17-20020a056602121100b0065494dbfa48mr429048iot.48.1650563089203;
        Thu, 21 Apr 2022 10:44:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl1YQOEVY+1qSNaDbIxcdVgs0qKa/G47nRJAskX+bzbU7JPpMpW0BqMh/3zik9rjEYsNK6RA==
X-Received: by 2002:a05:6602:1211:b0:654:94db:fa48 with SMTP id y17-20020a056602121100b0065494dbfa48mr429042iot.48.1650563088978;
        Thu, 21 Apr 2022 10:44:48 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id w5-20020a05660205c500b006546d0b5f6dsm9867748iox.41.2022.04.21.10.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:44:48 -0700 (PDT)
Date:   Thu, 21 Apr 2022 13:44:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v6 01/10] KVM: selftests: Remove dynamic memory
 allocation for stats header
Message-ID: <YmGYD20mn9hNfAEF@xz-m1.local>
References: <20220420173513.1217360-1-bgardon@google.com>
 <20220420173513.1217360-2-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420173513.1217360-2-bgardon@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:35:04AM -0700, Ben Gardon wrote:
> There's no need to allocate dynamic memory for the stats header since
> its size is known at compile time.
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Ben Gardon <bgardon@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

