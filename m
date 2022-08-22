Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D059C985
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiHVUEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiHVUEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F783DF3A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661198678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3MGzdqS7zqufQ3nM6oMD7RGCJ/sN7ainzK/gxogNSs8=;
        b=PzSHEufysK2X6erBLac4sZ9ThFd8/h3CRQIyI2dkMb1mcVlbNXsvcNJLY+fhtKkeGVyQ83
        h+HariboMtG66KbKgH1Jeu1fnoIbDiAE1ynmT2LcqsGXvpCLRI+7gVK8E2BPssUiYDZfxK
        O5bw5qqXuvwB59DYKxJRQ87t3IdYwnA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-kOY0OIitM8Ctfu7lYcgGfg-1; Mon, 22 Aug 2022 16:04:37 -0400
X-MC-Unique: kOY0OIitM8Ctfu7lYcgGfg-1
Received: by mail-qt1-f199.google.com with SMTP id e30-20020ac8011e000000b00342f61e67aeso9029081qtg.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3MGzdqS7zqufQ3nM6oMD7RGCJ/sN7ainzK/gxogNSs8=;
        b=EMe0yNIRQcNDFGnXo0Y5WP0NB1UJjDbP4u/UpZ+I8DpSTv552KJ+BputUspQ6s+XWa
         76C70EXx6UXto7RWg5RcXTWB8BRpRxRjD6NUm9d8N1mmmLfyMGXhlxR1YihGWihp0aEn
         BmSvuoNw6RwXsVj2Doxg1vwrfYR8MSR8kiNXj7LL8pw7lyQMyWrzpehTzcp91NZzr9fA
         hbPwaKuJ74D5bzk7S+rOqi191GC0mOlhZJNb8He0I7N2enjQCcHFjMFbNWwVNZrH999v
         7UzIn+wLZDp4CJJUki1k0YlVvsqeX6ZSjoTk2UZBCAJh3mJuSFuAoJQzh1sBhhaNhSqo
         TNqw==
X-Gm-Message-State: ACgBeo3UExbkD1tCLZKFkVk9Roict59fPEjVezuEAKLjlpIUaK/YVbMY
        AigVal2cz8xESwq5t/jtpzk+W/BUK5wTWzwEoLSpKuE/qY3OVjp5XC9so3Q9+bMbCuLClxTSZJ1
        6UiU/kMhm94c/71c4ZVvIMMI5
X-Received: by 2002:a05:620a:21c1:b0:6bb:7ccf:6833 with SMTP id h1-20020a05620a21c100b006bb7ccf6833mr13721737qka.541.1661198676678;
        Mon, 22 Aug 2022 13:04:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5LOeB5P1xEn5p0J+Wjs5Cb7HpGTmF29MjR498dW9ZMxZSFoMvhbKVMxYbiaVxLyhNE3g4aWA==
X-Received: by 2002:a05:620a:21c1:b0:6bb:7ccf:6833 with SMTP id h1-20020a05620a21c100b006bb7ccf6833mr13721722qka.541.1661198676436;
        Mon, 22 Aug 2022 13:04:36 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::48])
        by smtp.gmail.com with ESMTPSA id u21-20020a05620a455500b006b615cd8c13sm11817223qkp.106.2022.08.22.13.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 13:04:35 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:04:33 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Implement get_optimum_mode(), not
 set_load()
Message-ID: <20220822200433.k5ximhpufcxom2kv@halaneylaptop>
References: <20220726102024.1.Icc838fe7bf0ef54a014ab2fee8af311654f5342a@changeid>
 <20220822193153.zn2oxljmd76awqot@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822193153.zn2oxljmd76awqot@halaneylaptop>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 02:31:53PM -0500, Andrew Halaney wrote:
> Hey Douglas,
> 
> On Tue, Jul 26, 2022 at 10:20:29AM -0700, Douglas Anderson wrote:
> > Since we don't actually pass the load to the firmware, switch to using
> > get_optimum_mode() instead of open-coding it.
> > 
> > This is intended to have no effect other than cleanup.
> 
> I hate to post something without looking into it very deeply, but with
> this statement about no effect I figured I'd report what I'm noticing
> before diving deeper.
> 
> I'm currently playing with the dts patches in [0], and without this
> patch (and a hack patch applied that is unrelated to this) the board boots
> fine. With this patch applied I get the messages reported in [1] (which I
> think is still a clean up that should be applied) and the board fails to
> boot due to regulator_enable() failing at the first invocation I see.

Sorry for more spam, but just to be clear, in the above I'm saying that
if I revert this patch the error message below goes away and the
regulator_enable() call succeeds allowing the board to boot. Re-reading
what I wrote it sounds like a jumbled mess.

> 
> Is that something you expect?
> 
> Here's the ultimate failure message for regulator_enable():
> 
>     [    1.213419] ufshcd-qcom 1d84000.ufs: Adding to iommu group 0
>     [    1.219492] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to find vdd-hba-supply regulator, assuming enabled
>     [    1.230287] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to find vccq2-supply regulator, assuming enabled
>     [    1.241079] vreg_l17c: invalid input voltage found
>     [    1.246002] ufshcd-qcom 1d84000.ufs: ufshcd_enable_vreg: vcc enable failed, err=-22
>     [    1.253952] ufshcd-qcom 1d84000.ufs: Initialization failed
>     [    1.259622] ufshcd-qcom 1d84000.ufs: ufshcd_pltfrm_init() failed -22
>     [    1.266151] ufshcd-qcom: probe of 1d84000.ufs failed with error -22
> 
> [0] https://lore.kernel.org/all/20220722143711.17563-1-quic_ppareek@quicinc.com/
> [1] https://lore.kernel.org/all/166118500944.215002.10320899094541954077.b4-ty@kernel.org/
> 
> Thanks,
> Andrew
> 
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > 
> >  drivers/regulator/qcom-rpmh-regulator.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> > index 561de6b2e6e3..b2debde79361 100644
> > --- a/drivers/regulator/qcom-rpmh-regulator.c
> > +++ b/drivers/regulator/qcom-rpmh-regulator.c
> > @@ -306,9 +306,10 @@ static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
> >  }
> >  
> >  /**
> > - * rpmh_regulator_vrm_set_load() - set the regulator mode based upon the load
> > - *		current requested
> > + * rpmh_regulator_vrm_get_optimum_mode() - get the mode based on the  load
> >   * @rdev:		Regulator device pointer for the rpmh-regulator
> > + * @input_uV:		Input voltage
> > + * @output_uV:		Output voltage
> >   * @load_uA:		Aggregated load current in microamps
> >   *
> >   * This function is used in the regulator_ops for VRM type RPMh regulator
> > @@ -316,17 +317,15 @@ static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
> >   *
> >   * Return: 0 on success, errno on failure
> >   */
> > -static int rpmh_regulator_vrm_set_load(struct regulator_dev *rdev, int load_uA)
> > +static unsigned int rpmh_regulator_vrm_get_optimum_mode(
> > +	struct regulator_dev *rdev, int input_uV, int output_uV, int load_uA)
> >  {
> >  	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> > -	unsigned int mode;
> >  
> >  	if (load_uA >= vreg->hw_data->hpm_min_load_uA)
> > -		mode = REGULATOR_MODE_NORMAL;
> > +		return REGULATOR_MODE_NORMAL;
> >  	else
> > -		mode = REGULATOR_MODE_IDLE;
> > -
> > -	return rpmh_regulator_vrm_set_mode(rdev, mode);
> > +		return REGULATOR_MODE_IDLE;
> >  }
> >  
> >  static int rpmh_regulator_vrm_set_bypass(struct regulator_dev *rdev,
> > @@ -375,7 +374,7 @@ static const struct regulator_ops rpmh_regulator_vrm_drms_ops = {
> >  	.list_voltage		= regulator_list_voltage_linear_range,
> >  	.set_mode		= rpmh_regulator_vrm_set_mode,
> >  	.get_mode		= rpmh_regulator_vrm_get_mode,
> > -	.set_load		= rpmh_regulator_vrm_set_load,
> > +	.get_optimum_mode	= rpmh_regulator_vrm_get_optimum_mode,
> >  };
> >  
> >  static const struct regulator_ops rpmh_regulator_vrm_bypass_ops = {
> > -- 
> > 2.37.1.359.gd136c6c3e2-goog
> > 

