Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF350A757
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390898AbiDURsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390889AbiDURsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8D232AEE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650563119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/p2iSGnfGUle2P8XzRAov/jOOTP3iXLe4XEX9Yg3l0=;
        b=BH4g59vEV5nbszCclkCmwahx9qj+ZEM9p2LCIT9gXdD9SXOyRUKGy/KNwgtSKj3D7O4gwv
        BH+OiEhxTf+R5QWrb/cFZ6Wbq00O0PWFTxbT5xWCsv1wVHUl3Ec1qc9ewWztUOsIIdIB3p
        HI/Pgf6O5WMuqoN9TajJebSDjQXFI+4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-QlCiR89rO72kR1S_YRbjrg-1; Thu, 21 Apr 2022 13:45:17 -0400
X-MC-Unique: QlCiR89rO72kR1S_YRbjrg-1
Received: by mail-io1-f69.google.com with SMTP id k2-20020a0566022a4200b00654c0f121a9so3801837iov.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B/p2iSGnfGUle2P8XzRAov/jOOTP3iXLe4XEX9Yg3l0=;
        b=dGprG1+2eXJMOCEny4xRy4Lu3k0lyJnGnTRR4ludff1JFawCTWi655JqIXTSVo64rL
         jcq8AjGLWd6x1TfA1NJjlT312dcuiTc7aGsUdt3k1TYdhYvcJkVdLF3LiG4xvU5aDWFI
         zi5jCibZR2XzDQ6pbU/Ulu0j2MmNK4FRTL6BCYEkBhfZZ1uVylnCjjjQlJ/7SBwnpiRg
         AN+PODoVWwOl8BJQcUSmPM9GxQVS3Q9kkHu8qaE4nIqzo8F5oC6wRw4MJpeHmlXrFTL0
         R/gI/8Jj6Udt3FhNS7APHQo7f3k49JQfRgX+zQBuv8OjbtTuHzeEOOKiVluOhlWd4lBX
         IlLw==
X-Gm-Message-State: AOAM533L8Hce0F9SK2GQVMYi3gjoUli7vZUSXJAXVB2raCBuOdkzFDZS
        xvNQAVfrxMVCX9k7ihqw1vPdobdnZ/hwlYSLPMjcGvbo62fecE7PiRsGu5RIxUuxX/37mdiBDTN
        sZ0WPAmLWpU/J/MUM5SjL6NEl
X-Received: by 2002:a05:6602:1481:b0:657:2836:587c with SMTP id a1-20020a056602148100b006572836587cmr431825iow.194.1650563117056;
        Thu, 21 Apr 2022 10:45:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNa6ff2f8hwn5Qi+HXlmOKf3dKYEKh4cWhKZwppwzvBeFMvpEGF62C/kioOmXbBtsEXZeYsw==
X-Received: by 2002:a05:6602:1481:b0:657:2836:587c with SMTP id a1-20020a056602148100b006572836587cmr431799iow.194.1650563116486;
        Thu, 21 Apr 2022 10:45:16 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id k17-20020a92c9d1000000b002cacb37614esm12590915ilq.43.2022.04.21.10.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:45:16 -0700 (PDT)
Date:   Thu, 21 Apr 2022 13:45:14 -0400
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
Subject: Re: [PATCH v6 03/10] KVM: selftests: Read binary stats desc in lib
Message-ID: <YmGYKp3E+hHKMIYE@xz-m1.local>
References: <20220420173513.1217360-1-bgardon@google.com>
 <20220420173513.1217360-4-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420173513.1217360-4-bgardon@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:35:06AM -0700, Ben Gardon wrote:
> Move the code to read the binary stats descriptors to the KVM selftests
> library. It will be re-used by other tests to check KVM behavior.
> 
> No functional change intended.
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Ben Gardon <bgardon@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

