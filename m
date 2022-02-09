Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE524AF7D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiBIRHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiBIRHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:07:48 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E911C05CB87
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:07:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso2878150pjg.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 09:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6K6q9ooo1q6qeMlSJENA4JzRbFJs2C2YinZqF/kRUdI=;
        b=ciaDkCOBTmSmdRkz2yI9IaEArDVU/aNXMpnH0ocTjlWnk4YWy4zN9Pko9CE3ZndSm8
         zrrGPCNcNACrkTnrKLI40RxvWhPC5titdzndhIf885JKiR8gXObf4+wsxEllNx9+pVyC
         c2ECKoamHdwR8SG4m5K6+bkxvkAx7+vzP0shSujAy2t7reJSOkhlckcM9hxW8IwaDKat
         h6W7SXTNV3PVBsouxmjN6AOAG4k+/tzsXUe24wvWrXqsoVQQD5IF2jcAOYL8JyWwI1e1
         FvfvA05uLaLQPjJ9shjXSVSXF4x+1xhBCAv9H7GmK5RlogIMdwe/YuRdVcxgRmZ/BDr0
         I6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6K6q9ooo1q6qeMlSJENA4JzRbFJs2C2YinZqF/kRUdI=;
        b=gYJ4cmMggxtXr3qKds3JwVlnqjMUHsw1AFuXv5yjHRjlhJhzOBS5mVen44zMyJ6rm7
         eZZRFtYuRdZknrx++yjjRCXf+Eoqxt+zly24gbfsGpd3utoZsuP0wsYSK2Xm4+DQHXSB
         ks+EJN2p7FfNeLgYi6fTGrm+70Gr5CbW1rkTInPfi0oxgQgwlPSK7Rk0/NxfmArGZQ7o
         oANb2IBqeh0QfDlrWshqzKKT29oN1ciuaxJpjbWU8yc42ZRg6KwCiyvdjg3KEqpbZvKn
         PyxPn2u9+o17p4Rf+KPbKfwETD+itIDEG7jv/rEu/ntK3DGrcXYK3jAshXfvSuvl6LVg
         CFtg==
X-Gm-Message-State: AOAM531sLPbz8IOuihXJQ3bzO5AZxnDu5XpFUZy8nMdfB+qmEggqdhyC
        i9jOH8pi1W/oFEm7WzBtuP3Vyg==
X-Google-Smtp-Source: ABdhPJyRj2WEf5Sh2K+1SdXq11oh4HE9FQS75xUq5SOSgZ95OpUQpf8kdGauF1dD0N/SLIao4vjSVQ==
X-Received: by 2002:a17:902:eb90:: with SMTP id q16mr2987035plg.76.1644426471305;
        Wed, 09 Feb 2022 09:07:51 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t9sm6401673pjg.44.2022.02.09.09.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:07:50 -0800 (PST)
Date:   Wed, 9 Feb 2022 17:07:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
Subject: Re: [PATCH 00/12] KVM: MMU: do not unload MMU roots on all role
 changes
Message-ID: <YgP04kJeEH0I+hIw@google.com>
References: <20220209170020.1775368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209170020.1775368-1-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022, Paolo Bonzini wrote:
> The TDP MMU has a performance regression compared to the legacy MMU
> when CR0 changes often.  This was reported for the grsecurity kernel,
> which uses CR0.WP to implement kernel W^X.  In that case, each change to
> CR0.WP unloads the MMU and causes a lot of unnecessary work.  When running
> nested, this can even cause the L1 to hardly make progress, as the L0
> hypervisor it is overwhelmed by the amount of MMU work that is needed.

FWIW, my flushing/zapping series fixes this by doing the teardown in an async
worker.  There's even a selftest for this exact case :-)

https://lore.kernel.org/all/20211223222318.1039223-1-seanjc@google.com
