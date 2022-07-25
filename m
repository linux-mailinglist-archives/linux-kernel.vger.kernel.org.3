Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BE557FD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiGYK1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiGYK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:27:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3341706A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:27:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b133so10045624pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FVLNEgbrV7foJiOyKD7CyXOXfsr9DbEH3gzOzG6OCuI=;
        b=pVIuZ/c2Uv6L+vhi8g/UsENSY53aXIK4Auwh1luZ48FrfiNybE7MU/g8o7In0zr1os
         Rbw6b/v9q5OSklfMgtBAJXEVk27ryXpPofeZf3uCavAcuJZAzcnigmi4Oxf8bVkjCK4Y
         Fzf5Iq71QGoKVuo1ekRPGc5RmVyC0/ae7IbRLPjQE7vtvMkfiCBI9T4qKSeSzwPT+GtC
         vLywsQ+A6OkGEBqP2tLaKFI/DGWl+MoE1IViHAylIAYCVa0g9oZ8fGGpWD02tpXgAIx1
         tYxMm/stTLsOsTNpbLamFL0QMts9v3EyT+yWJPDFK/7u/wor3OiWpYgzhtPcUzWVSYTn
         kT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FVLNEgbrV7foJiOyKD7CyXOXfsr9DbEH3gzOzG6OCuI=;
        b=hftSHzBVI7dZEcfWOwSsN8cXk9AhfUIM+vpELutFhcKZeec1fRkablQVGl+fg1hZ7R
         K02x+lOYx2OSIXOGKuafqU0pwmTOwCtaEisNHNlmD/5o8R6hbliUJfurkNGUWweOQpjZ
         tb8yEcSDrHESY4giy4sAZjeQat57EgniK5Lzkp84Bpjw7amTgzFOo9t7VOtI9dMayokT
         0EzhVbssfKCRkk5QnFWRHRZNxpjP74lnNphQhbMLAh0D1aGEHm3ttyLZXfyhXwUZstpg
         5CRMmSPyuczy+Od725gVcPEak1K98/HeYuo5/7S4l60FIg76QA9byN5uFqL97axlxUkQ
         EBJQ==
X-Gm-Message-State: AJIora+escbkCSKjzBFGMeAhjHFRhTwap5GQpDu8JsX2Chx+yNFgsq5G
        mjWvmtkm3U8T7gd8VimWoTFuqw==
X-Google-Smtp-Source: AGRyM1vJRtd9Y8LTqsNydNjGRZEDIaR9B/HvZkp6B3wSISp3Skci9dfbcIJxYkihu89FIDX/FA5H7A==
X-Received: by 2002:a05:6a00:1ac7:b0:52b:37ac:442c with SMTP id f7-20020a056a001ac700b0052b37ac442cmr12025537pfv.76.1658744834966;
        Mon, 25 Jul 2022 03:27:14 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78ec5000000b0051b32c2a5a7sm9188106pfr.138.2022.07.25.03.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 03:27:14 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:57:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, Linux PM <linux-pm@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: WARNING: CPU: 4 PID: 326 at drivers/opp/core.c:2471
 dev_pm_opp_set_config+0x344/0x620
Message-ID: <20220725102711.p6eerjjzgeqi4blu@vireshk-i7>
References: <CA+G9fYuGFReF0Z9qj7-80eY0gz-J2C5MVpno_8NjrGSH5_RB0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuGFReF0Z9qj7-80eY0gz-J2C5MVpno_8NjrGSH5_RB0Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-22, 11:01, Naresh Kamboju wrote:
> I have found this warning on db845c while booting Linux next-20220720.
> Please find more details in the below link,
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> [    9.769688] WARNING: CPU: 4 PID: 326 at drivers/opp/core.c:2471
> dev_pm_opp_set_config+0x344/0x620
> [    9.769698] i2c 16-0010: Fixing up cyclic dependency with acb3000.camss
> [    9.810991] msm-mdss ae00000.mdss: Adding to iommu group 15
> [    9.811082] Modules linked in: hci_uart qcom_camss msm(+) videobuf2_dma_sg
> [    9.823435] ath10k_snoc 18800000.wifi: supply vdd-3.3-ch1 not
> found, using dummy regulator
> [    9.827664]  ath10k_snoc(+) btqca v4l2_fwnode btbcm ath10k_core
> venus_core(+) gpu_sched camcc_sdm845 reset_qcom_pdc v4l2_async
> v4l2_mem2mem i2c_qcom_geni videobuf2_memops ath drm_dp_aux_bus
> drm_display_helper videobuf2_v4l2 bluetooth mac80211 i2c_qcom_cci
> videobuf2_common qcom_rng spi_geni_qcom gpi(+) qcom_q6v5_mss xhci_pci
> qrtr xhci_pci_renesas cfg80211 rfkill slim_qcom_ngd_ctrl lmh
> icc_osm_l3 pdr_interface slimbus qcom_wdt display_connector icc_bwmon
> qcom_q6v5_pas qcom_pil_info qcom_q6v5 qcom_sysmon drm_kms_helper
> qcom_common qcom_glink_smem qmi_helpers mdt_loader drm socinfo
> rmtfs_mem fuse
> [    9.885445] qcom-camss acb3000.camss: Adding to iommu group 16
> [    9.911179] platform ae94000.dsi: Fixing up cyclic dependency with
> ae01000.display-controller
> [[0;32m  OK  [0m] Started D-Bus System Message Bus.[    9.911593]
> Bluetooth: hci0: setting up wcn399x
> [    9.928261] CPU: 4 PID: 326 Comm: systemd-udevd Not tainted
> 5.19.0-rc7-next-20220720 #1
> 
> [    9.928265] Hardware name: Thundercomm Dragonboard 845c (DT)
> [    9.928267] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    9.928269] pc : dev_pm_opp_set_config+0x344/0x620
> [    9.977763] lr : dev_pm_opp_set_config+0x68/0x620
> [    9.982508] sp : ffff8000089337b0
> [    9.985846] x29: ffff8000089337b0 x28: ffff800008933c90 x27: ffff3e2780f9bc10
> [    9.993030] x26: ffffb9048f76dd40 x25: ffffb904d98c8de8 x24: ffff3e278da60080
> [   10.000226] x23: ffff3e2780f9bc10 x22: ffff8000089338b0 x21: ffff3e278eda0d80
> [   10.007416] x20: ffff3e2780f9bc10 x19: ffff3e2786ffe000 x18: ffffffffffffffff
> [   10.014602] x17: 0000000000000000 x16: ffffb904d7d90f50 x15: 6f63713d305f454c
> [   10.021795] x14: ffffb904d9df6a20 x13: 0000000000000040 x12: 0000000000000228
> [   10.028981] x11: 0000000000000000 x10: 0000000000000bd0 x9 : ffffb904d7d905e0
> [   10.036166] x8 : ffff3e27833a8c30 x7 : 0000000000000018 x6 : 0000000000000001
> [   10.043361] x5 : ffffb904d982f000 x4 : ffff3e27833a8000 x3 : ffffb904d9bf2c20
> [   10.043365] x2 : 0000000000000000 x1 : ffff3e2786f70d00 x0 : ffff3e2786ffe060
> [   10.043368] Call trace:
> [   10.043369]  dev_pm_opp_set_config+0x344/0x620
> [   10.043373]  devm_pm_opp_set_config+0x24/0x80
> [   10.043376]  core_get_v4+0x244/0x360 [venus_core]
> [   10.043393]  venus_probe+0x100/0x470 [venus_core]
> [   10.043404]  platform_probe+0x74/0xf0

Stanimir / Bjorn,

The OPP core expects all configuration options to be provided before the OPP
table is added. i.e. (for your case here), we need to call
devm_pm_opp_set_clkname() and devm_pm_opp_attach_genpd(), before calling
devm_pm_opp_of_add_table(). This is a hard requirement, it was a hard
requirement earlier (before the new changes in OPP core came in) too, just that
devm_pm_opp_attach_genpd() was missing the necessary WARN(), which was there in
every other helper.

Can someone from Qcom team reorder things a bit provide a patch to fix this
WARN() ? I will carry that in my tree then.

It may look like this, I don't want to touch code that I don't understand at
all:

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index cb48c5ff3dee..c93d2906e4c7 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -875,7 +875,7 @@ static int vcodec_domains_get(struct venus_core *core)
        }

 skip_pmdomains:
-       if (!core->has_opp_table)
+       if (!core->res->opp_pmdomain)
                return 0;

        /* Attach the power domain for setting performance state */
@@ -1007,6 +1007,10 @@ static int core_get_v4(struct venus_core *core)
        if (ret)
                return ret;

+       ret = vcodec_domains_get(core);
+       if (ret)
+               return ret;
+
        if (core->res->opp_pmdomain) {
                ret = devm_pm_opp_of_add_table(dev);
                if (!ret) {
@@ -1017,10 +1021,6 @@ static int core_get_v4(struct venus_core *core)
                }
        }

-       ret = vcodec_domains_get(core);
-       if (ret)
-               return ret;
-
        return 0;
 }

-- 
viresh
