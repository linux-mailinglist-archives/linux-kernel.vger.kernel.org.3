Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B263B54819E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbiFMIQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiFMIQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:16:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D208413D20;
        Mon, 13 Jun 2022 01:16:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq6so9598301ejb.11;
        Mon, 13 Jun 2022 01:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=wmBed819HgIGXTLMLXK4HJhTopAYR348ZqFWhkXovh0=;
        b=XWlvyQE8kCDnFeRA5sF/Qd/bI38hLweT20ofouY9OuGwRqsb9A+hJnUGTeFSSakdiW
         zX00iVuTNPssD5xK2790x9q1g+yf6FxinLoOlVoNxvcznRY7+a6vxOSeW/QxSXZqe20B
         XKarxqyDAmvA3f9QWJ4tUyZBBL/eIb5YW3avh2aGRXRkkIPan6nYxYVGQEbYaz8SEPAB
         oiftQz/+ZhOatAc8k1zgaTlNtyCge59LFZNKZVf+s3YwrwLZXhvY2iqmmEzvsYjV5IlK
         vsvW2gH9LBGo5/gKyzMtNL/QsQWKtstyLAJVDk3NnhOvdeOaOr8yGwg90WsKxrY3A2v6
         T5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wmBed819HgIGXTLMLXK4HJhTopAYR348ZqFWhkXovh0=;
        b=aaupT0uylcr79J2L75xb4NIFoCsT/oXig178M0O1riQmkIxePydbNeZu+5bMCBUWnM
         uG1oRGutG9Y60ux7JUsw7FP0NfUusM7ZfxooPlioc8BgYhi2PL957vgUIzfuTjeJ1VsO
         ipN0zGH71ysTW67DyBhziBdgUeevY/0Pix5dzxofamW9JcMdOKxTtMgZeboJG1FkvGRc
         ef2mjz4hSpXpFvbkts5EGVeNqBjpKfr/sxTEzBQIE/z8Ed0sf0wLehZYGjGJqgsSVCfB
         QAvfFksJQ2ysFbQlRUTA8j2jdtlWYhH49C5KLA0PyU6LZXsOczxJWMEhxmsSZufX5TRd
         6hiQ==
X-Gm-Message-State: AOAM531LOlQNuB4T3e0/x0lnMoP0i7t9ITMjIHj/KAASvRfA5fSpiXhX
        0h0Gwi9fX9OpYdZ8/prUsnw=
X-Google-Smtp-Source: ABdhPJxZIxHe5OXhSoITvctnX0VJvdCTh6dCnBmD8ep6zIHzGalk7ON9C8lGXqZFD9nzc3P+oHZKUg==
X-Received: by 2002:a17:907:62a1:b0:6da:7952:d4d2 with SMTP id nd33-20020a17090762a100b006da7952d4d2mr51454997ejc.260.1655108204083;
        Mon, 13 Jun 2022 01:16:44 -0700 (PDT)
Received: from felia.fritz.box (200116b8260df50089ef6db2443adc92.dip.versatel-1u1.de. [2001:16b8:260d:f500:89ef:6db2:443a:dc92])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7d38f000000b0042dd1584e74sm4397781edq.90.2022.06.13.01.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 01:16:43 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joe Perches <joe@perches.com>,
        linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/2] Move headers from dt-bindings/clk to clock
Date:   Mon, 13 Jun 2022 10:16:30 +0200
Message-Id: <20220613081632.2159-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael, Stephen,

I was investigating the state of ownership of the files in
include/dt-bindings/ according to the MAINTAINERS file and noticed that
there are two directories, clk and clock, that contain the include files
for clock drivers mentioned in dt-bindings.

It seems that by mistake, files were added to include/dt-bindings/clk/
instead of include/dt-bindings/clock/ where the majority of files are
located.

In the past, others already took care of moving some files from
clk to clock in the commit 8e28918a85a0 ("dt-bindings: clock: Move
ti-dra7-atl.h to dt-bindings/clock") and commit 35d35aae8177
("dt-bindings: clock: Move at91.h to dt-bindigs/clock").

This patch series repeats this activity of moving files from clk to clock
for the latest state of the kernel repository.

Michael, Stephen, please pick this minor clean-up patches into your common
clock tree.

The references that needed to be adapted was identified with git grep;
I have not compile-tested these patches and I am relying that the
specific compile-test builds for these drivers will detect any potential
issues with this refactoring.


Joe, I was also considering to create a rule in checkpatch.pl to check if a
patch creates some file in and warn about it. What do you think? You think
this is worth a rule in checkpatch? If so, I will create a first RFC patch
for such a rule.


Best regards,

Lukas


Lukas Bulwahn (2):
  dt-bindings: clock: Move lochnagar.h to dt-bindings/clock
  dt-bindings: clock: Move versaclock.h to dt-bindings/clock

 Documentation/devicetree/bindings/clock/idt,versaclock5.yaml | 4 ++--
 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml  | 2 +-
 MAINTAINERS                                                  | 2 +-
 arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi    | 2 +-
 arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi          | 2 +-
 drivers/clk/clk-lochnagar.c                                  | 2 +-
 drivers/clk/clk-versaclock5.c                                | 2 +-
 include/dt-bindings/{clk => clock}/lochnagar.h               | 0
 include/dt-bindings/{clk => clock}/versaclock.h              | 0
 9 files changed, 8 insertions(+), 8 deletions(-)
 rename include/dt-bindings/{clk => clock}/lochnagar.h (100%)
 rename include/dt-bindings/{clk => clock}/versaclock.h (100%)

-- 
2.17.1

