Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB3586FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiHARhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiHARhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:37:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDFD38B7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:37:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so11236871pjn.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=m6RoQab6XfL3m83DwD4AA4wcnAm85sbG4DZvEhMAwLQ=;
        b=gLiDAYzKp9k5A5mPr/+5czOhANqndPFpAAi5PfJ0EZTvUYkp+5XTzOjaSWqMzDdvl6
         1+gXkoWW0D/PSJ/QnBcIbNGtDJMzRyC/7Kl1eW27ufLEu3eLuHgFUorF9THrHOLIM+qS
         1dPMCnjMCQOj7O1f2qS7MM/MQZU/tsmjq3p6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=m6RoQab6XfL3m83DwD4AA4wcnAm85sbG4DZvEhMAwLQ=;
        b=J+VoaiziYZMtDtL7SWb7Os0hInYaA1ZXRzkyFs7WmcMUhtWasCbMzVaEHr4bpLQfHR
         /j9E/X+nDxzelWNVV1rwc46qi6LM8e1UiOcirn4OvUUJ3fH+fC3phrIFmhi3r0g5zyQy
         biLsRt400rAhV9s6vvmiiryD+aSS6rte6An1A/7/gJL+b7a4VGpwZM1raEB1pN/dnW2j
         0zOtNQR7OSIAPDBwH+OtJ22Cin7iKuJXLPkVVfj0dRSnFoTMDT9F/2DGwFdNbWbezCbC
         0LfwGSQ0gxhFzbPdFh/t1Z9NB9/lnebT24jN3waR84/SdFz3wNcV6zccu812zNHKNdcu
         reBA==
X-Gm-Message-State: ACgBeo3iFGmsNpDnAfCCstFwB7qEACsteoyTe9fUOACsYiOVHHWSP+58
        Mjjf6HLw70ZHrb9cVVCrZ/HD+Q==
X-Google-Smtp-Source: AA6agR59F6yh+fOCa/OcF84WjhO5d1D6O8NLvFgbumG3rvr9gZF3GjA4pGjg7ROchBAWufu0Rz/Zxg==
X-Received: by 2002:a17:90a:fe7:b0:1f3:10f0:c251 with SMTP id 94-20020a17090a0fe700b001f310f0c251mr21108751pjz.165.1659375439209;
        Mon, 01 Aug 2022 10:37:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11-20020a17090aea0b00b001f10c959aa2sm9150105pjy.42.2022.08.01.10.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:37:11 -0700 (PDT)
Date:   Mon, 1 Aug 2022 10:37:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [GIT PULL] execve updates for v5.20-rc1
Message-ID: <202208011036.F80AB3F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these execve updates for v5.20-rc1.

Thanks!

-Kees

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v5.20-rc1

for you to fetch changes up to c6e8e36c6ae4b11bed5643317afb66b6c3cadba8:

  exec: Call kmap_local_page() in copy_string_kernel() (2022-07-27 14:15:09 -0700)

----------------------------------------------------------------
execve updates for v5.20-rc1

- Allow unsharing time namespace on vfork+exec (Andrei Vagin)

- Replace usage of deprecated kmap APIs (Fabio M. De Francesco)

- Fix spelling mistake (Zhang Jiaming)

----------------------------------------------------------------
Andrei Vagin (2):
      fs/exec: allow to unshare a time namespace on vfork+exec
      selftests/timens: add a test for vfork+exit

Fabio M. De Francesco (1):
      exec: Call kmap_local_page() in copy_string_kernel()

Zhang Jiaming (1):
      exec: Fix a spelling mistake

 fs/exec.c                                   | 15 +++--
 kernel/fork.c                               |  5 +-
 kernel/nsproxy.c                            |  3 +-
 tools/testing/selftests/timens/Makefile     |  2 +-
 tools/testing/selftests/timens/vfork_exec.c | 90 +++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/timens/vfork_exec.c

-- 
Kees Cook
