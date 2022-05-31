Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A75395DE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346841AbiEaSGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346820AbiEaSGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:06:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7CE9BAF5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:06:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so3578815pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U8KygP5HX4ANbWdbvL1PVBHCmW/9zwhKWrTofJUHJ8g=;
        b=KpPTUTlHGzyq7z5TXtGgnCLsz3TsaVTwnC4R9n6g0KBCtTdRfC2tR5xORvaoaLa8zh
         09JbbaBhFlQfDHE5Fj8AzFo66zQtsoCo92UplQ4sBBRovj11j68IW/cDcnFkkALLfQkI
         pvNwSTgedSrgMdoDINic6e3UhJLDzHxkj4xno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U8KygP5HX4ANbWdbvL1PVBHCmW/9zwhKWrTofJUHJ8g=;
        b=0rDdgHxAqXJQt/3BNYH/jv9jFwdbfzx0OxzBrNLKp/Ygk+PxkYuft6WHMseFt/WFsd
         TQ37RalPt8CYqAgXtLsM1LqObAT1XLDzE6WBD78rYcgKvScRZzVOvoGIwXvPqTT7Pste
         M/bBEfE/Zf4pqPxAIUBIRSmaW3Utm1s2YZcp995ZivuvgDLmCjXS8BpVe7+JKiiGL1XZ
         vlUpx8/Ajszc5MiND0LKmyFUfbOdBPiR9s7DeeDe3OqVq/nCuQbi49+y883yy3/qdpo1
         zuUR9V6lKm84Ld0TkDOVObXRklJ83ITL0FobqC9TXAYD/LB/AENoh+79PbOOYOJhWAVE
         ZwJA==
X-Gm-Message-State: AOAM530w//DLds3j0KnKN8qN0wFpcRQkuhgHSrQY78w+VYjjiIDeBr6j
        sp/yn4fE2G8MEJylAto+4PedZA==
X-Google-Smtp-Source: ABdhPJxk0k0IE5MQ41zL5Wf8a/XJyLVLt7RJkuxqWxrzaxR2uwDa6Fx1or0jb5xUH07KYscnYdZ2Rw==
X-Received: by 2002:a17:90a:2e83:b0:1da:3273:53ab with SMTP id r3-20020a17090a2e8300b001da327353abmr30031100pjd.14.1654020376713;
        Tue, 31 May 2022 11:06:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b0016170bb6528sm11559540plf.113.2022.05.31.11.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:06:16 -0700 (PDT)
Date:   Tue, 31 May 2022 11:06:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Dinse <nanook@eskimo.com>
Subject: Re: [PATCH v2 8/8] KVM: x86: Bug the VM on an out-of-bounds data read
Message-ID: <202205311106.76479DB1E6@keescook>
References: <20220526210817.3428868-1-seanjc@google.com>
 <20220526210817.3428868-9-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526210817.3428868-9-seanjc@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:08:17PM +0000, Sean Christopherson wrote:
> Bug the VM and terminate emulation if an out-of-bounds read into the
> emulator's data cache occurs.  Knowingly contuining on all but guarantees
> that KVM will overwrite random kernel data, which is far, far worse than
> killing the VM.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
