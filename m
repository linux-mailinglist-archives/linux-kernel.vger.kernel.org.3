Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B44C9355
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiCASfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbiCASfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:35:50 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4C35881A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:35:09 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id s11so4710913pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 10:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Yy0S/B12hrVPjredzRX6p9VMgeZxxbvZgB4AarEd5qU=;
        b=WnY8jN5y6YAWbFGObh76FWUsKPn4rw1SFnANHAjfTW69nEb45tmennx1tH54hKoWsB
         faL+Agd+WVa/iPRnRnb/5+nJJRxgi+GoA0no6W++0HF2z/qMCa2WO254Ybfs1wmgGnVn
         73iqz1HudaUJADjdls1sx+JB0DWLHlu5rS/po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Yy0S/B12hrVPjredzRX6p9VMgeZxxbvZgB4AarEd5qU=;
        b=vj9HxsXK8NFgQ1iXwnVUuQnQhMXTB7ZPKZ7WQVaE35jQnYQgowtazp1oXYZAMYn8ZT
         5RoNHrIwZknX0qNMSL/hgdurhQ5xCNuIRl8tZC7zfRVJekWmm2fWZoB6OsUapD1DfUo3
         jvCzIjDF9Q7CoWHx5DOSxzy49ViimRIERDpG1i0apaSr+UrFLfky/r0n7uR+5/QN76D9
         seMS8GEF0Zx19a+QjkJW9whiEqwRo7FbeU0eT7q5pBTV0/LCmEWGnoffN3jtzg8Vc3dJ
         aSjlX7enAogP2sF9dttfhwD9hwhOL8Tw2YJrIVmII4iv9lSqSMfyuLJXgsEZZ4nG+fHJ
         6R1A==
X-Gm-Message-State: AOAM530fW1b2zhW7sJ5/1yDEo0JHSFMjRv8umFbR+u1yaP7tPzITxsLp
        A2FJ4+g0/WGTtVIUxEBRe5CxI95kmplUjw==
X-Google-Smtp-Source: ABdhPJzl0MJD80w950DodgcHrr5EeyxdMeFiLD/sjfEB7EeY1VSOJNI3izQXcWHok5SsIUKekCNK3g==
X-Received: by 2002:a63:2f87:0:b0:374:4ebe:2048 with SMTP id v129-20020a632f87000000b003744ebe2048mr22660117pgv.157.1646159708786;
        Tue, 01 Mar 2022 10:35:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm2709947pjv.57.2022.03.01.10.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:35:08 -0800 (PST)
Date:   Tue, 1 Mar 2022 10:35:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        matoro <matoro_bugzilla_kernel@matoro.tk>,
        matoro <matoro_mailinglist_kernel@matoro.tk>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [GIT PULL] binfmt_elf fix for v5.17-rc7
Message-ID: <202203011032.7D3F2719@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this binfmt_elf fix for v5.17-rc7. This addresses a
regression[1] under ia64 where some ET_EXEC binaries were not loading.

Thanks!

-Kees

[1] https://linux-regtracking.leemhuis.info/regzbot/regression/a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info/

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/binfmt_elf-v5.17-rc7

for you to fetch changes up to 439a8468242b313486e69b8cc3b45ddcfa898fbf:

  binfmt_elf: Avoid total_mapping_size for ET_EXEC (2022-03-01 10:29:20 -0800)

----------------------------------------------------------------
binfmt_elf fix for v5.17-rc7

- Fix ia64 ET_EXEC loading

----------------------------------------------------------------
Kees Cook (1):
      binfmt_elf: Avoid total_mapping_size for ET_EXEC

 fs/binfmt_elf.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
Kees Cook
