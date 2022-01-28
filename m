Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549004A03CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351746AbiA1Wg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiA1WgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:36:25 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71567C061714;
        Fri, 28 Jan 2022 14:36:25 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id u5so6657924ilq.9;
        Fri, 28 Jan 2022 14:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4sEL0jJEyg0DdGFHEn4Yo4advc5Ek9TkjI/milGbFk=;
        b=ZfZh/Fbxka+oD5Y7z4hM0n8uwV769AuRlb/pwrg4Vc3n0fUCY8khJcMwI6OLD7sKyU
         iPrbsf8eufrL1ukNaXMokPXTenncYKcfEp7SZDPWcyW2GBB0L6YUGMGJuK7fR/k9Dlqo
         WVXmTXXGs9iVTGhxSfSeayq4R73JYobAFvC/bj84lI+I0H2wPnSkc8NUuwW6hnhGSDRF
         YkjFNbIxCigg3nz79Uqhbc7aDj+VMfc2KIDz5aXLjt5+yqOFJl7OS4CGuXoZBlyydwEL
         JQ3HigoWIRaCmdBCpMmnXIlgth0YjbXFSeDdl05FNHAOO3CLTF+Ah9LcaBxX2gIi3sfC
         6pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4sEL0jJEyg0DdGFHEn4Yo4advc5Ek9TkjI/milGbFk=;
        b=v1ICPPvsuz67dD8zLi4cpc+1JVWdrJBTFOtlSW0wU/WWKdNUmud6LqlJMm1wrLjRSA
         49gwttTUkdnFHLk8K3F4tnoKdoKEIa6ibLH9fhJQzrBK8MOFUmbBh6YzogdiMygKA7W7
         imKA9faKMSLynwWuoAmTTpfh/4DTIz2EzZG78ndv1RcEwiufbA5Wr/x45Rm+CqGKslcK
         6JAjI7oCyAc5E6hvF4MnIxCrlavMIKJze7wnhsZTNcx4GIZ0+g0Z31cLq2ouLUPRcR+I
         +4T3n/HMff8ppCk6/4mdpxjscYbUSklCXXAlU74ZLiwfBqhp3eyUuFqrIONQAwSBRJZZ
         KP8g==
X-Gm-Message-State: AOAM533EwWrDzdOnT3cRObhkAqXPgaboEoTfpl95fKSGy9eoGNWoRGux
        XZ6nx/koDdau9TN3qKHgj9Rpgfe0Y4I=
X-Google-Smtp-Source: ABdhPJx1q7QjjHiONoxOWo5MOlj5onSKXY6TIr9QHLCEoj5/FCzs2+mynU0CvFugdtknqzew6jAODg==
X-Received: by 2002:a05:6e02:80d:: with SMTP id u13mr7306491ilm.151.1643409384372;
        Fri, 28 Jan 2022 14:36:24 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:9c52:a4df:7929:dcbf])
        by smtp.gmail.com with ESMTPSA id g5sm15803162ila.59.2022.01.28.14.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 14:36:23 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, cstevens@beaconembedded.com,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: udc: renesas_usb3: Fix host to USB_ROLE_NONE transition
Date:   Fri, 28 Jan 2022 16:36:03 -0600
Message-Id: <20220128223603.2362621-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support the external role switch a variety of situations were
addressed, but the transition from USB_ROLE_HOST to USB_ROLE_NONE
leaves the host up which can cause some error messages when
switching from host to none, to gadget, to none, and then back
to host again.

 xhci-hcd ee000000.usb: Abort failed to stop command ring: -110
 xhci-hcd ee000000.usb: xHCI host controller not responding, assume dead
 xhci-hcd ee000000.usb: HC died; cleaning up
 usb 4-1: device not accepting address 6, error -108
 usb usb4-port1: couldn't allocate usb_device

After this happens it will not act as a host again.
Fix this by releasing the host mode when transitioning to USB_ROLE_NONE.

Fixes: 0604160d8c0b ("usb: gadget: udc: renesas_usb3: Enhance role switch support")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 57d417a7c3e0..601829a6b4ba 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2378,6 +2378,8 @@ static void handle_ext_role_switch_states(struct device *dev,
 	switch (role) {
 	case USB_ROLE_NONE:
 		usb3->connection_state = USB_ROLE_NONE;
+		if (cur_role == USB_ROLE_HOST)
+			device_release_driver(host);
 		if (usb3->driver)
 			usb3_disconnect(usb3);
 		usb3_vbus_out(usb3, false);
-- 
2.32.0

