Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B2D4B779D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242042AbiBOQz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:55:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbiBOQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:55:45 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31CE117C80
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:55:35 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c10so10248413pfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ncFR85fN36o35lsssnL+wzNGDTqWC9hiHD/c8p65I4=;
        b=DJvP5WHoBzMbtMh4DC1UgHd3F3NZH6uAbOQ9+lOAr4dk9KlWWjyEJ0cK3iLWVrpM0o
         ucvUE54tj/suLWJdMQbd8+xd2S2+VeF+vhqsincACgfT2Am8n7UelphSp6t0T9VRgzqP
         xBi4FAynS/5RhUaTaFlKu/Aw465/Z3xT7IaOKTEWPXSfhV5kT3m+zyKEIK1xnMILuif8
         6FaCqbGh9D7ZTnlBQieAPkpnQsNKvpAIwwd/iYU/Oc13hevOtlIqxwQEXog4WYIE/kA0
         caiUZdM3bP5l7GD17XMi6GujWP/yoo/8goB350cMd+qww54Q/X4sH85sITFAYrQd2RiO
         4tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ncFR85fN36o35lsssnL+wzNGDTqWC9hiHD/c8p65I4=;
        b=i9t89cutAAjc6dj/gUSOhrpa9XYMtSziuW5EVKfBCVVx7BfoBNQ/a3ghujJXUlGYk6
         V7hwt7I6VJIfRzIIno7KV6Qxsa3uxjdMpGwXoFXs/TwAHusseE1dvJ5j5emr31/6r1s3
         GvEQBTz2rVm0ppR76XkvGXzrXFUXTPagI6E920RRqGd4otbEltBDWBlz0rTHTKhoScBb
         C4Qd8lYeFEF+FYrO7oSB9Jwv4wQ/ihUUvm5Xqdr+1L4vLjn38yBrxZjfR/FpJ1n1Ucue
         GEZCanDNjFVNJ32+dfMeOEcT/CRTvfs7c37MFlQIgb2SG+90cRfqfDMKxpAI8fZ5aEqn
         xdjA==
X-Gm-Message-State: AOAM5329ORt2DM8owxTjnzU/N2jYjBOL6J2aw+1KYN3Tyr97lZHdIpsL
        X2zeyXu+0vyh6Hx9ykRZNgW0sQ==
X-Google-Smtp-Source: ABdhPJxNkjayk772NXYsVPDj31XMmXZmRkbRaKzueCQf+WEYb+CAMQrXEiGlLUglpHR9JWyJf1TlxA==
X-Received: by 2002:a05:6a00:2410:: with SMTP id z16mr657064pfh.66.1644944135147;
        Tue, 15 Feb 2022 08:55:35 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v187sm12187382pfv.101.2022.02.15.08.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:55:34 -0800 (PST)
Date:   Tue, 15 Feb 2022 16:55:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] KVM: x86: use static_call_cond for optional
 callbacks
Message-ID: <YgvbAyD/4QEGQlpS@google.com>
References: <20220214131614.3050333-1-pbonzini@redhat.com>
 <20220214131614.3050333-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214131614.3050333-2-pbonzini@redhat.com>
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

On Mon, Feb 14, 2022, Paolo Bonzini wrote:
> SVM implements neither update_emulated_instruction nor
> set_apic_access_page_addr.  Remove an "if" by calling them
> with static_call_cond().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Sean Christopherson <seanjc@google.com>
