Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84654544746
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiFIJWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiFIJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B56F31F2ED
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654766556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CSAxAc/PUgTVCO/1S5Oh6/CQmuDfmZp7OzcrBw/CgNc=;
        b=CSYx5d1lcqmcYFZdiIv8WW7ZrRvsOlmm0dU8BW8QVl4zMylwRUduTKk+Olo2Gg9PhxKrc0
        KGCTPdLFSaFoWwisHnjj1B3NFyjIDTCPp9xg15Pl8giSAn99EfylVin0Cuft1wnMb+jb3w
        7uHrX5AnmEWcciwQknl86f2wKGXzmHA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-gv_aQl05On-znxzSbA3O4Q-1; Thu, 09 Jun 2022 05:22:34 -0400
X-MC-Unique: gv_aQl05On-znxzSbA3O4Q-1
Received: by mail-lf1-f72.google.com with SMTP id b2-20020a0565120b8200b00477a4532448so11420500lfv.22
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSAxAc/PUgTVCO/1S5Oh6/CQmuDfmZp7OzcrBw/CgNc=;
        b=ALzZIaJY1VYjCpbAsi4xdrMkI9Axq6YFmCO2K9V24iJePP3bHCVLUE6SMS0d8hY7NP
         9Zwu+RT2qwfxaqj2bnk53Tp4DU+ZqGs4pnuP9NYGrdPbVkd93mtpHHemUvjb3y9473YD
         s6sMms7PNaEUIEz1Otgi/7JLJtmewFrVHKJdPRb1gg8GzcAzWK7W0UtM2btu3dutjRkI
         hVeWJjf51XaXUr6Ew3FPfZFbCq0ina+LCJrj7fDEa4O9mKracCYV3ooRvEvo1if+B7Sx
         36SpP0EXs9hQncXlxZXuLft/FpxJjy9VD3Gc2QKSMPzQ4tHgliC1RdzT4cR8E2ROA/eE
         1KEQ==
X-Gm-Message-State: AOAM530TLi9amleo6OQodPv48yTgVutFney6Eg8JEseTcKBRGDNpRxvT
        jew2PCpvGQnUEIF1/eUslOJQv11fsDry4x6Uja5+p5PfA7upGXHtUwowYFIll/+KG5T9GQD+Jbo
        LFhte3wjW/3KhjcNpXKrKpl6vnLtbYIyoZblijiGn
X-Received: by 2002:a05:6512:1327:b0:478:e9b2:731d with SMTP id x39-20020a056512132700b00478e9b2731dmr34008160lfu.633.1654766553137;
        Thu, 09 Jun 2022 02:22:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYY5RfFzMQ+dIUaxSV2Hbei0RKanUmrhVB0W3bS4OZlHX25xVpTXe2jHjMcIVjh2nvWRqZNmPBMLA0lwbdw04=
X-Received: by 2002:a05:6512:1327:b0:478:e9b2:731d with SMTP id
 x39-20020a056512132700b00478e9b2731dmr34008151lfu.633.1654766552912; Thu, 09
 Jun 2022 02:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4ogiTa1V20aqxFqBrMH0z927YNNN2O=CKma+=M_8E81iQ@mail.gmail.com>
 <20220608155512.GA951633@p14s> <f1ffab82-b95b-c6c5-23c2-b35050ab8863@arm.com>
In-Reply-To: <f1ffab82-b95b-c6c5-23c2-b35050ab8863@arm.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Thu, 9 Jun 2022 11:22:21 +0200
Message-ID: <CA+QYu4qTTN=s=iC9Cx0woEghbzRnqkKpguZmW5qsg_6wRybnvQ@mail.gmail.com>
Subject: Re: [aarch64] [coresight_etm4x] [kernel 5.19.0-rc1] coresight-etm4x:
 probe of ARMHC500:20 failed with error -17
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        CKI Project <cki-project@redhat.com>,
        coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 at 09:46, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Bruno
>
> On 08/06/2022 16:55, Mathieu Poirier wrote:
> > CC'ing the coresight mailing list and maintainers.
> >
> > On Wed, Jun 08, 2022 at 03:20:12PM +0200, Bruno Goncalves wrote:
> >> Hello,
> >>
> >> We recently started to hit this call trace when loading the
> >> coresight-etm4x module.
> >>
> >> [   78.683475] coresight etm103: CPU103: etm v4.1 initialized
> >> [   78.683645] sysfs: cannot create duplicate filename
> >> '/devices/system/container/ACPI0004:00/ARMHC9FE:00/funnel0/connections/in:0'
> >> [   78.683650] CPU: 17 PID: 2522 Comm: systemd-udevd Not tainted 5.19.0-rc1 #1
> >> [   78.683653] Hardware name: HPE Apollo 70             /C01_APACHE_MB
> >>          , BIOS L50_5.13_1.16 07/29/2020
> >> [   78.683655] Call trace:
>
> Please could you confirm that there are no duplicate entries for the
> Graph connection for funnel0 (ARMHC9FE:00) input port 0 ?
>
> This looks like an issue in the ACPI table. The failing ETM
> ACPI table describes the output port connection to the funnel0 inport 0
> which I believe is connected to a different ETM that has been already
> probed. Does the system boot fine with the warning ? If yes,
> please could you check the existing link for "funnel0, in:0" ?

Correct, it seems in this case it was already probed by etm0.

# ls -allh /sys//devices/system/container/ACPI0004:00/ARMHC9FE:00/funnel0/connections/in:0
lrwxrwxrwx. 1 root root 0 Jun  9 05:10
/sys//devices/system/container/ACPI0004:00/ARMHC9FE:00/funnel0/connections/in:0
-> ../../../../../cpu/cpu0/ARMHC500:00/etm0

Bruno
>
>
> Suzuki
>
> >> [   78.683657]  dump_backtrace+0xc4/0x130
> >> [   78.683665]  show_stack+0x24/0x70
> >> [   78.683668]  dump_stack_lvl+0x64/0x80
> >> [   78.683673]  dump_stack+0x18/0x34
> >> [   78.683676]  sysfs_warn_dup+0x70/0x90
> >> [   78.683681]  sysfs_do_create_link_sd+0x13c/0x144
> >> [   78.683683]  sysfs_create_link_sd+0x20/0x30
> >> [   78.683685]  sysfs_add_link_to_group+0x48/0x74
> >> [   78.683688]  coresight_add_sysfs_link+0xa4/0x114 [coresight]
> >> [   78.683705]  coresight_make_links+0x98/0xdc [coresight]
> >> [   78.683714]  coresight_register+0x1d4/0x3cc [coresight]
> >> [   78.683721]  etm4_probe+0x1e0/0x334 [coresight_etm4x]
> >> [   78.683729]  etm4_probe_amba+0x44/0xa0 [coresight_etm4x]
> >> [   78.683735]  amba_probe+0x11c/0x1b0
> >> [   78.683741]  really_probe+0x19c/0x3f0
> >> [   78.683747]  __driver_probe_device+0x11c/0x190
> >> [   78.683749]  driver_probe_device+0x44/0xf4
> >> [   78.683753]  __driver_attach+0xd8/0x1b4
> >> [   78.683756]  bus_for_each_dev+0x6c/0xb0
> >> [   78.683758]  driver_attach+0x30/0x40
> >> [   78.683761]  bus_add_driver+0x154/0x240
> >> [   78.683763]  driver_register+0x84/0x140
> >> [   78.683765]  amba_driver_register+0x30/0x44
> >> [   78.683768]  etm4x_init+0xd8/0x1000 [coresight_etm4x]
> >> [   78.683775]  do_one_initcall+0x40/0x220
> >> [   78.683778]  do_init_module+0x50/0x1f4
> >> [   78.683782]  load_module+0x940/0xaf0
> >> [   78.683783]  __do_sys_finit_module+0x9c/0xfc
> >> [   78.683785]  __arm64_sys_finit_module+0x2c/0x40
> >> [   78.683787]  invoke_syscall+0x50/0x120
> >> [   78.683790]  el0_svc_common.constprop.0+0xd4/0xf4
> >> [   78.683792]  do_el0_svc+0x38/0x4c
> >> [   78.683794]  el0_svc+0x34/0xd0
> >> [   78.683797]  el0t_64_sync_handler+0x11c/0x150
> >> [   78.683799]  el0t_64_sync+0x190/0x194
> >> [   78.725063] coresight-etm4x: probe of ARMHC500:20 failed with error -17
> >>
> >> console log: https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/07/558044095/redhat:558044095_aarch64/tests/Boot_test/12104911_aarch64_1_test_console.log
> >>
> >> more logs: https://datawarehouse.cki-project.org/kcidb/tests/3797753
> >> cki issue tracker: https://datawarehouse.cki-project.org/issue/1261
> >>
> >> kernel config: http://s3.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/07/558044095/redhat:558044095/redhat:558044095_aarch64/.config
> >>
> >> Thanks,
> >> Bruno Goncalves
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

