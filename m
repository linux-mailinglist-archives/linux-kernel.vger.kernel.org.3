Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE42B543828
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244763AbiFHPzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbiFHPzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:55:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A924578B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:55:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso24174829pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qaT/kcVu0n8hYTw/I914LnAixdyMenHCzToZpD7JjS8=;
        b=TMexpVzytSlnG/LTzKkCu96Y+sL2kVYd7ZVeJpC6kBHxQs8ETMahoZqVGelLcynZLI
         dL3HXpQ/GdIuF7BJ7fNFFj5llT8/Hc4jEEA1ELlvcJp4c0L9OG1jWgH/OQxuiwaUiyRM
         TQ6dp9s6Pz2O7Bcd3hOqc9LR6/MkuQBz5w8AbZCHcJAPE3iiEWpwtSOIuV22OzJuBdr2
         TTW1j9VWgqyzKtTmxrDKbAxoYu7BORaXYjQELeSUs9xUOu432Uhfdk3G7mWr1syVpyZD
         ZJibLkecKAJt9qst2fl/dj6dYdQG63jzCugPzmwBp9CpDI+Bq8QPPf9laUPo5sDXeLmU
         aO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qaT/kcVu0n8hYTw/I914LnAixdyMenHCzToZpD7JjS8=;
        b=FImouH2NVZqtEIatO7VNOb9kkBg170N/CwJcRln1wWlX5IrvLbP14nBoQkFQ6+RfZr
         21gmqyz+QhCnkSFiA2J5jIMdJouw0gYxVV/tx/TdR9KfEIi+7cdit1nyKxMDLKvAIRa8
         SoaCcHOw1Cb+S4g46Sqw+e+68gJ3dINBJxo3BuSL5f7WIjxEcl9aK91FT/NmhNNzp9xX
         lrCLtYZucZWzPe+TJhvDqlApPfPgUet3QtzTNkbR472WbkJ0ZhDl/W81N6I85iE9EWRP
         0fgkP1WfWdECFeJzgJSQ9fCyt/i9QfOOkHRH1dvOBI+6yQO5LfGswSqIqbZL13blTwrY
         UvhQ==
X-Gm-Message-State: AOAM531/NYTYGW/0b0SrHQOZgzLqTydyLzrHHXWgnop3s5TpcNehXgP9
        GURFadwY7NHCd9G4ha6YJjCeuQ==
X-Google-Smtp-Source: ABdhPJw6oHyuJCBWen45Zc63TXT3ZYpyw9KTebzxAVR2lrKtqjPq2ziyXeh0RRRayXYjC1QXZIi87Q==
X-Received: by 2002:a17:903:18d:b0:167:47f3:49 with SMTP id z13-20020a170903018d00b0016747f30049mr28972912plg.95.1654703716463;
        Wed, 08 Jun 2022 08:55:16 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902778100b0015e8d4eb2d2sm14814885pll.284.2022.06.08.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 08:55:15 -0700 (PDT)
Date:   Wed, 8 Jun 2022 09:55:12 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        CKI Project <cki-project@redhat.com>,
        coresight@lists.linaro.org, Suzuki.Poulose@arm.com,
        mathieu.poirier@linaro.org
Subject: Re: [aarch64] [coresight_etm4x] [kernel 5.19.0-rc1] coresight-etm4x:
 probe of ARMHC500:20 failed with error -17
Message-ID: <20220608155512.GA951633@p14s>
References: <CA+QYu4ogiTa1V20aqxFqBrMH0z927YNNN2O=CKma+=M_8E81iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QYu4ogiTa1V20aqxFqBrMH0z927YNNN2O=CKma+=M_8E81iQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing the coresight mailing list and maintainers.

On Wed, Jun 08, 2022 at 03:20:12PM +0200, Bruno Goncalves wrote:
> Hello,
> 
> We recently started to hit this call trace when loading the
> coresight-etm4x module.
> 
> [   78.683475] coresight etm103: CPU103: etm v4.1 initialized
> [   78.683645] sysfs: cannot create duplicate filename
> '/devices/system/container/ACPI0004:00/ARMHC9FE:00/funnel0/connections/in:0'
> [   78.683650] CPU: 17 PID: 2522 Comm: systemd-udevd Not tainted 5.19.0-rc1 #1
> [   78.683653] Hardware name: HPE Apollo 70             /C01_APACHE_MB
>         , BIOS L50_5.13_1.16 07/29/2020
> [   78.683655] Call trace:
> [   78.683657]  dump_backtrace+0xc4/0x130
> [   78.683665]  show_stack+0x24/0x70
> [   78.683668]  dump_stack_lvl+0x64/0x80
> [   78.683673]  dump_stack+0x18/0x34
> [   78.683676]  sysfs_warn_dup+0x70/0x90
> [   78.683681]  sysfs_do_create_link_sd+0x13c/0x144
> [   78.683683]  sysfs_create_link_sd+0x20/0x30
> [   78.683685]  sysfs_add_link_to_group+0x48/0x74
> [   78.683688]  coresight_add_sysfs_link+0xa4/0x114 [coresight]
> [   78.683705]  coresight_make_links+0x98/0xdc [coresight]
> [   78.683714]  coresight_register+0x1d4/0x3cc [coresight]
> [   78.683721]  etm4_probe+0x1e0/0x334 [coresight_etm4x]
> [   78.683729]  etm4_probe_amba+0x44/0xa0 [coresight_etm4x]
> [   78.683735]  amba_probe+0x11c/0x1b0
> [   78.683741]  really_probe+0x19c/0x3f0
> [   78.683747]  __driver_probe_device+0x11c/0x190
> [   78.683749]  driver_probe_device+0x44/0xf4
> [   78.683753]  __driver_attach+0xd8/0x1b4
> [   78.683756]  bus_for_each_dev+0x6c/0xb0
> [   78.683758]  driver_attach+0x30/0x40
> [   78.683761]  bus_add_driver+0x154/0x240
> [   78.683763]  driver_register+0x84/0x140
> [   78.683765]  amba_driver_register+0x30/0x44
> [   78.683768]  etm4x_init+0xd8/0x1000 [coresight_etm4x]
> [   78.683775]  do_one_initcall+0x40/0x220
> [   78.683778]  do_init_module+0x50/0x1f4
> [   78.683782]  load_module+0x940/0xaf0
> [   78.683783]  __do_sys_finit_module+0x9c/0xfc
> [   78.683785]  __arm64_sys_finit_module+0x2c/0x40
> [   78.683787]  invoke_syscall+0x50/0x120
> [   78.683790]  el0_svc_common.constprop.0+0xd4/0xf4
> [   78.683792]  do_el0_svc+0x38/0x4c
> [   78.683794]  el0_svc+0x34/0xd0
> [   78.683797]  el0t_64_sync_handler+0x11c/0x150
> [   78.683799]  el0t_64_sync+0x190/0x194
> [   78.725063] coresight-etm4x: probe of ARMHC500:20 failed with error -17
> 
> console log: https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/07/558044095/redhat:558044095_aarch64/tests/Boot_test/12104911_aarch64_1_test_console.log
> 
> more logs: https://datawarehouse.cki-project.org/kcidb/tests/3797753
> cki issue tracker: https://datawarehouse.cki-project.org/issue/1261
> 
> kernel config: http://s3.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/07/558044095/redhat:558044095/redhat:558044095_aarch64/.config
> 
> Thanks,
> Bruno Goncalves
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
