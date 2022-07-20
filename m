Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D8C57BCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiGTR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiGTR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:28:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840106EEAC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:28:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so24644087edc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hf3nTZmXeWdoyiRltIOuXwx+NH7arTVEFrHTLIBm+H4=;
        b=RCORaxRT8Qbxt+h1vN8t853zf6aPCejPZUoLnkN5m/BzoeZVgt1Vw/WupksgA7STM7
         oGR46c9BsbGGL0WTrL8PgR2EmbGZk7MvtTlbDyUTlUM5vM0ZdOqVv84ZhgRSfN2G6W/F
         lAIn1Top+nWb6Xif/LbzB7kYZDYcCRTbYLcRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hf3nTZmXeWdoyiRltIOuXwx+NH7arTVEFrHTLIBm+H4=;
        b=QTKX+ozbSHgZkmCoNImTot/tQ3/ar1bZcM0wM4ngFdFrGqxFVvVRt6m5dfNs4uqWI/
         gMQdmSVvQ5uz8gyEfakZwaYTcCMrQfSdVYvHQ5krts1H5LFMxq8s+SRx+yV5GyOkMMvE
         StgFwTRylOREQYlP9Qgrjy4NLsVB40qvaiay4r1iCQLJhV2bsI+Q0pf/1bLFYXDr132b
         kWSVb3kge47TWChhTsGpIgGZq/nIGBJb33ZceqOBQbhhcTiHl+XMd6RVDnFNrF65hvPs
         HdX4saua0+XB2G3aGfhGVwBTHRRxjedBrEvE4Ov+Hz8MbLPGaYFTvBbQPNGIU1nVOIUY
         yyEg==
X-Gm-Message-State: AJIora+sjCmU5SvOn1P6tKO1raAZU3bvK8eMTSEOOjqVlssY8ENt/q6o
        iLaGNkm4Es5M1LfD624ABpmGMJWm677mU7DGcuc=
X-Google-Smtp-Source: AGRyM1vZE1inmBEVaZFTE0UwNleAC3o+fDVtvF3GH18aZDQL4loc/pW2dSkVigBlaiibY7zTF3aX7A==
X-Received: by 2002:a05:6402:190e:b0:43a:e914:8c11 with SMTP id e14-20020a056402190e00b0043ae9148c11mr50971188edz.281.1658338130794;
        Wed, 20 Jul 2022 10:28:50 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id d27-20020a056402401b00b0043a8f5ad272sm12761290eda.49.2022.07.20.10.28.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:28:50 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id z13so7538748wro.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:28:49 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr32009004wrh.193.1658338129463; Wed, 20
 Jul 2022 10:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220719114714.247441733@linuxfoundation.org> <CA+G9fYsCL48P5zFMKUxoJ-1vwUJSWhcn17rUx=1rxOdzdw_Mmg@mail.gmail.com>
 <CAHk-=wjo-u8=yJQJQnaP41FkQw7we9A-zJH3UELx5x_1ynPDfw@mail.gmail.com> <YtgvLUMuz+1zpQHR@fedora64.linuxtx.org>
In-Reply-To: <YtgvLUMuz+1zpQHR@fedora64.linuxtx.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jul 2022 10:28:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiu=yk=3xzXk18o5yU6v1wn27rcrOD=vmKm_aLNz=zJ+w@mail.gmail.com>
Message-ID: <CAHk-=wiu=yk=3xzXk18o5yU6v1wn27rcrOD=vmKm_aLNz=zJ+w@mail.gmail.com>
Subject: Re: [PATCH 5.18 000/231] 5.18.13-rc1 review
To:     Justin Forbes <jforbes@fedoraproject.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Slade Watkins <slade@sladewatkins.com>,
        John Harrison <John.C.Harrison@intel.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PDS_BTC_ID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding PeterZ and Jiri to the participants. ]

Looks like 5.18.13 added that commit 9bb2ec608a20 ("objtool: Update
Retpoline validation") but I don't see 3131ef39fb03 ("x86/asm/32: Fix
ANNOTATE_UNRET_SAFE use on 32-bit") in that list.

That said, 3131ef39fb03 should have fixed a completely different issue
on 32-bit, not the "naked ret" thing.

PeterZ, Jiri, any ideas? Limited quoting below, see thread at

  https://lore.kernel.org/all/CA+G9fYsJBBbEXowA-3kxDNqcfbtcqmxBrEnJSkCnLUsMzNfJZw@mail.gmail.com/

for more details.

              Linus

On Wed, Jul 20, 2022 at 9:37 AM Justin Forbes <jforbes@fedoraproject.org> wrote:
>
> On Tue, Jul 19, 2022 at 12:32:48PM -0700, Linus Torvalds wrote:
> > On Tue, Jul 19, 2022 at 10:57 AM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > >
> > > 2. Large number of build warnings on x86 with gcc-11,
> > > I do not see these build warnings on mainline,
> > ..
> > > 'naked' return found in RETPOLINE build
> >
> > Hmm. Does your cross-compiler support '-mfunction-return=thunk-extern'?
> >
> > Your build does magic things with 'scripts/kconfig/merge_config.sh',
> > and I'm wondering if you perhaps end up enabling CONFIG_RETHUNK with a
> > compiler that doesn't actually support it, or something like that?
>
> I am seeing these 'naked' return found in RETPOLINE build on the
> standard fedora 36 toolchain as well. No cross compiling, nothing fancy.
> These were not seen with mainline, or with the 5.18.12-rc1 retbleed
> patches.
>
> Justin
