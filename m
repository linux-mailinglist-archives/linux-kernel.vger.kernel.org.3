Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419014BBFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbiBRSkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:40:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiBRSkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:40:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEE92A0729
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:39:49 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u12so7805898plf.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z6Bvj05xcHZ8scACXRLrqFmVNNP/kVQ38WCNRoc9XKw=;
        b=rxk0jwB8ICLKh+8xaKXBp+1GzMw8O3daGo7CE8qC+eNNHZUl5rhvpsxPc+UkJtI9Ma
         KeZVPi9IRBNVjqLEJ+8R50hnUHGRKf56Ufo3ibpmdEciJ39pOv29hlXCt7YMhpLhcUEo
         HUzWguhARNtG9UbfU2cyuBn9ejeRfbvfS3MRi3BVrEHEIgziCmp2twyApgtveBjZY7AA
         sOuTFg6TR9vDcJR3tBxfo9zRB1ayCW/T1YkWUOHacvs9Cg10bh8ZD2XHmrqaylELbP6S
         Fw0y2/FuiOBOdI87r4ncpeVYTQzwFBhefTG/leFRrd8fac2nrgmfiX//dR8VQpyDsyI9
         TAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z6Bvj05xcHZ8scACXRLrqFmVNNP/kVQ38WCNRoc9XKw=;
        b=G2Rwhx37mepP3mvABIKZQEeSN28ScaOzl107CwmSGgZvsBeGbTAwr0+bqlSIK3Ggnt
         IP9F32q5Ubvu+ZriEDSF9hm9hr+Z71zgcGcuJcXeVIczOKRekqFvkoQufarZR5mTYS35
         uyUkqKjwQcVJ5tALHkIZoIdok1xRyKvK0mJ9b6IMwkYx8mQVXqxM5rQ3k3awTeTY6Jdg
         dWGOT76CNqgP+wLbpCwgM0OYtAKcIsr0vTwUDCnUdIBl2s6BXE1FZWab4eHIRISWjfE1
         6K1ErpXJiuV8jVyIielWRY3r3R/d8aa67IWs3O/H/W1mq4bElzVSdubi3DzsbDGlfVnt
         Hhfw==
X-Gm-Message-State: AOAM5300Vpqn8ea367wjKZnb10UQ1+gPEJRZ+xn7Juqpj5qPiF43JNNR
        rmRyHitlGWB/aXGi6Lro4foYe/c5Bs5LKg==
X-Google-Smtp-Source: ABdhPJzjq13fjwW0o9GeWGu5+HhZkEk3XYCmh4PYDrDLtL3cQaeU7+asPz9j0b75b+hI9CssfaYEIQ==
X-Received: by 2002:a17:90a:bb0e:b0:1b9:fffa:f030 with SMTP id u14-20020a17090abb0e00b001b9fffaf030mr9613386pjr.206.1645209588900;
        Fri, 18 Feb 2022 10:39:48 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id on17sm104807pjb.40.2022.02.18.10.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:39:48 -0800 (PST)
Date:   Fri, 18 Feb 2022 18:39:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 08/18] KVM: x86/mmu: do not pass vcpu to root freeing
 functions
Message-ID: <Yg/n8dC7Umd5x0m6@google.com>
References: <20220217210340.312449-1-pbonzini@redhat.com>
 <20220217210340.312449-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217210340.312449-9-pbonzini@redhat.com>
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

On Thu, Feb 17, 2022, Paolo Bonzini wrote:
> These functions only operate on a given MMU, of which there are two in a vCPU.

Technically 3, but one is only used to walk guest pages tables ;-)

> They also need a struct kvm in order to lock the mmu_lock, but they do not
> needed anything else in the struct kvm_vcpu.  So, pass the vcpu->kvm directly
> to them.

Wrapping at ~75 chars is preferred for changelogs.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
