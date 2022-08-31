Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB15A82F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiHaQTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiHaQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:19:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0605D51EA
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:19:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so8393781pja.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=oxZjFnLq8UzZwrTw3lW/vJL1ogPuvIfdTOh9n8VfXdo=;
        b=UpcDc0Q7zg1iBHu/7I4GupHxNeBJSs3PVF8n4fZjcZx/gp8c0xS1l18M4JGihim4cx
         ozYWN9rVrsiJXQSF6oJN9utkzcBjWdSNdpmyvrCjVq3mo/lzXyw6ZhZ+fEXWTTBYUnnV
         unW+3OobGG+MKPiG3B9gq7OXiNaYqA6w4vSxkJXK0K0NebjOR1Apf+Um5+jXZgChYx59
         jX2Oa1MtY8KufAEZbJOuN/+V4byMJe9V/kJ6N0mRAFJ2jDuZEnQdjog6IyjfPtG6cBKP
         /lTPwN5AeWXkcOi41C6GGnmfVdtnNhjpQiDzlxQgccZRGNeUi93ELk/y6q8n0IETlc7B
         48Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oxZjFnLq8UzZwrTw3lW/vJL1ogPuvIfdTOh9n8VfXdo=;
        b=f374B0ge5WNV8aBLkXTDhGqkN2igBv/3Wnfad3wZcBluLT6lQNAsAVRkcA5k0cyD+D
         qhYLdlCgugCpUZk6YLaI4svYuZVFH0H/xO/+GBMGfM6wbEpC3IEB86ahvnFOeBNPCzs4
         haMsx7sT3X7JRFj6h1m13fWiM6ihPtc5PlHwtzcwm6Vmw18U6BC3596m8a5ji0I+iSLc
         cyDxFk8ZpWxXggn8wOZafTY1+XogsmC1uAalE15twksdZ68zTRiY9YRz4yWVD/Iges5s
         S8cPf+Ec/bZ3VD+oaVAQHgJVkj0r190RKDx5vibsSD7YBOukAgbFB+tCjKDTkHYThgGQ
         bYmg==
X-Gm-Message-State: ACgBeo1PYidLCDPRCps2aGWmFvlpjE/scPmKTGX5tfgY03kRiPdtf1NZ
        rXveL6fSDBvHxdC9XjTK0xQ3K2dd75EhiA==
X-Google-Smtp-Source: AA6agR79bKoMHXDICJTCmFbnDbavjXBOfNl3BgJWZiWPhpt0fq5vLk+4NzR1vVrfgtMBNiSmqgx9QQ==
X-Received: by 2002:a17:90b:3149:b0:1fd:dcbb:918f with SMTP id ip9-20020a17090b314900b001fddcbb918fmr4006553pjb.18.1661962771115;
        Wed, 31 Aug 2022 09:19:31 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a25-20020a631a19000000b004296719538esm3543322pga.40.2022.08.31.09.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:19:30 -0700 (PDT)
Date:   Wed, 31 Aug 2022 16:19:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH 03/19] Revert "KVM: SVM: Introduce hybrid-AVIC mode"
Message-ID: <Yw+KDoSSKN0xgJW0@google.com>
References: <20220831003506.4117148-1-seanjc@google.com>
 <20220831003506.4117148-4-seanjc@google.com>
 <17e776dccf01e03bce1356beb8db0741e2a13d9a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e776dccf01e03bce1356beb8db0741e2a13d9a.camel@redhat.com>
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

On Wed, Aug 31, 2022, Maxim Levitsky wrote:
> On Wed, 2022-08-31 at 00:34 +0000, Sean Christopherson wrote:
> > Remove SVM's so called "hybrid-AVIC mode" and reinstate the restriction
> > where AVIC is disabled if x2APIC is enabled.  The argument that the
> > "guest is not supposed to access xAPIC mmio when uses x2APIC" is flat out
> > wrong.  Activating x2APIC completely disables the xAPIC MMIO region,
> > there is nothing that says the guest must not access that address.
> > 
> > Concretely, KVM-Unit-Test's existing "apic" test fails the subtests that
> > expect accesses to the APIC base region to not be emulated when x2APIC is
> > enabled.
> > 
> > Furthermore, allowing the guest to trigger MMIO emulation in a mode where
> > KVM doesn't expect such emulation to occur is all kinds of dangerous.
> > 
> > Tweak the restriction so that it only inhibits AVIC if x2APIC is actually
> > enabled instead of inhibiting AVIC is x2APIC is exposed to the guest.
> > 
> > This reverts commit 0e311d33bfbef86da130674e8528cc23e6acfe16.
> 
> I don't agree with this patch.
> 
> When reviewing this code I did note that MMIO is left enabled which is kind
> of errata on KVM side, and nobody objected to this.

I didn't object because I didn't read the patch.  I'm very much objecting now.
