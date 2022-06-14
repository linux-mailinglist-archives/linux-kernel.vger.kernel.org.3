Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F5854ABCA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355673AbiFNI24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355601AbiFNI2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66291344C0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655195324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KByEBSgeM4obm3XP5zIe1UTexQSKb/lcAH9UJiuFrIw=;
        b=VJx5DdY1w5aImPc2rtTc8czfc8DRw5rnYeEm856KnSfrJpqD2HfMVwOj3+90ACWnu6nwZl
        Cgf0u2jEnyDxLilYYA4ojAno4Qz2TAUgoRT2cRSkbeAOdV9/MwB1WxAgQw6OVqXeWLunXQ
        Y58j5UUKamcgxe33a14yGErlugNulwg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-cSHe-3wHP46gnnd_ylspSg-1; Tue, 14 Jun 2022 04:28:43 -0400
X-MC-Unique: cSHe-3wHP46gnnd_ylspSg-1
Received: by mail-ej1-f69.google.com with SMTP id a9-20020a17090682c900b0070b513b9dc4so2570560ejy.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KByEBSgeM4obm3XP5zIe1UTexQSKb/lcAH9UJiuFrIw=;
        b=rrXgmZ8uUtQ7IclBvnYoMV1ueUs/Spwt5d0/AEZCw++p0liQXEbtKavMcw21rN1ujm
         WJDRruxOJT/tCoswKmUGUHshpuete/DvtJRY+V9IHP9rdfdJiGY2E1f1L5rTR/uVbWlJ
         HA7LJhiZcmeis+oPwLEJXNf1aO7eI4vnjys7UaJFMmSlH4Nw5wOJ51iNbyryslOqoV88
         x+yCZn5mDsFV2t021PaKvsijcpFnUZaJAvzOdHVV7CmPLBxGyWH5Z8VMXb7xdJPU1tnn
         cEzIncHQgn+p59ICAB/lBIqG2Bd5nsKHKX6s+CjoLXe79/ujRKYLiFiLOFWlHPyVLvQC
         2aCQ==
X-Gm-Message-State: AOAM532vcH77ifELkFAyR94GEUdmD/cxJpM4bCgmR+NvPz2dFiXVO0Gd
        TVFKX/C7FW6xfXVK1i6xjj4rzmdBCV0VwNvRgnkXxdMhOYXNzq67l+ausrvm12ar0RWLogGcDZ7
        lfLv14g2aztHqr2FWCqZ+t5iJ
X-Received: by 2002:a17:906:51d6:b0:712:c9:8a1b with SMTP id v22-20020a17090651d600b0071200c98a1bmr3307711ejk.656.1655195322084;
        Tue, 14 Jun 2022 01:28:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDLxiVy9ewakvDf7UcsKF/XgtCeL1lKugQaZWmd6BWzHidp+NQWZiN7h5adae5T4y9GLP1Mw==
X-Received: by 2002:a17:906:51d6:b0:712:c9:8a1b with SMTP id v22-20020a17090651d600b0071200c98a1bmr3307700ejk.656.1655195321888;
        Tue, 14 Jun 2022 01:28:41 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id zj11-20020a170907338b00b006ff0fe78cb7sm4751566ejb.133.2022.06.14.01.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 01:28:41 -0700 (PDT)
Date:   Tue, 14 Jun 2022 10:28:39 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     shaoqin.huang@intel.com
Cc:     pbonzini@redhat.com, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Peter Gonda <pgonda@google.com>,
        David Dunn <daviddunn@google.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Remove the mismatched parameter comments
Message-ID: <20220614082839.a5iqpk4td2allbwu@gator>
References: <20220614224126.211054-1-shaoqin.huang@intel.com>
 <20220614074835.qto55feu74ionlh5@gator>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614074835.qto55feu74ionlh5@gator>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 09:48:35AM +0200, Andrew Jones wrote:
> On Tue, Jun 14, 2022 at 04:41:19PM -0600, shaoqin.huang@intel.com wrote:
> > From: Shaoqin Huang <shaoqin.huang@intel.com>
> > 
> > There are some parameter being removed in function but the parameter
> > comments still exist, so remove them.
> > 
> > Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 1665a220abcb..58fdc82b20f4 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -1336,8 +1336,6 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
> >   *   vm - Virtual Machine
> >   *   sz - Size in bytes
> >   *   vaddr_min - Minimum starting virtual address
> > - *   data_memslot - Memory region slot for data pages
> > - *   pgd_memslot - Memory region slot for new virtual translation tables
> >   *
> >   * Output Args: None
> >   *
> > @@ -1423,7 +1421,6 @@ vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm)
> >   *   vaddr - Virtuall address to map
> >   *   paddr - VM Physical Address
> >   *   npages - The number of pages to map
> > - *   pgd_memslot - Memory region slot for new virtual translation tables
> >   *
> >   * Output Args: None
> >   *
> > -- 
> > 2.30.2
> >
> 
> Hi Shaoqin,
> 
> Please check kvm/queue, the extra parameter comments have already been
> removed.
>

Eh, never mind, I looked at the wrong functions. Your patch does indeed
apply to kvm/queue and is indeed necessary. Sorry for the noise.

Thanks,
drew 

