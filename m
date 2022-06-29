Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D361A56015A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiF2Nd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiF2Nd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:33:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C085021E03;
        Wed, 29 Jun 2022 06:33:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c13so22204094eds.10;
        Wed, 29 Jun 2022 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=HX8H/5X1AYfUWCH90rbwrqx1PKjGOWb2yIxjpKzybeA=;
        b=qeZgDBijplrDWYpAEKdR/SiM5rpBNhifg1GErkSgVqrKkyT4qmExnNbUnOddmwpDBH
         bPmITpGwsaiYPQM66R7IMvzJGmo1bD04yb1fjQOCgljxeaXD8KZn3Hs3TAJLzHJfUbED
         zRs057U9pRO4D8HPc01++Gt1wazc06ufcye8IkfQh3+ltG4I3tTBwe/lhcpOG2n/bjXd
         k2lWTFjGR/FayGftJ6Hg424As11UUWsXpE4UUBOGGd95KAawGHELO80wHaWstKEcvgKQ
         qP4m1ylkVzhmXUvUZCzcgxE2Y7z4juIVwV9k3E6IIh47TJya1bwSpNMAyUbpwfB9Uc+4
         TEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=HX8H/5X1AYfUWCH90rbwrqx1PKjGOWb2yIxjpKzybeA=;
        b=kKUfyv1ZpRiy1d2cIc4SG4tifxaMdv88dvw6E2lbdeC4mDKE6ZmF6XRP9e8RXLirg9
         Xgqo16JeUhenxGgtzh0ukmQsBvkpFxoxudkysbGlpVi1A6XcUgM4gCETgcQHrghgbPJf
         BcoxGXCLd4dscCpKJKQ9MdUOo3Q5aPROZeMidYeseY0nVDFiK4WkFp6zbs4SCMJZ8Apa
         G4DLjdTP/ffEq6GhYQKIVKX6zIxAx5/V9IKuOezuVhVW8mB8B7BDLSdHg5w6Y0SDXhl2
         nqi20JwOnWZdPFQpG0xlBFV/jbx4zDFK6E2m4mYQ6TH3Fe8xqKUW7HUjDa5R13VwM5dr
         YMiA==
X-Gm-Message-State: AJIora8PbmCX7caY1z6R7EKxbIrvLX0t2gHmR1EXqjDSJHt7ZM9H8zH/
        B5r2eMwna6gMaVtED3OYn04=
X-Google-Smtp-Source: AGRyM1skQZ2qnYsz4+K70WDhSHK67i2xGhaBOEwaG3LUhRyMnIL/2XD0Cn8CjOGt4wQUhlCwMRYRAg==
X-Received: by 2002:a05:6402:2c4:b0:435:8ce0:aef8 with SMTP id b4-20020a05640202c400b004358ce0aef8mr4335159edx.140.1656509604394;
        Wed, 29 Jun 2022 06:33:24 -0700 (PDT)
Received: from localhost (92.40.169.111.threembb.co.uk. [92.40.169.111])
        by smtp.gmail.com with ESMTPSA id i23-20020aa7c9d7000000b0042de3d661d2sm11285593edt.1.2022.06.29.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 06:33:23 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     cw00.choi@samsung.com
Cc:     myungjoo.ham@samsung.com, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: extcon-next: patch "extcon: max77843: Replace irqchip mask_invert
 with unmask_base" should be reverted
Date:   Wed, 29 Jun 2022 14:09:26 +0100
Message-ID: <3AvtDmBqK77YBE1XGCycEcGxreGWRJSQ@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chanwoo,

I just noticed that one of my patches wound up in extcon-next as
commit a7d674db4612 ("extcon: max77843: Replace irqchip mask_invert
with unmask_base").

That patch has been applied too early and should be reverted/dropped,
as it depends on changes made in my regmap-irq refactoring series[1].
My commit message was overly broad and didn't communicate that fact,
however. Unmask registers are in fact broken right now so the patch
doesn't work as advertised and will break the driver.

For avoidance of doubt my other two extcon patches you took,

    extcon: sm5502: Drop useless mask_invert flag on irqchip
    extcon: rt8973a: Drop useless mask_invert flag on irqchip

are safe to take early and do not need to be reverted.

[1]: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/

Best regards,
Aidan
