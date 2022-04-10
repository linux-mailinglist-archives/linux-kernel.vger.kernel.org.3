Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C96F4FB04E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 23:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiDJVK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 17:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiDJVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 17:10:56 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B0CDC1;
        Sun, 10 Apr 2022 14:08:44 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id ke15so11810778qvb.11;
        Sun, 10 Apr 2022 14:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uuGcB3VRccVwSj8pHR359GBojRIxqgRtMfnRzy/LJCo=;
        b=lhuzd65iJi8ylH1ApT2DjunGJwOxBJGHIT0dhXl4HQvEvP6QtR+RPoZ2Fq2cuUZtWW
         AuFqCEtgyUqwIwAMUIDlVkOczZZo0WTCYQgxbh6rQZlTiT9Ki9EyUV1IqA9zSvi0UpCz
         PIKdmfiynTf1Zlox7+qn65PasHl2aWPyOgpJ57J7B7yEr/ckZZ4YP7c1o065pozi3Zqp
         ksrUxOXW+ruLvpllUFnograt+xAQhzxuMpvCYRr/WN6Jkf4NL0p89PFNg0PA0+PBBnAM
         hVZR+bn50nAq0gZTd95aHKhyd4E1oUhEIvWf1CuKfdSa2g3RvgE3FrEWwx1y/mr96rzx
         dKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uuGcB3VRccVwSj8pHR359GBojRIxqgRtMfnRzy/LJCo=;
        b=Igd897ma9JaKcGOTqrdCAu7MbNFn9tEC3arQW7Onx69TjhGt079wfvejFTpWlEHGiX
         DbyEvuFJYqxk6riOdiZx2W+M8mopN+Z38plBMXAZt1n//ihTMNbj0Acb8sEfiq1K12t9
         B0UF4NGx5QMe5C+NZgoCe3n/eeXUcXjDC2Mwn7N+NCTfaEHkDxhMMF7potm2jQxrKVqX
         m6hybZcy+ULbZl3DjZL9kcdzj5tvThxNku7rpfPsp5s4QG/GvN0kfcy2PkQN4KlLqzp2
         CgvZOpkl9IGykFaX714p9H/nMUNnw78SV+5I41xDkN7CzdtYs/Vx7B5G42OGrii7Leuo
         H5UQ==
X-Gm-Message-State: AOAM5308oJHfzJm2OiMiXEYzZwVU1cAHWo3EAm7Rhm6bzcaM0rXY7x2S
        JNcdUwdvH7hoDCTxtQ6k/50=
X-Google-Smtp-Source: ABdhPJxBa3YgOKkohaXEOlN65yPywx80K8sigvmIuhus6PZgDt8fG+CkiZFlTMoNlTnL+rfqr4Xw/w==
X-Received: by 2002:a05:6214:300d:b0:444:4ada:a471 with SMTP id ke13-20020a056214300d00b004444adaa471mr82752qvb.93.1649624924050;
        Sun, 10 Apr 2022 14:08:44 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:b84e:f99c:2a1b:100b])
        by smtp.gmail.com with ESMTPSA id i68-20020a375447000000b006809e0adfffsm18438090qkb.25.2022.04.10.14.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 14:08:43 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH v2 0/2] of: overlay: rework overlay apply and remove kfree()s
Date:   Sun, 10 Apr 2022 16:08:31 -0500
Message-Id: <20220410210833.441504-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Fix various kfree() issues related to of_overlay_apply().

The fixes revealed inconsist variable names for the same variable
across functions, resulting in difficulty understanding the code
that was being modified.  Doing both variable renaming and the
fixes results in a hard to review patch, so split into two patches.

The first patch in the series contains only variable renaming.
The second patch contains the kfree() related fixes.

Frank Rowand (2):
  of: overlay: rename variables to be consistent
  of: overlay: rework overlay apply and remove kfree()s

 Documentation/devicetree/overlay-notes.rst |  23 ++-
 drivers/of/overlay.c                       | 175 +++++++++++----------
 2 files changed, 115 insertions(+), 83 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

