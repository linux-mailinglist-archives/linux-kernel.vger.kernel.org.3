Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8CD4CC675
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiCCTt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiCCTt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:49:57 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FFC1A2701
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 11:49:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id ay5so5714308plb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 11:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KQ0wcOx2SQw4Qbd73iAm9amGlmLaItMj8NK3TTfF//Q=;
        b=qBKStBez19at04+k4VefYMHHzVnCU3z3/Q/hQe6rJ7qGX9ZthBXd97aAoxK3IUKK9/
         oj77rXjDHVz96ddFwzl6lC2b+D14B3WOhMp0o5yvGnP1bhSgEvPn7dVz7nn8MAV0fS+E
         ShYcMp6e0G9fGRq8ZWbK6W+yFZ0I/q05DkoZt0mGF4YfzsaOBxUMkOPbYjGN7eCN8O7C
         HoAnOKorBgPQvW8EDoyIr0ThXzdWRC2M1D78cfFfVwHaRUr6/lSrDVKtY2D9gpmNqbjY
         IhPRvzjhQiB7tUAsP/OqbUh4rgrfp+xlZYvBYDzbLFx/naA+IaYmwx8STpK8szVFJMpc
         TF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KQ0wcOx2SQw4Qbd73iAm9amGlmLaItMj8NK3TTfF//Q=;
        b=wsceUedca/0wipBw9+4GRi7nDMQvCyfGV6p/JwxC67gEViF2OLxJ6clP6BfcibfFHl
         vtV8WVcQqI4/Qdw0th9E1xJO+ZMF9BZnEv7tdF1kHWG31Qdyy9wu9VCDbyYFMChHkciA
         AzDPPyo6p9nlHUdSEPbw5WSVoRJnm4H01GwuwMZnfRqocdkdBuq8eQf9igMl1sSm/75d
         EPlP0JosjSQAqblFh/jZtE6PVhzMktdGXLEvvG5O/NshRPn0cOkcoVZM0ee91Z3ijX8Y
         K3eD1H7LiaZmCrx1IdP3SRHcESdQ+hC4l/Py7480FaSpTXZbeOfCkZ46e7V/SISRAWB9
         Srsw==
X-Gm-Message-State: AOAM5338Kr3MI/h5b7Oo0blOZnMl0dmxTxoHr/0lBOsncsLx0zq9gs05
        cq9jAOvbyB8S98SaBQtCJleGlQ==
X-Google-Smtp-Source: ABdhPJz5ZRkQK/R8WKCjGF7iOXXXgBuxdefhJTebxHJgF29bDGBNIVOBhLZryFznFg9GkrtMH1Rkwg==
X-Received: by 2002:a17:90a:b798:b0:1bd:652a:97b5 with SMTP id m24-20020a17090ab79800b001bd652a97b5mr7019460pjr.6.1646336949863;
        Thu, 03 Mar 2022 11:49:09 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090ad20600b001b8d01566ccsm9046957pju.8.2022.03.03.11.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 11:49:09 -0800 (PST)
Date:   Thu, 3 Mar 2022 19:49:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH 4/4] KVM: x86: lapic: don't allow to set non default apic
 id when not using x2apic api
Message-ID: <YiEbsasKjrvKKyff@google.com>
References: <20220301135526.136554-1-mlevitsk@redhat.com>
 <20220301135526.136554-5-mlevitsk@redhat.com>
 <Yh5QJ4dJm63fC42n@google.com>
 <6f4819b4169bd4e2ca9ab710388ebd44b7918eed.camel@redhat.com>
 <Yh5b3eBYK/rGzFfj@google.com>
 <297c8e41f512587230a54130a71ddfd9004c9507.camel@redhat.com>
 <eae0b69fb8f5c47457fac853cc55b41a30762994.camel@redhat.com>
 <YiDx/uYAMSZDvobO@google.com>
 <df1ed2b01c74310bd4918196ba632e906e4c78f1.camel@redhat.com>
 <YiEZJ6tg0+I+MdW5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiEZJ6tg0+I+MdW5@google.com>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022, Sean Christopherson wrote:
> With your proposed change, KVM_SET_LAPIC will fail and we've broken a functional,
> if sketchy, setup.  Is there likely to be such a real-world setup that doesn't
> barf on the inconsistent x2APIC ID?  Probably not, but I don't see any reason to
> find out.

I take back the "probably not", this isn't even all that contrived.  Prior to the
"migration", the guest will see a consistent x2APIC ID.  It's not hard to imagine
a guest that snapshots the ID and never re-reads the value from "hardware".
