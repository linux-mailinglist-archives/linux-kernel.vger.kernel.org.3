Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21245395D3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346787AbiEaSEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiEaSEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:04:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1047CDEB
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:04:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so426514pjm.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B8GjlwO1IDX8yQKTLhckP0RN3+Br6mUp/BEeeHNZ6P4=;
        b=ZFcjgximABJ3ZUmxA9Is/VEnNr1rXySVubxg/ntgf3GpLwYD8ytU5yyGTW47xZsAs8
         9Worlrjwrl+/B2d/vPjE4YJ7y02pqfQ7qkmqOr9y1XLaCSzKGD6Dxn78blrs+EpX5j+Z
         rfw0ehW0YyqEnRyt9jaWfERU8seXFCQz0nUk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B8GjlwO1IDX8yQKTLhckP0RN3+Br6mUp/BEeeHNZ6P4=;
        b=0Ezi6g7njxNf3VJyVxe0OsoO0TUDrxs99tZyIeJJq+SHp51TCf5CV+UP0KiaABlELp
         FEefgZNlBxD6ncdQG7NtlV2J6Ip/RdIGCraTA67ebadK9SnIynzhbiS/4jDINgd8aZV4
         4n1rJwG8A3CiCTGl9l+eFRu/7TR/6gCPtYxJd3yXjjqicLHbC1ludWQ3IwCaPijPjIWa
         5naNHGNZyoBG5gYGiLPOyLDlkBD+h1/RSBL0g3145s/P0lk4CIEZs1ci3TyrbILf6oC0
         3Le2QYgBsNFYk8OhXQrjsOOGw8bAeXtsyehdwU8EKH1/EO+nDsZS+YhALuEYYlNAvLMZ
         44kg==
X-Gm-Message-State: AOAM5326BaoNVmoEtdXHUSZbPI5Liu4VKizvMzcaaSOjDvCHDuniayWv
        nZDsM4psLnsVrr8lyMmTy9tOsg==
X-Google-Smtp-Source: ABdhPJxFVAHZvI3yS7iKqKpUOeEpUkv3rQI+avm+uvdfAPmjPGviNqZhC8i3isuBW8HlLuZF6waraA==
X-Received: by 2002:a17:902:8644:b0:15a:3b4a:538a with SMTP id y4-20020a170902864400b0015a3b4a538amr62298333plt.146.1654020247135;
        Tue, 31 May 2022 11:04:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u70-20020a627949000000b0051ba7515e0dsm462657pfc.54.2022.05.31.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:04:06 -0700 (PDT)
Date:   Tue, 31 May 2022 11:04:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Dinse <nanook@eskimo.com>
Subject: Re: [PATCH v2 3/8] KVM: x86: Omit VCPU_REGS_RIP from emulator's
 _regs array
Message-ID: <202205311104.5D8D79E3F2@keescook>
References: <20220526210817.3428868-1-seanjc@google.com>
 <20220526210817.3428868-4-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526210817.3428868-4-seanjc@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:08:12PM +0000, Sean Christopherson wrote:
> Omit RIP from the emulator's _regs array, which is used only for GPRs,
> i.e. registers that can be referenced via ModRM and/or SIB bytes.  The
> emulator uses the dedicated _eip field for RIP, and manually reads from
> _eip to handle RIP-relative addressing.
> 
> To avoid an even bigger, slightly more dangerous change, hardcode the
> number of GPRs to 16 for the time being even though 32-bit KVM's emulator
> technically should only have 8 GPRs.  Add a TODO to address that in a
> future commit.
> 
> See also the comments above the read_gpr() and write_gpr() declarations,
> and obviously the handling in writeback_registers().
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
