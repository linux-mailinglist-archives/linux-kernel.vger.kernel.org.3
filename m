Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA414ECDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiC3UIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiC3UIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:08:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB85D19C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:06:49 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j13so21492557plj.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zz99CC/dzN0eKJq2+dN0xgIk5MEz2najshGkZSY+2K8=;
        b=lXcRLFGBm3OOD7++f2H7UcUVxFqk6ODsXpbDcaMGKaQ8St/MfvpJOzMDLzvE00SH5C
         676TZvbAj2IlNNuVqOwIhos4c4xpaXIbhJFMeBePgRhWvYM6ITc6yaNBuxm3N0H/m7yE
         iNHLmTXMxYJDmGtQs0w02WKoKZXpy+BIZaEmNmyvPhwhJkmQoO3xTptFkuwdlwDhCreK
         k1q/OQQ5u3KATvhOHpRKPuwScqf/KdUck7jJP2CQ8L5D9gh76mIqRzp8W2mqfPNNPjGW
         UQUbEc2zjKyJKkx+cR5EBzolRuWCccau/qBpIUXOQPCs+unVXu77K7xa3dE6cPRsnfwm
         CF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zz99CC/dzN0eKJq2+dN0xgIk5MEz2najshGkZSY+2K8=;
        b=HIAVLmOwVHt+OA/UyOfz1qU94/AHP204IXUcB1QdrRFEjFMrZKShsLVBMjnYPYJxJ7
         8HFjBcaL4rJUJF2GdVOl4AZybL5dzwcxBO/qVgbIz3KkniyI/gJv/sNozmylN2UX7VZh
         dcNV5vNqWYDFTALjuJldnL7SQlOnII8eun8LMocUAalA48Qf2nLYWbTl693lkRzxat0z
         8bXa01JAfcFlgJeAiaiPfzhNCxlOgdCIHwSb0mbr0aKkP6tsZ16DrHOiu+5NqJ9qgmiG
         g/iHtzjP3tk/84x8DwFObk6pJ7CgW8s5HXyBEZ/zKQFGT00/X3bjKlRxTbGOG2JJqk7a
         0F6A==
X-Gm-Message-State: AOAM531F0oqZfaR92SJqA0V312t1nwdJmeD4uh88SGRZljmUOunCU9JH
        StAiy10GjpUUJx/DHLbzjAzt8g==
X-Google-Smtp-Source: ABdhPJx0p0Kvtux9zYtuaEVA2gBoIJL0FZuHW0gNsAWIw107ERi54YP0VFNxfVFEDaAFMkGYXhSJNA==
X-Received: by 2002:a17:902:6841:b0:150:9b8c:3a67 with SMTP id f1-20020a170902684100b001509b8c3a67mr1072224pln.151.1648670808911;
        Wed, 30 Mar 2022 13:06:48 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w4-20020a056a0014c400b004fb0c7b3813sm21188919pfu.134.2022.03.30.13.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:05:37 -0700 (PDT)
Date:   Wed, 30 Mar 2022 20:05:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/7] KVM: VMX: Introduce PKS VMCS fields
Message-ID: <YkS398j08ZuXQgUx@google.com>
References: <20220221080840.7369-1-chenyi.qiang@intel.com>
 <20220221080840.7369-2-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221080840.7369-2-chenyi.qiang@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022, Chenyi Qiang wrote:
> PKS(Protection Keys for Supervisor Pages) is a feature that extends the
> Protection Key architecture to support thread-specific permission
> restrictions on supervisor pages.
> 
> A new PKS MSR(PKRS) is defined in kernel to support PKS, which holds a
> set of permissions associated with each protection domain.
> 
> Two VMCS fields {HOST,GUEST}_IA32_PKRS are introduced in
> {host,guest}-state area to store the respective values of PKRS.
> 
> Every VM exit saves PKRS into guest-state area.
> If VM_EXIT_LOAD_IA32_PKRS = 1, VM exit loads PKRS from the host-state
> area.
> If VM_ENTRY_LOAD_IA32_PKRS = 1, VM entry loads PKRS from the guest-state
> area.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
