Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952015280D0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiEPJWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbiEPJV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:21:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1AF26542
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:21:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q18so13840130pln.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZE2sTJsadm9K7ftIu5rqHwlhK0KVCsbqfIVmJX6zs2s=;
        b=Lqcn2ru4ZoTSodzxiYNqnxDMBm14zt0c7pBGCyFRCoe5SB3C7fDbfb7QQ0/ibvr4yn
         x57tFsELEjoV9Qe0AHrIHukOzZXVfniHK+KfImP4SCR27+cO+AkE9RUjFfa76Tw0q96e
         jE8bohbrKfFUwwU304XtcLkizPgRojEm6D0toXn6kzIjfSFeWvDf+4OiF+MIR8A5LxJJ
         O8AHW2+gpL5Gh3ZSU3qToxyZMSHSfnYp+2bQx52DSdKbRqZsyKXILZuaox3rQWPfVtdi
         DUdcCquaWQl6lMqy4WfdrcSnMT2zmX5Tv4V4gjbVDjrYzZz0envdUpHzTFgq4D/sWB2d
         Si4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZE2sTJsadm9K7ftIu5rqHwlhK0KVCsbqfIVmJX6zs2s=;
        b=N4uLj4MQiu17JV29siesXhQcL4B2lYOYoFm6oR6TJkumIpTRhptaUkBgNUa+uPHQZq
         UBnwe1/rcCCxH0uDH6iwECw2zTNlvw1EQgHR6qeLYjm9+QyA18zeu4PgkIfUpNMY6W88
         z59RBc+vGnc7SIIdsWc2VGN4GH/Er0192l89BN10XfOTyUfNq9Q7MYbN/strbrY/ACyy
         Y6G3c/o9VPqqnNNaspbOSfLY7Tg44ncgIJIy3mRMMkPJUaRl+Ct0Wx173QcxAQ7V2GIM
         URdOuIwbUevpRigAMcyU3D2GQfSXZZ1FjIJRqMlpObnXduEQqamUfzd3hdX2sYD9OKXd
         mrRQ==
X-Gm-Message-State: AOAM530cMymzzCJCjmYyq3OaupjRU6rGIk5nBene4HQHhsIsY4qo1TNa
        USP0OPE4KjltljY5RzQnfvA=
X-Google-Smtp-Source: ABdhPJwZoLGjqEmKbmu0QtHDuubjGU2+b4Bxbj3i7J09IyHcUz3VD2136iyJyyMD5uSscATGFeoS5g==
X-Received: by 2002:a17:903:244d:b0:15e:a3a2:5a75 with SMTP id l13-20020a170903244d00b0015ea3a25a75mr17016080pls.89.1652692914115;
        Mon, 16 May 2022 02:21:54 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id ku11-20020a17090b218b00b001dedb8bbe66sm6029521pjb.33.2022.05.16.02.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 02:21:53 -0700 (PDT)
Date:   Mon, 16 May 2022 17:21:50 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     dan.carpenter@oracle.com, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] staging: rtl8712: fix KMSAN: uninit-value in
 r871xu_drv_init
Message-ID: <cover.1652618244.git.wanngchenng@gmail.com>
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

Changelog v3->v4:
- Update commit messages.

v3: https://lore.kernel.org/all/cover.1651833575.git.wanngchenng@gmail.com/

Wang Cheng (3):
  staging: rtl8712: add error handler in r8712_usbctrl_vendorreq()
  staging: rtl8712: fix uninit-value in usb_read8() and friends
  staging: rtl8712: fix uninit-value in r871xu_drv_init()

 drivers/staging/rtl8712/usb_intf.c      |  6 +++---
 drivers/staging/rtl8712/usb_ops.c       | 27 ++++++++++++++++---------
 drivers/staging/rtl8712/usb_ops_linux.c | 21 ++++++++++++-------
 3 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.33.1

