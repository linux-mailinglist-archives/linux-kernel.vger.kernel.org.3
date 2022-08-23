Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39EF59E9F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiHWRlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiHWRkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:40:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C57F8169E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:40:45 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 1so6635031pfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=v6lRPM+3zN/ip04eMnlUz/vm6I+nhZAf0/gIGNk1rpA=;
        b=jlfFEYvnx6DVboNEmMYPyjpwUAdYWn6hoEehW78moWu9vbNtLiSKoKvpcDGEK3XrPk
         GkO+3nl25yeQ+NFvpxNRz3RfEU8rUJPChlYoEYADrOiPvP2TAIeOBm1samMemvuyJvuR
         74kyiOz6Ckb8jP5tBXS1OuOcxTkYFwsu1zVz9EyeqNhkAZMxVH7LxQ9NUK++XSd+hksq
         7X9zGM4MdFNFLTncLdGaCAeQEi1KL4Cy4SOTszAqqbwiT5f7RKBPr6ASWHdMPY9N2LNy
         PFc7pM2mRR3bkz8M22dPlEzIJK8pACgy4I9w9Z3l5Poyz3w8fUq4+MpuYA9zJeiMecbd
         9Nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=v6lRPM+3zN/ip04eMnlUz/vm6I+nhZAf0/gIGNk1rpA=;
        b=FZV1RUj5f/ylw7ibQCULzMu3eDs5W88g7EZxL5x5ranRtYC8p/ja+FmJw9lSBFC7Wu
         YyAo+QIsnaqOmPo2VCh9AskPtC4lZKCJPAYLvqNUC35EW+m1WetUnFfXulw/thD2CKyO
         afi1XXCFBnaoUDK3ti84pwx8U1amQrONL+Cy0rSxXvyNxVDF9ylVi67xYHunQd0Zy6J3
         GemBCnHwDtHpJA7tS3tv9qK+5MAanyuZIZq+/wb8Gb4b3JbUwfaTFrtxTkl3O3g1DPeS
         AJq5dzCy/Eotuq7phiNS7cWY/nGNK0bkNvxm3zeEFXXXrkdaK3fpP+LBKzRCC7EMlRKc
         Vf3Q==
X-Gm-Message-State: ACgBeo3zTsPdHOVhxRLK9mWCsdgmIsk1UBHrOzltu2VzzZHBAuZoEGN7
        QsCzUZMjKDuz/HPuAL33AQVQJw==
X-Google-Smtp-Source: AA6agR7EBZp5nRbUJaxMRef64NoaMQBoniN4qwub/Ab0fL63zfQgRFmF0TAxcgdbiG3/zsAyzUXmog==
X-Received: by 2002:aa7:84d3:0:b0:535:fea5:2ccd with SMTP id x19-20020aa784d3000000b00535fea52ccdmr22382134pfn.19.1661269244499;
        Tue, 23 Aug 2022 08:40:44 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s19-20020a635253000000b0040d75537824sm5072135pgl.86.2022.08.23.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 08:40:44 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:40:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sagi Shahar <sagis@google.com>
Subject: Re: [PATCH v8 018/103] KVM: TDX: Stub in tdx.h with structs,
 accessors, and VMCS helpers
Message-ID: <YwT0+DO4AuO1xL82@google.com>
References: <cover.1659854790.git.isaku.yamahata@intel.com>
 <d88e0cee35b70d86493d5a71becffa4ab5c5d97c.1659854790.git.isaku.yamahata@intel.com>
 <651c33a5-4b9b-927f-cb04-ec20b8c3d730@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651c33a5-4b9b-927f-cb04-ec20b8c3d730@linux.intel.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022, Binbin Wu wrote:
> 
> On 2022/8/8 6:01, isaku.yamahata@intel.com wrote:
> > +static __always_inline void tdvps_vmcs_check(u32 field, u8 bits)
> > +{
> > +	BUILD_BUG_ON_MSG(__builtin_constant_p(field) && (field) & 0x1,
> > +			 "Read/Write to TD VMCS *_HIGH fields not supported");
> > +
> > +	BUILD_BUG_ON(bits != 16 && bits != 32 && bits != 64);
> > +
> > +	BUILD_BUG_ON_MSG(bits != 64 && __builtin_constant_p(field) &&
> > +			 (((field) & 0x6000) == 0x2000 ||
> > +			  ((field) & 0x6000) == 0x6000),
> > +			 "Invalid TD VMCS access for 64-bit field");
> 
> if bits is 64 here, "bits != 64" is false, how could this check for "Invalid
> TD VMCS access for 64-bit field"?

Bits 14:13 of the encoding, which is extracted by "(field) & 0x6000", encodes the
width of the VMCS field.  Bit 0 of the encoding, "(field) & 0x1" above, is a modifier
that is only relevant when operating in 32-bit mode, and is disallowed because TDX is
64-bit only.

This yields four possibilities for TDX:

  (field) & 0x6000) == 0x0000 : 16-bit field
  (field) & 0x6000) == 0x2000 : 64-bit field
  (field) & 0x6000) == 0x4000 : 32-bit field
  (field) & 0x6000) == 0x6000 : 64-bit field (technically "natural width", but
                                              effectively 64-bit because TDX is
					      64-bit only)

The assertion is that if the encoding indicates a 64-bit field (0x2000 or 0x6000),
then the number of bits KVM is accessing must be '64'.  The below assertions do
the same thing for 32-bit and 16-bit fields.
 
> > +	BUILD_BUG_ON_MSG(bits != 32 && __builtin_constant_p(field) &&
> > +			 ((field) & 0x6000) == 0x4000,
> > +			 "Invalid TD VMCS access for 32-bit field");
> 
> ditto
> 
> 
> > +	BUILD_BUG_ON_MSG(bits != 16 && __builtin_constant_p(field) &&
> > +			 ((field) & 0x6000) == 0x0000,
> > +			 "Invalid TD VMCS access for 16-bit field");
> 
> ditto
