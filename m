Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEE35A1A73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbiHYUiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiHYUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:38:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E9CB7EC8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:38:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id c16-20020a17090aa61000b001fb3286d9f7so6187998pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qD6ZliJsA6s2l8d9zqsn2AY7abAbXk8ip2gFp/mSy7I=;
        b=SJ8sYTc8JRQiaQ6oRRtWX4MFHMSCo2XdhGKk2xaj2unDvP5PMYQqkog+MOoXT+7SGu
         FnB/Q52IagX1LHZVxpWnLfWAp4L6Zw1AVWk5mM3Q+ywFeRoZbVD/hnXtvERF+1IWSM+l
         uCoQhVIdmMrpeqXwdcxfzNIjSqYx+x4wZxwcnuEsYnPq0s/+tZ/DPVNPQtJNklN5r1e2
         mWSgByYbM7JKLpAnCqdGc5xQqIk14WsKs+UnwONOeU4t0IasQlceDbmeHB1oCGOQx0Ls
         Efj0Y5AQzmG+HcDJwS/bxqDFrSMfg4Zx++xjIP/xMsjSosOs28/Sja/LIpJoRqY/G146
         1Y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qD6ZliJsA6s2l8d9zqsn2AY7abAbXk8ip2gFp/mSy7I=;
        b=T2zyNqMceVMJTtlsOClrMAiByx99g28VVGUAgrB6NS+aXSSdB34iKJnPgaVJcnETYu
         ok0U4ll7ygAWedTiALv6jBSrfRc07AEToQXDxJZQMj3wXb2ystZIPVEh8H/sBup6r+kN
         By7X6/aVIH0+RzFOQMEqMnVEPR/zAjVf/96QTn3AK3zqKsfM/vK8B5it2iHG/dYn3Dd2
         Gq20eJq7S+WB3lAQdB+0WK5rZrGRAT2ajQsTQ9RPjsrAoCM+hUrkgoUgyEcH45Fa1PNC
         Uviy7yEtAGMPFpd+mTzJM7ix8x9iJZolkD3osOv3FrFep1MZrLRaWr8C4+lRncvRB/kG
         ilJA==
X-Gm-Message-State: ACgBeo2a3NUW/iq4wVmckB31GveMynOm3J5tmaMx7khEV6s0g51X5cv7
        7rnQEvH5cMl+l2Yh6XlsjQtzpBMqkIqxJaCqzMCaLA==
X-Google-Smtp-Source: AA6agR47cZbJGmgbFboUwNUYzROA3izsO3sSyXOTucCkOjNs+7Fw+S6vE+UX47d4aoDRINtSeST8midQ+VNOkzhh6As=
X-Received: by 2002:a17:90b:1b48:b0:1f4:f4e5:c189 with SMTP id
 nv8-20020a17090b1b4800b001f4f4e5c189mr860155pjb.226.1661459888889; Thu, 25
 Aug 2022 13:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220802230718.1891356-1-mizhang@google.com> <20220802230718.1891356-2-mizhang@google.com>
 <b03adf94-5af2-ff5e-1dbb-6dd212790083@redhat.com> <CAL715WLQa5yz7SWAfOBUzQigv2JG1Ao+rwbeSJ++rKccVoZeag@mail.gmail.com>
 <17505e309d02cf5a96e33f75ccdd6437a8c79222.camel@redhat.com>
 <Ywa+QL/kDp9ibkbC@google.com> <CALMp9eSZ-C4BSSm6c5HBayjEVBdEwTBFcOw37yrd014cRwKPug@mail.gmail.com>
 <YweJ+hX8Ayz11jZi@google.com> <CAL715WK4eqxX9EUHzwqT4o-OX4S_1-WcTr5UuGnc-KEb7pk6EQ@mail.gmail.com>
 <Ywe3IC7OlF/jYU1X@google.com> <CAL715WJEkT6heVT1P2RZw_5NxBcORCrBTS60L_RZT-05zr_zsw@mail.gmail.com>
In-Reply-To: <CAL715WJEkT6heVT1P2RZw_5NxBcORCrBTS60L_RZT-05zr_zsw@mail.gmail.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Thu, 25 Aug 2022 13:37:57 -0700
Message-ID: <CAL715W+y6kRvLUOpY+u91mdY1XdfaJsgzJuwozrZW3=UqSp2nw@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: x86: Get vmcs12 pages before checking pending interrupts
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
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

> Currently, KVM_SET_NESTED_STATE is a two-step process in which the 1st
> step does not require vmcs12 to be ready. So, I am thinking about what
> it means to deprecate KVM_REQ_GET_NESTED_STATE_PAGES?

typo:

"KVM_SET_NESTED_STATE is a two-step process" -> "Launching a nested VM
is a two-step process".
