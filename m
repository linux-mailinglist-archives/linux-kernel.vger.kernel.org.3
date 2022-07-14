Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25D9575830
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 01:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbiGNXyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 19:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGNXya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 19:54:30 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE1166AD7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:54:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so3963899wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibj7frjbnZYO6FL5Vcqe0nREICqfMGkWNo0vt/sikdc=;
        b=WRwkPR+l/fHOtFnWu857T99CGcTNNnKNno0+Q2bDqa6pzRYWywqfczziScZtRjEd5W
         1R3MbArz5GlRSZWHB7FKq1E7fTNvHvR/XKEB3Qom0jV4h2h9SoYt2qjcp+L5Dd/WJGbI
         GeP9OvRHwiHIsDsWZYbOlh5eLZA2VcPgKOQSTdM6NiF3xazjTSaTZkrnt7PpJpNIJn+o
         bKkvDDMgnrcdCu8l4i0a0fuQSBzdpeiBzNnzT0MLhxLaadTHz58EEoonqNLRrrl+Yepc
         +3LWT+tMjR0upeELByc9xFp8h75AHg/9LEICWbwHGWqgWm0K3+tjEhHUKewK0ljXm4i5
         wCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibj7frjbnZYO6FL5Vcqe0nREICqfMGkWNo0vt/sikdc=;
        b=DqESb5S1Wy7HkBkj2C94/iuGIvXFxNF+3TyBbtSTRust+M1r90hlIWWc38JcZawbqU
         6BoFDVbd+yS/Rmqso/MIPaiyu3Wfg1FizabW2abSx4JLOFfGDo//nexibybrB80tvtYY
         qNLST5D8Ytpn1qGyWRWj/1hUxUkNYEchrNsLzoIia7c0BYkUtyNy7e0sXC+MjmCwcU+f
         rY49GQ8RslKsVoLuJ1UhYrb29p5vNY0Pp9Gv1DCkb9iKufqZKG1/5/NWrJgeZB+t27Tm
         Y38AiBswxRI4oLu1q1F7pmPUMlfuflH8v12dvaIDLTRVUvFH8HW4Xh2q/XMs9pM+nvz1
         kE8w==
X-Gm-Message-State: AJIora+59NK39aX9INU4bWmxAV1G0VsOYyXaHsCOyr2A6spvrOlMUQqF
        SnJMd8MXHbxb5ivRRRKQRow=
X-Google-Smtp-Source: AGRyM1tQJHzl9hc1mqT5TqMUIUJix99T+jKqcZvUSZXSyQdFkEi0p4frQhhcaBj6ycd5YCUiNPrtLg==
X-Received: by 2002:a05:600c:3b20:b0:3a2:e956:67ca with SMTP id m32-20020a05600c3b2000b003a2e95667camr11560523wms.183.1657842868097;
        Thu, 14 Jul 2022 16:54:28 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600c150400b003a03185231bsm3160722wmg.31.2022.07.14.16.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 16:54:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] firmware_loader: Replace kmap() with kmap_local_page()
Date:   Fri, 15 Jul 2022 01:54:15 +0200
Message-ID: <1731607.VLH7GnMWUR@opensuse>
In-Reply-To: <YtB/QJw84z7mh0dr@bombadil.infradead.org>
References: <20220710101156.26139-1-fmdefrancesco@gmail.com> <YtAtQihwVrdymfOX@kroah.com> <YtB/QJw84z7mh0dr@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC 14 luglio 2022 22:40:32 CEST Luis Chamberlain wrote:
> On Thu, Jul 14, 2022 at 04:50:42PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 11, 2022 at 08:52:49PM +0200, Fabio M. De Francesco wrote:
> > >=20
> > > I see that the outputs of selftests, regardless of running a 5.19.0-
rc6 =20
> > > kernel with or without my changes, show always the same error:
> > >=20
> > > "not ok 1 selftests: firmware: fw_run_tests.sh # TIMEOUT 165=20
seconds".".
> > >=20
> > > I ran those tests on a QEMU/KVM 32-bits VM, booting a vanilla 5.19.0-
rc6=20
> > > kernel with HIGHMEM64GB enabled.=20
> > >=20
> > > As said, outputs don't change with or without my patch. Instead it=20
changes=20
> > > with the latest openSUSE stock kernel (5.18.9-2-pae):
> > >=20
> > > "ok 1 selftests: firmware: fw_run_tests.sh".
> > >=20
> > > Unfortunately, I'm not familiar with kernel selftests. Any ideas=20
about what=20
> > > could have made this tests fail? Is it expected?=20
> > >=20
> > > If not, I can try and figure out why these outputs are not what they=
=20
should=20
> > > be (the second version of my patch can wait the time it takes).
> >=20
> > No idea, sorry, Luis might know more.
>=20
> The selftests should have a config file, ensure that stuff is all
> enabled. Can you verify if this stuff was enabled on your config:
>=20
> cat tools/testing/selftests/firmware/config=20
> CONFIG_TEST_FIRMWARE=3Dy
> CONFIG_FW_LOADER=3Dy
> CONFIG_FW_LOADER_USER_HELPER=3Dy
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> CONFIG_FW_UPLOAD=3Dy
>=20
>   Luis
>=20
You've been helpful to tell me how to check that all the necessary options=
=20
were enabled. Actually they were _all_ enabled.

Soon after checking, I started to look at something else...

Being not familiar at all with selftests I had not realized that I was=20
using the tests built for an older version of the kernel.=20

I made some confusion between cross-compiling for x86-32 in a separate=20
directory from sources, installing my custom 5.19.0-rc6 kernel in the VM,=20
and running the selftests built for an older 5.18.0-rc[something].

Everything is working perfectly now (with and without my patch)[1]:
"ok 1 selftests: firmware: fw_run_tests.sh".

I'm sorry for my lack of experience :-(

Thank you so much,

=46abio

[1] https://lore.kernel.org/lkml/20220714235030.12732-1-fmdefrancesco@gmail=
=2Ecom/




