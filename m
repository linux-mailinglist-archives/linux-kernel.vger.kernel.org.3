Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2261F54B75A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbiFNRIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344838AbiFNRIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F8EF1E3C2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655226511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arExzYcJh6coYBGryTUDrklEuifMUMl6IcPdTTiqMP4=;
        b=LLQulmyLZUabbqkOQEF45DbOBTBJEb/OyjhRqtK92KGNLKGpfc6d94T6rIdqOH9JprAMOF
        8QoCZW5ltlIa8Anw0oNMAVz79xjs7qJGiKap4OKUlAo1Fv72gWWoF4wWBS2TCSSOgTynh7
        ZpLXvdI4Bn5cMj8pt2RTNXgn5XTpxIQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-ebTkO7e9MWmPkFL5pdRrtw-1; Tue, 14 Jun 2022 13:08:30 -0400
X-MC-Unique: ebTkO7e9MWmPkFL5pdRrtw-1
Received: by mail-wm1-f69.google.com with SMTP id p24-20020a05600c1d9800b0039c51c2da19so820545wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=arExzYcJh6coYBGryTUDrklEuifMUMl6IcPdTTiqMP4=;
        b=qKItwFZQVMe86NWv7K8CLmOPsLu97t1z6G14c1JANmAP2u/1KW1m6/DwRirDJQQf09
         PeFpPLYaGO4FK6h47ZYNLKDEy+nkzIHDAEgPUdQ9dn17UMnueI2XDldv0QQrbgUqD0jJ
         HK3/ToMI9MCa3kTaBLlwVdYaJfDlhmSCjdGdYiRpcUX+fL5aSZKiauiyT9ixjl7MyN4Q
         us2BL0BAx8jj+mhmtXeFbwzTETAE/Jpha4jFES5QsQ8/5e+EbGLoM4hmOYUzeQJYTgrt
         /wc9Bm5TiYuK+0pWqgDNsFwRYI8MZbj6C6yaVA7PZpU6eRlyx6vwhA1Yiz5zhCKZTwes
         uMyA==
X-Gm-Message-State: AOAM530nHC8C7+i/dPkhjciRB578Vt5H8smq4Q7vVFI7pc8Hrb0SLXtO
        0RrdF1whMs3myPZOnxa/h7ZYwTJbbFbYTF+UwbsZt2esuMxZSTAUxQAkDFZQ1PVWNbZngD8aS4X
        FXESWsmnWtZ28TfN+BlSdPYk7
X-Received: by 2002:a05:600c:3c8f:b0:39b:808c:b5cb with SMTP id bg15-20020a05600c3c8f00b0039b808cb5cbmr5233770wmb.11.1655226508827;
        Tue, 14 Jun 2022 10:08:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfulXSgkHcoNVhCpVUCALcchmTfsuX5OOOyVvW4iK4zOt/EXcjhLh+v88uAeKhN5Ss7V1otw==
X-Received: by 2002:a05:600c:3c8f:b0:39b:808c:b5cb with SMTP id bg15-20020a05600c3c8f00b0039b808cb5cbmr5233737wmb.11.1655226508556;
        Tue, 14 Jun 2022 10:08:28 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id e15-20020adfe38f000000b0020fd392df33sm12241754wrm.29.2022.06.14.10.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 10:08:27 -0700 (PDT)
Message-ID: <6e602ced-a19f-0691-0cda-553dad46a130@redhat.com>
Date:   Tue, 14 Jun 2022 19:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] KVM: selftests: Remove the mismatched parameter comments
Content-Language: en-US
To:     shaoqin.huang@intel.com
Cc:     Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Peter Gonda <pgonda@google.com>,
        David Dunn <daviddunn@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614224126.211054-1-shaoqin.huang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220614224126.211054-1-shaoqin.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 00:41, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
> There are some parameter being removed in function but the parameter
> comments still exist, so remove them.
> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
>   tools/testing/selftests/kvm/lib/kvm_util.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 1665a220abcb..58fdc82b20f4 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1336,8 +1336,6 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
>    *   vm - Virtual Machine
>    *   sz - Size in bytes
>    *   vaddr_min - Minimum starting virtual address
> - *   data_memslot - Memory region slot for data pages
> - *   pgd_memslot - Memory region slot for new virtual translation tables
>    *
>    * Output Args: None
>    *
> @@ -1423,7 +1421,6 @@ vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm)
>    *   vaddr - Virtuall address to map
>    *   paddr - VM Physical Address
>    *   npages - The number of pages to map
> - *   pgd_memslot - Memory region slot for new virtual translation tables
>    *
>    * Output Args: None
>    *

Queued, thanks!

Paolo

