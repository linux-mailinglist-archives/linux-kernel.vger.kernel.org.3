Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5734BFC73
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiBVPZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiBVPZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:25:46 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD31162035
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:25:21 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id c1so2547063pgk.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JOVsUFfKVdevn4xo8tl2n5gZT4eizbbSPVY0rmb9bKM=;
        b=hkCJ+If856zbN40skCffOWE5ppC+hZSvhR64QkWhgmk15mi10rMYEdpZKZwIf5cuJ+
         MieJE7z+kiDP3QvwQ5+L1uftB6EnkiXgSc6Gy7JfZjYp5EH9JakMONqr+vrU2+L35Mfd
         T0t946GmC1gpd70jvmwt5s3Yk8dEwX9K3AHRLgvc086Y4EJaR2pHtaUZC0DxugYGNBni
         EwsyrZ5w55w02H8LA4FIP40u5XmhXHDyMtkNHpkAsnWBN8D7ciOyO0U4PQVe8eKqcm+s
         UDk9qlPc0wrmYACdpvu6TcHWnzVQJNXNentJLVuiqNuFSZP0Cu3MIibAfXciY23o8hj1
         2gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JOVsUFfKVdevn4xo8tl2n5gZT4eizbbSPVY0rmb9bKM=;
        b=zgeYf62cba0lc8CZXwyCQ0eeOsZ4D5MkN9nNuQJSEnvMLFHB+1c32HxStsmqVOjXS4
         5mOGG7BMRL7SYr7TRyjBsBfGDmxQ1uqc0Sexr7V/UOHVaVXOpO6LqkcYUKMwzmJuDpjI
         IFdB9H2j73Tr7R1MfTj967THRk42ByFMJ/mPMuMzfafTsTnXhuo8HjPibQDslZbVTmE2
         H9k9/P3EjeDCOjaWlTBcMLPDLb08yRQMqASslkX+8cwcmzhQByaeQL6MFXQYtZj4Lusw
         I1eCMJnjXA2U9Rcfam19Nfov1c23vaMWgF5Y9VTWZwks1iLNyGMhTH3HUR+h2ct8kCIX
         3kPw==
X-Gm-Message-State: AOAM530Al2B1WgUNgN5sCcr9orCggATdWe2fwGcgbuTISGl8STuERXL9
        NZdDp30CHQAZ53A1upWJ0nMx9g==
X-Google-Smtp-Source: ABdhPJzzL85VCR+MvGAAUkiNedsSi1qI0C6f+LwJD7Gf2CaiPgeGKiP+EybUjXrjl/zxArP1USdK6g==
X-Received: by 2002:a05:6a00:1c46:b0:4e1:82cb:e39c with SMTP id s6-20020a056a001c4600b004e182cbe39cmr25608230pfw.18.1645543520485;
        Tue, 22 Feb 2022 07:25:20 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h27sm21100567pgb.20.2022.02.22.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 07:25:19 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:25:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix function address when kvm_x86_ops.func is
 NULL
Message-ID: <YhUAXKkGjO/Yjz8G@google.com>
References: <20220222062510.48592-1-likexu@tencent.com>
 <01ba8559-b6f9-cc75-2080-7308a04ce262@redhat.com>
 <fb9e8765-33d8-5696-37bc-98e33c93f0c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb9e8765-33d8-5696-37bc-98e33c93f0c2@gmail.com>
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

On Tue, Feb 22, 2022, Like Xu wrote:
> On 22/2/2022 4:33 pm, Paolo Bonzini wrote:
> > On 2/22/22 07:25, Like Xu wrote:
> > > From: Like Xu <likexu@tencent.com>
> > > 
> > > Fix the function address for __static_call_return0() which is used by
> > > static_call_update() when a func in struct kvm_x86_ops is NULL.
> > > 
> > > Fixes: 5be2226f417d ("KVM: x86: allow defining return-0 static calls")
> > > Signed-off-by: Like Xu <likexu@tencent.com>
> > 
> > Sorry for the stupid question, but what breaks?
> 
> Although they are numerically the same, I suppose we should use the
> & operator here, as in the other cases where __static_call_return0 is used.

Meh, IMO all the other instances are weird for adding the "&".
