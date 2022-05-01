Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7C51654E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349426AbiEAQka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347056AbiEAQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:40:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C157186F2
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 09:37:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a1so14290114edt.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=cHz2Chb4WauAyCgl7HzeNesuAPLoMUd1ln+Xeg1BqlU=;
        b=eIICAgahx1Pi255U+g/Kk9Q7E5jEghl2OH+0vD0b58A9Qf9WLKIXcSVkxW3MxGQE/V
         iifLdPlHOgbvsQ4jkFjZG5oI4vZWjpKsXXs9oowHCCCELnPzNZsQpgZSKxxcDH4rE2x9
         b8CGqLFBfHniTLTO3c5XT+ocNkkO4dahCO6AbwQwjSMch3TAWaH5jWKGm2zWZA9jyNTE
         feFklMibUOADm9SjVMl5vEs+XRB6Q4pYlLIXPCsHqPz1pUTLOpdwAJuJFNwHE6fXaSef
         u9nUoiNecC55Zkv+5dy31XOhkzXoSLHQF4BLSWqwWb+uVve6qQbMWxV7GaScdQbMfiIl
         9mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=cHz2Chb4WauAyCgl7HzeNesuAPLoMUd1ln+Xeg1BqlU=;
        b=40I0EGecwwYHVOY4yQLrz9/9XGPvnJg3SVnON9rrPZN4TvqK1bb0sUxGG0poCDLoek
         6IRKZMXe2hYwRd4z0uKl50utVeTMqk3kZkW06L+FWdDxfYohtgcU7w73jbxmc5843fWr
         qC8nwgMbh5sIIyySDJXYnkx3sLhD9GjF2QfeKM5UmHovzWTggS0Od3sOc3KN9VmpsiDO
         fthFEnevHcfoFoX1VS7BLfi7QxI7f9EbhOa8i4ASmHvSms5n/12L5njuyd0W7t9iPG1x
         zyl3d57aLfcDVJz2NK6rlkSu0lsHk3MdjsHQR+7lND58bIotUocp9VHTp8Muyv09hiEE
         ngcQ==
X-Gm-Message-State: AOAM531nRh/+yMxTwhaIY+lUHA360vX72RAxgSveT7iCuFlG6dSxuWra
        YhmPzJEuETb75AXwIQ6JnSU=
X-Google-Smtp-Source: ABdhPJz4KRMo8eAqZm23yzk/ee5LqUPVku/+0DMinYuo7KtVI/w2jd5IdlzNDGxF29rOKpZtADHcNw==
X-Received: by 2002:aa7:d708:0:b0:427:b5ee:b8f2 with SMTP id t8-20020aa7d708000000b00427b5eeb8f2mr4594397edq.404.1651423021044;
        Sun, 01 May 2022 09:37:01 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id u5-20020a056402064500b0042617ba63a0sm5551023edx.42.2022.05.01.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 09:37:00 -0700 (PDT)
Date:   Sun, 1 May 2022 18:36:48 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: vt6655: Fix name and return value of
 CARDbGetCurrentTSF
Message-ID: <cover.1651422181.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of the function that uses CamelCase which
is not accepted by checkpatch.pl

Replace unused return value.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

Philipp Hortmann (2):
  staging: vt6655: Rename function CARDbGetCurrentTSF
  staging: vt6655: Replace unused return value of card_get_current_tsf

 drivers/staging/vt6655/card.c        | 22 ++++++++++------------
 drivers/staging/vt6655/card.h        |  2 +-
 drivers/staging/vt6655/device_main.c |  2 +-
 3 files changed, 12 insertions(+), 14 deletions(-)

-- 
2.25.1

