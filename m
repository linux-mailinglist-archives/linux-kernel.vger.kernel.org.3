Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408ED54D282
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344239AbiFOU0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344540AbiFOU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:26:39 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD6254197
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:26:35 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31332df12a6so72892587b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZhOJrNSe4tw1TLZXZSk7fj1hsRNpg+r9MLGzlaIJnX8=;
        b=BhZCyttiyADlWlm1Oi+B8BMTTx6bqd7GA0tZaInrvrRxJ/ZkS21VnWpkx3ANg29rru
         42iArm24byKHu7RO+x6G7nwfWEcmDX7JX2QriH8rmeDwf7zmfstBXH8G8PgAmEpV/Y5u
         g1DNUNbfZ5uDyClMMdKNIAM+/FDMdOSfekpxk2Xv8AN+QdyRG4H/NozoUxQHdWM/Gwm0
         FAH5t6GFzOKASMnF4Gag/5IYni7Q6ZGzFt+Vw0/BYfLF5KuaPzQfqB26UwowRTT4Z1jN
         D1pNKUJ9vComISmBavrtcFjwHN8vnsxGdiSWsOZ7pZ9l5IVuVGNvVf/ly9YKSBkZ6nJL
         T4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZhOJrNSe4tw1TLZXZSk7fj1hsRNpg+r9MLGzlaIJnX8=;
        b=y9K+vYWnYfp/G7jH5Wnr6g2kwXDoAw2BXDcdqQmPCTtA5pNzmDhKCjsgNdlsklCE1S
         g5agkHTFStN64vdsfy1phxL760ypsX6CsEYkht3EBvc6aSRXYExioV2pqo1L+AQRCi5S
         fliaQpDbN5plZfLCJeXyn/v3OJSmNs6STs+Jh9hGVTcj5rwaKB0nKe+81sEcqhf5BCxM
         jha6+GoC0AfWT6lhakwn0X5XlBV2AIpdjaAcEtZwReBPhvBr1IW8ihLM++bbVcrkkL3K
         wG7vE0Mi5H4U3b6CTeFmrcxXqSJ/atXlMSw6qeV9QV7NHXbDoxl+zSvWXdqjUfVYoawW
         n1Rw==
X-Gm-Message-State: AJIora+gKjH0KtQzSVejPo+HeQqv1RAPk9E9nL9qfEwEpvLo/Hu+iH13
        M1tQjnH98fo4Gj3b6Vw1UEcYr29GdT3/n+8qfFGEJQ==
X-Google-Smtp-Source: AGRyM1trp2IwwZ1LxjKluseSLEOfUbMF21q4UObCXdi7+K0O53j+d6/hh+IfloJ5B6Ulz23BZ1/c1svnIVbE4FfHjKU=
X-Received: by 2002:a0d:fa85:0:b0:314:67dd:2566 with SMTP id
 k127-20020a0dfa85000000b0031467dd2566mr1730949ywf.66.1655324794612; Wed, 15
 Jun 2022 13:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220614210217.1940563-1-martin.fernandez@eclypsium.com>
 <20220615190519.GA1524500@alison-desk> <CAD2FfiGxy=9ARK5FT_iaLACZSzR+R4crmGJv7T+v_w3+ktOzCQ@mail.gmail.com>
 <20220615195425.GA1524649@alison-desk>
In-Reply-To: <20220615195425.GA1524649@alison-desk>
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
Date:   Wed, 15 Jun 2022 17:26:23 -0300
Message-ID: <CAFmMkTGFpehSFOsnDuQN4aTnwfgYGwTbGBxtvUU_byDcoRVPPA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alex Bazhaniuk <alex.bazhaniuk@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 4:54 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Wed, Jun 15, 2022 at 08:34:58PM +0100, Richard Hughes wrote:
> > On Wed, 15 Jun 2022 at 20:06, Alison Schofield
> > <alison.schofield@intel.com> wrote:
> > > My first reaction is lying about the cpuinfo is not a soln, since
> > > it creates a problem for a users currently relying on cpuinfo to be
> > > the source of truth for TME.
> >
> > I think you have to qualify "source of truth". At the moment the CPU
> > reports "Yes! I support TME!" and then for one reason or another the
> > platform turns it off and actually there's no memory encryption of
> > your secrets at all. There's seemingly no userspace way of telling if
> > TME is actually active. We were told that we shouldn't export the
> > "platform has disabled a CPU feature" in sysfs and just to clear the
> > cpuid flag that gets exported (like AMD is currently doing) which is
> > what Martin proposed here. Programs want to know the true CPU
> > capability can do __get_cpuid_count() like they can for the SME/SEV
> > capabilities.
> >
> Disagree on sending folks to use __get_cpuid_count() when they already
> have cpuinfo.
>
> Why is a sysfs entry TME-enabled 0/1 a bad thing?

:)))
This was my very first patch, and I got half of the community complaining
It was so long ago that I don't recall everything, maybe Mart=C3=ADn does?
or Richard?

  It can be documented
> to have the same meaning as the log message.
>
> You keep referring to AMD. How is their exception documented?
>
> Alison
>
> > > Are we to tell them to go look in the
> > > log now, because fwupd folks didn't want to ;)
> >
> > We're not telling anyone to use the log; grepping megabytes of
> > unformatted kernel logs is a terrible (and slow) way to get one
> > boolean value.
> >
> > Richard.
