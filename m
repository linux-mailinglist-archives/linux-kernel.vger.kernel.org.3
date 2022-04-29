Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59B5515669
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiD2VMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiD2VMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:12:35 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD6F939CD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:09:16 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e656032735so9389330fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4D+xRvYNiIgs2Ah74ZpUa+WjA9w36MIgQE3pxVahvKM=;
        b=I0U590a/mwwuibMjsPb9PMeOt8KFsumofDvWPxBqbZws+PJlxpOLFQvnxjnnioM6Hr
         q0WhZT3yc8S/UU6n5x+fKhjj2icaTt2hd5wTjhb906AzCslGAL0PFgyMZvLkcamx+dOO
         FPApwKSwNBcyhqAcyylYLMnlH33TquJGzTue4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4D+xRvYNiIgs2Ah74ZpUa+WjA9w36MIgQE3pxVahvKM=;
        b=ncqjHMLnvXkWW9zkWZyA44BLWCXkKJc21HyTwgdaSCRIFMqqLM6E/tEjLv2JX4DMPT
         1NTrf0hb29YOYb/9c0OG15MLn/5mGkval1hFI/7n2ScPcUSa6u84TCymd6U5VeMSem0X
         +SKzx37zJoeggE+jmvDX8G8oSHy7CK/njTi12aEac36hnK6o1X+TZ75iR/s8wPKYTUP/
         VatYORpjQ9n7iETqAhfeN06FZPHfa4L2aw3RVOG6ldraEVVvV5Kc7F32a5OAahXawSMH
         kdnpPyM0OVYk/wbPD07I0m3WPY/ppGfycAK5CEUdtAHWNGmAb2XcxOdDomPiR+1uZTYR
         PMlg==
X-Gm-Message-State: AOAM530LBAdghHzm4O3tAyiZbwko07wMWBjUi6uYrsu29GJETIEPVHyP
        XqZHBzV5lJqIQq4AfAR4xSDMBg==
X-Google-Smtp-Source: ABdhPJzwq8ab8yHXHRI0tXl9bC9FG5a3mvVy/LGd1Lo1NzBOtidvVtPffOYY0qYi9CdZdK2ApBb/uA==
X-Received: by 2002:a05:6870:9596:b0:d6:d3ea:1d92 with SMTP id k22-20020a056870959600b000d6d3ea1d92mr584211oao.6.1651266555860;
        Fri, 29 Apr 2022 14:09:15 -0700 (PDT)
Received: from shuah-tx13.internal ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id m18-20020a4add12000000b0035eb4e5a6d3sm1186263oou.41.2022.04.29.14.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 14:09:15 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] misc: rtsx: set NULL intfdata when probe fails
Date:   Fri, 29 Apr 2022 15:09:13 -0600
Message-Id: <20220429210913.46804-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtsx_usb_probe() doesn't call usb_set_intfdata() to null out the
interface pointer when probe fails. This leaves a stale pointer.
Noticed the missing usb_set_intfdata() while debugging an unrelated
invalid DMA mapping problem.

Fix it with a call to usb_set_intfdata(..., NULL).

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/misc/cardreader/rtsx_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 59eda55d92a3..1ef9b61077c4 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -667,6 +667,7 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 	return 0;
 
 out_init_fail:
+	usb_set_intfdata(ucr->pusb_intf, NULL);
 	usb_free_coherent(ucr->pusb_dev, IOBUF_SIZE, ucr->iobuf,
 			ucr->iobuf_dma);
 	return ret;
-- 
2.32.0

