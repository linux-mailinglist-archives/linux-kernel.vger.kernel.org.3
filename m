Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD849595F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiHPPdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiHPPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:32:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F2B4AD74
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:32:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z12so13052707wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3ladZqrQ7hNXeMbMYQUqvYEHlbnDirnZuxEqx51rn3k=;
        b=e8vzu7PeBAdXQ6hugx5wz3E3xcqvRq28DlomHp8jfJkPAEpsBgPoXI1xpbFHaQldMI
         8gFyvKYLgXuDC3xGwdVIeAEWq8l4Hooexm8c1zD3F1S7DhTtCjDcOWr/EzCwF0v07g/o
         CbaORHWZ6LO0NGLDNh9TPemDhdVcDvmKngMDz9oTjxOYtjIp2yQQbHzra2ueoU85FOB7
         H+KG0YrLKy3crgf9B7zKgjeDei8hCgC+BMJLi+u7y1cias+4IDektykh7UGMqgcuGF2i
         2IyS+sqhmTFXR3FHIv4liTLXxFO/MX68nq9yIxfSgW8dD4SNS7evif9dTp/2aw3D1i2j
         of0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3ladZqrQ7hNXeMbMYQUqvYEHlbnDirnZuxEqx51rn3k=;
        b=VvcB0SEIn2s3/VNnf0sejzrfOd0rmIbVp4ZYWkY/jos4OGcUzjI+hXcE15PtHymZw7
         H5LsxIXEECP0k6vDp7dMz+K1r7SOw/bM0yihJzpPLcjyKNklUt/60B47OJSY9zwNaCxt
         SNLTeP6sh6/TgPOMV35QJYVhFkZ1Iaf2217cTmAUKDPygfkzkNXfEUSppTLfGUbbEjXH
         UCpsKoYo/6FLeNo76z9gSke5craYJHkO1Ly7LzT1dCFfTzXWnQIZ8jBMgw/3epDHlH+3
         Bu+3hDPSeQyrU0RDmjtYWxGtSzI9a6K/XsPJQQBtf6+qaQbOxwChXgNqvoattlMfeCKH
         +BoQ==
X-Gm-Message-State: ACgBeo34NBaxaykzIaVvMYDH+SjYZjuLxYcoCyuonFQKcFvNFadoHayN
        BPzQUeJhHtUtJl7H/KfgnkfrrQ==
X-Google-Smtp-Source: AA6agR7WnOpx6lbbKXS0hGEuz9TJ/O7NMQdTx0mIHN6ef6AgzxJdcpTQQRMe8Jkwbuzf6vloQMoz1g==
X-Received: by 2002:a5d:47a4:0:b0:220:600d:2b0f with SMTP id 4-20020a5d47a4000000b00220600d2b0fmr12148608wrb.407.1660663974377;
        Tue, 16 Aug 2022 08:32:54 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b003a6077384ecsm2938495wms.31.2022.08.16.08.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 08:32:53 -0700 (PDT)
Date:   Tue, 16 Aug 2022 18:32:51 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sdm845: Add the RPMh stats node
Message-ID: <Yvu4o1bFdKLfvaiL@linaro.org>
References: <20220812101240.1869605-1-abel.vesa@linaro.org>
 <T2Uz7zs4Ht58lYc5zWg1VBY0ju6bVaSKa9y3RhBQWDDHmPXBHbAxI2J34jSeY0BFQy2y4JtFn3nQS0Lz4xI5jw==@protonmail.internalid>
 <20220812101240.1869605-3-abel.vesa@linaro.org>
 <e6821eef-4fcb-97b1-24be-e2bb62b99039@linaro.org>
 <Yvtx2aK1Uu51hTPM@linaro.org>
 <b34b2fa6-7dbf-e4d3-9833-57efd42f9137@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34b2fa6-7dbf-e4d3-9833-57efd42f9137@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-16 14:50:50, Caleb Connolly wrote:
> 
> 
> On 16/08/2022 11:30, Abel Vesa wrote:
> > On 22-08-15 21:34:07, Caleb Connolly wrote:
> > > 
> > > 
> > > On 12/08/2022 11:12, Abel Vesa wrote:
> > > > SDM845 is a special case compared to the other platforms that use RPMh
> > > > stats, since it only has 2 stats (aosd and cxsd), while the others have
> > > > a 3rd one (ddr).
> > > > 
> > > > So lets add the node but with a SDM845 dedicated compatible to make
> > > > the driver aware of the different stats config.
> > > Hi,
> > > 
> > > I gave this a go on the OnePlus 6, I noticed the driver is also meant to
> > > read the stats for remote procs via smem, however this seems to fail for me
> > > - it can't find any of the SMEM items even if I probe the driver manually
> > > after ensuring remoteprocs have booted. Is this an unsupported feature on
> > > SDM845?
> > 
> > Thanks for giving it a test.
> > 
> > Actually, you need to probe the qcom_stats after the remoteprocs have
> > booted.
> 
> Hi, thanks for getting back to me. I did try this as mentioned above but I
> think I must have been doing something wrong as I get different behaviour
> now:
> 
> 
> enchilada:/ # cat /sys/class/remoteproc/remoteproc*/state
> 
> running
> 
> running
> 
> running
> 
> running
> 
> enchilada:/ # ls /d/qcom_stats/
> aosd  cxsd
> enchilada:/ # rmmod qcom_stats
> enchilada:/ # insmod /data/qcom_stats.ko
> enchilada:/ # ls /d/qcom_stats/
> adsp  aosd  cdsp  cxsd  modem  slpi

Well, I run on upstream MTP, which has less enabled in devicetree.

> 
> 
> 
> Weirdly, despite it succeeding it prints the following in dmesg with logging
> added to qcom_create_subsystem_stat_files() [1]:
> 
> [  156.540307] Couldn't get smem object 'wpss' (item: 605, pid: 13): -2
> [  156.546899] Couldn't get smem object 'gpu' (item: 609, pid: 0): -2
> [  156.553260] Couldn't get smem object 'display' (item: 610, pid: 0): -2
> [  156.559957] Couldn't get smem object 'adsp_island' (item: 613, pid: 2): -2
> [  156.567007] Couldn't get smem object 'slpi_island' (item: 613, pid: 3): -2

See my comment below your related changes.

> > 
> > Doing so, you'll end up having the following:
> > adsp  aosd  cdsp  cxsd
> 
> I seem to get a few more, I have some out of tree patches enabling the SLPI,
> and iirc the db845c doesn't have a full modem firmware. If these look good
> to you I'd appreciate it if you add my Tested-by.

Looks OK to me.

> 
> enchilada:/ # for x in /d/qcom_stats/*; do echo $x; cat $x; done
> /d/qcom_stats/adsp
> Count: 48
> Last Entered At: 1199663157
> Last Exited At: 1524359015
> Accumulated Duration: 793060082
> /d/qcom_stats/aosd
> Count: 0
> Last Entered At: 0
> Last Exited At: 0
> Accumulated Duration: 0
> /d/qcom_stats/cdsp
> Count: 35
> Last Entered At: 1194818037
> Last Exited At: 1194769648
> Accumulated Duration: 3223580811
> /d/qcom_stats/cxsd
> Count: 0
> Last Entered At: 0
> Last Exited At: 0
> Accumulated Duration: 0
> /d/qcom_stats/modem
> Count: 49
> Last Entered At: 3687081003
> Last Exited At: 3686727026
> Accumulated Duration: 2915592136
> /d/qcom_stats/slpi
> Count: 53
> Last Entered At: 3120905905
> Last Exited At: 3120894535
> Accumulated Duration: 3218969498
> 
> Am I right in thinking the aosd and cxsd being all 0 is probably a similar
> issue to the one reported by Stephen in [2]?

Might be, I'm not sure. I'll have closer a look.

> 
> 
> [1]:
> 
> diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
> index 121ea409fafc..56cfb20d3683 100644
> --- a/drivers/soc/qcom/qcom_stats.c
> +++ b/drivers/soc/qcom/qcom_stats.c
> @@ -178,8 +178,12 @@ static void qcom_create_subsystem_stat_files(struct dentry *root,
> 
>         for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
>                 stat = qcom_smem_get(subsystems[i].pid, subsystems[i].smem_item, NULL);
> -               if (IS_ERR(stat))

Basically, the error here means the subsystem is not available right at
this moment. We could probably return EPROBE_DEFER here, but it really
depends on each platform's devicetree what remoteprocs they have
enabled or not. So I guess the safest thing to to is to just skip
quietly the ones that haven't probed yet.

> +               if (IS_ERR(stat)) {
> +                       pr_info("Couldn't get smem object '%s' (item: %d, pid: %d): %ld\n",
> +                               subsystems[i].name, subsystems[i].smem_item, subsystems[i].pid,
> +                               PTR_ERR(stat));
>                         continue;
> +               }
> 
>                 debugfs_create_file(subsystems[i].name, 0400, root, (void *)&subsystems[i],
>                                     &qcom_subsystem_sleep_stats_fops);
> 
> 
> 
> [2]: https://lore.kernel.org/linux-arm-msm/20220628201340.3981860-1-swboyd@chromium.org/
> > 
> > > > 
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> Tested-by: Caleb Connolly <caleb.connolly@linaro.org>
> > > > ---
> > > > 
> > > > Changed qcom,rpmh-stats-sdm845 to qcom,sdm845-rpmh-stats, as suggested
> > > > by Krzysztof.
> > > > 
> > > >    arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
> > > >    1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > index 5bea96a9ce06..67fe08b837be 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > @@ -4851,6 +4851,11 @@ ebi_cdev: ebi {
> > > >    			};
> > > >    		};
> > > > 
> > > > +		sram@c3f0000 {
> > > > +			compatible = "qcom,sdm845-rpmh-stats";
> > > > +			reg = <0 0x0c3f0000 0 0x400>;
> > > > +		};
> > > > +
> > > >    		spmi_bus: spmi@c440000 {
> > > >    			compatible = "qcom,spmi-pmic-arb";
> > > >    			reg = <0 0x0c440000 0 0x1100>,
> > > > --
> > > > 2.34.1
> > > > 
> > > 
> > > -- 
> > > Kind Regards,
> > > Caleb (they/he)
> 
> -- 
> Kind Regards,
> Caleb (they/he)
