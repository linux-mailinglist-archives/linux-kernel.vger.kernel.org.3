Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162FE564590
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 09:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiGCH0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 03:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGCH0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 03:26:18 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F4495A9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 00:26:16 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 6049B2F2F6F;
        Sun,  3 Jul 2022 09:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1656833174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+c9PScz1Ue2Lmb20pV+6BjxjkrlZtxBSlESfutw+vc0=;
        b=OLJ/1U6WF8dDjh68sjdMLy9hpdJ426neb/lYZcxUBWnscdwDZHaSRa1RiVktQ74sHfqQeu
        Up6F3hiaNHrswaM+DgM9VTvgVTlyEbgMpP+7eBLbaQMJBQGGncaLRTSiw0yo+h2g+FPZVw
        QnRSzgyV26SL/3QImhw/BGyXjeSkvoBIFLPzCfx69hJFwlmVZHK6X9D/QVZAbc6qBRcArI
        uliwXMAQnIAaIanBKJ0XnHGqNsKjyeBsJQN59zI84GID+cmofzupmkIF8GbCjDAZnKmcAt
        Z6Cf27rysPOPxg0KlUcav2sFCMlunsAyrabfjGyd04Tkel/SX/RT+iapCorCIw==
Message-ID: <ea4989713501d63c1546993d3961f321bdaccb1f.camel@svanheule.net>
Subject: Re: [PATCH v4 3/5] lib/test: Introduce cpumask KUnit test suite
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Date:   Sun, 03 Jul 2022 09:26:13 +0200
In-Reply-To: <YsC8cTncwh+lhHxK@yury-laptop>
References: <cover.1656777646.git.sander@svanheule.net>
         <c96980ec35c3bd23f17c3374bf42c22971545e85.1656777646.git.sander@svanheule.net>
         <YsC8cTncwh+lhHxK@yury-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-02 at 14:45 -0700, Yury Norov wrote:
> > On Sat, Jul 02, 2022 at 06:08:26PM +0200, Sander Vanheule wrote:
> > > > Add a basic suite of tests for cpumask, providing some tests for em=
pty
> > > > and completely filled cpumasks.
> > > >=20
> > > > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > >=20
> > > > Notes:
> > > > =C2=A0=C2=A0=C2=A0 Changes since v3:
> > > > =C2=A0=C2=A0=C2=A0 - Test for_each_cpu*() over empty mask and cpu_p=
ossible_mask
> > > > =C2=A0=C2=A0=C2=A0 - Add Andy's Reviewed-by
> > > > =C2=A0=C2=A0=C2=A0 - Use num_{online,present,possible}_cpus() for b=
uiltin masks
> > > > =C2=A0=C2=A0=C2=A0 - Guard against CPU hotplugging during test for =
dynamic builtin CPU masks
> > > > =C2=A0=C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 Changes since v2:
> > > > =C2=A0=C2=A0=C2=A0 - Rework for_each_* test macros, as suggested by=
 Yury
> >=20
> > We have a special tag for it:
> >=20
> > Suggested-by: Yury Norov <yury.norov@gmail.com>

Of course, sorry I forgot about this. I should've included this already whe=
n introducing this patch
anyway.

Best,
Sander
