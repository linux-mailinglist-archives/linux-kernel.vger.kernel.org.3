Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9828D52905F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 22:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347985AbiEPUkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349191AbiEPUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 16:32:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA5220D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 13:16:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n8so15520387plh.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eEf303JFQr27w0Vt+K07oyfUlhM8ngQeghXsWAlSwH4=;
        b=IKLOHQm2ajjJD3zfYAXlQZxSzcodxxKtRJ5h/jXk42qggHsRPKw+FFz3WeVVUrup/6
         +GPtLWnGZDyFJ2+YTix41B7mSK6h3oG95eqdNCKRuGJXswh3tZVVEtMSIVC2Zqbpt2NV
         mcVl5xiU48XAZdetvRJRQNBh8Yi5Ag/9SlihX9FHbtH5wUIA3AEX30yabOmf6GP/rAjf
         Cz/Lnmb3SdW7+s762tUxq3yFngRcIqOZ5BJuIPDrIGB1bkjTyXfSMtv0hpxMFz/L4vuc
         CdvpnOJ1eHcwGxxKnAUKJ8WZTp57sw4ALgsgxwH2eToFNACX2/Z+VoD90qtdebwsYwo5
         tSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eEf303JFQr27w0Vt+K07oyfUlhM8ngQeghXsWAlSwH4=;
        b=ZEeTQ5rXHJuxIQwkUFN8x3WGxDoZewYDo6SIWB6n8BSP06Jh/HKbmlQ4NGGobscSkw
         slXjKO4PgsdBgVY7IhkwoJFkj2nEKyZxa6HtckpWTQpqkg5mZXxtkWlXigsy2MazKcVL
         zbNEg21VtaprHNzqFuYITRAhar+uh5XC1neAgVBb0D+gX2HKSsCZbVByP4UIK2+SEKp3
         cJX1n9nnRyr9ooNF3snjk3Qt/Ze5NGoM9EOhr2fTcH206cZnYJTIK05GtDGIvqnnjh6m
         2z8VfcAFJy3EolL5U0xy2T04lGksKherQXDBAoUOAgKExOe2hqxaQi98AR5psxim5c1k
         CF8w==
X-Gm-Message-State: AOAM530IiCcEp2IdVJeC6JvcE0MOkCNH+q7pca4dDHDdfzs8kj7de7YD
        TA0v11TBcIk4r4L6EoH2u/MKtgz9/jQqiQ==
X-Google-Smtp-Source: ABdhPJykKyOAnItGqLNia7022tjeLb/8kmYyTzBSKpYjXaZe7Rw+w2V9L8itS02vwdLcXf78wpx5OQ==
X-Received: by 2002:a17:90b:505:b0:1de:ffef:6167 with SMTP id r5-20020a17090b050500b001deffef6167mr16471499pjz.172.1652732176891;
        Mon, 16 May 2022 13:16:16 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b0015e8d4eb254sm7419120pln.158.2022.05.16.13.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:16:16 -0700 (PDT)
Date:   Mon, 16 May 2022 20:16:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/34] KVM: nVMX: hyper-v: Enable L2 TLB flush
Message-ID: <YoKxDbWDvKmaLiC3@google.com>
References: <20220414132013.1588929-1-vkuznets@redhat.com>
 <20220414132013.1588929-20-vkuznets@redhat.com>
 <3d25a230ec31161823c6320ceef77ab0c331e3d1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d25a230ec31161823c6320ceef77ab0c331e3d1.camel@redhat.com>
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

On Wed, May 11, 2022, Maxim Levitsky wrote:
> On Thu, 2022-04-14 at 15:19 +0200, Vitaly Kuznetsov wrote:
> > +/*
> > + * Note, Hyper-V isn't actually stealing bit 28 from Intel, just abusing it by
> > + * pairing it with architecturally impossible exit reasons.  Bit 28 is set only
> > + * on SMI exits to a SMI transfer monitor (STM) and if and only if a MTF VM-Exit
> > + * is pending.  I.e. it will never be set by hardware for non-SMI exits (there
> > + * are only three), nor will it ever be set unless the VMM is an STM.
> 
> I am sure that this will backfire this way or another. Their fault though...

Heh, that was my initial reaction too, but after working through the architecture
I gotta hand it to the Hyper-V folks, it's very clever :-)  And if we ever need a
synthetic exit reason for PV KVM... :-)
