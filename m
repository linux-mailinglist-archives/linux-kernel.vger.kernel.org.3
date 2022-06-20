Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3210550EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbiFTDgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiFTDgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:36:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12E6B848
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:36:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s37so9063672pfg.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVBB91Q21dmlELD+CGqOWdd8NHbp9ekIt+W7tA2FCWc=;
        b=Cn12uO6fPiT9mRwhoBioM6FCV4ohhDwf11PplmQu/2/BJlCsd7FMG+4+kUOjONmK6t
         88LXAclOy5moz2epcADuTzxYn15D5fVJtzZVJfbMEUkO4GUtysUFQ78KXNEXFQlqduF4
         mcwBqohfszErnFvtJbEFFOmi6gzxKdGv2+YciQHV/5j86ndLKT9tuvItg56/w1VvrnUr
         FND8hjF0xjViSh6z2iuMrjZFF4j5Jb2lR5T7F8h9lcjETTnggB+ARiNVuS8G7L1V3SH8
         XycIDOW1sz0P2Pi8/CKwrcLc7KVQLRqaXDTcamdJ1pMVkoxRugUSBeNyb3OWVjtqU5Tj
         wl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVBB91Q21dmlELD+CGqOWdd8NHbp9ekIt+W7tA2FCWc=;
        b=6s3q/y7OowZ57/kP1Nh+RkBMOM/IevYaajZZvU3u/rnVDhF2lvHIqe/2TMPviO4Cgu
         p2ZanyegYyc8p78zQIyUrPj6r79P0oi/ISDcMla3uhZkAjySwmcoflwJDA7UxHncFdOz
         +U6aA9hm64eQVCzJ/gWjkCQHN9Mj5xzFtZgXWuAJWBtBPTcclrps/vSSAslJh9y+lASZ
         mCL26iVEfZ99548s6s4o7GCIZKxMy5UgwAj5xdfIrgJWUbSIFuFIzyDJOGcaNgMHcWHO
         +cPAigE/6yQjjkHZFwFYgaBaI+akW5V7OEHYibXiBt/rVZJ0Po5h9PShfydmKav5+j5M
         otvg==
X-Gm-Message-State: AJIora+soXD+pncv0wCD1iUTdbfJ4ETdzISe9YK2303ukwdCregkjs5A
        ta8UZmR3imeZsBJurukJLeqmg7t5dYdBaQ==
X-Google-Smtp-Source: AGRyM1uOIK9MNhVOsVmDd3c5AKncc6wQPn/MuKhHQiSXwwK5WMNZg8ssYDvuST87F1ADc4lUHx7Ugw==
X-Received: by 2002:a05:6a00:16c6:b0:522:7ed2:4ff0 with SMTP id l6-20020a056a0016c600b005227ed24ff0mr22497415pfc.9.1655696195314;
        Sun, 19 Jun 2022 20:36:35 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id n18-20020a639712000000b0040cb1f55391sm1315243pge.2.2022.06.19.20.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 20:36:34 -0700 (PDT)
From:   onenowy <onenowy@gmail.com>
To:     hch@lst.de
Cc:     Jason@zx2c4.com, abhijeet.rao@intel.com, alan.adamson@oracle.com,
        axboe@fb.com, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, monish.kumar.r@intel.com,
        pankydev8@gmail.com, sagi@grimberg.me, yi.zhang@redhat.com
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR observed during blktests]
Date:   Mon, 20 Jun 2022 12:36:27 +0900
Message-Id: <20220620033627.8728-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615113106.GA10697@lst.de>
References: <20220615113106.GA10697@lst.de>
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

> I don't think we can wait for 5.20 - the "offending" commit is in
> 5.19-rc and -stable.  So I'll plan to prepare a patch based on the model
> number for now, still hoping we can come up with something better
> eventually.

Hi ,
Some samsung SSD for OEM also have the identical PCI-ids and are affected by this quirk.
But they have different subsystem-ids.

For example,

model number: MZQLB1T9HAJR-00V3 for lenovo
vendor: 144d
device: a808
subvendor: 1d49
subdevice: 403b

model number: MZVLB256HBHQ-00000
vendor: 144d
device: a808
subvendor: 144d
subdevice: a801

Addtition of subsystem-ids of X5 to pci_device_id(as below) may solve this problem.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17aeb7d5c48522..92fd3b1d88fc95 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3475,7 +3475,7 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
 				NVME_QUIRK_SKIP_CID_GEN },
-	{ PCI_DEVICE(0x144d, 0xa808),   /* Samsung X5 */
+	{ PCI_DEVICE_SUB(0x144d, 0xa808, {X5 subvendor?}, {X5 subdevice?}),   /* Samsung X5 */
 		.driver_data =  NVME_QUIRK_DELAY_BEFORE_CHK_RDY|
 				NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },


But I don't know X5's subsystem ids, Can someone provide subsystem-ids of X5?
