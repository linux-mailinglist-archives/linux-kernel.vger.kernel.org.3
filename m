Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8498B4F20B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 04:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiDEB1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 21:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiDEB1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 21:27:24 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4113E28AB3C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 17:39:02 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id h3-20020a4ae8c3000000b00324b9ae6ff2so2015967ooe.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 17:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVbRFb3pHKJObhGTfG4TyT4E0cfow5X3SEOtVm7qSqU=;
        b=D8RB3yzwW1THTOskjZcYFnmP4WkVo9Xx0bih+Eq2XdF3des0BmB41dk8Q5MCyR9mOi
         hPh+AGv+gTG3fUM3DRMyZK1EbiSGLDNPOU7EnkVBOkRhgVfqnSgj5p58xQTZoL/Z9YeK
         xGUATkEXjRYfTWebIUnQ9lyOTaUDql4l47eER4ak4WIxGXEuoPWdzBFCkzUNwRALUxyq
         Lzd5n36eq80YTcSls+P/7hSSS11v8hMRbmgDWIMPPjpS66vs84SeW/vxqNJ68iEFvbGR
         Joqf9+/Xje/9GvhVKr67Ql5MRB/x8+s8JamGESZisUs8ae6JyhWJT7ENUkr/fx10J7QD
         +1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVbRFb3pHKJObhGTfG4TyT4E0cfow5X3SEOtVm7qSqU=;
        b=bI8hDCYTMl8Z2Br/SDTgEBfRTscARfEgNese4WVRsqTylgfC8LAdNC2vK8+VHv+6IP
         ltfbkV4uqruIuh/4P0VoERmDwj1YS9n8Y0jLGg8Vfomh/BvxLQm4p+mYMlZftscwNfN8
         m9BTZgIzsRz28Up7oiBmQl0nppX8Ga97niuvJcdpCkPUozT6gs2ECCbmPxT9ecO37o/k
         teBqgWAWFVNxIvWevTHqOveHMl09zd1Pqa6DRsKSCrfco+O35Xar47rxFTc3U/+9e/h6
         BMEkVpSL8m0S//iAwCSsLIxL0mNfiQEDfGb+012u64wa+jL174jAPJST3HjhASo4Tah/
         1bdQ==
X-Gm-Message-State: AOAM533JKPVQ2c0Jaj5Lz4XJqNluRI8hHE+RQF9sYTyaRgkvoK+mFa7b
        ynIyGdcDupMNvZvNRbMv/NtT6rU5hBral+msMwY/s80Gk7Y=
X-Google-Smtp-Source: ABdhPJxtx/GH6LWYXx8C6ldpwgMglrOnpypW5aqgzqo7wrMaQbWjNebWBzYw94xuXDp+yqNNkgufUEvGH5nrWfeZq1Y=
X-Received: by 2002:a9d:6250:0:b0:5cd:afcf:999d with SMTP id
 i16-20020a9d6250000000b005cdafcf999dmr293865otk.75.1649118183603; Mon, 04 Apr
 2022 17:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220329134632.6064-1-likexu@tencent.com> <CALMp9eRqrkLRQ7UWNUdp3Z58WWgTqO-OPRuNo+EjcOW3c5eteQ@mail.gmail.com>
In-Reply-To: <CALMp9eRqrkLRQ7UWNUdp3Z58WWgTqO-OPRuNo+EjcOW3c5eteQ@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 4 Apr 2022 17:22:51 -0700
Message-ID: <CALMp9eTCqRD+LyQ13+-3nyKAHcJ-T00K-vfK3iu0RnFR=Ax0hQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/pmu: Update AMD PMC smaple period to fix guest NMI-watchdog
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Hankland <ehankland@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Minor nit: "sample" is misspelled in the subject line.
