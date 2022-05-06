Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646E151CF45
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388452AbiEFDRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388447AbiEFDR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:17:29 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D48F63BE2
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:13:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id a191so5102126pge.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=t9ZKsEQo1Den80Ampwi5bEjEZNCMM58cKnc5jFoHVAE=;
        b=ATTy5exSBCfn1gQd9m59fPG3gpTAvdg53X1O5VaKxE098hN9mFiGSSy8T+b6lgjUis
         ATr5rZoxkBf+fJjvDGfT+KQEKj9xj+KW0gznlmCiuR/WihhrrJS/FSIEbzPGo/GY76WM
         3fg1opJIb9ct9nviPqZTYvtKsv5Nivq0Vqs5Y25V7SVsGA7guVtfVHVT1SMstrCrS5zq
         A+LdOPnNUR9q9/lFHeOdBjLs8evj+Z9uHheC+OE3RG7sYb33FoADJnYRFeXW3tGnzLaQ
         zg8UgDnOvdZGR9wLdZ/DUIRa/tHHvCUOyqlWk/VSv39TGhwNoYI34G+RBHpsGQgGD+TK
         TNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=t9ZKsEQo1Den80Ampwi5bEjEZNCMM58cKnc5jFoHVAE=;
        b=ltf0BRVyNPX29tDOWsyqNlANdP//Is2FCU8mL3L1iEPVPvAV2/xhLRJM1jffCY52SU
         hCKwuBr7zhgXZK1AT6/fMVl4OvDojGwe9F05gMI91USr6pF/KRxip9WolMoQnWqgA2uL
         FWtFFh1js9T5lA02xqSpnwWYrGb7Ty1ueZwytgha17FMuuUAAM6ohEdmRw7rpzPQxIhe
         jVY8XBKM9msHLHrV9eRsvZwd2+K7oXDjUCgp/2bG9+9k0UkS0DiM+0YwNRv3fQsc63XU
         W2E5tcJY28zli6IAErvzkCmJprl4m3BUOzoWa3Q6Dxbu9+3fjdDHDzz2Uor/rT3ZsNBB
         GKFQ==
X-Gm-Message-State: AOAM5323ArIGETHXPD/7FWpAY7qgQHDUgBvT8tiS9+3ik89wibzyNVbk
        9vlqZvuNPLgDT8Py/U8ONSQ=
X-Google-Smtp-Source: ABdhPJzjVjDlWxNle3CpXUsuif5mM+dOfdpIWnuNma4NHn4mUv1/9NgOHd65kl83U6fDLhmfZ2QCUA==
X-Received: by 2002:a63:cd41:0:b0:3c5:1242:3a0d with SMTP id a1-20020a63cd41000000b003c512423a0dmr1088134pgj.266.1651806827590;
        Thu, 05 May 2022 20:13:47 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b0015e8d4eb1d5sm397734plo.31.2022.05.05.20.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:13:47 -0700 (PDT)
Date:   Fri, 6 May 2022 11:13:43 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     dan.carpenter@oracle.com, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: rtl8712: fix uninit-value 'data' and 'mac'
Message-ID: <cover.1651760402.git.wanngchenng@gmail.com>
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

This is a v2 patch to fix KMSAN: uninit-value in r871xu_drv_init,
https://syzkaller.appspot.com/bug?id=3cd92b1d85428b128503bfa7a250294c9ae00bd8
Previous version and discussion could be seen here:
https://lore.kernel.org/all/20220414141223.qwiznrwgjyywngfg@ppc.localdomain/

Changelog v1->v2:
- Split to two patches.
- Add kmsan reports.
- Fix uninit-value 'data' by adding error checking and initialization
  rather than changing logic of r8712_usbctrl_vendorreq().

Wang Cheng (2):
  staging: rtl8712: fix uninit-value in usb_read8() and friends
  staging: rtl8712: fix uninit-value in r871xu_drv_init()

 drivers/staging/rtl8712/usb_intf.c |  6 +++---
 drivers/staging/rtl8712/usb_ops.c  | 27 ++++++++++++++++++---------
 2 files changed, 21 insertions(+), 12 deletions(-)

-- 
2.33.1

