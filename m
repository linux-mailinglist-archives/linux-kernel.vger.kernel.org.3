Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5B4C38C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiBXW2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiBXW2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:28:51 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D618E3C4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:28:20 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 139so2970044pge.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NF/iGcyMODxJd9hqjYLYxLcN2czTwBn1UOj2IoRGcP8=;
        b=GhGK4UmLpNzx2+ohKdGzYdnehJPpnDtc4ZPCSQSF+XN9W52Va2beVoCqg+ww9MVBea
         8C79LKwYirUw2PQKTDZa+obsIlomXleHgnOh0XzF/QA5ZYKkdNU55iW3alKJPn6KRNag
         yP9DEyDvc8lVh2fp/InUTbYsKtgDXmBS+WLbDSXCj5f3hCo67bbnEb7Q+K6GbjkfSj1T
         4lr80FFJgmYzfnWHp7VuDbodJcb6WVQiAKLLkXlm5YU1MeY3DuBSOrvkBLTOiuuVB+bt
         0dUbvWyWGspw7LodJylb2ObAVXtY4+lP0lf3EqykK0OqMFZ0EqGq53n59njJQj3WsNuw
         6E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NF/iGcyMODxJd9hqjYLYxLcN2czTwBn1UOj2IoRGcP8=;
        b=lPERvDIYuI+APmXgQpYNuPneBPP+eHuxv09K6MIWEhgyeErE5aJl5AQ2EWpDmveYwL
         RgpYYQlIpJOXrKclUYDNgKnjMm0H/Ue6ZZJfW7LXtuuYXa1nDLVV20u5BGaALH5ipOLw
         lj5aqJ9MfX1BUVPit6wQynkI9L6EG5r+cr6aOX9SKs+WeFtZpuICcBYb1RkXfjEK101Z
         aWQakBw/7lciKEzmDDDW1H53a90F+vuCD3pV9HT3GOxCi4d62BPEPXzpAZkBscekVvrS
         cfAYXLdZCzJ21b/BZBp1pkqDhyvC9YJ6okEBPA1yHGqcgAkkRwtpnu3tCb9bvzdSjGsj
         EBVA==
X-Gm-Message-State: AOAM530bNgmyMCrVHd7zpx+VJ5QiD8bJN2ZcinePHSipdO6ncjsj4NGN
        6Au7t/y5xUjumespelP/ETsxHw==
X-Google-Smtp-Source: ABdhPJyMIBiMPrAbg0mqyTV/P3U7UaWOv6ucsXvGaR9sjG5VuieOYn9UTIG2lHyZkX7jAqO7lSC9ng==
X-Received: by 2002:a63:4412:0:b0:372:f29e:3108 with SMTP id r18-20020a634412000000b00372f29e3108mr3814834pga.354.1645741699770;
        Thu, 24 Feb 2022 14:28:19 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00073000b004dfe2217090sm455511pfm.200.2022.02.24.14.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:28:19 -0800 (PST)
Date:   Thu, 24 Feb 2022 22:28:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
        Like Xu <like.xu.linux@gmail.com>
Subject: Re: [PATCH] KVM: x86: Temporarily drop kvm->srcu when uninitialized
 vCPU is blocking
Message-ID: <YhgGfyqRZp4S2/gn@google.com>
References: <20220224212646.3544811-1-seanjc@google.com>
 <CABgObfZnW=7v6agYYK6ENgiNOwFCbCZo_8t95LoFrt3sg5srcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZnW=7v6agYYK6ENgiNOwFCbCZo_8t95LoFrt3sg5srcg@mail.gmail.com>
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

On Thu, Feb 24, 2022, Paolo Bonzini wrote:
> I had just found the same issue and dropped the patch. If it's okay, I will
> squash this and also include your reverts in the next pull request.

That's fine, I got a giggle out of seeing kvm/master force updated :-)

In case you haven't seen it, this needs to be squashed too:

https://lore.kernel.org/all/20220224190609.3464071-1-seanjc@google.com
