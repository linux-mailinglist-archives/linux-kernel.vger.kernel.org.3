Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A31F59A5D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349993AbiHSTEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349154AbiHSTEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:04:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823E5BBA6E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:04:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y4so4892776plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=dWdBqT9/Ac0yEwjzBOvK2CKqhBkFCVfvYxG4xnsbB3g=;
        b=VOHRJ3E+goJpxVxESzRea4lH1uDlpLcZk4nIk0Koj4pWc7PRImm/kyzgvF8RiDiACD
         EKfw/7MSi6373/9Vi2MhJ3t0Ze5HVacqymzZksp5qLlYTBM6ilO9uhuSV+Ga730MHE8+
         c62mzRET2ncqnukmIu6ZeBxyjwnKw8VQhvLwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=dWdBqT9/Ac0yEwjzBOvK2CKqhBkFCVfvYxG4xnsbB3g=;
        b=m4MZpwn9pwFPYzwl5jf+Lotvw2r062Ltz+/0hb+ir8dbH3pBn18u8cBW/+PqbAjNky
         nlAI2GN7FV24oK3vCUlVjF1QqTVx8Z44gdQzOPbuxAnEOQ+J5ksNkgGFckdSli2UifdS
         aEoQ2R4+Suv59yrxXkpLt8HFzX5LxtzeCSdIXkxPu10vaTw2umGhcUM7SKRnq8B75avZ
         BKlQX+CvhYWCD5EQBukwp5JFaM8EsNZUMTVHHE8kbgCdLoG2GRhyEp8+AdlEAXwIJJ4o
         tp3U3JA8uV95mtTJe610VzTWOcGzj6lwQcmkHslGSNgCYZFKlR7lsy8yr8HM+GrGqLsl
         ERmg==
X-Gm-Message-State: ACgBeo11WzvXNcMmy0WOQ/nt6w2TKnyzneWQOLvZJG3CGbj4rFYdbvbh
        ADeTbhhJZxgAKH32Zl8+wriaXw==
X-Google-Smtp-Source: AA6agR40YiBYTDilvWJiqKNOZx0ZfALTLJUvWI6iF+g7TXtP03nJgQURfX1HCscJvUNPYBfPJblM4Q==
X-Received: by 2002:a17:902:e80a:b0:172:c1c9:d307 with SMTP id u10-20020a170902e80a00b00172c1c9d307mr3972211plg.54.1660935848934;
        Fri, 19 Aug 2022 12:04:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id jj9-20020a170903048900b0016d785ef6d2sm3463628plb.223.2022.08.19.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:04:08 -0700 (PDT)
Date:   Fri, 19 Aug 2022 12:04:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] execve fix for v6.0-rc2
Message-ID: <202208191202.5F5A43A0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this execve fix for v6.0-rc2.

Thanks!

-Kees

The following changes since commit c6e8e36c6ae4b11bed5643317afb66b6c3cadba8:

  exec: Call kmap_local_page() in copy_string_kernel() (2022-07-27 14:15:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.0-rc2

for you to fetch changes up to 3a608cfee97e99b3fff9ffe62246a098042e725d:

  exec: Replace kmap{,_atomic}() with kmap_local_page() (2022-08-16 12:11:27 -0700)

----------------------------------------------------------------
execve fix for v6.0-rc2

- Replace remaining kmap() uses with kmap_local_page() (Fabio M. De Francesco)

----------------------------------------------------------------
Fabio M. De Francesco (1):
      exec: Replace kmap{,_atomic}() with kmap_local_page()

 fs/exec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
Kees Cook
