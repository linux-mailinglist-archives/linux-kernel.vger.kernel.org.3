Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B405597379
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbiHQP6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiHQP6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:58:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D6D275DF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:58:18 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id jm11so10131281plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=N/WaSsPXcsWnjCnSSPJP4Q8Ljo2CE3bKMSMHFmavyz8=;
        b=rd5QWMpg70Ct1pOLObknk29n4imApi59EIycO1OeIdFy2hCjZgop6xFsUcxPY8zDRN
         qRQ9G6Yk/Df/YdBDWweBIwB5xOlmqF4cBIytynWUIIZDB7cNaUXtNK//9TGYJJsLWLKW
         6VrlUpaPQ5b08gB5Nt96rabBMmBw3GlmL2Mxgafd999QZhZOLw4uaGF9H70fAC8vluK9
         CmjATKwCwI8pqPeNhcTCSJN/2RWzXtpkV2Feco4/v5uMq4fDDxJtJmMQRu2MHECIClSg
         IUcynX83YWS8fxTk5nT4srvW2YL1RoSpqQgFZKfwH2i13byIaMXP/u9O+hTcfPtmLtB8
         o9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=N/WaSsPXcsWnjCnSSPJP4Q8Ljo2CE3bKMSMHFmavyz8=;
        b=R2h5jCgSfOra1k4DY5spQeHTtbuOFt9QAwqQAkFGXmgelquYHAVIwMoqNzoQoJHeZe
         v5ehLq8tjRTKQsWjTtX0/i9zq55lwuIZ+hfdfsIbnzJYLodqj/lMoQBNkAlpK34CDhxB
         FMXvIu2acZE946rLx3FSotyQ59R4UO7W1XQrZvgnbL9X+7BSkc7M+HdQJXo7FR34pA8s
         30JMELf6A/Nf1vDnB9H94R92XJ/QrHS2RlVV/iZjjmD3shoUlhm15K+qvOQXkkxrpvxo
         a2TVZoJ7hWbmfIChF5MPVUmrL8j3+pmmarmh9qY4OPUkFwJat0dcgSXfrqJjvmAhzIr2
         N7ow==
X-Gm-Message-State: ACgBeo2UICe28uaxsFUB/ZlDu6WvChfXMUNsOOwBHf7yVC/FmQ74WdHG
        6cA5mtvWdwtRt2hf7wSLZQzA5YYw/VIxmA==
X-Google-Smtp-Source: AA6agR49cFPYRbFIlHQtThHDIiPqtcvprLzHgXVPdqbz+ILfXAukXL6pKJt9AcImmPKj9L3KL79G2g==
X-Received: by 2002:a17:902:b489:b0:171:5091:d53b with SMTP id y9-20020a170902b48900b001715091d53bmr27369354plr.44.1660751898152;
        Wed, 17 Aug 2022 08:58:18 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d23-20020a631d57000000b0041c3ab14ca1sm9550364pgm.0.2022.08.17.08.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 08:58:17 -0700 (PDT)
Date:   Wed, 17 Aug 2022 15:58:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] KVM/VMX: Do not declare vmread_error asmlinkage
Message-ID: <Yv0QFZUdePurfjKh@google.com>
References: <20220817144045.3206-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817144045.3206-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+PeterZ

On Wed, Aug 17, 2022, Uros Bizjak wrote:
> There is no need to declare vmread_error asmlinkage, its arguments
> can be passed via registers for both, 32-bit and 64-bit targets.
> Function argument registers are considered call-clobbered registers,
> they are saved in the trampoline just before the function call and
> restored afterwards.

I'm officially confused.  What's the purpose of asmlinkage when used in the kernel?
Is it some historical wart that's no longer truly necessary and only causes pain?

When I wrote this code, I thought that the intent was that it should be applied to
any and all asm => C function calls.  But that's obviously not required as there
are multiple instances of asm code calling C functions without annotations of any
kind.

And vmread_error() isn't the only case where asmlinkage appears to be a burden, e.g.
schedule_tail_wrapper() => schedule_tail() seems to exist purely to deal with the
side affect of asmlinkage generating -regparm=0 on 32-bit kernels.
