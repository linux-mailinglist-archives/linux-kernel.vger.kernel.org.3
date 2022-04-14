Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC9D501DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245091AbiDNWEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244475AbiDNWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:04:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C0A145C;
        Thu, 14 Apr 2022 15:01:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s18so12606653ejr.0;
        Thu, 14 Apr 2022 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTFOzudZRQlUE0vWM5TltHX/Y77Z3ongXE2fa99Aecc=;
        b=T54vkceWpdNsB45/gzn21jFRIviwXuX+6HnpZMNvoNuPBjI6J3JXDN5cfct2GrCwLo
         Xf2c4T6pUaCuIpd1NjXeeTL3ZrqD9Eb82mERyxwUb7aKMbyllwwjG92Wh2dCsordyMh4
         I7pKH5YlT1s4BJe4kjqW61XLCgHwY8ae75cigFhdTv+AZAYcPB9JO66bvt2B5C8CAy2j
         WGEnh88KXM0ZoMsaoJc3XSgIEa40ltzQfjMqhIEd4t29nTr5AeJ5z46dUtkKUKmQaUL0
         Ebirmw7vB2KhHP3IKQed9Yh2orLuYcU0bMuXMqwwnZUIi+AcwiGUeGTCn1keU05nuAgb
         ru6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTFOzudZRQlUE0vWM5TltHX/Y77Z3ongXE2fa99Aecc=;
        b=TdSD3SDLCwJkMR4q/ZK0a+085KJEwoZXnP183uZLwVoYp9MH8YzxfvYHsrthx9uTlh
         0DKRE7p2hJkD340rtKwOkWmyvD91ZITqw4CNEKluDlnbLCCCgjdB1QMZMC8RENg9DDGK
         9/Snl1j1M/PB2fFC+tY/txnwPNzoffrZS9fJV+WStp/xf9kPKqgkzDKlbusbyPyaQiSQ
         HvU7YekYROACOPL4ir5hNYsEn1b58z2n0D8+j/Q0xTzg4wa0Eoh1kUTKOd6wicG01Xkb
         AUodqGmgukZ9uFZs0X4wkww+x8o/SfjZOVrHRCkHenqLWxyr/NLqRF3Aen3++39wiBWC
         yEAQ==
X-Gm-Message-State: AOAM533d0fVP7KKh9iMMJm6FgJ17RWLx5b8Jy2OIGz7jpqbdVi6r/ZdE
        xnTesjBvgm48LYIWhC2Noew=
X-Google-Smtp-Source: ABdhPJzHVZ1n4G0jwoS3BpxKzBE6a8Ly7Vy/c1JhQDY/r4PRXSDDoyeiVD7oHItFmqyJD3ZE7BJ7Zw==
X-Received: by 2002:a17:906:7f02:b0:6cf:86d8:c31c with SMTP id d2-20020a1709067f0200b006cf86d8c31cmr4199162ejr.518.1649973696694;
        Thu, 14 Apr 2022 15:01:36 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id e15-20020a170906044f00b006e897e110fcsm1060948eja.48.2022.04.14.15.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:01:36 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, powen.kao@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] several UFSHPB changes
Date:   Fri, 15 Apr 2022 00:01:23 +0200
Message-Id: <20220414220127.587917-1-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Bean Huo <beanhuo@micron.com>

*** BLURB HERE ***

Bean Huo (4):
  scsi: ufshpb: Merge ufshpb_reset() and ufshpb_reset_host()
  scsi: ufshpb: Remove 0 assignment for enum value
  scsi: ufshpb: Cleanup the handler when device reset HPB information
  scsi: ufshpb: Add device reset HPB regions Infor handling for HPB
    device mode

 drivers/scsi/ufs/ufshcd.c |   4 +-
 drivers/scsi/ufs/ufshpb.c | 142 +++++++++++++++++++++++---------------
 drivers/scsi/ufs/ufshpb.h |  10 ++-
 3 files changed, 94 insertions(+), 62 deletions(-)

-- 
2.34.1

