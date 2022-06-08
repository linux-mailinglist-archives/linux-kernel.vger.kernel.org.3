Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52B4543139
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbiFHNUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbiFHNU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D885396B6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654694426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Rq05BCmy97EXh40H1m0tdjd6d+HaMN3GmoVc82N4IA0=;
        b=Gf2cc9FKi+H9Yk2r1s6OQOobHMx4uuthLFuPV6gdYC041/1xkOmy73Msqj6PFXYLiTWbWL
        e7BkRgImd/6SV38ov1f0xldt0noPxUoHrkC2lJbgHKi9pVsxB7C1ljrepSLzLumGLVYfYF
        gAvmKue9vexZ5B2dgkf3FQSItIMNT+U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-qXweLDykPpKNVn2SEqz11Q-1; Wed, 08 Jun 2022 09:20:25 -0400
X-MC-Unique: qXweLDykPpKNVn2SEqz11Q-1
Received: by mail-lf1-f70.google.com with SMTP id u5-20020a056512128500b00479784f526cso1298532lfs.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 06:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Rq05BCmy97EXh40H1m0tdjd6d+HaMN3GmoVc82N4IA0=;
        b=nvBnBuRblWFceyd7jOmyJsJMjfoCh8qLYvzklkyb/tP3SjAAXtLz7pPnDRFbvobEx1
         TmPWP+265YCXCaTfujAQ7yDU8J3bwhwzSxoUT319TeUBSeQSwwJLz9QLKe9jhF8R/thc
         jEgtxhpocwKhU4mn/r2fN8OmWJUWtjcsz9RAbsvO8kcCbBlq6jZyma5GCqfK73dCU6bE
         KEyQJhyfHlLUe0Oc6DjnB1QYGYbLk++9PjNV1+6sWgtNRv5Oa3dsj+mpQHvwCYwGr662
         QoMcWk0G3v6lczWWOZ2WdtXMjT4fhlTcFX5mLKVDqPhq28hoomBv46Uc6EZp00Tiu8/P
         5jqA==
X-Gm-Message-State: AOAM5311uygyDZADyekYZ3zv0sHbjYezQJ7s45vULBbXKZVjg9RmqhS4
        +g5aWGxCKD6A3acHduqJs7Drs+R0cAS22tmdbgCgDUfwEvMDvZ0P7EiAqp74d81YpPTHN3CWg33
        dOFLAnqoAQQNSSn1BV+f9rLxDqIDkWqnzC8C3QD6i
X-Received: by 2002:a05:6512:1109:b0:479:79ee:b5f8 with SMTP id l9-20020a056512110900b0047979eeb5f8mr2110047lfg.608.1654694423368;
        Wed, 08 Jun 2022 06:20:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzm79bpuTnajRoeYTNATim2GihBtodpPR4EKTzYafCDwxjt50pF0WaStXa/xY7QnFk+ZiKNq1ji+iMp1ApYPTE=
X-Received: by 2002:a05:6512:1109:b0:479:79ee:b5f8 with SMTP id
 l9-20020a056512110900b0047979eeb5f8mr2110030lfg.608.1654694423038; Wed, 08
 Jun 2022 06:20:23 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Wed, 8 Jun 2022 15:20:12 +0200
Message-ID: <CA+QYu4ogiTa1V20aqxFqBrMH0z927YNNN2O=CKma+=M_8E81iQ@mail.gmail.com>
Subject: [aarch64] [coresight_etm4x] [kernel 5.19.0-rc1] coresight-etm4x:
 probe of ARMHC500:20 failed with error -17
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We recently started to hit this call trace when loading the
coresight-etm4x module.

[   78.683475] coresight etm103: CPU103: etm v4.1 initialized
[   78.683645] sysfs: cannot create duplicate filename
'/devices/system/container/ACPI0004:00/ARMHC9FE:00/funnel0/connections/in:0'
[   78.683650] CPU: 17 PID: 2522 Comm: systemd-udevd Not tainted 5.19.0-rc1 #1
[   78.683653] Hardware name: HPE Apollo 70             /C01_APACHE_MB
        , BIOS L50_5.13_1.16 07/29/2020
[   78.683655] Call trace:
[   78.683657]  dump_backtrace+0xc4/0x130
[   78.683665]  show_stack+0x24/0x70
[   78.683668]  dump_stack_lvl+0x64/0x80
[   78.683673]  dump_stack+0x18/0x34
[   78.683676]  sysfs_warn_dup+0x70/0x90
[   78.683681]  sysfs_do_create_link_sd+0x13c/0x144
[   78.683683]  sysfs_create_link_sd+0x20/0x30
[   78.683685]  sysfs_add_link_to_group+0x48/0x74
[   78.683688]  coresight_add_sysfs_link+0xa4/0x114 [coresight]
[   78.683705]  coresight_make_links+0x98/0xdc [coresight]
[   78.683714]  coresight_register+0x1d4/0x3cc [coresight]
[   78.683721]  etm4_probe+0x1e0/0x334 [coresight_etm4x]
[   78.683729]  etm4_probe_amba+0x44/0xa0 [coresight_etm4x]
[   78.683735]  amba_probe+0x11c/0x1b0
[   78.683741]  really_probe+0x19c/0x3f0
[   78.683747]  __driver_probe_device+0x11c/0x190
[   78.683749]  driver_probe_device+0x44/0xf4
[   78.683753]  __driver_attach+0xd8/0x1b4
[   78.683756]  bus_for_each_dev+0x6c/0xb0
[   78.683758]  driver_attach+0x30/0x40
[   78.683761]  bus_add_driver+0x154/0x240
[   78.683763]  driver_register+0x84/0x140
[   78.683765]  amba_driver_register+0x30/0x44
[   78.683768]  etm4x_init+0xd8/0x1000 [coresight_etm4x]
[   78.683775]  do_one_initcall+0x40/0x220
[   78.683778]  do_init_module+0x50/0x1f4
[   78.683782]  load_module+0x940/0xaf0
[   78.683783]  __do_sys_finit_module+0x9c/0xfc
[   78.683785]  __arm64_sys_finit_module+0x2c/0x40
[   78.683787]  invoke_syscall+0x50/0x120
[   78.683790]  el0_svc_common.constprop.0+0xd4/0xf4
[   78.683792]  do_el0_svc+0x38/0x4c
[   78.683794]  el0_svc+0x34/0xd0
[   78.683797]  el0t_64_sync_handler+0x11c/0x150
[   78.683799]  el0t_64_sync+0x190/0x194
[   78.725063] coresight-etm4x: probe of ARMHC500:20 failed with error -17

console log: https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/07/558044095/redhat:558044095_aarch64/tests/Boot_test/12104911_aarch64_1_test_console.log

more logs: https://datawarehouse.cki-project.org/kcidb/tests/3797753
cki issue tracker: https://datawarehouse.cki-project.org/issue/1261

kernel config: http://s3.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/07/558044095/redhat:558044095/redhat:558044095_aarch64/.config

Thanks,
Bruno Goncalves

