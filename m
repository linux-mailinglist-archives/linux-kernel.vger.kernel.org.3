Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11730576CD4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiGPJdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiGPJdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:33:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FD12657A;
        Sat, 16 Jul 2022 02:33:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w185so6579156pfb.4;
        Sat, 16 Jul 2022 02:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b9sp3ZaPCJfXtbSUrFWEULxoyM5LsOvzmqkPFx3Byxo=;
        b=oSuy73AJs92IXvif2iJfuHfusV6Sl67EoC7Ee7QAPrYTL3M5YXXwHEod+9oNG2r9aK
         t+8/j9wbq7HaUGn9idxrzgsY9xt8mqITqkbW/K3wakZygL4IbvgBaWW+Qb18gOUTyWMb
         dKdzHm2cvmgSZjTa1Kvsz9O+0uXU4MQt2HErd+2QiAywvgnfF9+7AgjNyvuvc+UZmofH
         AhongfJEHbRF0DDWBGWTywWS83IWww37rnhYH10Tfn3KSuGP1lNP8Ytv1PC9t8ur7KJj
         tYcIHJR2mEph9sk2Aad+bFr+HxNzcN6pDd7bw7wlQph3eajKe74/SPRYf54y3WERzTC4
         sO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b9sp3ZaPCJfXtbSUrFWEULxoyM5LsOvzmqkPFx3Byxo=;
        b=6tepUfYN01gqltXRLvdgA95Txk5z2ILZTWGn4O/2eobG0TQoOoFCsajif9Ic1rey7a
         APquFHenmpERsMd2xj2bAnXh+g/0pfZ1VSAyQEZNX5Hi6kMm/NamV8A/gQdcFcVvNqEB
         rd5oYxQ+QlACGwLZDKyZ1n3pfKXOUu7oUVQCMd6wRzDdUJZZf+cKTqTxOCmY+dLMlbNA
         nrBhKhDGrjGJWFQuKFjIGyzeiLGI1ibz+4dKlYEcXMqqgtbh3ziGGZPQrZF7mNfQlJBX
         lXmFc1L7pR15sVNboikfv3VPHw627mBDoHSTiL7Ef1lFt7bdRMqxdWJVvQgFpvbO8tj3
         NZmA==
X-Gm-Message-State: AJIora9jZUVD+x8FEs2MndKXULcEzNIB9KRZ6uXEb6TqgkBUkBvd9pCt
        2av4/sZ9UVmZkydgZ7jEHCc=
X-Google-Smtp-Source: AGRyM1vNi9JRB2xodo1rojkRbFa6GagnAAnCAuOteZGLXPf0fVkujN6XolacQOKPLrql7U+1KMwHuA==
X-Received: by 2002:aa7:88c3:0:b0:52a:d6ee:eb5d with SMTP id k3-20020aa788c3000000b0052ad6eeeb5dmr18257505pff.63.1657964018942;
        Sat, 16 Jul 2022 02:33:38 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-23.three.co.id. [116.206.28.23])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b0016bee668a5asm5124124plr.161.2022.07.16.02.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 02:33:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id BC9E11038C0; Sat, 16 Jul 2022 16:33:33 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Martin Liska <mliska@suse.cz>, Andi Kleen <ak@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kbuild@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/4] kbuild: lto: documentation fixes
Date:   Sat, 16 Jul 2022 16:32:46 +0700
Message-Id: <20220716093249.19326-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is documentation fixes for kbuild LTO feature tree [1]. Two patches
fixes warnings reported by kernel test robot, the others are formatting
improvements.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git

Bagas Sanjaya (4):
  Documentation: lto: add blank line padding before single requirement
    list
  Documentation: lto: use bullet list for FAQ
  Documentation: lto: use bullet lists for external link references list
  Documentation: lto: add LTO documentation to toc index

 Documentation/kbuild/index.rst     |  2 ++
 Documentation/kbuild/lto-build.rst | 36 +++++++++++++++++-------------
 2 files changed, 23 insertions(+), 15 deletions(-)


base-commit: 79a278f10955da2801240f52efb828d158b2b36c
-- 
An old man doll... just what I always wanted! - Clara

