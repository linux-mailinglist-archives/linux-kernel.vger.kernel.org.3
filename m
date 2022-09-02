Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105625AA91A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiIBHvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiIBHvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:51:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32CBABF32;
        Fri,  2 Sep 2022 00:51:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x19so1159822pfr.1;
        Fri, 02 Sep 2022 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ytaS2HDgiOt5YedCmHjB6NzOPHEeyztGDe+t4/ynB9g=;
        b=IHU8HZzHDz1NEVK1FUbzsCmji46rKwPkkP6V5APfvELxfEBciQ/CRE6h9rPnWVJutq
         lXwvQcNCOo23Lx17Ed09B1zXE0eK9xg6qUjPVvL64o8BZHVHQeXSCLIb68p9UOGYV8db
         IZrg70C0r8OepEyY6Pit6wqxkDgo8olaiAG7uStVg352gB/08tYVa8YKcPKMSah+rhCj
         amg1gp9KU3rxAsvjTbgaRJQbgtjg6YflC3BqlaI+O5J+BJEzt84kJgv2igjgi19nwm9d
         GUDqD9SXI0qRZnvIv8SVgp3t6Gab7Dky/FgR8kF9pjS1PEgk+hZ1bgGTi+5Ck9curGXv
         SaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ytaS2HDgiOt5YedCmHjB6NzOPHEeyztGDe+t4/ynB9g=;
        b=fKfT6+rkgqyxVOCaA4nNzl524fNd/uHr/CCmIeX51MfknEJPHaU0bidnt4feMAUdXC
         vEaHIzL+USfFKV2SHtE7hqXtwqZJgOujTK2FJRl0hr8CuEIDC/V+phxHm8Xa8JBIHcDE
         bQbDKL60hXiFr2eOPejOIgz+9aAhFLBpWvWxpXO3Khyh4JwuxLEiISrfsd88UOTieNle
         OqIAjnHVYnpv3EWd/dUKQ+VqTyK/oQTaxuA2grRTT3CthvF2t5nB8cPcJAJX8RT7If5t
         GU3Srs2urDSymQaROHK5oxNOfSALPflpEzHmQUyb3PERZ28fVeM5gyVppKJ6b4kr6LbV
         7LdA==
X-Gm-Message-State: ACgBeo32WuiHTq6VHwjX3wdQPICPsD+h9h9xsbhRzi2EOm0SNYHz8ZAO
        f6it/XK3Pb8fJyeYt0GX49g/YE6pR1vN3jCs
X-Google-Smtp-Source: AA6agR4c8S/vuJdq6qi+8Z/hdP5FiMeDGwDeuB/GfKYqAnrtTz7U1k0exR83AM0TwSLRrB00WK5vRw==
X-Received: by 2002:a63:8643:0:b0:42b:66ab:b051 with SMTP id x64-20020a638643000000b0042b66abb051mr30526063pgd.259.1662105112467;
        Fri, 02 Sep 2022 00:51:52 -0700 (PDT)
Received: from localhost ([166.111.139.139])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902b19600b00174fa8cbf6dsm898927plr.161.2022.09.02.00.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:51:51 -0700 (PDT)
From:   Zixuan Fu <r33s3n6@gmail.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [BUG] scsi: megaraid_sas: possible null pointer dereference in megasas_slave_alloc()
Date:   Fri,  2 Sep 2022 15:51:48 +0800
Message-Id: <20220902075148.2391710-1-r33s3n6@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Hello,

Our fault injection tool finds a possible null-pointer dereference in the
megaraid_sas driver in Linux 5.10.0:

In the file drivers/scsi/megaraid/megaraid_sas_base.c:
In megasas_get_seq_num(), the call to dma_alloc_coherent() may fail: 
6459: el_info = dma_alloc_coherent(&instance->pdev->dev,
                                   sizeof(struct megasas_evt_log_info),
                                   &el_info_h,
                                   GFP_KERNEL);

This error is propagated to its caller megasas_start_aen().
6749: if (megasas_get_seq_num(instance, &eli))
6750:     return -1;

Then it is propagated again to its caller megasas_probe_one().
7428: if (megasas_start_aen(instance)) {
7429:     dev_printk(KERN_DEBUG, &pdev->dev, "start aen failed\n");
7430:     goto fail_start_aen;
7431: }

In error handling code of megasas_probe_one(), it removes the pointer
`instance` from `megasas_mgmt_info.instance`:
7445: megasas_mgmt_info.instance[megasas_mgmt_info.max_index] = NULL;

But it stores the pointer `instance` in the pdev by calling pci_set_drvdata()
before and do nothing about it in error handling code:
7401: pci_set_drvdata(pdev, instance);

Then, in another thread, megasas_slave_alloc() is called. This function calls
megasas_lookup_instance() to get the pointer `instance`, which can not be
found in `megasas_mgmt_info.instance`. Therefore, NULL is returned:
2087: instance = megasas_lookup_instance(sdev->host->host_no);

This causes a null-pointer dereference bug:
2095: if ((instance->pd_list_not_supported || 
           instance->pd_list[pd_index].driveState == MR_PD_STATE_SYSTEM))

If we just add a check for `instance`, another bug is found.
megasas_fault_detect_work() is called by a thread. and it retrieves the
pointer `instance` from `work`:
In the file drivers/scsi/megaraid/megaraid_sas_base.c:
1901: struct megasas_instance *instance = 
        container_of(work, struct megasas_instance, fw_fault_work.work);

Because the structure `instance` points to is broken, the following calls
about `instance` causes some page-faults:
1907: fw_state = instance->instancet->read_fw_status_reg(instance) &
                 MFI_STATE_MASK;
1911: dma_state = instance->instancet->read_fw_status_reg(instance) &
                  MFI_STATE_DMADONE;
...

I am not quite sure how to fix this possible bug. Any feedback would be
appreciated, thanks!

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>

Best wishes,
Zixuan Fu
