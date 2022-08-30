Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894955A6F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 23:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiH3VrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 17:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiH3VrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 17:47:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605268B9A0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:47:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t5so12416915pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dVlzunJUSzWThV4T6DnGxZVU8CH0mAS4M8OrhLIAz/8=;
        b=ojIaOXncfdguOJaR4zBmlj1oXRUBlg9o6lKNRObncl1gOn85wetAyeYtaFwLxgLY72
         OD+ZV9WRib6vCl6CByBAheOYUrvjY+t+Yhmc+FkgFePpyUjjyh97Csj2R6qo7dplehrD
         iPXz0KhpizAVXD0yJAYK7t5/Y7SiRze/HSTb24XHEpbTZMFZiXzA97qudG3aAqHe+1rY
         a80UFXv6A8FAbCWO/o8QzJdt+MVcJISlt2z54fmYHFVjcOXlrSp3Hch6BLVeBC06zd9I
         2y9J7ic/dkK6plIl1xxKHAHK7fCrxrkAEOCIDBaJPkQeKtxPRUITMjaa8mHdMTinlGm8
         HODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dVlzunJUSzWThV4T6DnGxZVU8CH0mAS4M8OrhLIAz/8=;
        b=yQ62r14zbMizXeEjq8mjN/4I3/ryB9wvp0c9pCi16oQX1F3b3GU6W+mhYzScnFJdA3
         QqNnm5uOvAAJWc3yBmCNeE+WsFVGdwIimonZfCMPVzd27OXH5H6x/PK2JrHhs3ZAJclY
         ZIFY/pZs3xuS3poBdMoldA83Ii7g/SkD6dOqIg2tQdpELMsBs8T4RT1yJCelsaLBNtf9
         Gm+DLvc50iZvhwIqBDkk2K0IMgW+CF2MGCn1sUrISiVGq4ra5q6SVFtBXykVxhvVKWGV
         VRm3dXjvJrrvpTLht5f326dJ8WAhe28ARoC/dbk+nlE7FE+QT3LPBh+Upsgy3oYMfykB
         gDeg==
X-Gm-Message-State: ACgBeo2TRK+i75PPgBDJsfkKtGok8wSYwEjuV4JlaR8wBKBWpP1t07E3
        fuFPIIEbQhBc2F5+N3RjRsD1Bw==
X-Google-Smtp-Source: AA6agR6LDvHrQi12qh3N1gzEOhhEt53EIuFStmnQA0FwU3grdc31xOk0cvoAi7uKUbduttsF9ybfhg==
X-Received: by 2002:a17:90a:640c:b0:1f7:6ecf:33b6 with SMTP id g12-20020a17090a640c00b001f76ecf33b6mr47781pjj.3.1661896019769;
        Tue, 30 Aug 2022 14:46:59 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ij24-20020a170902ab5800b001753eb6668csm329636plb.251.2022.08.30.14.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:46:59 -0700 (PDT)
Date:   Tue, 30 Aug 2022 21:46:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH] KVM: SVM: remove unnecessary check on INIT intercept
Message-ID: <Yw6FT8eWqNsK4VT3@google.com>
References: <20220819165643.83692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819165643.83692-1-pbonzini@redhat.com>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022, Paolo Bonzini wrote:
> Since svm_check_nested_events() is now handling INIT signals, there is
> no need to latch it until the VMEXIT is injected.  The only condition
> under which INIT signals are latched is GIF=0.
> 
> Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Pushed to branch `for_paolo/6.1` at:

    https://github.com/sean-jc/linux.git

Unless you hear otherwise, it will make its way to kvm/queue "soon", thus completing
the circle.

Note, the commit IDs are not guaranteed to be stable.
