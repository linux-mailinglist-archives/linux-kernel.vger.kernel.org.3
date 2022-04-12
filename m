Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CBD4FE859
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358836AbiDLTAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358803AbiDLTAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:00:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F540E48
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z99so14885353ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Uu00i8lAMXsKvesfMLYBDGeZkoj5cycOV9pwempbMQ=;
        b=flrRPRmssxmiyBRsMihagETbQ5IQp2gPA4gEFufe1qAdW9CfT3iMEf0izj2bPtvIwD
         7dV/Uwge7CJJJSVsvqCy4pc7NJKPOQ5zuwehRI1JE/o3+LyMPDvncur3lUt+o8Uhj3ur
         /+/btWwc0ZnhdneH5sN1Tj6D8JXcZ7+uibX6RFzPbGe/S++6ySJuwKPxoFfpvzD8cSRP
         xO3JEkKBX+Mdce0uWqff5/nhCizlz/mFMxAt2Bz+LiEAku4xSKAinHU27ubz7yNeX9od
         s6reYEyrzPaC84iy7f7azmULwA1Kplk/xFzd6xEOpzSYNWicQsxRR82xFSn5s2RZOoaR
         0SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Uu00i8lAMXsKvesfMLYBDGeZkoj5cycOV9pwempbMQ=;
        b=NOxl6iYNbGmV1W7jXFs3cF9zDUb6rdTRKfdx3eLlmt+EGs6huDY7Yi+S6+1459z1ra
         rfPiZblZl6TUden7E8TyF2bKyQOg2MJOY45XVJr98yg6Xlt8ytfgGXiPjt8Onn2rwgLL
         YboSR58uxOKuAWI14Mo8EUm+Euk5eJ+B09mvFX/ugHzg9uTMfoU/wFf3iNv/gGludXyq
         O3+s3Sds+1MkyquSTfn49WJ0RbrW5OlPJ5F3ovPaWUyRNGlEGAVxIypHZweaHEAuTqRS
         T+mEW8ldWt6c8sLWt6G4pgNCmx4JRyqnNdrB73DG5Em1lY5k/oYImEzSFhDHszVFHyRf
         o+2w==
X-Gm-Message-State: AOAM530dA2ruEBoLYXQDVL5bPmT/F2YQjIek3x9dJFi1HhXWrvEb2Ctp
        ddfPxKD149Mf5C/zzqGFoCo=
X-Google-Smtp-Source: ABdhPJwzOH8HQiS7B9jA/636/d+uBVP2t2Ne/rfK1YrAlDDueuZAcCxImPriEOQjXBAanafUf2wvdw==
X-Received: by 2002:a05:6402:26c7:b0:41b:7aef:bdf6 with SMTP id x7-20020a05640226c700b0041b7aefbdf6mr40683004edd.210.1649789881649;
        Tue, 12 Apr 2022 11:58:01 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm13443482ejm.103.2022.04.12.11.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 11:58:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/6] staging: r8188eu: clean up block_write() in rtw_fw.c
Date:   Tue, 12 Apr 2022 20:57:48 +0200
Message-Id: <20220412185754.8695-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This series cleans up the block_write() function in rtw_fw.c.

I wondered if removing the part that writes 8-byte blocks makes any
notable difference. On my system it took about two seconds longer to
init the device. So I left that as is.

Tested on x86_64 with Inter-Tech DMG-02.

Michael Straube (6):
  staging: r8188eu: correct macro spelling mistake
  staging: r8188eu: rename parameter of block_write()
  staging: r8188eu: change void parameters to u8
  staging: r8188eu: reduce variables in block_write()
  staging: r8188eu: remove unneeded initializations
  staging: r8188eu: clean up long lines in block_write()

 drivers/staging/r8188eu/core/rtw_fw.c | 73 ++++++++++++++-------------
 1 file changed, 37 insertions(+), 36 deletions(-)

-- 
2.35.1

