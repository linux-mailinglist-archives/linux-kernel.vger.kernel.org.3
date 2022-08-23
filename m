Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6744B59EC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiHWTeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiHWTeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:34:22 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798675F65;
        Tue, 23 Aug 2022 11:28:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q9so3934216pgq.6;
        Tue, 23 Aug 2022 11:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Prlh86Jq8x03ewPJmL5SAzbToND5xEk3H994ssQnFck=;
        b=VqrjnvNnk8nrfdVXEf/eCXEDKm3OiYi3WZ+va/EQvF6qfJ8Nt8un5I8WAYcaVX7VqY
         VHGxbbZX0ctkIJ7449eTgtZgdOlMWGHgW09lZHCPlau3xnY0ZsvyaCWcFOAQHjd25i6V
         Wpb7/ihr75OEOfW0KKpNWlvZDn7MFUspks2XWvbRBY9zMfi2CX/aZfFGuCSOo0dxaMY1
         WCAdK1M3PaK4TJeQy8ytYvt5TpHO19UvylS0f0A3xVR9dcsnznOpIMAPtcWcwnotvHmS
         zzRPBnLH6jUVeLgF2NkcL9PyD5QblVUVARIYVLfoiDJsctS/okQpeohmL06A5pLvPqcB
         Ko6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Prlh86Jq8x03ewPJmL5SAzbToND5xEk3H994ssQnFck=;
        b=Z2vytRzV20gO4I1HdmtCis6O4qHpKj8jcJhH64xs+mumBGunWkJ24U+r5WYehAItim
         3zO+bLLiMnqq722sFWCgp0/KnXMYgFxI49Z+O1/ycq1xNx8fegsqAx3wTjaz4CQ/xI8y
         6KfFqBqAy8rmj6/iL+4tq36p3F0U64aY3iu/I7U+QGv39EnoO218/FSrzgf/LP/OK6Bj
         0k5Ll0rQ6pvRV6FjvtLmY33sNbSKtzTD9L9+KUBcK9ycIshE2aYL5UBT4sWU3NQQizTG
         1KpwpnpWq+YNMoOFtYstk83f557uIDGbztvUMccFtgG6q/b4/RHZJARJXu9mtDSjVwgv
         QoQQ==
X-Gm-Message-State: ACgBeo0PESwEpadoU+b8crRwCs97EVSE1ynitfwC+iHaZBjTJRFDr/GY
        gcEQG2JpXjt192+DfK0lKHE=
X-Google-Smtp-Source: AA6agR7os+3W0OmRSxR/bh5OW1XZf/sajmlzGC3Dtg3RSDjXmehQ4r1e/owKUb8RSVHzof38hf1KhA==
X-Received: by 2002:a65:6e8f:0:b0:42a:c7d3:f2ed with SMTP id bm15-20020a656e8f000000b0042ac7d3f2edmr6445117pgb.209.1661279289483;
        Tue, 23 Aug 2022 11:28:09 -0700 (PDT)
Received: from fedora.. ([103.159.189.136])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090a6e0d00b001f2fa09786asm10328798pjk.19.2022.08.23.11.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:28:08 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Khalid Masum <khalid.masum.92@gmail.com>
Subject: [PATCH 0/2] usb: ehci: Prevent possible modulo by zero 
Date:   Wed, 24 Aug 2022 00:27:56 +0600
Message-Id: <20220823182758.13401-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches prevents two modulo by zero error.

Khalid Masum (2):
  usb: ehci: Prevent possible modulo by zero
  usb: ehci: Prevent possible modulo by zero

 drivers/usb/host/ehci-q.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.37.1

