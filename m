Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA35379D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiE3L0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbiE3L0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:26:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F667CDFD
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:26:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id t13so8885114ljd.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=npSoPOR18gr4kYVcO6FCP7SdcO9Nfox2m4Mymj662QY=;
        b=DzFBkjp3mxBY6C3TkNtzvS3/ADlVGt5Bn8JVavdokD3lBw+vFquDRlLPRgJVM1nCxk
         cTwSZ3t9JJ2thLH8pWrWRvRU8/zAPYoK5BBLjTHlm3amSYYgZSk3UlFMe8E4Kk+ku6Qx
         GaV7upGsDVYX+XZgINYmA5dgGadtfVH4qDLm443NC1Jj7mZpLfIbb5ycqic/c1ozMzIY
         pv5X3DY4xnp4kezJSQyNLofVY/k6Tp99MSgOyFZVVv8IsbSrISqyzfDCUdi1XYuTFgLg
         JND5M5/OmgGPqvgvTwidQk/pN2uDRmFBb0+jjq0ff+1Ua8b4VDVrRRvoWrtY3okgLLf3
         2TSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=npSoPOR18gr4kYVcO6FCP7SdcO9Nfox2m4Mymj662QY=;
        b=2QpecDhb8HtqoqZsD3o1ievnZwr5PhzHjVkrRFN/XVnb5GOD2ndG1MuerEqTtX58YQ
         vGcKWjSTKNegvO8vJJ5czNwJ9eQa7hzXosym+/gPvGlTo5sfTVkFwd5+5HhsBoIDrAwU
         SgNp1pEFMnZrH1fNKmd4z+okttBMYeVofN/++zBd1xUP/RN0656aV5FqrDsRVScLYGb8
         r/b7Ji/8cvMYVNzVOCI7Qf3RMskTReWGuvK7lISzCkZckjxcER8Y+tKfUPk6j+QY7h44
         lZCIex0ODa5SPJAymduGR+VWpmCOPBfcbGhnG85waKG1skDfk5YMyLTnxgoBN5gWJeUb
         xv6A==
X-Gm-Message-State: AOAM5329ZfqhBKMgnX8ajone6QryJ6UV2YWunEQVwSuzfjuUCDuYoNca
        Ymf5C7QSGdYZz2Q1X97hi6kkj61ky7SY2w==
X-Google-Smtp-Source: ABdhPJyvMauwBGWci6pyzoGU2h1C9VnN++whWVOzXhb8QUPfKvpCll4M/eYaFsgnVQeW9MsJ5FB22Q==
X-Received: by 2002:a2e:330f:0:b0:253:da40:de51 with SMTP id d15-20020a2e330f000000b00253da40de51mr31122907ljc.76.1653909975531;
        Mon, 30 May 2022 04:26:15 -0700 (PDT)
Received: from jade (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id a10-20020a194f4a000000b0047255d2117csm2257899lfk.171.2022.05.30.04.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:26:14 -0700 (PDT)
Date:   Mon, 30 May 2022 13:26:12 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Fix OP-TEE compiler warning for v5.19
Message-ID: <20220530112612.GA1511426@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small patch which fixes a compiler warning in the OP-TEE
driver.

Note that this pull request is on top of and earlier accepted/applied [1]
pull request in order to avoid a merge conflict.

Thanks,
Jens

[1] https://lore.kernel.org/lkml/20220503192916.GA3288817@jade/

The following changes since commit 3e47235eaee09488c7e467b9aaccb7c93c862c6b:

  tee: make tee_shm_register_kernel_buf vmalloc supported (2022-04-05 08:04:16 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-warning-for-v5.19

for you to fetch changes up to a3b9ecc805e9131476c719111fe347c7dbc0d1d1:

  tee: optee: Pass a pointer to virt_addr_valid() (2022-05-30 08:06:45 +0200)

----------------------------------------------------------------
Fix a compiler warning in OP-TEE driver

----------------------------------------------------------------
Linus Walleij (1):
      tee: optee: Pass a pointer to virt_addr_valid()

 drivers/tee/optee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
