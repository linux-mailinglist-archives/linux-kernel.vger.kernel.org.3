Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9DF4B00D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiBIW6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:58:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbiBIW6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:58:01 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F5FE051102
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:57:54 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x4so247764plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9hlT9vQoLsVUjhpXGLlm7SvL3xA/YnfAS42BSAPz/pE=;
        b=r734V9jLiaYfgXN0U+a0+2HFTV0eBCXCPquFaY/jlvnSdXeYv8CNvRDh/k7nddphJt
         i8MOmjleXPePA6uvYMQC2S8sulBSJ8DjBef7De+Qt/G30bc1Ij6Wau47EIQHjyvzr767
         zEDwNvkCqLOmt1Jt+Z63JDDnSrNnXQyyR5s0gNfZKAqOn47bYilzIbNHWdbXFsYJhZkk
         dz01b+CjCMs7TzyfXo9oORg+cwjc4++HwDCXGps1KqbJMfg7ozkyCtGABKVvSC3lFm1n
         fC5HzenqA0xBzwiHiaG6eMG6VvXtSS42e9ELMj9likPB63B2zJzx7PaOerJbkPVJpUqw
         I2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9hlT9vQoLsVUjhpXGLlm7SvL3xA/YnfAS42BSAPz/pE=;
        b=F64c23DNXho93/KMlHIo1QRpRim+VnN8P7IrwIgI0zdlLQjBty4V38fqCUxIsh8mFt
         ci9HYLmzkq+964FhspGJQY31MYbV+9i/D4u5If3Ume7k0gpcrWAw5MjQVyfhmiSrqFA7
         94Bk+iPzvggiW7vNvBfa8eIxcMEnlthdD3+xCbmke/ti/yFq3QiG0lQ4OJv5WkZjig9t
         q+Qak7fPEZcKsY0200ACZwHj0N5fPuzEhyAN2D5tcKrMNL3NGBRwTyL5C/oodN1ePFP2
         guU6db65N0UEmqAdMndF4hhgdn2VvcLZLNn2oHtMltr2nSKTzI6lYnYYOvzUZdyqT54O
         9oag==
X-Gm-Message-State: AOAM532Q6I7Rh/d2PdzACSRlxocCmESJ+U8/dKMwQRgqhEnDbQKZGjci
        SpbC6XWR6wI6bhLW3egbrAmEjkCZNorStg==
X-Google-Smtp-Source: ABdhPJzxCieXiOFBmRxLOPkMpJ+lVohhiFAWUBH7GcomfK6r/tS+mSnDhcBvuqYoUy/9VfU1Cv+eLg==
X-Received: by 2002:a17:90b:3a82:: with SMTP id om2mr4731200pjb.167.1644447468162;
        Wed, 09 Feb 2022 14:57:48 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gk15sm269582pjb.3.2022.02.09.14.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:57:47 -0800 (PST)
Date:   Wed, 9 Feb 2022 22:57:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com, vkuznets@redhat.com
Subject: Re: [PATCH 04/23] KVM: MMU: constify uses of struct kvm_mmu_role_regs
Message-ID: <YgRG6GPX906Yy51b@google.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204115718.14934-5-pbonzini@redhat.com>
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

On Fri, Feb 04, 2022, Paolo Bonzini wrote:
> struct kvm_mmu_role_regs is computed just once and then accessed.  Use
> const to enforce this.

It's not new enforcement, just syntatic sugar (though it's tasty sugar).  All fields
in struct kvm_mmu_role_regs are const specifically to prevent such a struct from
being changed regardless of how a pointer was obtained.

struct kvm_mmu_role_regs {
	const unsigned long cr0;
	const unsigned long cr4;
	const u64 efer;
};
