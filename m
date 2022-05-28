Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8AD536C5C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 12:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiE1Knx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 06:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiE1Knw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 06:43:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4513411A0A
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 03:43:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j25so8775606wrb.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 03:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=5az1MYytdxZl1eknAdhpDUqdDPhl7opCX8WZOgKwVXc=;
        b=g88AnUp0BsSiiRSXvNpFSvBXCk9H8MaAg2NfxyoICckHK2CxbW2B/89hmterT8IYap
         JbPPdic8Ti+KDkTAQ6ZkFdstylDgc8KJzWhlp0GUYYvqfCpMJ4xdLDvTCft/KAY/DyUQ
         ui+6HXL/+Sr/6sBUXbDKIS4r1QXIJWQsPc+wlDZ1crw9IIaQx8a1y33S3+7JkwI0nLKw
         DGfCSO1GOmU1N6Ezj5hEc99RXjY+lIkspnXIhBWKQI3SI6TdX8uRt96CoYuBMNj78asq
         eRA8X3zwiX8/pO2VVYNpXdndp6QftLu/Gw3PdUMXx6wi1Go+Dj1dJmdbqQs8bIM4DJ5e
         K9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5az1MYytdxZl1eknAdhpDUqdDPhl7opCX8WZOgKwVXc=;
        b=KZy6JDKqjjL2NPy15/sZqE3Ks/XEFyp47YEuHmRrV2X+FzgV9KbWnqVwMlKPqCLqWO
         KvxSDiDg9Vildcm57aN9JjAJISUkHNxdhpYJQyWgra+PBCXCAFuSs0HzRaK9NzEJXoDg
         iEOQW9DbYbazjKFIKmzdYAHiJPQiwVcQwGJON2k6nlTZLnuEj/hlPCJx0LsOc2docPOE
         HzkoZmJIUoSBLFFH+QSZGwhTLK1rVJjQNPbFXXH5VwgdKvqJp2qAuN7Ux6EhCVkM0nBI
         0IoOSwzRR8qgCRsGiLoSnval7KKftB22rzx/JBPMfULNuqCJFGn2gPAio+vV5KjIdRIx
         vwVQ==
X-Gm-Message-State: AOAM531mrwCliqbdQ6jav0zVIDymxYWz+fEqZZZw68dJ3QRXlLggrSAs
        60Z/AkTPUz63DX3zKh1UXRKFpn1gTp4=
X-Google-Smtp-Source: ABdhPJxsURgktGYPtetYqlno1yjhcAodZw1pEqMmwMkOEx9gG4pJsOKUQIz8ysFAs0NxUbGH+vrs0g==
X-Received: by 2002:adf:e491:0:b0:210:c71:dd15 with SMTP id i17-20020adfe491000000b002100c71dd15mr9839989wrm.538.1653734629858;
        Sat, 28 May 2022 03:43:49 -0700 (PDT)
Received: from debian (host-2-98-37-191.as13285.net. [2.98.37.191])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b0039456fb80b3sm4828086wmq.43.2022.05.28.03.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 03:43:49 -0700 (PDT)
Date:   Sat, 28 May 2022 11:43:47 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: mainline build failure due to 8bdc2a190105 ("crypto: poly1305 -
 cleanup stray CRYPTO_LIB_POLY1305_RSIZE")
Message-ID: <YpH84wrg4ZxIkkie@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi All,

The latest mainline kernel branch fails to build for:

arm: imx_v6_v7_defconfig and multi_v7_defconfig
mips: decstation_64_defconfig, decstation_defconfig, decstation_r4k_defconfig

with errors like:

In file included from crypto/chacha20poly1305.c:13:
./include/crypto/poly1305.h:56:46: error: 'CONFIG_CRYPTO_LIB_POLY1305_RSIZE' undeclared here (not in a function); did you mean 'CONFIG_CRYPTO_POLY1305_MODULE'?
   56 |                 struct poly1305_key opaque_r[CONFIG_CRYPTO_LIB_POLY1305_RSIZE];
      |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


git bisect pointed to 8bdc2a190105 ("crypto: poly1305 - cleanup stray CRYPTO_LIB_POLY1305_RSIZE")

I have checked .config to confirm that it contains:

CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set

so, CONFIG_CRYPTO_LIB_POLY1305_RSIZE will not be defined as it now
depends on CONFIG_CRYPTO_LIB_POLY1305.


--
Regards
Sudip
