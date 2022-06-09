Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCAC544DE3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbiFINlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbiFINlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:41:06 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A59B22
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:41:03 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id a4-20020a056402168400b0042dc5b94da6so17114826edv.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eTBiLx7Hu1SlVzsMpZo2b+d4lU4L10GWK2pHkUo+SAE=;
        b=PeiLjAJ6ilDmNlrQqDLc5/7zn+iw3QxVOy3lE6Xs7rqSb9xNjfWEha4ocIhN6Qnox/
         VR+/tx2D7fu0/LwRJ/mhFNzt6yK1MmFr9bKKYTKmXKEi9s7b2PQo6kRE70zdgNI2DcPg
         yh58nzp5dQdS71dkF/UCS6ci2d/WZ7q2gjNigDeq5ktfn+5iAesDLU7p7TlLu97ogvhc
         z5YQRUEwSpCETE50RvFA/MEkR/6S6f8rfVcSqbb6sTkvU5RzienX0yFsLAAPDXB7+Egs
         EL9dyN0JhMO0s/A9oToAIB5xvmDPOPj2Ntm0P+YjbX6452pHvsEm9bVPEwJMPsC/yTG0
         oF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eTBiLx7Hu1SlVzsMpZo2b+d4lU4L10GWK2pHkUo+SAE=;
        b=DPZVs3olbcQJvL0pN21qnhagLl7H7VlVxSCKNgNYyixeZ1EIj3CFOQ3eP8K6nbBq4z
         V+g8Wx6Zcu4tZkGEZb1ccpYFqQV/3J/rR1jyIq9bdl/lcw3Zqb2exwMDQetbgiLsEmOg
         p04fXMFw9bM1QeyjS2kZJ9OtucvR7UjD5oncumYWm3g6hLZUAREIQza1zAP7CDpHo9dv
         oHH2kLWLhuq5HEeaKASoji5/ccd0FRQtYLnabAqlH06bQu0sSpI1ZkbCph413tw3quMX
         bGHzkXjkZOgIavqeJzNhKF7F6MkONLUnxCr6xG6ShrwShhcbTd7VjZ4YFkte+zm8NSpM
         XF/A==
X-Gm-Message-State: AOAM5305NzF1XdgspHBUu/MDj1lZNDx6KODvQRlEz7hGKUIK0KHVYSnE
        7J3A/XLSP6X3paCjnbhTNRiQWsKEj74t
X-Google-Smtp-Source: ABdhPJw+jQAuK2G5ha/0RJY1berjS7YFIotJofaX8bNXnVGs2fMN5yiilsREOw6VQKoe0TKXHITn89Oos5VS
X-Received: from coin.lon.corp.google.com ([2a00:79e0:d:204:9556:75c2:7376:a13c])
 (user=pterjan job=sendgmr) by 2002:aa7:ce84:0:b0:42d:ce51:8c6e with SMTP id
 y4-20020aa7ce84000000b0042dce518c6emr46564046edv.10.1654782061822; Thu, 09
 Jun 2022 06:41:01 -0700 (PDT)
Date:   Thu,  9 Jun 2022 14:40:57 +0100
Message-Id: <20220609134057.2485190-1-pterjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH] vboxguest: add missing devm_free_irq
From:   Pascal Terjan <pterjan@google.com>
To:     Hans de Goede <hdegoede@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

This fixes the following warning when unloading the module:

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
 drivers/virt/vboxguest/vboxguest_linux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
index 6e8c0f1c1056..faa4bc9f625c 100644
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -423,6 +423,7 @@ static void vbg_pci_remove(struct pci_dev *pci)
 	vbg_gdev = NULL;
 	mutex_unlock(&vbg_gdev_mutex);
 
+	devm_free_irq(gdev->dev, pci->irq, gdev);
 	device_remove_file(gdev->dev, &dev_attr_host_features);
 	device_remove_file(gdev->dev, &dev_attr_host_version);
 	misc_deregister(&gdev->misc_device_user);
-- 
2.36.1.476.g0c4daa206d-goog

