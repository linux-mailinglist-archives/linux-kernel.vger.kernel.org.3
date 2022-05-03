Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E2517DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiECHAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiECHAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:00:42 -0400
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886BE240B5
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651561021;
        bh=IkD2eC64H4a98Hm5EUi6JNXhMplBS97eRkzCZjPYuZk=;
        h=From:To:Cc:Subject:Date;
        b=pPKAxDC2hYAc6zZDWQ8/rUIWAeFrq7C68wIAHdjNgh5AJTN03EHtB2WNUo9MUtVtL
         C5QpsGW2mSfGkZPbhMu24crFpzi3GyRZ+aGS6MCvFBUuMH/RU7jvoSRlIRKCjeE1Y2
         FjJnF76WmRGHPyGan6+//Pitool3/Yzl4jiEMavM=
Received: from localhost.localdomain ([59.172.176.242])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id E3B30812; Tue, 03 May 2022 14:56:59 +0800
X-QQ-mid: xmsmtpt1651561019tgdnr890c
Message-ID: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieuDg962aXAZu67cxzwJSFTylAyyn0cBZ7CDblJEpwNipuMzCDi1
         Kt45NMxcYnlvKh1wZqr6osnAWSeJkAON2Y+vNxBuM+uwhp4X268pPE1w3Kj6tM36FRjkSV7VC3Ru
         23YahIBoWsi0+TydIlyv8+BsLY0sUyc+ZHQdumbXYLxPhWX/NbmB+CTz4YdjiOni3regbGUO67Wb
         GMJrO3L+jYwvz/r1gvbWsmPDZ/KpFhB0AICXckVWVyiXmiIdQjc2SFoPVxg/7mIoBAR96t63azKp
         4L9Xkigv31wSi7hNqbpYgzENjCv1sJm1CKl5gIzdFSdJUx9GQVyApyLryBhwReXRmbDv9SkEamUI
         IjZ+dsNyg//aYG3q+w5+2EAd3W7zCS+OkieYbIROfC5D0NeMdTnVY0SQK0B92k6fZz2zYs4eRY4B
         xKqBSNA1fxmjQtRaYrPjFM73azm+kdPuPvoYwCP01lnLJvbXr5/BiVNYzMdwLc9w9y2kRZBMxkpr
         c4PSX4HC+AFCRmov9TnBoYuIvPztTHnjEJnKxU21VJpZonS7fd5hrdKaOl46cbBG71IkoE+m5XVa
         Kr/25AhaRsJ/DE7xIi6Jm6FYIO3mHB7e07okm/JD6S2MElnU+fx2SMf7rgzStO1/sbSSWdF655bS
         6ejmo/e3ZSLHFUokYu7ZojA2jKq06ktmE4MwK3abXVuizuH+f6yBL4TgOb+HSPXC2NRMak2o0jfn
         ThPuOKYLD45seASS+9wyAE7S4zme4G8Nr27EfkMwLJrAjVOMk6KVe/F3vYsToXGsMKkrlk1ONkmz
         +NFn7UV89MD19blPJiou9Xy019C/o9sHivXqLyOPvmO4XDxHn9lIHSASKmVStRn47270RggOyadA
         NP3PpT+M4lseZ3nuzA/OltoB8HqMTlS2U8OfW5EBlLkm2z8B1JPoIW4NziACQ7QWrnigFLQcaG8j
         ScIoeiVFs=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 00/12] staging: some memory-related patches
Date:   Tue,  3 May 2022 14:56:47 +0800
X-OQ-MSGID: <20220503065647.3153-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

This is a collection about some memory-related bugs fixing.
In brief, there are two types about them.
First is some memory allocation functions are called without proper
checking, which may result in wrong memory access in the subsequent
running or some else.
Second is lacking proper error handling that does not release some
allocated resources, which may result in memory leak problems.

These issuses are similar, so they are put in this series together.
Note that most of them are sent as each separate patch before, this series
rebased them to the lasted version. While there are some inherent logical
relationships between 03~05/11~12.

Xiaoke Wang (12):
  staging: rtl8712: fix potential memory leak in
    r8712_xmit_resource_alloc()
  staging: rtl8712: fix potential memory leak in _r8712_init_xmit_priv()
  staging: rtl8712: fix potential memory leak in r8712_init_drv_sw()
  staging: rtl8712: change the type of _r8712_init_recv_priv()
  staging: rtl8712: add two validation check in r8712_init_drv_sw()
  staging: rtl8723bs: fix a potential memory leak in rtw_init_cmd_priv()
  staging: rtl8723bs: fix potential memory leak in _rtw_init_xmit_priv()
  staging: rtl8723bs: fix potential memory leak in rtw_init_drv_sw()
  staging: r8188eu: fix a potential memory leak in _rtw_init_cmd_priv()
  staging: r8188eu: fix potential memory leak in
    rtw_os_xmit_resource_alloc()
  staging: r8188eu: fix potential memory leak in _rtw_init_xmit_priv()
  staging: r8188eu: check the return of kzalloc()

 drivers/staging/r8188eu/core/rtw_cmd.c      | 16 +++---
 drivers/staging/r8188eu/core/rtw_xmit.c     | 42 +++++++++++----
 drivers/staging/r8188eu/include/rtw_xmit.h  |  2 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c |  4 +-
 drivers/staging/rtl8712/os_intfs.c          | 26 +++++++--
 drivers/staging/rtl8712/recv_osdep.h        |  2 +-
 drivers/staging/rtl8712/rtl871x_recv.c      |  6 +--
 drivers/staging/rtl8712/rtl871x_xmit.c      | 27 +++++++---
 drivers/staging/rtl8712/xmit_linux.c        |  3 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c    | 17 +++---
 drivers/staging/rtl8723bs/core/rtw_xmit.c   | 50 ++++++++++++-----
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 60 +++++++++++----------
 12 files changed, 163 insertions(+), 92 deletions(-)

-- 
