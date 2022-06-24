Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84B55A070
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiFXRjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiFXRi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:38:28 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1654D24E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:38:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q140so3040738pgq.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3kDqsealhz+clkDjmQMJ0LSGvDM3X4MUEdmUqyhprC4=;
        b=juBhL6FdKN33HFxCeJTuvPGoDF/55JA3lmhW9LFCphk+c6G2qjT+/cZjhqfZ38m8BK
         Fu6K7ic8BdlkA78wRSfeIEZbhUztnhLqj2T7E8NSK3bdAyKoBzcx/bCJJNyPD7qZh8SN
         KqCZzKM7Boi/7jzwhRKdgmwgcEkbupwvDIlUlrUNtl/akyAALdGUzvcGvJ6KXbOJr0O9
         VoMVlPS2Ffu/FV2ITE3+jqoGbalBS7navDyZ35/2l47IMn2rTaNmaVGbUJIh+TUWnZkv
         ILxZg5BqiiS2E/i9jIUGu9KsU2IVqAUD63/d4zpMS/HmAWsU9GykYdJ2ZDXqrEz4Js5T
         S3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3kDqsealhz+clkDjmQMJ0LSGvDM3X4MUEdmUqyhprC4=;
        b=1TP9KIEsD/2+aZcEgV9Iadx5uLwaicC3ouehD/RYtk56Tdw5N8bd9/vmVSmaBvF3nD
         hLK8WqRJqMZgdsk6IqebpDVJ3200GhRQuqgITxHQu41TCtPEeWzNmawGdM1q3NtjSX7r
         /NCOEki0af4/9U6DhYPPkU3XPFjNrw0JiYSjufZFpwZmB7tzD3XfzhK4DKTlsaLouB9H
         x21MMcVsbOwJC0S3/yh/FWVNqkdGlzYlTkt9u1n+3d7UvqDxcMsJlN2eZi/2W3Hiv82j
         nrOCBv3Z3YUVx6l6XnQxXZxqtkGAir+E+Ee9nQJWAoJtMiiXn1zv7bX6n8d0PK5AewzO
         wrQA==
X-Gm-Message-State: AJIora9Wn8d7j5bfB1CqXd1XRvnDd9D2WwHZNx8bBqRq+BpRfK4P1ufr
        TBhE9r72CTG3sqBXTpMCHADQ1g==
X-Google-Smtp-Source: AGRyM1uLvnAJjhQ/EXwZDy/O3e1qyJGFOi/LsFUKFis0PhPPsRz7w61giAEqPL8upDGjoAbmyzMb3Q==
X-Received: by 2002:a63:884a:0:b0:40c:ab0d:fa21 with SMTP id l71-20020a63884a000000b0040cab0dfa21mr11358pgd.404.1656092306583;
        Fri, 24 Jun 2022 10:38:26 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902d2c300b0016796cdd802sm2151603plc.19.2022.06.24.10.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:38:25 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:38:21 +0000
From:   David Matlack <dmatlack@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] KVM: x86/mmu: Use "unsigned int", not "u32", for
 SPTEs' @access info
Message-ID: <YrX2ja1r1/7LGv+k@google.com>
References: <20220624171808.2845941-1-seanjc@google.com>
 <20220624171808.2845941-3-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624171808.2845941-3-seanjc@google.com>
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

On Fri, Jun 24, 2022 at 05:18:07PM +0000, Sean Christopherson wrote:
> Use an "unsigned int" for @access parameters instead of a "u32", mostly
> to be consistent throughout KVM, but also because "u32" is misleading.
> @access can actually squeeze into a u8, i.e. doesn't need 32 bits, but is
> as an "unsigned int" because sp->role.access is an unsigned int.
> 
> No functional change intended.
> 
> Link: https://lore.kernel.org/all/YqyZxEfxXLsHGoZ%2F@google.com
> Cc: David Matlack <dmatlack@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>
