Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A017146815F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383810AbhLDAnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354411AbhLDAnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:43:18 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBBFC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 16:39:53 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bj13so9065256oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 16:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6CTGWOJj33TbulfanFz3rqoqcXrsGW03hcSOMWhm314=;
        b=FDXgLoedqqqlHKiundq7+LUsj5n6C2jNRFvwHiQ+BWnO/HGra5MEmej1Op+sNWpYkb
         QJ7SbRSQ17+Ywx7KW+uIBJY4XCoUWXjtqUc9po7+VB4Y8pCKVpOBzOReH4FIdFsChUeU
         hjVPTRF/dxykhzfSa/3ujFIARnFh32H1z6jkUCbz1vpgpfzvK14jxOQwpcJposrPcPzx
         S46FYZhdV5ESq88Iy3ZbOL7vnoo7vtjUe8phPA2/UbIp3Xt2bqg7iihn8H7PmCKrkJMY
         Wydwf6tS46lYPHgEPXGFMu+aRKA2Fbw1jCpzCzBnwElv6W8sKEtFZEXlrybHYR+7oY6j
         M1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6CTGWOJj33TbulfanFz3rqoqcXrsGW03hcSOMWhm314=;
        b=2wudnZX7dCi/Q99+A99UuNBc0mJB3z5sgixPSuAcfPV+R/PA9+A5jihPdfWiMhtQyx
         PH2l5wsQzmwjQ4Gx8mOlU8XVWfcbw2K/F9VdBGPaijSPso+HCuF40DLbngkEN+WpiykN
         5FXhhM4YD3IzKcLSN/ETIZerCKcHmpH6Kdht9end7vWT2Jq1oDSDZmF3QI0O7tEN3B5u
         0T9UqWmI4dh+PW7R4534N33h+HzvmFC4qKqPBraFGsbJQU/143arRuRJif9VOiwfG8DM
         cmFgC/RtWaDlX9SLWdPaU0OsrFZfI71e08c66bJU4Yxz+htTadMPyHR3N5QCTMcKHKqe
         RZYA==
X-Gm-Message-State: AOAM530UgCnJk7X1LJ46lzMnRjlxWoiyOxbUYKPI9tQEdZAkR9KnQgHF
        Pp5/vPsWik8U5jkziqI7yY+ViA==
X-Google-Smtp-Source: ABdhPJwSLwNd3ieqEdRIjGzhp0qxGW1x6Z9p7l/jWYwmHL510J79atRWdIOHK3VrfGzaBBlh9bCkpQ==
X-Received: by 2002:a05:6808:1381:: with SMTP id c1mr12347552oiw.129.1638578392617;
        Fri, 03 Dec 2021 16:39:52 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id s26sm1048794oiw.19.2021.12.03.16.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 16:39:52 -0800 (PST)
Message-ID: <9f9ad753-a97c-b11c-4b8b-5ddad0508e0e@kali.org>
Date:   Fri, 3 Dec 2021 18:39:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] clk: qcom: rcg2: Cache rate changes for parked RCGs
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <20211203035601.3505780-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/2/21 9:56 PM, Bjorn Andersson wrote:
> As GDSCs are turned on and off some associated clocks are momentarily
> enabled for house keeping purposes. Failure to enable these clocks seems
> to have been silently ignored in the past, but starting in SM8350 this
> failure will prevent the GDSC to turn on.
>
> At least on SM8350 this operation will enable the RCG per the
> configuration in CFG_REG. This means that the current model where the
> current configuration is written back to CF_REG immediately after
> parking the RCG doesn't work.
>
> Instead, keep track of the currently requested rate of the clock and
> upon enabling the clock reapply the configuration per the saved rate.
>
> Fixes: 7ef6f11887bd ("clk: qcom: Configure the RCGs to a safe source as needed")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/clk/qcom/clk-rcg.h  |  2 ++
>   drivers/clk/qcom/clk-rcg2.c | 32 +++++++++++++++++---------------
>   2 files changed, 19 insertions(+), 15 deletions(-)
>
> <snip patch>

With this applied, I'm getting

[   28.404134] ------------[ cut here ]------------
[   28.404448] video_cc_venus_clk_src: rcg didn't update its configuration.
[   28.405500] WARNING: CPU: 7 PID: 372 at 
drivers/clk/qcom/clk-rcg2.c:122 update_config+0xd0/0xe0
[   28.405999] Modules linked in: snd_timer(+) snd hci_uart(+) soundcore 
btqca btrtl venus_core(+) btbcm v4l2_mem2mem videobuf2_v4l2 btintel 
bluetooth videobuf2_common videodev mc ecdh_generic hid_multitouch(+) 
ecc ath10k_snoc ath10k_core qcom_rng ath mac80211 qcom_q6v5_mss libarc4 
cfg80211 rfkill sg qcom_wdt qcom_q6v5_pas evdev slim_qcom_ngd_ctrl qrtr 
qcom_pil_info pdr_interface qcom_q6v5 slimbus qcom_sysmon rmtfs_mem 
tcp_bbr sch_fq fuse configfs ip_tables x_tables autofs4 ext4 mbcache 
jbd2 panel_simple rtc_pm8xxx msm llcc_qcom ocmem ti_sn65dsi86 
drm_dp_aux_bus gpu_sched drm_kms_helper drm camcc_sdm845 ipa qcom_common 
qmi_helpers mdt_loader gpio_keys pwm_bl
[   28.407149] CPU: 7 PID: 372 Comm: systemd-udevd Not tainted 5.15.6 #45
[   28.407175] Hardware name: LENOVO 81JL/LNVNB161216, BIOS 
9UCN33WW(V2.06) 06/ 4/2019
[   28.407212] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   28.407243] pc : update_config+0xd0/0xe0
[   28.407261] lr : update_config+0xd0/0xe0
[   28.407265] sp : ffff800010833620
[   28.407268] x29: ffff800010833620 x28: ffffd0c345fa7000 x27: 
ffffd0c345fa7a80
[   28.407274] x26: ffff2ed90222e100 x25: 0000000005f5e100 x24: 
0000000000000000
[   28.407288] x23: ffffd0c2fdc80cd0 x22: ffff2ed9092480c8 x21: 
ffffd0c345852bb0
[   28.407293] x20: ffffd0c34615a9d0 x19: 0000000000000000 x18: 
ffffd0c346209900
[   28.407305] x17: ffffd0c346209918 x16: ffffd0c344f7c4d0 x15: 
00000000000500a8
[   28.407309] x14: 0000000000000000 x13: 2e6e6f6974617275 x12: 
6769666e6f632073
[   28.407314] x11: ffffffffffff56a0 x10: ffffffffffff5658 x9 : 
ffffd0c34499b66c
[   28.407329] x8 : 00000000ffffefff x7 : ffffd0c34602b0a8 x6 : 
0000000000017ce0
[   28.407333] x5 : ffff2eda737e5a48 x4 : ffff800010833460 x3 : 
0000000000000001
[   28.407338] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff2ed90aa6e740
[   28.407378] Call trace:
[   28.407425]  update_config+0xd0/0xe0
[   28.407429]  clk_rcg2_shared_enable+0x74/0xb4
[   28.407471]  clk_core_enable+0x78/0x220
[   28.407536]  clk_core_enable+0x58/0x220
[   28.407540]  clk_enable+0x38/0x60
[   28.407544]  core_clks_enable+0xd8/0x160 [venus_core]
[   28.408358]  core_power_v4+0xe0/0x150 [venus_core]
[   28.408419]  venus_runtime_resume+0x70/0x90 [venus_core]
[   28.408451]  pm_generic_runtime_resume+0x38/0x50
[   28.408538]  __rpm_callback+0x50/0x1b0
[   28.408570]  rpm_callback+0x74/0x80
[   28.408588]  rpm_resume+0x618/0x8b0
[   28.408595]  __pm_runtime_resume+0x4c/0xa4
[   28.408599]  venus_probe+0x2f8/0x4d0 [venus_core]
[   28.408616]  platform_probe+0x74/0xf0
[   28.408693]  really_probe+0xc4/0x470
[   28.408722]  __driver_probe_device+0x11c/0x190
[   28.408729]  driver_probe_device+0x48/0x110
[   28.408734]  __driver_attach+0xd8/0x1f0
[   28.408738]  bus_for_each_dev+0x7c/0xe0
[   28.408814]  driver_attach+0x30/0x40
[   28.408816]  bus_add_driver+0x154/0x250
[   28.408820]  driver_register+0x84/0x140
[   28.408823]  __platform_driver_register+0x34/0x40
[   28.408841]  qcom_venus_driver_init+0x30/0x1000 [venus_core]
[   28.408857]  do_one_initcall+0x50/0x240
[   28.408955]  do_init_module+0x60/0x270
[   28.409106]  load_module+0x2050/0x2460
[   28.409109]  __do_sys_finit_module+0xa8/0x114
[   28.409130]  __arm64_sys_finit_module+0x2c/0x3c
[   28.409139]  invoke_syscall+0x50/0x120
[   28.409272]  el0_svc_common.constprop.0+0xdc/0x100
[   28.409295]  do_el0_svc+0x34/0xa0
[   28.409307]  el0_svc+0x28/0x80
[   28.409426]  el0t_64_sync_handler+0xa4/0x130
[   28.409430]  el0t_64_sync+0x1a0/0x1a4
[   28.409453] ---[ end trace f08b1f47ee3d43ed ]---


And a blank screen - it seems similar to the "blue" screen that I see 
every few reboots, however this time, closing the lid and letting it 
suspend and then waking back up by opening it up - during the suspend, 
we get:

[  141.357919] ldo1: Underflow of regulator enable count
[  141.357940] Failed to disable vdds: -EINVAL
[  141.606278] ------------[ cut here ]------------
[  141.606368] disp_cc_mdss_ahb_clk already disabled
[  141.607229] WARNING: CPU: 3 PID: 1277 at drivers/clk/clk.c:952 
clk_core_disable+0x1dc/0x1f4
[  141.607470] Modules linked in: rfcomm xt_conntrack aes_ce_ccm 
nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter 
snd_seq_dummy snd_hrtimer snd_seq snd_seq_device xt_addrtype nft_compat 
nf_tables libcrc32c nfnetlink br_netfilter bridge stp llc overlay 
q6asm_dai snd_soc_wsa881x regmap_sdw q6routing q6afe_dai soundwire_qcom 
snd_soc_wcd934x gpio_wcd934x q6adm snd_soc_wcd_mbhc cpufreq_ondemand 
cpufreq_conservative q6asm q6dsp_common cpufreq_powersave q6afe 
algif_hash algif_skcipher q6core af_alg bnep cpufreq_userspace lz4 
lz4_compress wcd934x regmap_slimbus zram zsmalloc apr qrtr_smd fastrpc 
binfmt_misc snd_soc_sdm845 nls_ascii uvcvideo nls_cp437 
videobuf2_vmalloc snd_soc_rt5663 vfat videobuf2_memops fat 
snd_soc_qcom_common snd_soc_rl6231 aes_ce_blk soundwire_bus crypto_simd 
cryptd aes_ce_cipher pm8941_pwrkey snd_soc_core snd_compress 
crct10dif_ce ghash_ce gf128mul snd_pcm_dmaengine sha2_ce sha256_arm64
[  141.608446]  qcom_spmi_adc5 snd_pcm sha1_ce qcom_vadc_common 
qcom_spmi_temp_alarm joydev industrialio snd_timer snd hci_uart 
soundcore btqca btrtl venus_core btbcm v4l2_mem2mem videobuf2_v4l2 
btintel bluetooth videobuf2_common videodev mc ecdh_generic 
hid_multitouch ecc ath10k_snoc ath10k_core qcom_rng ath mac80211 
qcom_q6v5_mss libarc4 cfg80211 rfkill sg qcom_wdt qcom_q6v5_pas evdev 
slim_qcom_ngd_ctrl qrtr qcom_pil_info pdr_interface qcom_q6v5 slimbus 
qcom_sysmon rmtfs_mem tcp_bbr sch_fq fuse configfs ip_tables x_tables 
autofs4 ext4 mbcache jbd2 panel_simple rtc_pm8xxx msm llcc_qcom ocmem 
ti_sn65dsi86 drm_dp_aux_bus gpu_sched drm_kms_helper drm camcc_sdm845 
ipa qcom_common qmi_helpers mdt_loader gpio_keys pwm_bl
[  141.609150] CPU: 3 PID: 1277 Comm: systemd-sleep Tainted: G        
W         5.15.6 #45
[  141.609184] Hardware name: LENOVO 81JL/LNVNB161216, BIOS 
9UCN33WW(V2.06) 06/ 4/2019
[  141.609204] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[  141.609236] pc : clk_core_disable+0x1dc/0x1f4
[  141.609265] lr : clk_core_disable+0x1dc/0x1f4
[  141.609292] sp : ffff800017c63940
[  141.609303] x29: ffff800017c63940 x28: ffff2ed900fb8118 x27: 
ffffd0c3450bbe20
[  141.609348] x26: 0000000000000002 x25: 0000000000000000 x24: 
ffff2ed90bf23200
[  141.609388] x23: ffffd0c3461a1590 x22: 0000000000000001 x21: 
ffff2ed90c90dd00
[  141.609427] x20: ffff2ed909bccf00 x19: ffff2ed909bccf00 x18: 
0000000000000000
[  141.609466] x17: 000000040044ffff x16: ffffd0c344f7c154 x15: 
0000000000000000
[  141.609505] x14: ffff2ed900296740 x13: 0a64656c62617369 x12: 
642079646165726c
[  141.609545] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 
ffffd0c34499b66c
[  141.609584] x8 : 00000000ffffffff x7 : 656c626173696420 x6 : 
00000000fffff633
[  141.609622] x5 : ffff2eda73771a48 x4 : ffff800017c63780 x3 : 
0000000000000001
[  141.609659] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff2ed920b70000
[  141.609700] Call trace:
[  141.609714]  clk_core_disable+0x1dc/0x1f4
[  141.609745]  clk_disable+0x3c/0x5c
[  141.609773]  msm_dsi_runtime_suspend+0x68/0x90 [msm]
[  141.610617]  pm_generic_runtime_suspend+0x38/0x50
[  141.610696]  genpd_runtime_suspend+0xb4/0x314
[  141.610761]  pm_runtime_force_suspend+0x54/0x140
[  141.610794]  dpm_run_callback+0x60/0x180
[  141.610816]  __device_suspend+0x120/0x5a0
[  141.610839]  dpm_suspend+0x158/0x2c0
[  141.610863]  dpm_suspend_start+0xa8/0xb0
[  141.610886]  suspend_devices_and_enter+0x100/0x810
[  141.610960]  pm_suspend+0x38c/0x480
[  141.610982]  state_store+0x98/0x11c
[  141.611005]  kobj_attr_store+0x1c/0x30
[  141.611063]  sysfs_kf_write+0x50/0x60
[  141.611089]  kernfs_fop_write_iter+0x134/0x1c4
[  141.611140]  new_sync_write+0xf0/0x18c
[  141.611192]  vfs_write+0x210/0x2b0
[  141.611220]  ksys_write+0x74/0x100
[  141.611246]  __arm64_sys_write+0x28/0x3c
[  141.611275]  invoke_syscall+0x50/0x120
[  141.611339]  el0_svc_common.constprop.0+0x4c/0x100
[  141.611368]  do_el0_svc+0x34/0xa0
[  141.611393]  el0_svc+0x28/0x80
[  141.611431]  el0t_64_sync_handler+0xa4/0x130
[  141.611455]  el0t_64_sync+0x1a0/0x1a4
[  141.611483] ---[ end trace f08b1f47ee3d43ee ]---
[  141.611653] ------------[ cut here ]------------
[  141.611664] disp_cc_mdss_ahb_clk already unprepared
[  141.611831] WARNING: CPU: 3 PID: 1277 at drivers/clk/clk.c:810 
clk_core_unprepare+0x1a0/0x1c0
[  141.611880] Modules linked in: rfcomm xt_conntrack aes_ce_ccm 
nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter 
snd_seq_dummy snd_hrtimer snd_seq snd_seq_device xt_addrtype nft_compat 
nf_tables libcrc32c nfnetlink br_netfilter bridge stp llc overlay 
q6asm_dai snd_soc_wsa881x regmap_sdw q6routing q6afe_dai soundwire_qcom 
snd_soc_wcd934x gpio_wcd934x q6adm snd_soc_wcd_mbhc cpufreq_ondemand 
cpufreq_conservative q6asm q6dsp_common cpufreq_powersave q6afe 
algif_hash algif_skcipher q6core af_alg bnep cpufreq_userspace lz4 
lz4_compress wcd934x regmap_slimbus zram zsmalloc apr qrtr_smd fastrpc 
binfmt_misc snd_soc_sdm845 nls_ascii uvcvideo nls_cp437 
videobuf2_vmalloc snd_soc_rt5663 vfat videobuf2_memops fat 
snd_soc_qcom_common snd_soc_rl6231 aes_ce_blk soundwire_bus crypto_simd 
cryptd aes_ce_cipher pm8941_pwrkey snd_soc_core snd_compress 
crct10dif_ce ghash_ce gf128mul snd_pcm_dmaengine sha2_ce sha256_arm64
[  141.612553]  qcom_spmi_adc5 snd_pcm sha1_ce qcom_vadc_common 
qcom_spmi_temp_alarm joydev industrialio snd_timer snd hci_uart 
soundcore btqca btrtl venus_core btbcm v4l2_mem2mem videobuf2_v4l2 
btintel bluetooth videobuf2_common videodev mc ecdh_generic 
hid_multitouch ecc ath10k_snoc ath10k_core qcom_rng ath mac80211 
qcom_q6v5_mss libarc4 cfg80211 rfkill sg qcom_wdt qcom_q6v5_pas evdev 
slim_qcom_ngd_ctrl qrtr qcom_pil_info pdr_interface qcom_q6v5 slimbus 
qcom_sysmon rmtfs_mem tcp_bbr sch_fq fuse configfs ip_tables x_tables 
autofs4 ext4 mbcache jbd2 panel_simple rtc_pm8xxx msm llcc_qcom ocmem 
ti_sn65dsi86 drm_dp_aux_bus gpu_sched drm_kms_helper drm camcc_sdm845 
ipa qcom_common qmi_helpers mdt_loader gpio_keys pwm_bl
[  141.613142] CPU: 3 PID: 1277 Comm: systemd-sleep Tainted: G        
W         5.15.6 #45
[  141.613167] Hardware name: LENOVO 81JL/LNVNB161216, BIOS 
9UCN33WW(V2.06) 06/ 4/2019
[  141.613181] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[  141.613206] pc : clk_core_unprepare+0x1a0/0x1c0
[  141.613236] lr : clk_core_unprepare+0x1a0/0x1c0
[  141.613264] sp : ffff800017c63950
[  141.613275] x29: ffff800017c63950 x28: ffff2ed900fb8118 x27: 
ffffd0c3450bbe20
[  141.613318] x26: 0000000000000002 x25: 0000000000000000 x24: 
ffff2ed90bf23200
[  141.613358] x23: ffffd0c3461a1590 x22: 0000000000000001 x21: 
ffff2ed90c90dd00
[  141.613396] x20: ffff2ed900fa0c78 x19: ffff2ed909bccf00 x18: 
0000000000000000
[  141.613436] x17: 000000040044ffff x16: ffffd0c344f7bdf0 x15: 
0000000000000000
[  141.613475] x14: ffff2ed900296740 x13: 0a64657261706572 x12: 
706e752079646165
[  141.613515] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 
ffffd0c34499b66c
[  141.613554] x8 : 00000000ffffffff x7 : 61706572706e7520 x6 : 
00000000fffff664
[  141.613592] x5 : ffff2eda73771a48 x4 : ffff800017c63790 x3 : 
0000000000000001
[  141.613629] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff2ed920b70000
[  141.613667] Call trace:
[  141.613678]  clk_core_unprepare+0x1a0/0x1c0
[  141.613710]  clk_unprepare+0x38/0x50
[  141.613736]  msm_dsi_runtime_suspend+0x70/0x90 [msm]
[  141.614063]  pm_generic_runtime_suspend+0x38/0x50
[  141.614091]  genpd_runtime_suspend+0xb4/0x314
[  141.614121]  pm_runtime_force_suspend+0x54/0x140
[  141.614151]  dpm_run_callback+0x60/0x180
[  141.614173]  __device_suspend+0x120/0x5a0
[  141.614195]  dpm_suspend+0x158/0x2c0
[  141.614218]  dpm_suspend_start+0xa8/0xb0
[  141.614241]  suspend_devices_and_enter+0x100/0x810
[  141.614267]  pm_suspend+0x38c/0x480
[  141.614290]  state_store+0x98/0x11c
[  141.614311]  kobj_attr_store+0x1c/0x30
[  141.614340]  sysfs_kf_write+0x50/0x60
[  141.614360]  kernfs_fop_write_iter+0x134/0x1c4
[  141.614390]  new_sync_write+0xf0/0x18c
[  141.614418]  vfs_write+0x210/0x2b0
[  141.614443]  ksys_write+0x74/0x100
[  141.614469]  __arm64_sys_write+0x28/0x3c
[  141.614496]  invoke_syscall+0x50/0x120
[  141.614523]  el0_svc_common.constprop.0+0x4c/0x100
[  141.614551]  do_el0_svc+0x34/0xa0
[  141.614576]  el0_svc+0x28/0x80
[  141.614597]  el0t_64_sync_handler+0xa4/0x130
[  141.614621]  el0t_64_sync+0x1a0/0x1a4
[  141.614643] ---[ end trace f08b1f47ee3d43ef ]---


And then upon wake, we get

[  144.822647] OOM killer enabled.
[  144.822660] Restarting tasks ... done.
[  144.828624] PM: suspend exit
[  144.854302] [drm:dpu_encoder_frame_done_timeout:2127] [dpu 
error]enc31 frame done timeout
[  145.153281] rfkill: input handler disabled
[  145.679342] usb 3-1.3: new high-speed USB device number 4 using xhci-hcd
[  145.734319] [drm:dpu_encoder_phys_vid_wait_for_commit_done:513] [dpu 
error]vblank timeout
[  145.734336] [drm:dpu_kms_wait_for_commit_done:454] [dpu error]wait 
for commit done returned -110
[  145.792887] usb 3-1.3: New USB device found, idVendor=5986, 
idProduct=2115, bcdDevice=54.20
[  145.792909] usb 3-1.3: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[  145.792915] usb 3-1.3: Product: Integrated Camera
[  145.792920] usb 3-1.3: Manufacturer: SunplusIT Inc
[  145.822516] [drm:dpu_encoder_helper_report_irq_timeout [msm]] *ERROR* 
irq timeout id=31, intf=1, pp=0, intr=0
[  145.870521] usb 3-1.3: can't set config #1, error -71
[  145.910326] [drm:dpu_encoder_helper_report_irq_timeout [msm]] *ERROR* 
irq timeout id=31, intf=1, pp=0, intr=0
[  145.910369] [drm:dpu_encoder_phys_vid_disable [msm]] *ERROR* wait 
disable failed: id:31 intf:1 ret:-110
[  145.932329] ldo1: Underflow of regulator enable count
[  145.932343] Failed to disable vdds: -EINVAL
[  145.936885] dsi_link_clk_enable_6g: Failed to enable dsi pixel clk
[  145.936901] msm_dsi_host_power_on: failed to enable link clocks. ret=-22
[  145.936906] dsi_mgr_bridge_pre_enable: power on host 0 failed, -22


And then a little later...

[  462.153015] ldo1: Underflow of regulator enable count
[  462.153049] Failed to disable vdds: -EINVAL
[  462.155657] Internal error: synchronous external abort: 96000010 [#1] SMP
[  462.155702] Modules linked in: rfcomm xt_conntrack aes_ce_ccm 
nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack 
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter 
snd_seq_dummy snd_hrtimer snd_seq snd_seq_device xt_addrtype nft_compat 
nf_tables libcrc32c nfnetlink br_netfilter bridge stp llc overlay 
q6asm_dai snd_soc_wsa881x regmap_sdw q6routing q6afe_dai soundwire_qcom 
snd_soc_wcd934x gpio_wcd934x q6adm snd_soc_wcd_mbhc cpufreq_ondemand 
cpufreq_conservative q6asm q6dsp_common cpufreq_powersave q6afe 
algif_hash algif_skcipher q6core af_alg bnep cpufreq_userspace lz4 
lz4_compress wcd934x regmap_slimbus zram zsmalloc apr qrtr_smd fastrpc 
binfmt_misc snd_soc_sdm845 nls_ascii uvcvideo nls_cp437 
videobuf2_vmalloc snd_soc_rt5663 vfat videobuf2_memops fat 
snd_soc_qcom_common snd_soc_rl6231 aes_ce_blk soundwire_bus crypto_simd 
cryptd aes_ce_cipher pm8941_pwrkey snd_soc_core snd_compress 
crct10dif_ce ghash_ce gf128mul snd_pcm_dmaengine sha2_ce sha256_arm64
[  462.156645]  qcom_spmi_adc5 snd_pcm sha1_ce qcom_vadc_common 
qcom_spmi_temp_alarm joydev industrialio snd_timer snd hci_uart 
soundcore btqca btrtl venus_core btbcm v4l2_mem2mem videobuf2_v4l2 
btintel bluetooth videobuf2_common videodev mc ecdh_generic 
hid_multitouch ecc ath10k_snoc ath10k_core qcom_rng ath mac80211 
qcom_q6v5_mss libarc4 cfg80211 rfkill sg qcom_wdt qcom_q6v5_pas evdev 
slim_qcom_ngd_ctrl qrtr qcom_pil_info pdr_interface qcom_q6v5 slimbus 
qcom_sysmon rmtfs_mem tcp_bbr sch_fq fuse configfs ip_tables x_tables 
autofs4 ext4 mbcache jbd2 panel_simple rtc_pm8xxx msm llcc_qcom ocmem 
ti_sn65dsi86 drm_dp_aux_bus gpu_sched drm_kms_helper drm camcc_sdm845 
ipa qcom_common qmi_helpers mdt_loader gpio_keys pwm_bl
[  462.157479] CPU: 1 PID: 961 Comm: gnome-shell Tainted: G W         
5.15.6 #45
[  462.157517] Hardware name: LENOVO 81JL/LNVNB161216, BIOS 
9UCN33WW(V2.06) 06/ 4/2019
[  462.157542] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[  462.157579] pc : dpu_reg_read+0x20/0x30 [msm]
[  462.157870] lr : dpu_hw_intf_get_status+0x2c/0x90 [msm]
[  462.158158] sp : ffff800015f237e0
[  462.158177] x29: ffff800015f237e0 x28: ffffd0c2fd91cc90 x27: 
00000000ffffffff
[  462.158234] x26: ffff2ed907c6c000 x25: 0000000000fe45a8 x24: 
0000000000000000
[  462.158287] x23: ffff2ed90bda9880 x22: 0000000000000003 x21: 
000000000000043b
[  462.158339] x20: ffff2ed901483180 x19: ffff800015f2383c x18: 
ffffffffffffffff
[  462.158393] x17: 000000040044ffff x16: ffffd0c3450b84f0 x15: 
0000000000000000
[  462.158444] x14: 0000000000000000 x13: ffff5e172dc1d000 x12: 
000000003474591d
[  462.158496] x11: 0000000000000000 x10: 0000000000000080 x9 : 
ffffd0c2fd8c3dbc
[  462.158548] x8 : ffff2ed9050fbb00 x7 : ffffd0c3460484c0 x6 : 
0000000000000000
[  462.158598] x5 : 0000000000000000 x4 : 00000000ffffffff x3 : 
ffffd0c2fd8c3d90
[  462.158648] x2 : 000000000006a800 x1 : 000000000006a800 x0 : 
ffff800010f6a800
[  462.158700] Call trace:
[  462.158720]  dpu_reg_read+0x20/0x30 [msm]
[  462.159003]  dpu_encoder_phys_vid_get_frame_count+0x74/0xf0 [msm]
[  462.159288]  dpu_encoder_get_frame_count+0x38/0x50 [msm]
[  462.159544]  dpu_crtc_get_vblank_counter+0x5c/0x8c [msm]
[  462.159592]  __get_vblank_counter+0xec/0x140 [drm]
[  462.159709]  drm_update_vblank_count+0x70/0x390 [drm]
[  462.159740]  drm_vblank_disable_and_save+0x84/0x11c [drm]
[  462.159772]  drm_crtc_vblank_off+0x108/0x320 [drm]
[  462.159803]  dpu_crtc_disable+0x60/0x3d4 [msm]
[  462.159853]  disable_outputs+0x25c/0x320 [drm_kms_helper]
[  462.159893] drm_atomic_helper_commit_modeset_disables+0x28/0x54 
[drm_kms_helper]
[  462.159910]  msm_atomic_commit_tail+0x1a0/0x780 [msm]
[  462.159959]  commit_tail+0xac/0x190 [drm_kms_helper]
[  462.159977]  drm_atomic_helper_commit+0x168/0x400 [drm_kms_helper]
[  462.159995]  drm_atomic_commit+0x58/0x70 [drm]
[  462.160032]  drm_mode_atomic_ioctl+0x864/0xb80 [drm]
[  462.160063]  drm_ioctl_kernel+0xd0/0x120 [drm]
[  462.160093]  drm_ioctl+0x248/0x470 [drm]
[  462.160124]  __arm64_sys_ioctl+0xb4/0xfc
[  462.160136]  invoke_syscall+0x50/0x120
[  462.160148]  el0_svc_common.constprop.0+0x4c/0x100
[  462.160156]  do_el0_svc+0x34/0xa0
[  462.160164]  el0_svc+0x28/0x80
[  462.160174]  el0t_64_sync_handler+0xa4/0x130
[  462.160179]  el0t_64_sync+0x1a0/0x1a4
[  462.160192] Code: d503233f f9400000 8b214041 8b010000 (b9400000)
[  462.160200] ---[ end trace f08b1f47ee3d43f0 ]---
[  462.195181] usb 3-1.3: USB disconnect, device number 5
[  483.266267] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  483.266287] rcu:     1-...0: (7 ticks this GP) 
idle=bfb/1/0x4000000000000000 softirq=18411/18411 fqs=4691
[  483.266304]     (detected by 6, t=21002 jiffies, g=40289, q=8854)
[  483.266313] Task dump for CPU 1:
[  483.266319] task:gmain           state:R  running task stack:    0 
pid: 1562 ppid:     1 flags:0x0000000e
[  483.266336] Call trace:
[  483.266341]  __switch_to+0x138/0x190
[  483.266361]  0x8b007afdbf2f3900
[  546.283350] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  546.283375] rcu:     1-...0: (7 ticks this GP) 
idle=bfb/1/0x4000000000000000 softirq=18411/18411 fqs=18763
[  546.283387]     (detected by 0, t=84007 jiffies, g=40289, q=8931)
[  546.283395] Task dump for CPU 1:
[  546.283401] task:gmain           state:R  running task stack:    0 
pid: 1562 ppid:     1 flags:0x0000000e
[  546.283412] Call trace:
[  546.283416]  __switch_to+0x138/0x190
[  546.283433]  0x8b007afdbf2f3900
[  609.319122] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  609.319145] rcu:     1-...0: (7 ticks this GP) 
idle=bfb/1/0x4000000000000000 softirq=18411/18411 fqs=32816
[  609.319162]     (detected by 6, t=147012 jiffies, g=40289, q=8968)
[  609.319172] Task dump for CPU 1:
[  609.319177] task:gmain           state:R  running task stack:    0 
pid: 1562 ppid:     1 flags:0x0000000e
[  609.319195] Call trace:
[  609.319200]  __switch_to+0x138/0x190
[  609.319222]  0x8b007afdbf2f3900

