Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3154D1D04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348283AbiCHQT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbiCHQT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:19:26 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E955427170
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:18:29 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t19so13953105plr.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/g6o8su2Hk/zPgoUfjrHPTRcmqqT0E/Il4cBIitP3q8=;
        b=GTCzEH82Rnt5FXgl1VRwd7dNo+KQvT4TpRHahjGuBnV/x2AKKeIC9XKrvuZEmbRSC9
         ocZyofopdAHtAf5AUhqf+pIcHOkhMSr90cpLPkPW7cJ3bcAd/kua5xF/u9lYswfP+ClF
         Y4Nl+H8d7W/Py3AKp23Ps1IoGT0So+1y3lKwYQ7qat5s7g3S1n+QdA6R3KppamK8ssym
         EVPwrf2oj1ZHOuwnRWggdGe7YkGZTP8ocLdnxkzXfbpkPmHH0FzUqC1odPX98BU5e8ji
         iMkpgqK27vF9X5hNXbn6jDmiyE3O3OAcZOU6oh91zbbAYWJtOmouXVg1iIGjVKnuMPxr
         11qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/g6o8su2Hk/zPgoUfjrHPTRcmqqT0E/Il4cBIitP3q8=;
        b=2/gqVq+9fjFEfId7ug2cbl2og6JXxYNqN1yYZEHgpkxGohEHuB5XdUdZawBI/Dk2t+
         3Af8vIXRaQ+f6rTLsSI5vRafIySrgZVw0nt4YgxLxtJvxlDnizg+waJHQWhAl06/mEzV
         jpqKnIHkcevnEPwmBxK/4YDrLydjw/9NcFImPSOJVHT7tOKXURP3KAtZ8GslCP05GiW7
         v54kXXg0tWHCiExUblXsB31vzY7S2EI3h+f1OdknKJuYPYJNjOqUcXfLNz1chDlhnN2D
         lYPbMTdm/mtd1kpoOCSjAfjtjXPI6olEf5Z3AQJe3Qe6GLARBFgOrT7NsI2IveEWMmMv
         1//A==
X-Gm-Message-State: AOAM5305zd/3fKTVR+pEmXLwekY6Ahn55d6ekDLq538ZSavTZZzRFc8c
        8nThsOmIdXGA64KOz0xA+8TFLg==
X-Google-Smtp-Source: ABdhPJyHIHEShx9RNJ9IjV0iPtEFIr+XzYj+oAzTTb2boOxTjsTZ42kcLJ9Z0kcYLlt0fjKzHrX5mQ==
X-Received: by 2002:a17:90b:314:b0:1be:dc22:62f2 with SMTP id ay20-20020a17090b031400b001bedc2262f2mr5513818pjb.102.1646756309299;
        Tue, 08 Mar 2022 08:18:29 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id kk12-20020a17090b4a0c00b001bed1ff3717sm3309593pjb.6.2022.03.08.08.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:18:28 -0800 (PST)
Date:   Tue, 8 Mar 2022 16:18:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 02/25] KVM: x86/mmu: nested EPT cannot be used in SMM
Message-ID: <YieB0VT8HrurWYD8@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221162243.683208-3-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022, Paolo Bonzini wrote:
> The role.base.smm flag is always zero when setting up shadow EPT,
> do not bother copying it over from vcpu->arch.root_mmu.
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
