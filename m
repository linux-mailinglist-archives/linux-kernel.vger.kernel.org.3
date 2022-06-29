Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA9560468
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiF2PVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiF2PVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:21:31 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378A7275F7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:21:31 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-101dc639636so21875675fac.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2T0btOHeyWCOKe1UWHkhUvUHS/MItGk1w4QBCDkZ4Gc=;
        b=QYWJ//L+qI1VaT6BTLpR0mn4ybSfHJjOB59oc66CPuMTLXUXDjVqEZfxrGguTFft+N
         P1X6hhy4Om6xevvr/INAHWoIR+h94c1mlClgNU1QYzcujw1Nky4FEobcVAmEn1g07eUJ
         1i0wtm5aCqj7hzniCltu5McaZcnLYvTVg91agdutGXJBrLUtYQ0A0WSlvM/BSr3mWq8E
         Dv2TzFDVHcFDAO8d87VBLa8doDB3sw00uhee9l9yyNgUpHgYq6N2qxoLZfDfaThecyQ+
         9RalcLgj9jmSdC/I3gVuyUHwhV/P1JA2glFVLNMhblzPIspZ44voU/ZO13h/WIKFuGyr
         /ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2T0btOHeyWCOKe1UWHkhUvUHS/MItGk1w4QBCDkZ4Gc=;
        b=Si6B+bbgu/VFb4mDDA65n5hNGQ4pPPEfqzFL7+Sa8QZInpYQwHxNNjl7jC9o/x5n4q
         Miu/OU8V26RF9OFq+ICO79cdtUuwA1x8dBwAokcDCw4Wym21Yy1XaYYMj73/HPX3kYoY
         KN37ryXEGm+OhGpPhk808k2OJjDPXjvNHesppwlnROgFLsZ7gHISg2CAf/fCqhrtIwkG
         ZJhjXIiS3cR+kLWi1cp8baVewMW4PWvwJ1i1bsTLqsV0L7AC9TuVWrFpyCkAB/5pPxAP
         +uyyYT1HfBNBcrghtw/zXLY2bgT2paNfW2ZNJM+groPoZ6T/Rl5OlXEdZMIbPv2dxzi1
         J1yA==
X-Gm-Message-State: AJIora//bwpGEcRdXXjfNPo2M1zEwtLN67hgjYjecrbCx/2RrpWvGg6O
        8qabHuEFfabMF2kx8mP/bY67y5ueezjdY5ySBw==
X-Google-Smtp-Source: AGRyM1sMakczPu1rAbNKkhmk2FkXi9/U7dM+O8/FRyHcVcvQYR5xJqmThWxZcXXId8SZkrV6D6F4QUj9XeEFp4DbvyE=
X-Received: by 2002:a05:6870:8892:b0:101:9d4f:4aa5 with SMTP id
 m18-20020a056870889200b001019d4f4aa5mr2265968oam.106.1656516089340; Wed, 29
 Jun 2022 08:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220606203802.158958-1-brgerst@gmail.com> <53296bc3-d220-dfe5-514b-bba2496ef4b3@kernel.org>
In-Reply-To: <53296bc3-d220-dfe5-514b-bba2496ef4b3@kernel.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 29 Jun 2022 11:21:17 -0400
Message-ID: <CAMzpN2iBk4bfFWyxrMtFanxxNAM9MYNXPZ3oQSmyBpQjuNP_Ug@mail.gmail.com>
Subject: Re: [PATCH 0/8] x86 signal code cleanups
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 7:23 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On 6/6/22 13:37, Brian Gerst wrote:
> > The 32-bit signal code has significant differences from 64-bit, and
> > those are duplicated for native and compat modes.  This patch series
> > merges the 32-bit code into one file, and does some general cleanups
> > in the x86 signal code.  There should be no functional changes.
> >
>
> This looks generally sane.  What kind of testing have you done?

I ran all of the self tests, did a parallel kernel build, and general
usage like web browsing.  Do you have any suggestions for other tests?

--
Brian Gerst
