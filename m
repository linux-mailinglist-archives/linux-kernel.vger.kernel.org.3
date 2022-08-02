Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA18F587DFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbiHBONQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbiHBONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:13:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB0E28720;
        Tue,  2 Aug 2022 07:13:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c17so3641106lfb.3;
        Tue, 02 Aug 2022 07:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xYQllLGwQDfot9WaYK/IQR36FqQ2jGUDVaRhMK36BzI=;
        b=k+E6+lqWxja7FEj1o9hHkU4jGoxS875065nmyE3nsg6QvKJaCrs8+Rb0EVOd0r7Fw3
         uy7KANXio+czDbvb8hZ6hWO27qxwESmhOBJmnxqhgT4Dd7WSqHt5Ny9E1CyaZRzBMr2T
         xBR0Hmxidnga1ctyjE7FYKd2i8qrMfxmeplMb23XZu4MWSOV5X42U3mKDTXrgzwR9Fsp
         GvhWiwEm1oDe0+4I57O4s2NZkL5D8JDU+uFQ6Ca+PKJDV/GrzrNVeYrZSJpg9RDHh13b
         zlzPY+f/FtNTSmhEtSM8w7CdGO7+3GGnpDvY/9ahNnt1NDlpGEF55efOAwNLvJCtHqwT
         cHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xYQllLGwQDfot9WaYK/IQR36FqQ2jGUDVaRhMK36BzI=;
        b=lDYlpSMMy+6bcd1WTyA060r9EWqpAOR0RNzvSeN2G+opf8uh7GPKoC3+TaoK1CmqPU
         6AZLQyXg3Tpa2AMRtGpSkAVVZK3V1SNn3f8dB8Nzryeff/l1JiogVz4UkavogZeeoiyP
         dj4NiSKgPP7nOCasxDjE77zsje/Dzb2M2cVD01kgK0m/WJ0cRsJrFE8jOuPjB7QgSdoW
         b3+ZLisKx3xb7OMHRutjydbrwXLMVDuZCZq3ARDm4154X/nQdztx1EAYWhZdRT6OCnjJ
         ldCVmLngZGsqe9GkLpC6IW9F1JTRUaLnkOr5Y9GH62HY7+c1Eiel69fn8u0S1Ae4FY62
         38lg==
X-Gm-Message-State: ACgBeo2ncxndv5xMrgPgLKeJmWr89J6FxwtM1nGB7sq6BxdPU8Gyctih
        PmjLJCMr7Mhhc69L6AOvNG0aXEJ6c/uvraAYwA==
X-Google-Smtp-Source: AA6agR4xvmSr+T+c/s7ABoUE+edquaAUHnTDl5bREQFKmzOrbx0IDYwBN3+IHpO/DHmdSGp87EzDmxIyiaYOS2vVqAU=
X-Received: by 2002:ac2:483b:0:b0:48a:e7f2:c7ff with SMTP id
 27-20020ac2483b000000b0048ae7f2c7ffmr6746275lft.591.1659449582464; Tue, 02
 Aug 2022 07:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
 <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2> <20220802080831epcms2p2c2b9f94e2f450a6a772a193d9720b650@epcms2p2>
In-Reply-To: <20220802080831epcms2p2c2b9f94e2f450a6a772a193d9720b650@epcms2p2>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 2 Aug 2022 22:12:49 +0800
Message-ID: <CAGaU9a_qK43ruFKHKybZmZwOz-QR44ci5qZWiuejH4oeMN2VLQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] scsi: ufs: wb: Add ufshcd_is_wb_buf_flush_allowed()
To:     j-young.choi@samsung.com
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
