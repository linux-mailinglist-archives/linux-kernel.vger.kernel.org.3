Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03F5A410B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 04:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiH2CUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 22:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiH2CT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 22:19:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC3862D1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 19:19:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so86558pja.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 19:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=0H3AUYuP4P/tMp7k/Nt9coEcCeVEYZaStWGgcyYhtco=;
        b=NfCku//zQ3DpnXc2hrSQ7Mpl2mjyzVD0yU0fwGZyS/DevEh8mNstpHBjJpZWsFB4KD
         WaGGtlT3WOFDuSHMVnZO0TtCQkvmfx9PslISrbdToNHVdoh4yAuiklbNb9XxguEXwdBq
         LLgkPtf8jgCjtTmNtikm+8RDG4sOrj9/UfADcaAvQks4Mpl0RXHwY6VZajwE+XWdummB
         teKDEK854SRoZA1/MCNrptCcbY6+VIxuPk7XuhrAgapunOVhKH2n++LW+ZLP3CQIclGE
         6eP+srcogAz1o2FOTaT/6B390AH3LmOg0xu7xRYpsweBEy5PgsmJ8ez6JiOITylGbCMd
         di8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=0H3AUYuP4P/tMp7k/Nt9coEcCeVEYZaStWGgcyYhtco=;
        b=39PiqPBwm8l/4iTbnjwqXJlb1/KD03/SyJoVzyMH2RPWvph63Gr1b2zP1SVp7JCCmf
         hi657p6ACx5Qd/W48gTd//K50rcunI8JBtQ4wleiKOIWL2HeFSt0vuEzsIih8Ztbmqh6
         3d32uvGL5ZgvLYVNI0CcHR1wgUmcj5BkU9wMsm1dfy2Ix+iglUuVL0XWJDn2teRQ+196
         9gcK0I+JtL8djXR5HPSAekiBHu5kCrbef/J4Ev2odeBECxvOIaGU4aHPKnhKdy1O9baE
         VFrwXiuQzmxWOLPFYZQXtr8ofDwL7qXtDBMYKRHKdc3wcjPSuI6SZ03/JTZrS1Y98auR
         Qzpw==
X-Gm-Message-State: ACgBeo0TiUct9LZS6samv4FT7boSuM4Xer7c24y1dtm3ytLXvL3fGl4q
        PTwKdaqmgiuEYTjkRgFUN1PvmcGRD8M=
X-Google-Smtp-Source: AA6agR7eB1+pPFKRUGO04fj1oQc0uJXG3yYMgqjDCnKY4J9L8oslQsJujDPNtFhFYMbbRCaHc5SXhA==
X-Received: by 2002:a17:902:bd49:b0:172:df88:8981 with SMTP id b9-20020a170902bd4900b00172df888981mr14448764plx.120.1661739591284;
        Sun, 28 Aug 2022 19:19:51 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-73.three.co.id. [223.255.225.73])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902a3cf00b0016d72804664sm5988156plb.205.2022.08.28.19.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 19:19:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 166A5107D6A; Mon, 29 Aug 2022 09:19:43 +0700 (WIB)
Date:   Mon, 29 Aug 2022 09:19:43 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM and miscellaneous subsystems list 
        <linux-mm@kvack.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: One of reviewers and maintainers for checkpatch is inactive
Message-ID: <YwwiP7Erud6Ns9mu@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ks3BxDV1mEZuNsep"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ks3BxDV1mEZuNsep
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

It seems like one of reviewers for checkpatch subsystem, Dwaipayan Ray
<dwaipayanray1@gmail.com>, is apparently inactive with his last post
about a year ago ([1]). Maybe remove him from MAINTAINERS?

[1]: https://lore.kernel.org/lkml/CABJPP5Bpc_0c=3Db8kymo0fgXZARNZJ8EM5F=3DG=
px1=3Dy+vOfPWM8Q@mail.gmail.com/

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ks3BxDV1mEZuNsep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYwwiMAAKCRD2uYlJVVFO
o0PgAP4/JO9GTBTBL35I5zYvgbcbrSpyY3d+aEGd/y8c1Ma7SAD/XhY9gy1c+h9Z
YM8MpPhqMqieVwyln6yo8PyRo0WJGQs=
=CJEt
-----END PGP SIGNATURE-----

--ks3BxDV1mEZuNsep--
