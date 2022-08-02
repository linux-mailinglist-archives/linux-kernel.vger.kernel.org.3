Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0007858805D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238382AbiHBQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbiHBQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:36:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D563474D8;
        Tue,  2 Aug 2022 09:35:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m13so14627416wrq.6;
        Tue, 02 Aug 2022 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=VvwQtDo4XUJDzMifcJqq50awcOPGpZoT2iv0SGOkoG0=;
        b=ZOYY8PNoSP7tsnnUzh4b6hp1O53entYC9lwroAKSc+XBb3ZrDyTohjAd2o4krKwcQd
         cWGMEhM6zXC5BInO+dXqhFGT5jtOgHVIFewbcfbZDyxluuE6R4kzTum5C5ccK6sf6zj5
         r8HcmBmr0IuViYwJqzU/iXapdMoCksvuD3yEi1kqx4/BJ9ffgy5WN55MC8z4+Yj8gBm3
         cI6BwWZOVYzB3SkEnylLMKgIEMoATLN1sA6ZnySDWZfOCf90LiIV7eBNaL4C7qWRByKk
         qCZzCZQg10kOTnGTqBvWn8PU4fRBpw/kLek7CVP4vGwDw8H8/hUAm4XBnE4uDLTyaFFj
         RblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=VvwQtDo4XUJDzMifcJqq50awcOPGpZoT2iv0SGOkoG0=;
        b=sBHVczze5hLoQzGXn4dAnuUjMk4RdRBionWjmvXZMMFs6/bvmBqLGuVpqQkjq4uE39
         hMC6td1CYQ7tDwiL+lyWdpNCX7T5yr/OetLpedHGTex++W/6Bzy9p49zgIxmahUbO7vK
         cvf4zShS7mbmrpZAR7LfPhKOMWpKM14gyR8qF8waKghWT0bnf/oyN6qYrLR22vNZJvV9
         v9cf2/KhWzwzkbZgXvyN8E7A/Q6aBTIuR6VB5NjXF3blBtugbqSUu5U09ZujE+RjOCrQ
         yPjR0tzs4o0RHmSPMdmDIKGAxo3B+fn7NlL3cWylee0fS2i5A0LOAl/zWYSwHR3CWb2r
         zJjg==
X-Gm-Message-State: ACgBeo1L5EVXlwFEevywVg39adqn0JcfYftPk9jOMtV0JW7hziqpMSox
        sPbk5YPFwRO8SxdlWqYY+hQyI94vNe4=
X-Google-Smtp-Source: AA6agR5Ik1mqNq6dg9U2/iNzesl5GWF3q0J2Z4CErzUGsbZLCnQuan35y78BqWpZztVKfBJzI4pTqA==
X-Received: by 2002:a5d:6852:0:b0:220:5c11:3cda with SMTP id o18-20020a5d6852000000b002205c113cdamr9370321wrw.592.1659458155799;
        Tue, 02 Aug 2022 09:35:55 -0700 (PDT)
Received: from debian ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id z5-20020a056000110500b002206b4df832sm4684944wrw.110.2022.08.02.09.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 09:35:55 -0700 (PDT)
Date:   Tue, 2 Aug 2022 17:35:47 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        clang-built-linux <llvm@lists.linux.dev>
Subject: mips maltaup_xpa_defconfig build failure with clang
Message-ID: <YulSY1pDms0ZyNs9@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Not sure if it has been reported, mips maltaup_xpa_defconfig fails to
build with clang with the error:

arch/mips/mm/tlbex.c:629:24: error: converting the result of '<<' to a boolean; did you mean '(1 << _PAGE_NO_EXEC_SHIFT) != 0'? [-Werror,-Wint-in-bool-context]
        if (cpu_has_rixi && !!_PAGE_NO_EXEC) {
                              ^
./arch/mips/include/asm/pgtable-bits.h:174:28: note: expanded from macro '_PAGE_NO_EXEC'
# define _PAGE_NO_EXEC          (1 << _PAGE_NO_EXEC_SHIFT)
                                   ^
arch/mips/mm/tlbex.c:2568:24: error: converting the result of '<<' to a boolean; did you mean '(1 << _PAGE_NO_EXEC_SHIFT) != 0'? [-Werror,-Wint-in-bool-context]
        if (!cpu_has_rixi || !_PAGE_NO_EXEC) {
                              ^
./arch/mips/include/asm/pgtable-bits.h:174:28: note: expanded from macro '_PAGE_NO_EXEC'
# define _PAGE_NO_EXEC          (1 << _PAGE_NO_EXEC_SHIFT)
                                   ^

--
Regards
Sudip
