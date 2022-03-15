Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0F24D92B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbiCOCpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242228AbiCOCpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:45:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF61C93B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:44:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u2so163603ple.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tbq0DatDy1Kwpjy5ISodyc3++rb89o9Ra/9aIJPVmqs=;
        b=N438C6Wdi1bFL83NHj/RnpueNryxiARWzH6JW2a4+tExGrlt/zohiZevhpfKOY59vO
         nT6P8+anQZI0M2T5FOPEhFLxhZnrI85DfTwGrG/F5D+CLsD/eMWq1Hi/uURZRoFCJu9E
         OBzjREQ27by+/gCWvaMPfO4jUGl4xdYPwMD5OzpLaXc9RKxNZP5XotceumLYUwQsUZkX
         5QOGoWoJ85wgcvdy23XYAIzX7Yyc331jouFqTlkBufwo9Me25/kOZdt/uqOOLr6t+tAH
         RuFNpSV4ExpYYw8zBA2NkeGFFEbsUFchpLfVAxqKSr+g3ypR41pZ6kc+YXHyKuJxy+xl
         gGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tbq0DatDy1Kwpjy5ISodyc3++rb89o9Ra/9aIJPVmqs=;
        b=gBpztM0yJtyY89M1kbIeSmqPIwioMnB2+baszdoB6e7t1IiGfrwbftW+jfDYanLvAS
         6Y8zGh6BLbkaigQ0Y/aIeAcH4U0ak5RJA/taN86Ar9GnJkwn+VrZpFoN3z13Jrjp+OuF
         7u52fDf/HPd8pMNxfmfipIgqd1sYURQLP79e+33//0uhaHWXGLRJjnuKi3jlVXBIxi6M
         SeQxA8XCp9eaakMGR885tMJKHbijJcau4IvFsEBmNyUi/BeHJcKhiO87Bjd6hR7PRKeh
         QpxnixOIa9mUJvPZfFZNqG1X5Qrb2mt8dZeJ3R3lqv7IAeYrjzsm487DKBzVK4j8Arzz
         ZFiA==
X-Gm-Message-State: AOAM533YHA+xlSdrx9sGDkqeKZuA9zhsc5QSjTBVvmGZTgEl6aYYsYGD
        bULJl5dT2OtzURlTZfdrnwzeTQ==
X-Google-Smtp-Source: ABdhPJwsipELBsmyC8zsErRVkuW+LXfEM+ekQjfZGc5ALoD0ofvL1ErWtB73y5/UQpXb8hgf9qmScw==
X-Received: by 2002:a17:903:4083:b0:153:4103:542d with SMTP id z3-20020a170903408300b001534103542dmr16378622plc.160.1647312280680;
        Mon, 14 Mar 2022 19:44:40 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id h2-20020a056a00218200b004f66d50f054sm21925946pfi.158.2022.03.14.19.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 19:44:40 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:14:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: arm64: db845c: cpuhotplug: WARNING: CPU: 3 PID: 26 at
 kernel/irq/manage.c:1887 free_irq+0x348/0x370
Message-ID: <20220315024436.fawk4gor6amuicfk@vireshk-i7>
References: <CA+G9fYtZ0vJaiA2sD+UuUiqAuZ+Yh88YNqgjTU7R9cwsvRcHTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtZ0vJaiA2sD+UuUiqAuZ+Yh88YNqgjTU7R9cwsvRcHTQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Bjorn.

On 14-03-22, 19:07, Naresh Kamboju wrote:
> [ please ignore this email if it is already reported ]
> 
> While running LTP cpuhotplug04 tests on linux mainline 5.17.0-rc8 on the
> arm64 db845c device the following kernel warning was noticed [1] & [2].
> This is not a regression but this warning was noticed for a while.
> 
> /opt/ltp/testcases/bin/cpuhotplug03.sh: line 40:   929 Killed
>         cpuhotplug_do_spin_loop > /dev/null 2>&1
> cpuhotplug03 1 TPASS: 1 cpuhotplug_do_spin_loop processes found on CPU1
> Name:   cpuhotplug04
> Date:   Thu Jan  1 00:00:43 UTC 1970
> Desc:   Does it prevent us from offlining the last CPU?
> 
> [   34.409899] psci: CPU0 killed (polled 0 ms)
> [   34.589257] psci: CPU1 killed (polled 0 ms)
> [   34.748788] migrate_one_irq: 30 callbacks suppressed
> [   34.748834] IRQ169: set affinity failed(-22).
> [   34.748867] IRQ171: set affinity failed(-22).
> [   34.748911] IRQ183: set affinity failed(-22).
> [   34.748929] IRQ184: set affinity failed(-22).
> [   34.748945] IRQ185: set affinity failed(-22).
> [   34.748964] IRQ186: set affinity failed(-22).
> [   34.748981] IRQ187: set affinity failed(-22).
> [   34.748999] IRQ188: set affinity failed(-22).
> [   34.749014] IRQ189: set affinity failed(-22).
> [   34.749031] IRQ190: set affinity failed(-22).
> [   34.757748] psci: CPU2 killed (polled 0 ms)
> [   34.973881] ------------[ cut here ]------------
> [   34.978667] WARNING: CPU: 3 PID: 26 at kernel/irq/manage.c:1887
> free_irq+0x348/0x370
> [   34.986579] Modules linked in: snd_soc_hdmi_codec venus_dec
> venus_enc lontium_lt9611 videobuf2_dma_contig qcom_spmi_adc5
> qcom_spmi_temp_alarm qcom_pon rtc_pm8xxx qcom_vadc_common qcom_camss
> snd_soc_sdm845 crct10dif_ce videobuf2_dma_sg snd_soc_rt5663
> snd_soc_qcom_common v4l2_fwnode hci_uart venus_core snd_soc_rl6231
> v4l2_async btqca soundwire_bus v4l2_mem2mem btbcm i2c_qcom_geni
> videobuf2_memops bluetooth msm camcc_sdm845 videobuf2_v4l2
> reset_qcom_pdc i2c_qcom_cci videobuf2_common gpu_sched spi_geni_qcom
> qcom_rng qcom_q6v5_mss ath10k_snoc ath10k_core ath xhci_pci mac80211
> xhci_pci_renesas qrtr display_connector slim_qcom_ngd_ctrl cfg80211
> qcom_wdt rfkill qcom_q6v5_pas pdr_interface qcom_pil_info qcom_q6v5
> icc_osm_l3 lmh slimbus qcom_sysmon drm_kms_helper qcom_common
> qcom_glink_smem qmi_helpers mdt_loader socinfo drm rmtfs_mem fuse
> [   35.061476] CPU: 3 PID: 26 Comm: cpuhp/3 Not tainted 5.17.0-rc8 #1
> [   35.067760] Hardware name: Thundercomm Dragonboard 845c (DT)
> [   35.073506] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   35.080582] pc : free_irq+0x348/0x370
> [   35.084328] lr : free_irq+0x300/0x370
> [   35.088073] sp : ffff800008263c90
> [   35.091457] x29: ffff800008263c90 x28: 0000000000000003 x27: ffff65e489bac000
> [   35.098720] x26: 0000000000000000 x25: ffff287f41e51edc x24: ffff287f41e51f90
> [   35.105981] x23: 0000000000000000 x22: 00000000000000ad x21: ffff287f40d06b00
> [   35.113242] x20: ffff287f41e51e00 x19: ffff287f42bc7300 x18: ffffc29b34722b00
> [   35.120504] x17: ffffc29b34722b18 x16: ffffc29b31d22ca4 x15: 0000000000050088
> [   35.127762] x14: 0000000000000010 x13: ffff287f41fbd958 x12: 0005008800000000
> [   35.135019] x11: 0000000000000040 x10: ffffc29b34401eb8 x9 : ffffc29b32ebc62c
> [   35.142278] x8 : ffff287f40400270 x7 : 0000000000000000 x6 : 0000000000000000
> [   35.149535] x5 : ffff287f40400248 x4 : ffff287f40400378 x3 : 0000000000000000
> [   35.156796] x2 : 0000000002030200 x1 : ffff287f41e51e00 x0 : ffff287f42a57000
> [   35.164056] Call trace:
> [   35.166558]  free_irq+0x348/0x370
> [   35.169955]  qcom_cpufreq_hw_cpu_exit+0x80/0xd0
> [   35.174584]  cpufreq_offline.isra.0+0x26c/0x2b0
> [   35.179202]  cpuhp_cpufreq_offline+0x1c/0x30
> [   35.183561]  cpuhp_invoke_callback+0x16c/0x5b0
> [   35.188094]  cpuhp_thread_fun+0xd0/0x1c4
> [   35.192090]  smpboot_thread_fn+0x1ec/0x220
> [   35.196287]  kthread+0x100/0x110
> [   35.199607]  ret_from_fork+0x10/0x20
> [   35.203273] ---[ end trace 0000000000000000 ]---
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> metadata:
>   git_describe: v5.17-rc8
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
>   git_sha: 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
>   kernel-config: https://builds.tuxbuild.com/26LbWSfZlShbqStTOvXGslR1RBI/config
>   build: https://builds.tuxbuild.com/26LbWSfZlShbqStTOvXGslR1RBI/
> 
> 
> steps to reproduce:
>   # cd /opt/ltp
>   # ./runltp -s cpuhotplug04
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 
> [1] https://lkft.validation.linaro.org/scheduler/job/4715107#L4147
> [2] https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.17-rc8/testrun/8446603/suite/linux-log-parser/test/check-kernel-warning-4715107/log

-- 
viresh
