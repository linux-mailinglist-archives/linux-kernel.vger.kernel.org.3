Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0375A10FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242035AbiHYMpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241976AbiHYMpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:45:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350AA1FCD9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:45:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id og21so1764056ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=0/Ipanas24TFq9elVE4ZKVYDVLeZuiUqjpMUdUnA5Cg=;
        b=QiREiYlxQ4tC8mq7oYLS19gPGBazl0yuaC/0T4kEQPdukHHlmdb2m7PgK+nS6rawGY
         7lmaJzSNHerV92nbvawZ3RPsHH3GCngelTVdILUfjFXeUq4Wa/xn9fewTSFJavTpNnab
         NqAApDfcwX91Y9QyyeLZ14xMs4/SSLUnsLPtAwZ4+3QdtEt3ASMse8JaHDOMwRq30zvJ
         tD702pM93p0cCVs1cdLhImEu+6yU2aH/MjytU2y9jkZ0fAi6OtPobD4M84ROWx93Bk1l
         64Jsj//IehTWCrsP8xK+V9GY+sXMoLC3Y8i8lJAX116NUrI0IkrVQqUEIH1j3seUMirq
         hIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=0/Ipanas24TFq9elVE4ZKVYDVLeZuiUqjpMUdUnA5Cg=;
        b=MRsaLLM1hO2rpNOshawB6JzeeSDGoou7SH1hW2b5RJupId7xqUJk6NoWlQ5aLqqAXg
         943BAUZVzsBiMy1+rg9wlfr9uzhuDoTHdXt8gaORe4bsgSNTeR/hZ89NdE4f8a1IvVc3
         u95UKhnWsI9cu16sNveR2yTbJDjUSjSuchsABGm3YWSYnH2zPxqEueCvzfN8R873/NoT
         EosTMNlMARhH8h37JQYmhVSTWbeqyP5brxITdMdtMS4DKKw75XTmpWZ1z44bPiAkABTX
         T0q0KeYcwnRBGmhzSVkAUZg3DREz/jfwApMek1NS6mPkclpgBvxPfL+lYPVNhpQafz6M
         O0JA==
X-Gm-Message-State: ACgBeo2rhn3YEYVETVqR3ipzVzZG9K72y2Bjyfw+gOz5H+yAvUTEvdma
        fMnlo+8y5lH8WeOREFyDU2Xic5LIW1nkrvVi3Lcjgg==
X-Google-Smtp-Source: AA6agR5Ssp4F0q9tefCq8WkXxmB/6ZNb/kPNJZEi3oyt2Vy5aGyxzDmuvOFkP7atxqjuzy3MHAlx/T1FbsEgM0odfGI=
X-Received: by 2002:a17:907:2cd1:b0:730:a980:d593 with SMTP id
 hg17-20020a1709072cd100b00730a980d593mr2391761ejc.48.1661431504490; Thu, 25
 Aug 2022 05:45:04 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Aug 2022 18:14:53 +0530
Message-ID: <CA+G9fYsmRByWNrUwLjfeWcxRF7R32XhB9oYAB3ZBJ7Fj1iqacw@mail.gmail.com>
Subject: db845: Unable to handle kernel NULL pointer dereference at virtual
 address 0000000000000000
To:     mhi@lists.linux.dev, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <quic_hemantk@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Davey <paul.davey@alliedtelesis.co.nz>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 Qcomm Db845c device kernel crash noticed while running LTP fs test case
 - read_all_sys read_all -d /sys -q -r 3
with Linux mainline kernel  6.0.0-rc2. The LTP fs read_all_sys failed
and the system
is live and finished the rest of the test case successfully.
This is an intermittent issue.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

tst_test.c:1431: TINFO: Timeout per run is 0h 15m 00s
[ 1099.320974] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[ 1099.327370] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[ 1099.329893] Mem abort info:
[ 1099.331461] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[ 1099.331474] Mem abort info:
[ 1099.331481]   ESR = 0x0000000096000004
[ 1099.331492]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1099.331502]   SET = 0, FnV = 0
[ 1099.331510]   EA = 0, S1PTW = 0
[ 1099.331518]   FSC = 0x04: level 0 translation fault
[ 1099.331527] Data abort info:
[ 1099.331535]   ISV = 0, ISS = 0x00000004
[ 1099.331543]   CM = 0, WnR = 0
[ 1099.331552] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000103802000
[ 1099.331563] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[ 1099.331593] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[ 1099.331605] Modules linked in: nfc algif_hash snd_soc_hdmi_codec
snd_soc_wsa881x regmap_sdw gpio_wcd934x snd_soc_wcd934x soundwire_qcom
snd_soc_wcd_mbhc wcd934x regmap_slimbus venus_enc venus_dec
videobuf2_dma_contig lontium_lt9611 mcp251xfd apr can_dev fastrpc
qrtr_smd crct10dif_ce snd_soc_sdm845 snd_soc_rt5663 ath10k_snoc
hci_uart btqca snd_soc_qcom_common qcom_camss ath10k_core btbcm
snd_soc_rl6231 videobuf2_dma_sg ath v4l2_fwnode leds_qcom_lpg
rtc_pm8xxx msm venus_core led_class_multicolor qcom_spmi_temp_alarm
soundwire_bus qcom_spmi_adc5 v4l2_async v4l2_mem2mem videobuf2_memops
bluetooth qcom_vadc_common qcom_pon videobuf2_v4l2 gpu_sched
reset_qcom_pdc camcc_sdm845 mac80211 drm_dp_aux_bus videobuf2_common
gpi spi_geni_qcom drm_display_helper i2c_qcom_geni i2c_qcom_cci
qcom_rng xhci_pci qcom_q6v5_mss cfg80211 xhci_pci_renesas rfkill lmh
qrtr icc_osm_l3 qcom_q6v5_pas qcom_wdt slim_qcom_ngd_ctrl
qcom_pil_info qcom_q6v5 pdr_interface qcom_sysmon display_connector
slimbus qcom_common
[ 1099.331914]  icc_bwmon qcom_glink_smem qmi_helpers mdt_loader
drm_kms_helper drm socinfo rmtfs_mem fuse
[ 1099.331955] CPU: 1 PID: 5358 Comm: read_all Tainted: G        W
     6.0.0-rc2 #1
[ 1099.331966] Hardware name: Thundercomm Dragonboard 845c (DT)
[ 1099.331975] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1099.331984] pc : channels_show+0xdc/0x134 [soundwire_bus]
[ 1099.332061] lr : dev_attr_show+0x2c/0x70
[ 1099.332078] sp : ffff800017013bc0
[ 1099.332083] x29: ffff800017013bc0 x28: 0000000000000001 x27: 0000000000400cc0
[ 1099.332098] x26: 000000007ffff000 x25: ffff482182fce3f8 x24: ffff482182fce3e8
[ 1099.332112] x23: ffffbc7dd90a4ca0 x22: ffffbc7dd907a230 x21: 0000000000000000
[ 1099.332125] x20: ffff482182fa2000 x19: 0000000000000000 x18: 0000000000000000
[ 1099.332139] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[ 1099.332152] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[ 1099.332165] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffbc7e2903e53c
[ 1099.332178] x8 : ffff482182fa3000 x7 : 0000000000000000 x6 : 0000000000000001
[ 1099.332191] x5 : 0000000000000004 x4 : 000000000000001f x3 : 0000000000000004
[ 1099.332203] x2 : 0000000000000000 x1 : ffffbc7dd90a4ca0 x0 : ffff482182fa2000
[ 1099.332217] Call trace:
[ 1099.332221]  channels_show+0xdc/0x134 [soundwire_bus]
[ 1099.332253]  dev_attr_show+0x2c/0x70
[ 1099.332261]  sysfs_kf_seq_show+0xb8/0x130
[ 1099.332275]  kernfs_seq_show+0x3c/0x50
[ 1099.332283]  seq_read_iter+0x1c4/0x4c0
[ 1099.332300]  kernfs_fop_read_iter+0x150/0x1e0
[ 1099.332307]  vfs_read+0x204/0x2b0
[ 1099.332319]  ksys_read+0x74/0x100
[ 1099.332327]  __arm64_sys_read+0x28/0x34
[ 1099.332337]  invoke_syscall+0x50/0x120
[ 1099.332351]  el0_svc_common.constprop.0+0x68/0x124
[ 1099.332361]  do_el0_svc+0x3c/0xd0
[ 1099.332370]  el0_svc+0x30/0x94
[ 1099.332383]  el0t_64_sync_handler+0xc0/0x13c
[ 1099.332392]  el0t_64_sync+0x18c/0x190
[ 1099.332408] Code: f9401437 8b130280 f9401ec2 aa1703e1 (b875d842)
[ 1099.332417] ---[ end trace 0000000000000000 ]---
[ 1099.338735] Mem abort info:
[ 1099.338739]   ESR = 0x0000000096000004
[ 1099.341585]   ESR = 0x0000000096000004
[ 1099.350447]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1099.353294]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1099.357101]   SET = 0, FnV = 0
[ 1099.362456]   SET = 0, FnV = 0
[ 1099.365548]   EA = 0, S1PTW = 0
[ 1099.365551]   FSC = 0x04: level 0 translation fault
[ 1099.365555] Data abort info:
[ 1099.368741]   EA = 0, S1PTW = 0
[ 1099.373662]   ISV = 0, ISS = 0x00000004
[ 1099.373666]   CM = 0, WnR = 0
[ 1099.373668] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000106f53000
[ 1099.376587]   FSC = 0x04: level 0 translation fault
[ 1099.380457] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[ 1099.383476] Data abort info:
[ 1099.389977]
[ 1099.396829]   ISV = 0, ISS = 0x00000004
[ 1099.402451] Internal error: Oops: 96000004 [#2] PREEMPT SMP
[ 1099.402455] Modules linked in: nfc
[ 1099.490108]   CM = 0, WnR = 0
[ 1099.499565]  algif_hash snd_soc_hdmi_codec snd_soc_wsa881x
regmap_sdw gpio_wcd934x snd_soc_wcd934x soundwire_qcom
snd_soc_wcd_mbhc
[ 1099.507567] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000101df2000
[ 1099.513170]  wcd934x regmap_slimbus venus_enc venus_dec
videobuf2_dma_contig lontium_lt9611 mcp251xfd
[ 1099.520205] [0000000000000000] pgd=0000000000000000
[ 1099.525648]  apr can_dev fastrpc qrtr_smd crct10dif_ce snd_soc_sdm845
[ 1099.529617] , p4d=0000000000000000
[ 1099.532963]  snd_soc_rt5663 ath10k_snoc hci_uart btqca snd_soc_qcom_common
[ 1099.540163]
[ 1099.547352]  qcom_camss ath10k_core btbcm snd_soc_rl6231
videobuf2_dma_sg ath v4l2_fwnode leds_qcom_lpg rtc_pm8xxx msm
venus_core led_class_multicolor qcom_spmi_temp_alarm soundwire_bus
qcom_spmi_adc5 v4l2_async v4l2_mem2mem videobuf2_memops bluetooth
qcom_vadc_common qcom_pon videobuf2_v4l2 gpu_sched reset_qcom_pdc
camcc_sdm845 mac80211 drm_dp_aux_bus videobuf2_common gpi
spi_geni_qcom drm_display_helper i2c_qcom_geni i2c_qcom_cci qcom_rng
xhci_pci qcom_q6v5_mss cfg80211 xhci_pci_renesas rfkill lmh qrtr
icc_osm_l3 qcom_q6v5_pas qcom_wdt slim_qcom_ngd_ctrl qcom_pil_info
qcom_q6v5 pdr_interface qcom_sysmon display_connector slimbus
qcom_common icc_bwmon qcom_glink_smem qmi_helpers mdt_loader
drm_kms_helper drm socinfo rmtfs_mem fuse
[ 1099.901294] CPU: 4 PID: 5357 Comm: read_all Tainted: G      D W
     6.0.0-rc2 #1
[ 1099.909780] Hardware name: Thundercomm Dragonboard 845c (DT)
[ 1099.916074] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1099.923680] pc : channels_show+0xdc/0x134 [soundwire_bus]
[ 1099.929734] lr : dev_attr_show+0x2c/0x70
[ 1099.934291] sp : ffff80001759bbc0
[ 1099.938227] x29: ffff80001759bbc0 x28: 0000000000000001 x27: 0000000000400cc0
[ 1099.946014] x26: 000000007ffff000 x25: ffff482182ffb290 x24: ffff482182ffb280
[ 1099.953804] x23: ffffbc7dd90a4ca0 x22: ffffbc7dd907a230 x21: 0000000000000000
[ 1099.961597] x20: ffff482184c74000 x19: 0000000000000000 x18: 0000000000000000
[ 1099.969392] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[ 1099.977186] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[ 1099.984977] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffbc7e2903e53c
[ 1099.992772] x8 : ffff482184c75000 x7 : 0000000000000000 x6 : 0000000000000001
[ 1100.000564] x5 : 0000000000000004 x4 : 000000000000001f x3 : 0000000000000004
[ 1100.008357] x2 : 0000000000000000 x1 : ffffbc7dd90a4ca0 x0 : ffff482184c74000
[ 1100.016151] Call trace:
[ 1100.019198]  channels_show+0xdc/0x134 [soundwire_bus]
[ 1100.024888]  dev_attr_show+0x2c/0x70
[ 1100.029094]  sysfs_kf_seq_show+0xb8/0x130
[ 1100.033746]  kernfs_seq_show+0x3c/0x50
[ 1100.038134]  seq_read_iter+0x1c4/0x4c0
[ 1100.042519]  kernfs_fop_read_iter+0x150/0x1e0
[ 1100.047502]  vfs_read+0x204/0x2b0
[ 1100.051441]  ksys_read+0x74/0x100
[ 1100.055376]  __arm64_sys_read+0x28/0x34
[ 1100.059860]  invoke_syscall+0x50/0x120
[ 1100.064250]  el0_svc_common.constprop.0+0x68/0x124
[ 1100.069697]  do_el0_svc+0x3c/0xd0
[ 1100.073652]  el0_svc+0x30/0x94
[ 1100.077348]  el0t_64_sync_handler+0xc0/0x13c
[ 1100.082265]  el0t_64_sync+0x18c/0x190
[ 1100.086567] Code: f9401437 8b130280 f9401ec2 aa1703e1 (b875d842)
[ 1100.093312] ---[ end trace 0000000000000000 ]---
[ 1100.098577] Internal error: Oops: 96000004 [#3] PREEMPT SMP
[ 1100.104823] Modules linked in: nfc algif_hash snd_soc_hdmi_codec
snd_soc_wsa881x regmap_sdw gpio_wcd934x snd_soc_wcd934x soundwire_qcom
snd_soc_wcd_mbhc wcd934x regmap_slimbus venus_enc venus_dec
videobuf2_dma_contig lontium_lt9611 mcp251xfd apr can_dev fastrpc
qrtr_smd crct10dif_ce snd_soc_sdm845 snd_soc_rt5663 ath10k_snoc
hci_uart btqca snd_soc_qcom_common qcom_camss ath10k_core btbcm
snd_soc_rl6231 videobuf2_dma_sg ath v4l2_fwnode leds_qcom_lpg
rtc_pm8xxx msm venus_core led_class_multicolor qcom_spmi_temp_alarm
soundwire_bus qcom_spmi_adc5 v4l2_async v4l2_mem2mem videobuf2_memops
bluetooth qcom_vadc_common qcom_pon videobuf2_v4l2 gpu_sched
reset_qcom_pdc camcc_sdm845 mac80211 drm_dp_aux_bus videobuf2_common
gpi spi_geni_qcom drm_display_helper i2c_qcom_geni i2c_qcom_cci
qcom_rng xhci_pci qcom_q6v5_mss cfg80211 xhci_pci_renesas rfkill lmh
qrtr icc_osm_l3 qcom_q6v5_pas qcom_wdt slim_qcom_ngd_ctrl
qcom_pil_info qcom_q6v5 pdr_interface qcom_sysmon display_connector
slimbus qcom_common
[ 1100.104934]  icc_bwmon qcom_glink_smem qmi_helpers mdt_loader
drm_kms_helper drm socinfo rmtfs_mem fuse
[ 1100.206234] CPU: 5 PID: 5359 Comm: read_all Tainted: G      D W
     6.0.0-rc2 #1
[ 1100.214849] Hardware name: Thundercomm Dragonboard 845c (DT)
[ 1100.221306] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1100.229086] pc : channels_show+0xdc/0x134 [soundwire_bus]
[ 1100.235271] lr : dev_attr_show+0x2c/0x70
[ 1100.239990] sp : ffff8000175cbbc0
[ 1100.244090] x29: ffff8000175cbbc0 x28: 0000000000000001 x27: 0000000000400cc0
[ 1100.252040] x26: 000000007ffff000 x25: ffff48218398d470 x24: ffff48218398d460
[ 1100.259995] x23: ffffbc7dd90a4ca0 x22: ffffbc7dd907a230 x21: 0000000000000000
[ 1100.267950] x20: ffff482183932000 x19: 0000000000000000 x18: 0000000000000000
[ 1100.275908] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[ 1100.283861] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[ 1100.291808] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffbc7e2903e53c
[ 1100.299759] x8 : ffff482183933000 x7 : 0000000000000000 x6 : 0000000000000001
[ 1100.307704] x5 : 0000000000000004 x4 : 000000000000001f x3 : 0000000000000004
[ 1100.315635] x2 : 0000000000000000 x1 : ffffbc7dd90a4ca0 x0 : ffff482183932000
[ 1100.323557] Call trace:
[ 1100.326742]  channels_show+0xdc/0x134 [soundwire_bus]
[ 1100.332564]  dev_attr_show+0x2c/0x70
[ 1100.336886]  sysfs_kf_seq_show+0xb8/0x130
[ 1100.341647]  kernfs_seq_show+0x3c/0x50
[ 1100.346138]  seq_read_iter+0x1c4/0x4c0
[ 1100.350606]  kernfs_fop_read_iter+0x150/0x1e0
[ 1100.355658]  vfs_read+0x204/0x2b0
[ 1100.359642]  ksys_read+0x74/0x100
[ 1100.363599]  __arm64_sys_read+0x28/0x34
[ 1100.368071]  invoke_syscall+0x50/0x120
[ 1100.372450]  el0_svc_common.constprop.0+0x68/0x124
[ 1100.377879]  do_el0_svc+0x3c/0xd0
[ 1100.381814]  el0_svc+0x30/0x94
[ 1100.385487]  el0t_64_sync_handler+0xc0/0x13c
[ 1100.390385]  el0t_64_sync+0x18c/0x190
[ 1100.394662] Code: f9401437 8b130280 f9401ec2 aa1703e1 (b875d842)
[ 1100.401390] ---[ end trace 0000000000000000 ]---
Test timeouted, sending SIGKILL!
tst_test.c:1478: TINFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1480: TBROK: Test killed! (timeout?)

ref:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.0-rc2-54-gc40e8341e3b3/testrun/11557426/suite/log-parser-test/tests/

metadata:
  artifact-location: https://builds.tuxbuild.com/2Dmj8axHFHLJ7YdTYjhOEGppduR
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/621141375
  git_describe: v6.0-rc2-54-gc40e8341e3b3
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  kernel-config: https://builds.tuxbuild.com/2Dmj8axHFHLJ7YdTYjhOEGppduR/config
  System.map: https://builds.tuxbuild.com/2Dmj8axHFHLJ7YdTYjhOEGppduR/System.map
  vmlinux.xz: https://builds.tuxbuild.com/2Dmj8axHFHLJ7YdTYjhOEGppduR/vmlinux.xz
  kernel_version: 6.0.0-rc2
  ltp-fs-tests:
  toolchain: gcc-11

--
Linaro LKFT
https://lkft.linaro.org
