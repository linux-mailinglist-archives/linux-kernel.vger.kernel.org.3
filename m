Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9516F49D5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiAZW47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAZW45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:56:57 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0123CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:56:57 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id y17so1023909qtx.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:subject:mime-version:content-transfer-encoding:date
         :message-id;
        bh=ebh1EkINheU6AJznWvOH5lBk106alADRJpgPgKqPubs=;
        b=BntBuQTnKUn3ZaQDv9tgk1ajdwcgCa+NsmFmkM1Sit48IuTC+KE5ExE292Q2m0Q29J
         hQRnZEnmdnnllzM98FU1LW4Iy35usSs1iFdstjqxiqd3CDvraVH/I+A0kDWZugIpZQ/7
         3EF49rggm3g6XuKGlZMuCkDn0KH2ba07VZrVsJGEOcfqw7i+MORd9LLChOZ5Hx/KDPiZ
         REajyJ3arIvdHkmonN59GSkeDTaoNshmYlrdQXa40ZsV2rpZHxrWtKirsXxJ4Boy/UYt
         olrIuhHThEehYe+TeOuTgALYSgFM3mrxhNI2sPnQN6RegbRqqlVtwZtAzrNtK+pMmsek
         ebZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=ebh1EkINheU6AJznWvOH5lBk106alADRJpgPgKqPubs=;
        b=eVwf432KFybzQ3uBLq5bF3gkqkAFnlM0H4YIIYIyUCEpV9KDxf0zMPe5HOP5rby1UJ
         ZMOwRoDWNdX6vWBNiQkLPgS4a20ejkUbEcafdB+mXv3RNiJKKT8TdUDrFGcGJAkp9LR4
         s24YmQX7RviVSaB9bykVWeicwjKfCxQ2S+jDwXLyLBCF8hdNLWFTwt1k/Yezr+kvLV8H
         l+sySx6NauL3aPZJirXzLWSi6AXRtRPQMykwNhMALiVFyKRvfR03PvBIQp/yuNdlCRQL
         bqUfDD5co846Ub2P6YYiXciLMuASGawU5EGVaX5e99/sSnRh01Entww1dB8IsMUMVJRb
         Wl0w==
X-Gm-Message-State: AOAM530oGehpQiLApgLjdPdUWgazJh9pvOlrZ+ZZeEj0oA9IY6QZL0YK
        chnnPioqcCD7c1XYnqs/FwrhM7d9sTDA5ERrug+cgyOMAM9KakCXVx/RJ+LLUz/RjuYIJqtrih1
        H03heUCQcY4iqU2PgQGlq+J4/v1TPJ/NdAZNI5qLT80iMD/DzaoP3qtbK3WHRkK4GnB1oOYmD3e
        leDWd8sg==
X-Google-Smtp-Source: ABdhPJwevkGjOIWN90SORrh4PbQbOIu4uyhJAOsxU2XW+bykb5ehMHkujEfXL0NJUEh2mqWfEiAllQ==
X-Received: by 2002:a05:622a:1a84:: with SMTP id s4mr729344qtc.133.1643237815507;
        Wed, 26 Jan 2022 14:56:55 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id k15sm440907qko.82.2022.01.26.14.56.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:56:54 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     linux-kernel@vger.kernel.org
Subject: linux-next 20220125 - build failure in objtool with gcc 12
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1643237813_15735P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Jan 2022 17:56:54 -0500
Message-ID: <20494.1643237814@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1643237813_15735P
Content-Type: text/plain; charset=us-ascii

Fedora Rawhide shipped gcc12, which apparently includes a new warning that
causes a build failure.  Apparently, it's unable to figure out that 'ptr' remains
valid on failed realloc(), and we only call realloc() again on failures...

  CC      /usr/src/linux-next/tools/objtool/exec-cmd.o
  CC      /usr/src/linux-next/tools/objtool/help.o
In file included from help.c:12:
In function 'xrealloc',
    inlined from 'add_cmdname' at help.c:24:2:
subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
   56 |                 ret = realloc(ptr, size);
      |                       ^~~~~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to 'realloc' here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~
subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
   58 |                         ret = realloc(ptr, 1);
      |                               ^~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to 'realloc' here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/usr/src/linux-next/tools/build/Makefile.build:97: /usr/src/linux-next/tools/objtool/help.o] Error 1
make[3]: *** [Makefile:59: /usr/src/linux-next/tools/objtool/libsubcmd-in.o] Error 2
make[2]: *** [Makefile:63: /usr/src/linux-next/tools/objtool/libsubcmd.a] Error 2
make[1]: *** [Makefile:69: objtool] Error 2
make: *** [Makefile:1405: tools/objtool] Error 2


--==_Exmh_1643237813_15735P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJh8dG1AAoJEI0DS38y7CIcVx0H/juR4Fvgq2+8djAtAFGjVfoj
3I0MAppfBxAV9trrn/9+ykBk8k+ULUQy4X0AeJtbplmvgXxPU+xgYSUbbY9Tqzbn
acifmlnr0t2QXkg6e0dB0fIx/A/ogRFNJKyIhRw6uGowbdBIl4WEiqjvCD6wWwPv
0XhAxoR9fW84/qrJl8x+U2WpEkEqrqWN4zOSDZxvRfMCPx0vqfkWVLdoON9BezN1
JHcDhGKeLQefGWuRZkM8yi6MxDKytrsEO9wQF1UrwI/QtrCYHh/InzMYhhCzRZC7
qPV8YsAuTi/tGXckuGcfwXfQG2iU1hsUI2e55Pmf3JyOu1N4rI9OCsVlEhHw3DY=
=O1py
-----END PGP SIGNATURE-----

--==_Exmh_1643237813_15735P--
