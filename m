Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C3B52EE30
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350290AbiETObi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350288AbiETObf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:31:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E5455362
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:31:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so11667794pjr.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0DG//MbJGoKBofb3Wv2zcGNbeX6mdORbdLC9eO83J74=;
        b=RyZ2fHoMPdJXpXOh7un0wS3PhpOVZKzrHvbgK1l/J1GBRlJ7AVPF7PITjPIeu1pzyu
         5oxdxizbEWsklG1cZKa9wTfsbuhA5RryPesqREOQwnHol7pxIzPiqMFVltfzfiU9rmn8
         ziSqQoDzAUsrgkssXgrZghSOldTyaNCj4iibGZAtTW28LdulatHee3HFMspX6MXuHEIS
         QKG5CgY9VgTjNNz+c1+aN7Q2xJ8aPciF9X2geBMDjn504LOU0tLeduZ1vLq/ybc5oM1z
         KpRuYM3Cws4axN2GPkLLKo7Eyta4QYAsYjvBcKkdrcX1gGtI+2EG2rzg/hVGFOAvAVC7
         m3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0DG//MbJGoKBofb3Wv2zcGNbeX6mdORbdLC9eO83J74=;
        b=N//NFhX32YFWAA/GdomJcGNO54yhdRqTkROSR1U16g658yutQALVfGXn21kf41EMr/
         3f57BG/dCIqz22vdYgxy2bc8I8j0+nKwJcGRlPpUNYmmhXl3xGY/PakaCyeqGP/tXUJ+
         JE6NBmXRM/7NnBGQU+zr6SIVhVr/k49SHuaqtjOxXjMm2UkhIxJhOWbsiIJAnT9AzAZX
         /rProKWXx9ptHiPR34xdoNopT1bknD3s9dyiEn8rZbXlrIbJD0JAmDBiSuJeTtrDMWHw
         vnZpQSiPYcw4x/sYF9e5PCQpoyWpk/SgkEMtAq105qXw81BcPL8N5Q66rsF9pnqFnbIB
         Y/Mg==
X-Gm-Message-State: AOAM530B7P6iUClLDPMjVRGHe6XxBG9eZ0totrYT5aoEk2cxDKDuMexU
        TZPjsp5u6lctub9p81o3QdukA4s/TyE7q9x2BpXKze5zsRJsbRrc9g==
X-Google-Smtp-Source: ABdhPJyZLORQIOeBiBuNIGPzyVz1F+iVuxdVs1vNrMVXKPex9srSwfE2OAwJ77LaqNYC6mcAxdKGk6oXIYB0h2IcBGU=
X-Received: by 2002:a17:90a:b88:b0:1df:2b03:20c with SMTP id
 8-20020a17090a0b8800b001df2b03020cmr11292190pjr.46.1653057093643; Fri, 20 May
 2022 07:31:33 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 20 May 2022 22:31:22 +0800
Message-ID: <CAMhUBjmeiyScQm-SOq2MJ=0TRXV0gjyLk_qWc95yjCk3NUNRFQ@mail.gmail.com>
Subject: [BUG] intel_th: pci: Found a bug in intel_th_pci_remove()
To:     alexander.shishkin@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

I found a bug when removing the module, the following log can reveal it:

[   14.739939] sysfs group 'power' not found for kobject '0-dcih'
[   14.740243] WARNING: CPU: 0 PID: 297 at fs/sysfs/group.c:280
sysfs_remove_group+0x9f/0x220
[   14.742469] RIP: 0010:sysfs_remove_group+0x9f/0x220
[   14.746649] Call Trace:
[   14.746778]  <TASK>
[   14.746888]  device_del+0x296/0xe50
[   14.747227]  intel_th_free+0x110/0x3f0
[   14.747418]  intel_th_pci_remove+0x38/0x50 [intel_th_pci]
[   14.747685]  pci_device_remove+0x92/0x24

Thanks,
Zheyu Ma
