Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13534F8226
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344294AbiDGOx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbiDGOxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:53:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9BBC054F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:51:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j20-20020a17090ae61400b001ca9553d073so6450348pjy.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+saCSnArnxO2TUlvbHmXQoFiDXGA5TGiskFrczuz73Y=;
        b=gHTdAdlGBmpoT+iYDeLwfYqrMCSYrMcJVsXDPpLHU3NBKwlohuLKsUBjowQ1O2LiOJ
         KZffRjcfwLSL6o96OsbDefjoXwv1mvenp7oEbdCKjdurcoUI7auXyhHB5WHqQ4OWkQlw
         IFDwCExv6ewWhlpPReqoL5OwUVapAHbqScbIH5uXL4fiqZrs4ymU0+44GkINgNYx8Ovr
         cEql/OO9nI49LTrPCuPEfNQp1GkO39m0yw8Si97vRBbODsWIWbo8Gys0dZ6AZQKoYAa+
         SDzbUpIdz3zViyGPYpdbQz594K4IeR/Do0h2paWmrHYt5Xyer4S+73NFgjXB759C1SEl
         yi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+saCSnArnxO2TUlvbHmXQoFiDXGA5TGiskFrczuz73Y=;
        b=3oRz+FrRhFN4VIpMg75crvx4lH7W4g+Cm5FWJBJWyDZ6n3VaKOZMaXm0lH9ZWvShQo
         KubNNwqTaXWEaZ6MySPrNszDiWNZG1ynCkjVPbiOuGLrwFNPQMqgEEagv9yN82B9tnQW
         yRyGwVzUuu1vsnFcQbVNErT6Te6DcLTIDhcQD4aL4idnSxaeWbY0j4ONKzWzljnlawFE
         mweE0abGEKxxOvj18DCAFp93MpqEiOVRRWrK+lrGMJ0ZLBTrtvhFKfZPVI39K/AwosxG
         6wVKPjeO35y0hCA4wSn6CY45Vr4giJLncoRgN/qxJtHLUkzeXzYo2X282I+uk6ddCWG0
         ak3w==
X-Gm-Message-State: AOAM531tc9gfYZmdFNJdoJl7NJSZCtVS8IBrmLwBtZXtSx1a0TS8U1fY
        ecUtY4V2IsObuGROs5fLnTNFaQ==
X-Google-Smtp-Source: ABdhPJxvrmY5um1dyneAX/623gzNPdyhWp8QxZWMYrK+6acrVNRKTmaYM1eWQbXVtos9Vd5O6e4Hbg==
X-Received: by 2002:a17:90a:4417:b0:1ca:a861:3fbf with SMTP id s23-20020a17090a441700b001caa8613fbfmr16611866pjg.80.1649343077600;
        Thu, 07 Apr 2022 07:51:17 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id rm5-20020a17090b3ec500b001c7559762e9sm9173481pjb.20.2022.04.07.07.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:51:16 -0700 (PDT)
Date:   Thu, 7 Apr 2022 14:51:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [RFC PATCH v5 092/104] KVM: TDX: Handle TDX PV HLT hypercall
Message-ID: <Yk76Yd2VTmONGA8H@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <6da55adb2ddb6f287ebd46aad02cfaaac2088415.1646422845.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da55adb2ddb6f287ebd46aad02cfaaac2088415.1646422845.git.isaku.yamahata@intel.com>
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

On Fri, Mar 04, 2022, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Wire up TDX PV HLT hypercall to the KVM backend function.
> 
> When the guest issues HLT, the hypercall instruction can be the right after
> CLI instruction.  Atomically unmask virtual interrupt and issue HLT
> hypercall. The virtual interrupts can arrive right after CLI instruction
> before switching back to VMM.  In such a case, the VMM should return to the
> guest without losing the interrupt.  Check if interrupts arrived before the
> TDX module switching to VMM.  And return to the guest in such cases.

Pretty sure you mean STI, not CLI.
