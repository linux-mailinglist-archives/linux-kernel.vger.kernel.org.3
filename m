Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DA457A755
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbiGSTj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiGSTj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:39:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C46845066
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:39:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l23so29150972ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sySFCogY4zJys9RbCxZTFaURS+YAXA9DoVe394Lvm2c=;
        b=Lka9E/d71oVcRQcSrhfh6av9axLhm/53mXFwHEcFKZquLRwmhjYhlGuwIkQZX9+nM2
         FnX1Gop+UPAiBhUe5/DIKJohmgw5l7UugJLhN94ryy02MdpdRrM50BU0c6ZdL/rZV/6z
         7xlacQLJIozEyIsuC+h8JlG+sWxUauBdXnP33/8GiWx/5dYBf/JzukcY5aEi8hRwsHbI
         Onl3C9hOOjF5uTs4w59xlwZhmzymQh5Ueh/oM4JGAGXJIh16NOXWMAk/IrffhbJhOkkd
         2ReK8qQt9f9OUUBZLj2OjDOvm+CSTWEZX4KboQ68ZECVqxss7J08TKzzMi8Tvv74RgGv
         VBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sySFCogY4zJys9RbCxZTFaURS+YAXA9DoVe394Lvm2c=;
        b=syY4/lcoj8mCqJizQRARcS19sm3RK23N7/AMP/ZFO+de+gBXUBgxtGUvmlcwBWKt3k
         PEeAwlqdJFss6Fw3db8X87PUv4RwFuf4e0Hxn5XTygXGtVK9cPzNNgDE8AVI+LIMGib8
         8QatHFMNuHWjkbbLSSN4pl4Xh092JPHQmhks89/nG7KC08Eekn/aP+bKO/bTHNY9QJ5+
         vCLnTAjF7Y77q711HnNRIhLTL0+Z4hRWTHvzJDSHPLr7zqHiEaeBqeKo1zDHwz7oHPvD
         yKXqaj7WsFZ+ex+J66j7pwqdlAS0aITtQc/BDc+TP+r+msW2oNyWK3NPVsgTYmabKYAM
         lRmw==
X-Gm-Message-State: AJIora+08HLUq4I8e4Z4aj1QnlZmoLhhuPtyJueNnAzAs2TGBvo0Rh8h
        JUyndw/pm/aJOrX1r2VktPtJJqKbyi2krdjyZRw=
X-Google-Smtp-Source: AGRyM1vuWLPpGh466pjJ+oMRrSKYIJUZlt4ovM/i+r7WNB3ItUqclO3pVGyXD/5tuQQobGNoTmyZbw==
X-Received: by 2002:a17:907:271a:b0:72b:4ef4:2d8e with SMTP id w26-20020a170907271a00b0072b4ef42d8emr32348191ejk.634.1658259594762;
        Tue, 19 Jul 2022 12:39:54 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id m6-20020aa7d346000000b0043bb71edd36sm110146edr.44.2022.07.19.12.39.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2022 12:39:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH REBASE] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <YtcIIaFeVIzor/jD@sirena.org.uk>
Date:   Tue, 19 Jul 2022 21:39:53 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D3667EE-FA11-455F-AA33-0B3E58815273@kohlschutter.com>
References: <Yta/zrJxQOfYmN4C@sirena.org.uk>
 <20220719184943.1566-1-christian@kohlschutter.com>
 <YtcIIaFeVIzor/jD@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Am 19.07.2022 um 21:38 schrieb Mark Brown <broonie@kernel.org>:
>=20
> On Tue, Jul 19, 2022 at 06:49:44PM +0000, Christian Kohlschu=CC=88tter =
wrote:
>> Regulators marked with "regulator-always-on" or "regulator-boot-on"
>> as well as an "off-on-delay-us", may run into cycling issues that are
>> hard to detect.
>=20
> I think this already got applied, I had another go at persuading =
things
> to cope which seemed to work - not 100% sure what was going on, git
> seemed less forgiving than raw patch here.  It didn't look like a
> rebasing issue, it looked like the umlaut was upsetting git.  Should =
be
> commit 218320fec29430438016f88dd4fbebfa1b95ad8d in my tree.

Yes, I just got your emails after I resubmitted. I had thought my email =
client had messed things up, and I had resent it with a proper git =
send-email setup.
Thanks again!

