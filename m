Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD732569C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiGGIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiGGIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:08:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D1233E27
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:08:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j3so5212639pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7AgIPqLatZhsIY/aKdspec70zCa/ClqK3dmXj4f62X4=;
        b=cSC6w3SPfVcJl9Mn7LEYDhIoOCCmZ1dIs9O6cwmm0gOvS2Z3JZkmV8VhSt09Xcwgqc
         WZPegT46+l8pbrcGz19c27Qw6clAXXkdcjI6d6Jz7XSOJqglRATC9/04s5TZvDYjlVqs
         8NXhKeIcTtMx2ZjgFCxwUM6nAnQTqgm1mAZ/HBaIe8y0CqVlRz5ejaphlPg/dblLkGSF
         xgbYrWVbLRkMpgHILhUbY0lCOEHAY5Ko0lqT0rc1H5HjRKXJwwBIYUBUKROBEj9q3HU/
         ZvicMJTxQj23shJ752g3CnrNnml/n8Gj7a/xpCkAov9o+Cut4s/KafnazwpvmZw/PJxn
         bHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7AgIPqLatZhsIY/aKdspec70zCa/ClqK3dmXj4f62X4=;
        b=EO7DvTEWVk2cdXhgS5Ns0SfnZdXlq+GqVIOMmob5iTfeBOE+kBib4T/n4c1Tpi7Cso
         wgZHkM03/7/NTokjkJlyHbnkQokXVDD4iSkuTSUBWxZm8D8t8OBB3Gkdwpobl6y4xY9s
         GdRkFrRNyGMlujuFAQ7Pz0VVM5XgSi/9OkFznDcAVNnYl1+U6os/gTlXXRAenTHL42eu
         Gq4AabAjIKaFy0D9eRMCztT7GlDHCqGhDT0YrCLwpxZt6ZyXByTGMBesos8iPEahhFQd
         3zCn3nO4T7Eb9L3bMik9D0XBaypBE01msQpTQOqfjKuNgi3qPk4Yg2+BdNyZVhEBliDz
         zhUQ==
X-Gm-Message-State: AJIora+kEB4z5skEiEQGGIF/Z91vqU5gWcfxSht8nvoznB0mOI2wiI4X
        2210XBjNRLyqbYzb7za6c/k1C3R9vmOMQg==
X-Google-Smtp-Source: AGRyM1uTxgSenCTFbWtBCy6acqG5UvoezsC4SEcs+QQvuthGZxoDT6eoD+3djpsTjeFgBHbPA75FKw==
X-Received: by 2002:a17:902:e5d1:b0:16b:ece4:79e6 with SMTP id u17-20020a170902e5d100b0016bece479e6mr17118256plf.83.1657181281582;
        Thu, 07 Jul 2022 01:08:01 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:a3e3:ea8c:2267:a237])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0016c0c82e85csm1377374plf.75.2022.07.07.01.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:08:01 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/3] xtensa: iss/network initialization error path fixes
Date:   Thu,  7 Jul 2022 01:07:58 -0700
Message-Id: <20220707080801.3496148-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series cleans up xtensa ISS network driver and fixes memory leaks
in initialization error paths.
The series was prompted by the patch [1] from Yang Yingliang, but that
patch alone has issues:
- a newly created net_device was added to a list of devices and not
  removed from it in case of error leading to UAF. The way the device
  list was used in the driver doesn't make much sense, so patch 1
  removes it altogether.
- a call to platform_device_unregister would complain that iss-netdev
  does not have a release() function and must be fixed. Patch 2 adds the
  release function for the iss-netdev platform device.
- a proper release() function for the platform device must free the
  net_device object, so the error path that calls
  platform_device_unregister must not call free_netdev afterwards to
  avoid double free. I've modified the patch 3 so that it does that and
  updated the description.

[1] https://lore.kernel.org/lkml/20220707023229.2580893-1-yangyingliang@huawei.com/

Max Filippov (2):
  xtensa: iss/network: drop 'devices' list
  xtensa: iss/network: provide release() callback

Yang Yingliang (1):
  xtensa: iss: fix handling error cases in iss_net_configure()

 arch/xtensa/platforms/iss/network.c | 63 +++++++++++++----------------
 1 file changed, 28 insertions(+), 35 deletions(-)

-- 
2.30.2

