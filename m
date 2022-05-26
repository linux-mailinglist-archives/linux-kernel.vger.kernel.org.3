Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1C5535171
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbiEZPa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347922AbiEZPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:30:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743F5C1EE8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:30:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n10so2041636pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=f0oIJyNR//HgUX2t3iRe655NHhT5Xxp8TrbHU6y9EEA=;
        b=TjibDcYmrAJMOftD/6wq23jnMY0yrbsrRREICRDTngCWmvp/5WlnXVNzxAWbqlskOM
         fPZRrEOIK9Z8XyxYLoN4AcWwL/fCuQO3mwhPMMiUMh8T6jVADnpksgh+M/vb4hiFSuTB
         7QcmwmLfERRnn+flCxbmJNI2MLnZVwuHK0hfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=f0oIJyNR//HgUX2t3iRe655NHhT5Xxp8TrbHU6y9EEA=;
        b=cwSuNH0QlkGwimdUktJaYItiSZrNmVz/uibYntUXk0ll/N7SCVW7ITWWegoVmwfeAk
         0PBp3c+o2zsacaeZxMa7Yaj5vqT0sTIObmJ4PJiTxfTCgIFRPOQcz5l9GpHyA8XpTzEo
         0aX8FvM2EM1YNIjiw8N72bT86BFLLhRtzeU0cIt4Hq701eQz3DwHuL1V767v9CpCFMOb
         zCi455nQgYglnEcDDzSwkz2HCbRujP/5iFNbcJSLnd1O8KTKnWRXFy0SwopVg+SYgmP2
         JXoFsaReTuheGNIx74p3Av3zAYsPoCwfIkKMfZ3uJuUrOCtAbd7wjtQT+MJeFjpDEIhh
         9nyA==
X-Gm-Message-State: AOAM530j+PH070R06gxB4jZ4nh/Qmm65AHxwOn9/nh3QjDOXnfKKRN+n
        ei5EdQ/wpJ94XVnFQ8opLMQJmw==
X-Google-Smtp-Source: ABdhPJzFCD0Fx7iv9q8tMYCCo+mBF4urg52jtuQthmRGfwkjSyXeIbyxnqAf+RtQgSfcLe7opvSrNw==
X-Received: by 2002:a17:903:1211:b0:15e:8208:8cc0 with SMTP id l17-20020a170903121100b0015e82088cc0mr38880866plh.52.1653579052887;
        Thu, 26 May 2022 08:30:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902f34100b0016368840c41sm1705409ple.14.2022.05.26.08.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 08:30:52 -0700 (PDT)
Date:   Thu, 26 May 2022 08:30:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [GIT PULL] kernel hardening fix for v5.19-rc1
Message-ID: <202205260827.CADD61804@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this kernel hardening fix for v5.19-rc1. This fixes an unlucky
build race condition when using the GCC plugins, noticed by a few folks.

Thanks!

-Kees

The following changes since commit ed5edd5a70b9525085403f193786395179ea303d:

  loadpin: stop using bdevname (2022-05-16 16:02:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.19-rc1-fix1

for you to fetch changes up to d37aa2efc89b387cda93bf15317883519683d435:

  gcc-plugins: use KERNELVERSION for plugin version (2022-05-24 08:25:16 -0700)

----------------------------------------------------------------
kernel hardening fix for v5.19-rc1

- Avoid GCC plugins needing utsrelease.h build target (Masahiro Yamada)

----------------------------------------------------------------
Masahiro Yamada (1):
      gcc-plugins: use KERNELVERSION for plugin version

 scripts/gcc-plugins/Makefile                  | 2 +-
 scripts/gcc-plugins/latent_entropy_plugin.c   | 2 +-
 scripts/gcc-plugins/randomize_layout_plugin.c | 2 +-
 scripts/gcc-plugins/sancov_plugin.c           | 2 +-
 scripts/gcc-plugins/stackleak_plugin.c        | 2 +-
 scripts/gcc-plugins/structleak_plugin.c       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
Kees Cook
