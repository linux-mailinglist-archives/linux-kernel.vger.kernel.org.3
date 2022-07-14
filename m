Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E603574B55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiGNK7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbiGNK7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1D4F4B4BA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657796381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FavxfYWL200Y0rn9Lp1shFMwNCXImob7qzskzLrDddU=;
        b=Dbh2yNnDdKna4OsqEf8qT/hwofO2srJEREsi94/iHyGLDCeZZIDJBwiShzHFQMD9SCBMBc
        WV0z5GvlV1ejUumm/EL8gcxvfHhtJ7rHzjAxkQvU3L4yP04UUkjcFokruKR9RHugco3cf4
        II1VF9YwNjgqvwt6qDWsfPyEhIinwPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-OOjnwfdRMZiMFvxBPBpBHQ-1; Thu, 14 Jul 2022 06:59:37 -0400
X-MC-Unique: OOjnwfdRMZiMFvxBPBpBHQ-1
Received: by mail-wm1-f72.google.com with SMTP id n18-20020a05600c501200b003a050cc39a0so494640wmr.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FavxfYWL200Y0rn9Lp1shFMwNCXImob7qzskzLrDddU=;
        b=p/Yjk6CzR9QRDvgRGQJhopVY0u1JoYtuj5U9q30k/CB19eBdku37UvFfjun1u2Ix9m
         +1BLWXUzXzketAGAwYYJ+/TgFbs3Rmb8ejhyny0/8NOsopwuxy/1PnLDRQJbttztfsIm
         Hy25tdjFr2BQCfRu1nmXANlq7IhIoVW5Usrl7/hcWRVv5+acsOdZ1R14p1zbKcnMEwmN
         /cH+1DvYSHrQGK9MJQx6MW1FjoErmt8ViA6xVUi78VlM/N54xSOtBq8JBI6utR8YFtw5
         +11xTOK3ynQ+lWvn/YHKxzFLpw9nrwCFx/L+uZNS1BvesCDMKfzwWoTbP4DsRKt+RJ+Z
         rBkQ==
X-Gm-Message-State: AJIora8Cgg7DZnc7qvRVfnm5yUUrEb68xJBSNTBl5z4cxfquR1tSJHyv
        dOoBFO87k9AW+3AXtSlZSE4q0oFdEaaphQb7ecEgUn6txwAVlqSdbudTRhFrE9aPTTlBM3DeZeG
        A/norqSRpBogQP6Mnp4K7ij8+
X-Received: by 2002:a5d:47a4:0:b0:21d:99b2:9434 with SMTP id 4-20020a5d47a4000000b0021d99b29434mr8238608wrb.597.1657796376742;
        Thu, 14 Jul 2022 03:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vMFeyb0UzdUzINxZqK//aaNWZxJ8umYEnULpjLkJUb8f7TOKCnyWQdEJVvreAIVsbJGvW6Mg==
X-Received: by 2002:a5d:47a4:0:b0:21d:99b2:9434 with SMTP id 4-20020a5d47a4000000b0021d99b29434mr8238592wrb.597.1657796376512;
        Thu, 14 Jul 2022 03:59:36 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id d13-20020adffbcd000000b0021d9591c64fsm1215600wrs.33.2022.07.14.03.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:59:35 -0700 (PDT)
Message-ID: <7f8d7a318bde9f290b5d782e63c8d27b3a6cdb40.camel@redhat.com>
Subject: Re: [PATCH 5.15 00/78] 5.15.55-rc1 review
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        kvm list <kvm@vger.kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 14 Jul 2022 13:59:33 +0300
In-Reply-To: <Ys/qHw7E/6gWqEbN@kroah.com>
References: <20220712183238.844813653@linuxfoundation.org>
         <CA+G9fYtntg7=zWSs-dm+n_AUr_u0eBOU0zrwWqMeXZ+SF6_bLw@mail.gmail.com>
         <1a143d949dc333666374cf14fae4496045f77db4.camel@redhat.com>
         <Ys/qHw7E/6gWqEbN@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-14 at 12:04 +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 14, 2022 at 12:50:10PM +0300, Maxim Levitsky wrote:
> > On Wed, 2022-07-13 at 18:22 +0530, Naresh Kamboju wrote:
> > > On Wed, 13 Jul 2022 at 00:17, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > This is the start of the stable review cycle for the 5.15.55 release.
> > > > There are 78 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Thu, 14 Jul 2022 18:32:19 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.55-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Results from Linaro’s test farm.
> > > Regressions on x86_64.
> > > 
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > 
> > > 1) Kernel panic noticed on device x86_6 while running kvm-unit-tests.
> > >    - APIC base relocation is unsupported by KVM
> > 
> > My 0.2 cent:
> > 
> > APIC base relocation warning is harmless, and I removed it 5.19 kernel:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.19-rc6&id=3743c2f0251743b8ae968329708bbbeefff244cf
> 
> Nice, but doesn't look relevant for stable trees.
> 
> > The 'emulating exchange as write' is also something that KVM unit tests trigger
> > normally although this warning recently did signal a real and very nasty bug, which I fixed in this commit:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.19-rc6&id=33fbe6befa622c082f7d417896832856814bdde0
> 
> Already in the 5.18.2 release, doesn't look all that relevant for 5.15,
> odd that it is showing up on 5.15.

Yep, I also think so - I just wanted to point out the source of these warnings.

Best regards,
	Maxim Levitsky

> 
> thanks,
> 
> greg k-h
> 


