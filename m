Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDA54CC1F2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiCCPxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiCCPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:53:49 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960433BFBB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:53:02 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i1so4349127ila.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6DnNvmYXESsi6H9sVmRWdYUNZpUkiKH4XY2aaJ2v7k=;
        b=eFdjzhSBjBqGbQVz8REEDf5wYsUbQQpEfqotJT4Svc1l5sFNthp49ywgecvpI7GiL0
         Y/fMI6O2Hi8pRjSnJD0TbzRtSangyvBm5ol+ZR8nr7zEJYFq3HrxVo6TbE1oXyU1RfWB
         Y4JUX5tVy0cKnzjT0FdHIOh53ejLog1y4fiZYjUuOtcLElGG+MYs7sjRfJ2bz1JY1SJa
         3ROG+7oei6j17b26oAor5ObZHr69hCYuwjeRDM+1C5v98jZRnN+9OxyJ34+wT7Ra0ESr
         1T+tCtbcGRloVm4hDA4u1PIMkENEWKznmO9fGl10tJ+ATC0QceVSHmu34bgQkE25YVMh
         XHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6DnNvmYXESsi6H9sVmRWdYUNZpUkiKH4XY2aaJ2v7k=;
        b=odVNvf//MBt9LWh6RpElJDacYVAPrtoS+Qzi6/XBJ4O6RIEe5GtDAe7TXjVQHKaRao
         0aob7wGltaEVE3qLnTGyOGrarvOA1xevNFZABUfpdHUosrzmE5nAFT3UPIGi5UMLhVCK
         oueiuLS3Di9+MkU6/G45h2ySn2fLE9fXTz4GG63KbZ3y19e47cmKd6UlGbM5IZzzHakr
         7aRC9gM0Y0huw2FrFhljRubykPUS58mPyF2Cg+HFERNesxW9GdSt06cc/RvxPmF2BZ0w
         S+Hu/t+4BGfaMkySFoDoSJ9NnJxlFv9JYIayXvEvE0Mt26pWcnRgJmH/uO/hUBULZBdb
         rGBA==
X-Gm-Message-State: AOAM5301H2oGDEzSAwpFBtWnT1HV01gObhTHyM2U4km6fud3te5Ci3pZ
        82+iO9Abaw9lfBIElFTOvGc=
X-Google-Smtp-Source: ABdhPJyqUeYDkSeRzxoBSQL92b89Gu1qPXC2ESMANoM1lLusFXD1c8ae76BujXWrVrMPFa+DQJK51w==
X-Received: by 2002:a05:6e02:178b:b0:2c4:d0a9:8399 with SMTP id y11-20020a056e02178b00b002c4d0a98399mr9956736ilu.144.1646322782035;
        Thu, 03 Mar 2022 07:53:02 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id a6-20020a92d346000000b002c1a6040691sm2506599ilh.70.2022.03.03.07.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:53:01 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, paskripkin@gmail.com, martin@kaiser.cx,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] staging: r8188eu: clean up struct recv_buf
Date:   Thu,  3 Mar 2022 21:21:02 +0530
Message-Id: <cover.1646321515.git.abdun.nihaal@gmail.com>
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

This series removes set but unused fields from struct recv_buf.

Abdun Nihaal (9):
  staging: r8188eu: remove unused field list
  staging: r8188eu: remove unused field recvbuf_lock
  staging: r8188eu: remove unused fields in struct recv_buf
  staging: r8188eu: remove unused field phead
  staging: r8188eu: remove unused field ptail
  staging: r8188eu: remove unused field pend
  staging: r8188eu: remove unused field pdata
  staging: r8188eu: remove unneeded field pbuf
  staging: r8188eu: remove unused fields in struct recv_buf

 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  | 20 -------------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 17 +---------------
 .../staging/r8188eu/include/rtl8188e_recv.h   |  1 -
 drivers/staging/r8188eu/include/rtw_recv.h    | 14 -------------
 drivers/staging/r8188eu/os_dep/recv_linux.c   |  9 ---------
 5 files changed, 1 insertion(+), 60 deletions(-)

-- 
2.35.1

