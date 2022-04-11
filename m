Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F554FC68B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347942AbiDKVQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350153AbiDKVQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:16:32 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BA3DFD1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:14:17 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id s4so12239354qkh.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=pkqd/GLpbqG7LAJ4m2LQWbg8yZe6P+EQh4+ijIpHwnY=;
        b=OO+sNYffcThi1xuROkKjBvJC05pcnrdx9WCnKGlHC58OIFg0RJeLekSfy1X5KM4QNk
         bjwKEyighYrUdxNUKxrkvNYNYWPxxatIbz2q+L40irGMA0JDZMD/Ixs04jHpp+vhPOKv
         QI2RRomlpipb3L+lAycz6Op2Ql1UfTXHVjLfzN23LO7fD+CpaHgUb6YBg46eFtTm4MnU
         MgJn8UytsHLcKOoUK7Ia5lonrpbyMk68bk49IYduea0dMG8D6dQsJvbUOF7q18bVdbMA
         w4/tjBahZ9KkqYX1lY7BibX+7ZwN1IKzuJc6zfhXrGVMlmCUFNrSfNOePO2382E0ryll
         FNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=pkqd/GLpbqG7LAJ4m2LQWbg8yZe6P+EQh4+ijIpHwnY=;
        b=1DDcaVNn4Ns/rSIeW+59xRCT3AAL5TfdwbyrCCBiFpr1WrK+PDhILe+ut/xypyr9g2
         wcKiTj0CT6Jt2K4ivYEJ4ByH43/sCF70YkZB1Bcyk9BEivhfCt5qAzKT/Cowi7bVY5Ku
         8PnHrHD4AAiJQ+aRFBgRh8y1lWjwmyKvPiqC7JFiLFigktBpGkNb91pJuqS3PchdWyYG
         Lu+4lDqlNpGyO9xMbgFx2jQCPm+Hg8Wk/tdpws6CxYDy84wie/xt17QLu6LyMOXH1LuR
         PWi1uo3FqmgyAQHpnG8W8DROLtKCeILAof9rVBdieV21hUOnsrXzEmH4A2aNwL/96NIw
         QtJQ==
X-Gm-Message-State: AOAM533bFKW0kPiPZxtowHODnuQi+GPg22fXjeGDmaojuOjh/cNUqIDN
        xesqeTtsI2G456sRtC3m0XD0Z5mPGIBN5hya
X-Google-Smtp-Source: ABdhPJyn7F36KNFwMXSCnqIDUv0dsKQ0NTeXHJoevaRzT0RVRooVRLQYT1yzOqDcZvA56oJwefUpdg==
X-Received: by 2002:a05:620a:1a99:b0:680:f33c:dbd3 with SMTP id bl25-20020a05620a1a9900b00680f33cdbd3mr970653qkb.17.1649711656365;
        Mon, 11 Apr 2022 14:14:16 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id c134-20020ae9ed8c000000b0069bf8f9cfb2sm5123158qkg.118.2022.04.11.14.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:14:15 -0700 (PDT)
Date:   Mon, 11 Apr 2022 17:14:11 -0400
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev,
        Jaehee Park <jhpark1013@gmail.com>
Subject: [PATCH] staging: greybus: replace zero-element array with
 flexible-array
Message-ID: <20220411211411.GA2796005@jaehee-ThinkPad-X1-Extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length and one-element arrays are deprecated. Flexible-array
members should be used instead. Flexible-array members are
recommended because this is the way the kernel expects dynamically
sized trailing elements to be declared.
Refer to Documentation/process/deprecated.rst.

Change the zero-length array, buf, in the struct 
gb_usb_hub_control_response to a flexible array. And add wLength as a 
member of the struct so that the struct is not a zero-sized struct.

Issue found by flexible_array coccinelle script.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---

I have a question for the authors: 
I saw a fixme comment in the hub_control function in usb.c:
/ FIXME: handle unspecified lengths /

I was wondering why this comment was left there?

In this patch, I'm using this struct:

struct gb_usb_hub_control_response {
    __le16 wLength;
    u8 buf[];
};

And instead of using response_size, I'm doing this:

struct gb_usb_hub_control_response *response;
And using sizeof(*response) as the input to gb_operation_create.

Would the flexible array address the handling of unspecified lengths 
issue (in the fixme comment)?


 drivers/staging/greybus/usb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
index 8e9d9d59a357..d0b2422401df 100644
--- a/drivers/staging/greybus/usb.c
+++ b/drivers/staging/greybus/usb.c
@@ -27,7 +27,8 @@ struct gb_usb_hub_control_request {
 };
 
 struct gb_usb_hub_control_response {
-	u8 buf[0];
+	__le16 wLength;
+	u8 buf[];
 };
 
 struct gb_usb_device {
@@ -102,16 +103,14 @@ static int hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue, u16 wIndex,
 	struct gb_operation *operation;
 	struct gb_usb_hub_control_request *request;
 	struct gb_usb_hub_control_response *response;
-	size_t response_size;
 	int ret;
 
 	/* FIXME: handle unspecified lengths */
-	response_size = sizeof(*response) + wLength;
 
 	operation = gb_operation_create(dev->connection,
 					GB_USB_TYPE_HUB_CONTROL,
 					sizeof(*request),
-					response_size,
+					sizeof(*response),
 					GFP_KERNEL);
 	if (!operation)
 		return -ENOMEM;
-- 
2.25.1

