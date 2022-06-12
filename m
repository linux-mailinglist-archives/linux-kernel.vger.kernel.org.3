Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDC8547A61
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 15:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiFLNh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 09:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiFLNhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 09:37:54 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72844AE00
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 06:37:52 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id k21-20020aa7d2d5000000b0042dcac48313so2510933edr.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gD+aT0qjgT75+iUPS1N/favvVXaDTEjoowGsau3TnVg=;
        b=MSPvarkOsX0LkOL948d7Zkp4IuHkY9yYa2JR2ywB4/8nZmHd59Xt9OeuqNLMT5khXZ
         9t+tE27/gVKzUegncZqVT7fed6rgwNOlw1PZ2sl3Pw7X9B+pinvcUZQD4dvHL9jP5R51
         +E5nZFVlVH1oX3jLR8rgQtZ6jVnkVZnsvfmgz3yQgBtyowEhBGlUO+0r+Pix6nFAYhvy
         tC0zLbk9AHHgculk8mEA2OvpKprUfCjRuD0S+P6EbBTs4LKI2JH34PpWf/x/MY40nQhu
         WMCkRMWLpPDgJts9ysu+4MbJsTr96NHE78qYF3a6CJcor0y/TYbDRZxWKhL/r4A3lkoN
         YnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gD+aT0qjgT75+iUPS1N/favvVXaDTEjoowGsau3TnVg=;
        b=7uhByE+1r0Vx12AgcB62IuM23JWWXiqojwQqKi9+Ushdt6k/v9E6q3RTSkqda4PC4K
         9B7Dy8cDcqNgdtAkG729zreVSh5k+B2tLFb3i8/7wZeU4+4XsS2vo1y4Vc9T6IfeHyfb
         AggxG7Ew6tVGCKb0vFRc9PFJ2/PpmrfrwLui1rae/6u3fnM/PgxxNiC3NN+TRPcA63N9
         34mrMs7rwnJ1u5eMp3cQF36lQJCWayhjb0ywjh0Bj/A3vN2qCVx5pMdf6A0RB9eN/G0s
         nSN8PZalhiDd4MnUg0A2KPjB13IbIyFb8M4jTS5xUKDgSskua29N2MoZG9c13aZurzXd
         3JYg==
X-Gm-Message-State: AOAM5300mPtuQVoMoCmu3ZZBSu1OC0x5BOZzzyzL6s7/IHYwrlF7ZqRg
        WcntB0cgLTEFkcJnpvjtKmN7FdLByvBm
X-Google-Smtp-Source: ABdhPJzpvLxKS1lH6E8BDBPabpdz6zobQY98A0/hRmbF2WNnf6VDGrnJSg7K/nynMqWy6BJ09SxJCx69xpJR
X-Received: from coin.lon.corp.google.com ([2a00:79e0:d:204:38ab:5d4a:6c0b:7372])
 (user=pterjan job=sendgmr) by 2002:a17:906:794e:b0:711:da52:c6c1 with SMTP id
 l14-20020a170906794e00b00711da52c6c1mr30012476ejo.463.1655041071040; Sun, 12
 Jun 2022 06:37:51 -0700 (PDT)
Date:   Sun, 12 Jun 2022 14:37:44 +0100
In-Reply-To: <de4521a5-aeb6-6b92-358b-be910029c1b7@redhat.com>
Message-Id: <20220612133744.4030602-1-pterjan@google.com>
Mime-Version: 1.0
References: <de4521a5-aeb6-6b92-358b-be910029c1b7@redhat.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2] vboxguest: Do not use devm for irq
From:   Pascal Terjan <pterjan@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When relying on devm it doesn't get freed early enough which causes the
following warning when unloading the module:

[249348.837181] remove_proc_entry: removing non-empty directory 'irq/20', leaking at least 'vboxguest'
[249348.837219] WARNING: CPU: 0 PID: 6708 at fs/proc/generic.c:715 remove_proc_entry+0x119/0x140

[249348.837379] Call Trace:
[249348.837385]  unregister_irq_proc+0xbd/0xe0
[249348.837392]  free_desc+0x23/0x60
[249348.837396]  irq_free_descs+0x4a/0x70
[249348.837401]  irq_domain_free_irqs+0x160/0x1a0
[249348.837452]  mp_unmap_irq+0x5c/0x60
[249348.837458]  acpi_unregister_gsi_ioapic+0x29/0x40
[249348.837463]  acpi_unregister_gsi+0x17/0x30
[249348.837467]  acpi_pci_irq_disable+0xbf/0xe0
[249348.837473]  pcibios_disable_device+0x20/0x30
[249348.837478]  pci_disable_device+0xef/0x120
[249348.837482]  vbg_pci_remove+0x6c/0x70 [vboxguest]

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
v2: stop using devm rather than adding a manual devm_free_irq

 drivers/virt/vboxguest/vboxguest_linux.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 6e8c0f1c1056..dec36934d679 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -360,8 +360,8 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		goto err_vbg_core_exit;
 	}
 
-	ret = devm_request_irq(dev, pci->irq, vbg_core_isr, IRQF_SHARED,
-			       DEVICE_NAME, gdev);
+	ret = request_irq(pci->irq, vbg_core_isr, IRQF_SHARED, DEVICE_NAME,
+			  gdev);
 	if (ret) {
 		vbg_err("vboxguest: Error requesting irq: %d\n", ret);
 		goto err_vbg_core_exit;
@@ -371,7 +371,7 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	if (ret) {
 		vbg_err("vboxguest: Error misc_register %s failed: %d\n",
 			DEVICE_NAME, ret);
-		goto err_vbg_core_exit;
+		goto err_free_irq;
 	}
 
 	ret = misc_register(&gdev->misc_device_user);
@@ -407,6 +407,8 @@ static int vbg_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	misc_deregister(&gdev->misc_device_user);
 err_unregister_misc_device:
 	misc_deregister(&gdev->misc_device);
+err_free_irq:
+	free_irq(pci->irq, gdev);
 err_vbg_core_exit:
 	vbg_core_exit(gdev);
 err_disable_pcidev:
@@ -423,6 +425,7 @@ static void vbg_pci_remove(struct pci_dev *pci)
 	vbg_gdev = NULL;
 	mutex_unlock(&vbg_gdev_mutex);
 
+	free_irq(pci->irq, gdev);
 	device_remove_file(gdev->dev, &dev_attr_host_features);
 	device_remove_file(gdev->dev, &dev_attr_host_version);
 	misc_deregister(&gdev->misc_device_user);
-- 
2.36.1.476.g0c4daa206d-goog

