Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F43650A959
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392025AbiDUTlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiDUTlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C321C2AC3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650569888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DBgurQd6wP9JubMGZ4g6gUot4E6ajHZvBQ1X3O5wbSE=;
        b=NRs4BTLNX2fVOwFUSmv/1L9O5Ep83QB+gbp951k9RKQIREMWgasU/1zui0TxHdmtu6f9+4
        4IdIqWJBIiDKnCX92Y23MF8LYYvQnOD+2HzbPvA2kW51vY3duyGL1GJPrzDn4BmmYTneoe
        ID+PcbRvirEVLMRICGE1jCU/WSepq24=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-DgE7SkDaPGOjmEGgMji-ug-1; Thu, 21 Apr 2022 15:38:07 -0400
X-MC-Unique: DgE7SkDaPGOjmEGgMji-ug-1
Received: by mail-io1-f69.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso3952403iov.16
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DBgurQd6wP9JubMGZ4g6gUot4E6ajHZvBQ1X3O5wbSE=;
        b=7ODWqW09pHwDv61nANOJNO+OlWVqADmkpI1o2FcCnzL4GHEchelBQkgpsh6ddgJQUE
         cgvDS9E9nH4wFEwtmzbN2jEVFcs6N18F8vhorV5VvbiWiYfnmNQAKW8JLpGVNcwNFKwb
         Ca2LWWPiC1UADFGVHzRb3g/8iW8Cdrq3akENtFTDp+qmgDVwcNgdgTvQudSVKhuxPGoG
         33g5P37Tfr7W+zU5FzUGJ08IeRmxb52fWeT2T/D09UX5IVXUXGhnK4OXxF1PbKP6tYss
         HtIFcfFfUyR5H5dKws6cMs+ev6YlGJZEAzbH2pBASCB4VlCAezLgX/OWGv9xMDpN03xF
         sVEA==
X-Gm-Message-State: AOAM5335+XTCupKfIueHEBCaPUI/BCYFsIz63y3BtSeuXyz53WluPx/Y
        fa0/kIPLX+jrBr/C78C9+5w9dPwIOUYPkLKlrjCJSnworlBSNqniiNYGPkLzkanz2rjI3LDMtQz
        DyLjEUvfr5YnFqwQVoVT7Kw0f
X-Received: by 2002:a05:6638:1503:b0:326:7da5:243b with SMTP id b3-20020a056638150300b003267da5243bmr566477jat.69.1650569887069;
        Thu, 21 Apr 2022 12:38:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyZKps8B5QReZRJ3kIB/AilzJgiFB90U1CcvZ1PQzcYsgnT4SKiXeFpcS4ftkTo6QDrIUT8Q==
X-Received: by 2002:a05:6638:1503:b0:326:7da5:243b with SMTP id b3-20020a056638150300b003267da5243bmr566473jat.69.1650569886866;
        Thu, 21 Apr 2022 12:38:06 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id r14-20020a92ce8e000000b002cd66e0bbc1sm1186741ilo.33.2022.04.21.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:38:06 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:38:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com
Subject: Re: [PATCH 2/2] kvm: selftests: introduce and use more page
 size-related constants
Message-ID: <YmGynbRAdiFPPWl7@xz-m1.local>
References: <20220421162825.1412792-1-pbonzini@redhat.com>
 <20220421162825.1412792-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421162825.1412792-3-pbonzini@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:28:25PM -0400, Paolo Bonzini wrote:
> Clean up code that was hardcoding masks for various fields,
> now that the masks are included in processor.h.
> 
> For more cleanup, define PAGE_SIZE and PAGE_MASK just like in Linux.
> PAGE_SIZE in particular was defined by several tests.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

