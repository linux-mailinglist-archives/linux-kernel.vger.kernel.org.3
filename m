Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C2A5B2A00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIHXPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIHXPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:15:07 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4D22B61A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 16:15:06 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-12803ac8113so15220526fac.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 16:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=x84tAzemIZD1nMC7iUsQKY4UVtWo/vfIUvZtcXbQwZI=;
        b=d2eDFZ5jZL+0zQOD2kyntF4UPUCwmmTg33IlQRUfzlOhmTfpZrtBlgD01+9Dn8o+Ut
         BmUpqnJ7xIzsL3uERZqKTla68Av96gvy3bc5xrucPdZVUr/gXRMWz8YA79xzKL0kb8+l
         0DB13SkzysD1UfJaO/TA2tHw0BtLgV9EBR6hADRafKyKoS3OEujOHUx8j0BtVYmU7V+U
         WTOca5RXzw45XLtIFej8+mRacT5odAeSy0o/Z6rKGXolehQenvGHIR2ddrU3cMXBi7tw
         IFDxN3Ge9p3BzkZ6T/Xvh+erEAAAamWApPGgJK52ztldLH7B92yl5wkqzoLlrUMKDqWy
         haTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=x84tAzemIZD1nMC7iUsQKY4UVtWo/vfIUvZtcXbQwZI=;
        b=K4yaNpl67ml90gUSFNRcYlerjVIsCsqm54UUIndSe34ipUZDhaB/DY1tM6GkwRVDvS
         di8hoO5JigcclbtkqHrhdi/SMAwwX+gMvdjIch4AhEY7bWg3llbVChpaoA/9orlQrS+J
         2xQWd5E07Ke1P1pbldRe7kw85DWlaRXKaQIfOer80fx82vji0LDNdz1EKcQFloPb1lDK
         FW9m4S60B3ayqMYyuav7+5rbfFMUxA8Iw+VLyG05E5RYQxIvlZvdH6wQDj0Co75aP69V
         iBji6xoTQiG4x5lGmhCFm7h8COnvtgVNkvnLjPQjY/0egfj1yvazBGAqKHP6IVoryFac
         u2jA==
X-Gm-Message-State: ACgBeo39mi2StTlZT/EpgdWFQF9KdnNMvORJrIrdwjB+Ce+faV4RA5f3
        BBcVBs40o40I2Rj1Sh3Rz1ep4+ez4tEYGvc3pyAGsg==
X-Google-Smtp-Source: AA6agR7CwKt1OV3kKEsMuvPZSIPAv9IzGPf7ihw3Dnrzsn+52gqwAYfYl0ZJ8OnpFIUdKljVaqq1xP9nSxZgHiYKjmg=
X-Received: by 2002:a05:6808:150f:b0:343:3202:91cf with SMTP id
 u15-20020a056808150f00b00343320291cfmr2456127oiw.112.1662678905621; Thu, 08
 Sep 2022 16:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220905123946.95223-1-likexu@tencent.com> <20220905123946.95223-5-likexu@tencent.com>
 <CALMp9eQtjZ-iRiW5Jusa+NF-P0sdHtcoR8fPiBSKtNXKgstgVA@mail.gmail.com>
 <0e0f773b-0dde-2282-c2d0-fad2311f59a7@gmail.com> <CALMp9eQQe-XDUZmNtg5Z+Vv8hMu_R_fuTv2+-ZfuRwzNUmW0fA@mail.gmail.com>
 <d63e79d8-fcbc-9def-4a90-e7a4614493bb@gmail.com> <CALMp9eSXTpkKpmqJiS=0NuQOjCFKDeOqjN3wWfyPCBhx-H=Vsw@mail.gmail.com>
 <c07eb8bf-67fc-c645-18f2-cd1623c7a093@amd.com> <c6559d3e-38ec-9a2c-7698-995eb9f265c6@gmail.com>
 <63e6c2da-653f-6f0d-8d56-f1c24122c76d@amd.com>
In-Reply-To: <63e6c2da-653f-6f0d-8d56-f1c24122c76d@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 8 Sep 2022 16:14:54 -0700
Message-ID: <CALMp9eQObuiJGV=YrAU9Fw+KoXfJtZMJ-KUs-qCOVd+R9zGBpw@mail.gmail.com>
Subject: Re: [PATCH 4/4] KVM: x86/cpuid: Add AMD CPUID ExtPerfMonAndDbg leaf 0x80000022
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Sep 7, 2022 at 11:00 PM Sandipan Das <sandipan.das@amd.com> wrote:
> This is the suggested method for detecting the number of counters:
>
>   If CPUID Fn8000_0022_EAX[PerfMonV2] is set, then use the new interface in
>   CPUID Fn8000_0022_EBX to determine the number of counters.
>
>   Else if CPUID Fn8000_0001_ECX[PerfCtrExtCore] is set, then six counters
>   are available.
>
>   Else, four legacy counters are available.
>
> There will be an APM update that will have this information in the
> "Detecting Hardware Support for Performance Counters" section.

Nonetheless, for compatibility with old software, Fn8000_0022_EBX can
never report less than four counters (or six, if
Fn8000_0001_ECX[PerfCtrExtCore] is set).
