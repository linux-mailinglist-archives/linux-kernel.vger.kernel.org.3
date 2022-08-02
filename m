Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D86F587631
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 06:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiHBEQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 00:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiHBEQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 00:16:32 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FAD459BA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 21:16:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so14158904pjl.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 21:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C6HB9uTf60BVvbZncr5sQL+IFnZUsS8J9nTGcw/j7Rw=;
        b=I5zwxvwvpyxGnk+WHFLO8Pq0Xiy8ph21o0HfIj5lWh/zSJvjtYDcB7CfxzHEFe2k6Z
         nLLHXeQ4HgdBoguSnbmcfEqCwWJZt37yUWd+EL7QBE42k6gwXCVS4gBq4vZaRaCqh2a9
         pA1JQ8GlvGGx8vQs2wvT/1XEcX9zqjDorlZfCllU3IqBCnRN5AuCTG5+sn+PbBR/9VJa
         BUOH68KZ83K4c4kjVl/hBectysySO199fxqsDvlTXU4wVZhciWTjyaMU+OJEvbn78w3q
         ubZohpLWD09yHAQNsmQ0jWFcIMY0sNNUizQwXK+c7QzSqu9LS1EVInAMtgBmED5fVBbf
         JZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6HB9uTf60BVvbZncr5sQL+IFnZUsS8J9nTGcw/j7Rw=;
        b=Ll+9a9Vid1viVJIWF91MeRWClfHbfIEI8w7Sxuqr/PxlRLmWcio5HvlVUPJCRRDMPV
         I/8XHBfUM6ACGdqUWM4e6/dykll7iGnUrnlTSJtHm4lWB6X0DSnpmYjgrReUYfYaabzk
         k6UrZnilqwvinZIrK8rqaIqo19w5+0cVyf3KCrNPYKHX3lIf63zfu/SywvQaxYCNO75L
         VqTqQYOxh03rmB+snIsDZ7l4wudEAP+GniCMEHLD1HO6qfbIVr6G3WbT4RLbah26IMEk
         O/2TtHmKsR3fnHANBLtlasNnhNFWLg0hJir+zfEv6f1iXto8bICNf+mF8mwuuMSg75Xh
         K6OQ==
X-Gm-Message-State: ACgBeo11yWt5OFd632CCtxmfa4jhWYEq5aMA2eZCevoxJmylmlVH02ua
        nj1EI8oPaYcS5iG5lO2vGAdlcw==
X-Google-Smtp-Source: AA6agR55b4L32phqlkvghpqYBJ6oUKz/RakdVBDEkF0S4WlcvUiscniySP1WanMVX+5sSPICd6zHBA==
X-Received: by 2002:a17:90a:930b:b0:1ed:5441:1fff with SMTP id p11-20020a17090a930b00b001ed54411fffmr22416378pjo.238.1659413790733;
        Mon, 01 Aug 2022 21:16:30 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902f64900b0016d2e8c2228sm10356025plg.238.2022.08.01.21.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 21:16:29 -0700 (PDT)
Date:   Tue, 2 Aug 2022 09:46:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] venus: pm_helpers: Fix warning in OPP during probe
Message-ID: <20220802041626.cjsuatqecw3qxsxm@vireshk-i7>
References: <20220801151641.1069181-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801151641.1069181-1-stanimir.varbanov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-08-22, 18:16, Stanimir Varbanov wrote:
> Fix the following WARN triggered during Venus driver probe on
> 5.19.0-rc8-next-20220728:
> 
>  WARNING: CPU: 7 PID: 339 at drivers/opp/core.c:2471 dev_pm_opp_set_config+0x49c/0x610
>  Modules linked in: qcom_spmi_adc5 rtc_pm8xxx qcom_spmi_adc_tm5 leds_qcom_lpg led_class_multicolor
>   qcom_pon qcom_vadc_common venus_core(+) qcom_spmi_temp_alarm v4l2_mem2mem videobuf2_v4l2 msm(+)
>   videobuf2_common crct10dif_ce spi_geni_qcom snd_soc_sm8250 i2c_qcom_geni gpu_sched
>   snd_soc_qcom_common videodev qcom_q6v5_pas soundwire_qcom drm_dp_aux_bus qcom_stats
>   drm_display_helper qcom_pil_info soundwire_bus snd_soc_lpass_va_macro mc qcom_q6v5
>   phy_qcom_snps_femto_v2 qcom_rng snd_soc_lpass_macro_common snd_soc_lpass_wsa_macro
>   lpass_gfm_sm8250 slimbus qcom_sysmon qcom_common qcom_glink_smem qmi_helpers
>   qcom_wdt mdt_loader socinfo icc_osm_l3 display_connector
>   drm_kms_helper qnoc_sm8250 drm fuse ip_tables x_tables ipv6
>  CPU: 7 PID: 339 Comm: systemd-udevd Not tainted 5.19.0-rc8-next-20220728 #4
>  Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>  pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : dev_pm_opp_set_config+0x49c/0x610
>  lr : dev_pm_opp_set_config+0x58/0x610
>  sp : ffff8000093c3710
>  x29: ffff8000093c3710 x28: ffffbca3959d82b8 x27: ffff8000093c3d00
>  x26: ffffbca3959d8e08 x25: ffff4396cac98118 x24: ffff4396c0e24810
>  x23: ffff4396c4272c40 x22: ffff4396c0e24810 x21: ffff8000093c3810
>  x20: ffff4396cac36800 x19: ffff4396cac96800 x18: 0000000000000000
>  x17: 0000000000000003 x16: ffffbca3f4edf198 x15: 0000001cba64a858
>  x14: 0000000000000180 x13: 000000000000017e x12: 0000000000000000
>  x11: 0000000000000002 x10: 0000000000000a60 x9 : ffff8000093c35c0
>  x8 : ffff4396c4273700 x7 : ffff43983efca6c0 x6 : ffff43983efca640
>  x5 : 00000000410fd0d0 x4 : ffff4396c4272c40 x3 : ffffbca3f5d1e008
>  x2 : 0000000000000000 x1 : ffff4396c2421600 x0 : ffff4396cac96860
>  Call trace:
>   dev_pm_opp_set_config+0x49c/0x610
>   devm_pm_opp_set_config+0x18/0x70
>   vcodec_domains_get+0xb8/0x1638 [venus_core]
>   core_get_v4+0x1d8/0x218 [venus_core]
>   venus_probe+0xf4/0x468 [venus_core]
>   platform_probe+0x68/0xd8
>   really_probe+0xbc/0x2a8
>   __driver_probe_device+0x78/0xe0
>   driver_probe_device+0x3c/0xf0
>   __driver_attach+0x70/0x120
>   bus_for_each_dev+0x70/0xc0
>   driver_attach+0x24/0x30
>   bus_add_driver+0x150/0x200
>   driver_register+0x64/0x120
>   __platform_driver_register+0x28/0x38
>   qcom_venus_driver_init+0x24/0x1000 [venus_core]
>   do_one_initcall+0x54/0x1c8
>   do_init_module+0x44/0x1d0
>   load_module+0x16c8/0x1aa0
>   __do_sys_finit_module+0xbc/0x110
>   __arm64_sys_finit_module+0x20/0x30
>   invoke_syscall+0x44/0x108
>   el0_svc_common.constprop.0+0xcc/0xf0
>   do_el0_svc+0x2c/0xb8
>   el0_svc+0x2c/0x88
>   el0t_64_sync_handler+0xb8/0xc0
>   el0t_64_sync+0x18c/0x190
>   qcom-venus: probe of aa00000.video-codec failed with error -16
> 
> The fix is re-ordering the code related to OPP core. The OPP core
> expects all configuration options to be provided before the OPP
> table is added.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Changed this to Suggested-by.

> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied. Thanks.

-- 
viresh
