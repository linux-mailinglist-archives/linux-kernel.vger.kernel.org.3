Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D127356290F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiGACdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbiGACdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:00 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0480599FE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:32:59 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id a7so595738ilj.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgSC/zXgeYwB16OHWIUUkEsMtqD5sdchassQ/vked7s=;
        b=f3vBUG4n4h1bDzqHUkFPeKLYEY9gdaJ1R2X3GTVyeaAiOLK4JKJxCwZ0zyEkAOodye
         z7vA8E/9NZ5aMTRwKWJnyP8U0F5LuWOmISazYfAaFNjbbE+hnq6Obmziu4F//ViPtJnG
         naxgV2FGqw4fsagiomQbG0nzSAcZP5kCjpkq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgSC/zXgeYwB16OHWIUUkEsMtqD5sdchassQ/vked7s=;
        b=yf619zchweNtu3ShG01QdVbqokYB5mMhwqcdWG29yxlvElQQBG0xviWmlYD03tTM1K
         kp+VAeQXK2X3xwhjRubfxb4vWuLUxT32HX/HPgg8efgVNgFiEzXtvqNdKUeW6jrm7dgl
         bVbTFFpTcRtikYZDEVuq71zE1KD/QJ67eylagyBM0bju2BnBJsbgPEIX6Hye45D9Ic41
         pgyM84M6G2ESjpsASEJ9Hys1yRXpX0+ZvUI5wcq/6DpMECqt9Y79gpQMuajPjh9J72ZS
         zsRgpLit847G9QAZQzyc6p7ynIimmSVUrJ32cC7kEcrUIuoa1SRSODfbqgnmnQpPGRbt
         nLCg==
X-Gm-Message-State: AJIora8vVgLohuPr0rA1sVvBygpy1gmVi+xtlp7mU4RoVlz7o+zpEboC
        Va5zc9scKdJjQAmIScTdbzqcppdRBv1uAQ==
X-Google-Smtp-Source: AGRyM1tyqb8800KoEbMplvdgfSGVEhILh6A+6oXJ5Q0hK6K4VQ/I6MK7f6I/LIaM8vle6OTUk9f7+Q==
X-Received: by 2002:a92:b10e:0:b0:2d8:d8a7:8b29 with SMTP id t14-20020a92b10e000000b002d8d8a78b29mr7132883ilh.233.1656642779374;
        Thu, 30 Jun 2022 19:32:59 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a22-20020a027356000000b00331cfbce17csm9367869jae.100.2022.06.30.19.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 19:32:58 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] rtsx_usb fixes
Date:   Thu, 30 Jun 2022 20:32:54 -0600
Message-Id: <cover.1656642167.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This two patch series consists of:

-- fix to "rejecting DMA map of vmalloc memory" dma mapping error
   due to passing dma mapped buffer to usb_bulk_msg(). This results
   in an attempt to map it again and fail.
-- a second fix to use separate command and response buffers to avoid
   potential conflicts.

Shuah Khan (2):
  misc: rtsx_usb: fix use of dma mapped buffer for usb bulk transfer
  misc: rtsx_usb: use separate command and response buffers

 drivers/misc/cardreader/rtsx_usb.c | 25 +++++++++++++++++--------
 include/linux/rtsx_usb.h           |  2 --
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.34.1

