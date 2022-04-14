Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04C9501AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344391AbiDNSUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDNSUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E18FE3393
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649960259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z5tgB23gsfb+KHanZyKg4LmdU6c+WAvLbSSi7WjMupg=;
        b=SafGiyKVBfT1llhyj/6BvlFc1OzwO2MtYxVhoV0GdVHagke9MxitKQpQi3dO3jpfmsE/PW
        2Vqk7/hkHfuQl7KK0LwuBhtHZm8/jmVMDz/27DP2bphPmwts2LWmxNep2+mFJTxiuvmLUi
        /kOocTkT5KQFMCOxBlB17p79Dwt5EqM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-PEjMwlKpPTu6FbNJgFVdPQ-1; Thu, 14 Apr 2022 14:17:38 -0400
X-MC-Unique: PEjMwlKpPTu6FbNJgFVdPQ-1
Received: by mail-qt1-f198.google.com with SMTP id br9-20020a05622a1e0900b002f1b4966c53so3747880qtb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5tgB23gsfb+KHanZyKg4LmdU6c+WAvLbSSi7WjMupg=;
        b=dfYLfPdq2iMsM4FTx+uOdIiha1hWbcetId5wAS47vX0oagcNOfvAtVw3xTgDKkrwlg
         b1xVn2lqik3AcmAuH3RLBReDM+R3Mz0JQi8ZuAdKajw5L2t9NK7o614skH3rDRdBL5K7
         LtpbK70ISF3tc92yWsHKEXL2ZdTQFDHs8EAPb2V3LlQgy5CGA0tCNXaT+JB/xpw/AfzB
         04GgPoTjzhrKShp6YlXITfpUXSpUoRQWeXYiG/469ZJpQHD1+W0aLY+o0Hw7+/wcJJ02
         +SNjbwThwwe+IZlR9Bxbf6z8u65L3LWM1eACRdrpCBdeasJyR+ypMkAe6AQSPPE86vw4
         lNSw==
X-Gm-Message-State: AOAM532KLWCyGX6PXICx9LFEufPrhN4ek+Bevg3+cHBHfi23FVIM82dV
        ZHvE66kVhPJvInVoAF/l/YuwlN5VMslyLEUKJh1aOdC6Ks04Qn4Sd5kXG/+ic2aioZjFs2sS+0Q
        VOAgAW0bLP36xWMt7W6CnSZGf
X-Received: by 2002:a05:620a:190f:b0:69c:34f3:cdc5 with SMTP id bj15-20020a05620a190f00b0069c34f3cdc5mr2816748qkb.579.1649960258039;
        Thu, 14 Apr 2022 11:17:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqlzxMzniXZYmYlsajFK1AyahG5bV7gnrcaBdvbFxg1rAeBX6GXs8+x5dyLKp6jcE5zMf4gQ==
X-Received: by 2002:a05:620a:190f:b0:69c:34f3:cdc5 with SMTP id bj15-20020a05620a190f00b0069c34f3cdc5mr2816734qkb.579.1649960257805;
        Thu, 14 Apr 2022 11:17:37 -0700 (PDT)
Received: from fedora.redhat.com (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85845000000b002edfd4b0503sm1701816qth.88.2022.04.14.11.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:17:37 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <mripard@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Thierry <athierry@redhat.com>
Subject: [PATCH v2 0/5] staging: bcm2835-audio: minor code style cleanups
Date:   Thu, 14 Apr 2022 14:16:17 -0400
Message-Id: <20220414181622.102049-1-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains minor code style cleanups to fix checkpatch warnings.

This handles TODO item "Fix the remaining checkpatch.pl errors and
warnings"

---

Changes since v1:
- removed mention of vc4 in Kconfig help text
- split patches so that each patch fixes only one checkpatch warning

Adrien Thierry (5):
  staging: bcm2835-audio: fully describe config symbol
  staging: bcm2835-audio: fix line ending with '('
  staging: bcm2835-audio: fix unnecessary space after cast
  staging: bcm2835-audio: fix mutex definition without comment
  staging: bcm2835-audio: fix mutex definition without comment

 drivers/staging/vc04_services/bcm2835-audio/Kconfig         | 6 ++++--
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c   | 5 ++---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c | 2 +-
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h       | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)


base-commit: 194193dd06848c1839d928090cb2032eec8b2f9c
-- 
2.35.1

