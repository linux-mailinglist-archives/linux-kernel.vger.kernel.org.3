Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD3D588EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbiHCOdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiHCOdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:33:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435F519C1D;
        Wed,  3 Aug 2022 07:33:35 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 13so825051pgc.8;
        Wed, 03 Aug 2022 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=JatyaQMvZqRXSjhM9SX5yq+wyykzu0VcX/V1mI7x90M=;
        b=Z+oHhlo/XD9ocZVdOJ0c+UZb3W11uDME3Qg2tHGTXVHWL4aDTC61JQtsNimBuRJLoN
         YpDwo6Vbf6pbrA88WEIMwXMDA38XnzjJIu8cxpMbjtpeD2g1D5LJmZqH5yuXqUNklZFL
         ROzrMa/+1l4gm/wiLEmStEoccMRQtslyNYVDC3Oj3Ayy+ngQGJrkO1XyXXe60AoDoCX3
         Az4nj0c267sLERFKjdjG5iJSPaG+WSuomTcs+68t2ZL3M/DwUARcn3dKK3xP12FQW0fq
         v7ZKWjrKiWkoF7Mq7dw/pLOC/dQs6L3tMN6FSV6h1uJZyv3IUlGGZKSw2CNIbpxOuOvl
         5ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=JatyaQMvZqRXSjhM9SX5yq+wyykzu0VcX/V1mI7x90M=;
        b=4vFVANzbrK5EbsoAMOVHj92ZZ//vy5fs8zMWaI8TCzb+zJH3WdCA7l96RUhcwUBpMG
         JKK3Lauxe8aqBF8PosR3G6GXOcbKlPdSUSr9I2nq+dY4c61xAoWTI6Qqu5svY9cRB5mi
         ClILHjazZmu8FUcmQkhaU5dxhgJTiJGg4lN0OogeqjRLX7iWVsWgcItC9flYZ8iCBRzH
         2i/clhXvQ+CVCDUXlMyhGowqN0eC9AvEHH9NrAykznVU0XK3U0zFLFGrwdpKWb8SR4Hz
         O5AZXFOzTJNFZA4JJBLToUFrt0guEjYwLu6Ft+E7M84lq8y8twcSw+nMQwPrUkon6e/d
         bf4A==
X-Gm-Message-State: AJIora98jv86F0NrrO/EVQsoz/x/6Zrx0rQa+RinzKm7+ANw792phIR7
        0aAVq0Qkb6QucbdSloJmP6mKTBEr490qho58Kqc=
X-Google-Smtp-Source: AGRyM1vP9Wcav9fDnhpdb+EB0Rimz1tLt2/rBavNmiFZ1ASdoV5B5U3LnQ/1bALs6pU/xjs+eY5A0yif49ONvSG69Ag=
X-Received: by 2002:a63:2a95:0:b0:41a:27e5:1996 with SMTP id
 q143-20020a632a95000000b0041a27e51996mr21207142pgq.447.1659537214627; Wed, 03
 Aug 2022 07:33:34 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Wed, 3 Aug 2022 16:33:23 +0200
Message-ID: <CAEwRq=qe+Frwpe=Zr4n_8A6vjOJnV3noegdnHSN7NTazkKejBA@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: core: Resolve supply name earlier to
 prevent double-init
To:     christian@kohlschutter.com
Cc:     broonie@kernel.org, heiko@sntech.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        m.reichl@fivetechno.de, robin.murphy@arm.com, wens@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it looks like you left a test for '&& rdev->constraints' in the if after you
moved the 'if (!rdev->constraints) {' above it.

-- 
Vincent Legoll
