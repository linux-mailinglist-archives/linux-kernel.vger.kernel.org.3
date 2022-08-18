Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC03597B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242611AbiHRBrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbiHRBrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:47:41 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A2FA50F4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:47:38 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l5so211028qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=2a8x4YaDnqKmp3Vw4tJAGheL7FT9WbovfEUB3rSgc10=;
        b=n9OyaGyLwuDFSKfYOgCHLRa0YdS8tCbRePDdsyEIQstjKj6Xg2voiJIKYk9/qRLNgC
         OiBBjFd6XsH2OdjFz3McGo+Q/sO2imvUXrkTnHE6YQNpvhFng4DzwoNY+9LLEe5Gh6w7
         0jPxS/0hdg3RHao0iTXkQetlC326uzlRtZrt/TKMmLFvGSGNlqlBUY6tApgK+18E029A
         ymBLdZIrwX33Nhe1/fyhREUzSEXERvfTNHy6fVi5cGKLK9tFCVqa8YdQw+84iyYWmfu/
         a4sJHXLP3sjuIvwxVRK6jxIRdByLEAy8KbfzQPKCfswmUTQ5GEJNSKktkNb4i+2JW3Ge
         AIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2a8x4YaDnqKmp3Vw4tJAGheL7FT9WbovfEUB3rSgc10=;
        b=EefKTn3pguKUJ6lbavO19FEIDnkgH341qHxIg1NG5W+h27HFWf9ddAWRIvr246e9O+
         l9f6hGxslZE1UJCY2Lff6b9pQqJncGQ/deVsUn1iQaSMv9jbbMetNhKvabJkG8vxNiYI
         1aZ4t3X8ewRsP3KwEXXbcEnB0OqMJWX7V5DB83fZK2M3RbmF1JcuTXDLVOcdzyJSJNYV
         gccGmWkS519IqMSz1N1/2wfvmYUb+H8Inny+6MMDWShwCDDJp3uWHAabfwc1jsf1K/T0
         n7Z0hYniq2pu2aO1u+aNE7DPBIIprNSBS5y+2eQqiXJiZD6imq0kZ1dZ7IeSutL3KSed
         eu5w==
X-Gm-Message-State: ACgBeo1hCLU/VQN6vFZRfrQ/PqUL4tKmbgLO1L7267XH4an4O4F0TMYo
        Od8FnTB4t6aelD0JBp/9FcZYSQaBWVB+Gw==
X-Google-Smtp-Source: AA6agR6TCt3GgrbPrl2KMgoru3Z2IE8bUss2Czcqwe0lSG/WodTqjOXpnyd96sP8AJQvFxkfgin0gw==
X-Received: by 2002:a05:622a:1910:b0:343:4ebe:fd3b with SMTP id w16-20020a05622a191000b003434ebefd3bmr883065qtc.144.1660787258004;
        Wed, 17 Aug 2022 18:47:38 -0700 (PDT)
Received: from baldur ([2600:380:7852:c2c2:200:ff:fe00:0])
        by smtp.gmail.com with ESMTPSA id bn44-20020a05620a2aec00b006bb619a6a85sm381946qkb.48.2022.08.17.18.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 18:47:37 -0700 (PDT)
Date:   Wed, 17 Aug 2022 20:47:23 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sdm845: Add the RPMh stats node
Message-ID: <Yv2aK52MzRPUIztr@baldur>
References: <20220812101240.1869605-1-abel.vesa@linaro.org>
 <T2Uz7zs4Ht58lYc5zWg1VBY0ju6bVaSKa9y3RhBQWDDHmPXBHbAxI2J34jSeY0BFQy2y4JtFn3nQS0Lz4xI5jw==@protonmail.internalid>
 <20220812101240.1869605-3-abel.vesa@linaro.org>
 <e6821eef-4fcb-97b1-24be-e2bb62b99039@linaro.org>
 <Yvtx2aK1Uu51hTPM@linaro.org>
 <b34b2fa6-7dbf-e4d3-9833-57efd42f9137@linaro.org>
 <Yvu4o1bFdKLfvaiL@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvu4o1bFdKLfvaiL@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16 Aug 10:32 CDT 2022, Abel Vesa wrote:

> On 22-08-16 14:50:50, Caleb Connolly wrote:
> > 
> > 
> > On 16/08/2022 11:30, Abel Vesa wrote:
> > > On 22-08-15 21:34:07, Caleb Connolly wrote:
> > > > 
> > > > 
> > > > On 12/08/2022 11:12, Abel Vesa wrote:
> > > > > SDM845 is a special case compared to the other platforms that use RPMh
> > > > > stats, since it only has 2 stats (aosd and cxsd), while the others have
> > > > > a 3rd one (ddr).
> > > > > 
> > > > > So lets add the node but with a SDM845 dedicated compatible to make
> > > > > the driver aware of the different stats config.
> > > > Hi,
> > > > 
> > > > I gave this a go on the OnePlus 6, I noticed the driver is also meant to
> > > > read the stats for remote procs via smem, however this seems to fail for me
> > > > - it can't find any of the SMEM items even if I probe the driver manually
> > > > after ensuring remoteprocs have booted. Is this an unsupported feature on
> > > > SDM845?
> > > 
> > > Thanks for giving it a test.
> > > 
> > > Actually, you need to probe the qcom_stats after the remoteprocs have
> > > booted.
> > 
> > Hi, thanks for getting back to me. I did try this as mentioned above but I
> > think I must have been doing something wrong as I get different behaviour
> > now:
> > 
> > 
> > enchilada:/ # cat /sys/class/remoteproc/remoteproc*/state
> > 
> > running
> > 
> > running
> > 
> > running
> > 
> > running
> > 
> > enchilada:/ # ls /d/qcom_stats/
> > aosd  cxsd
> > enchilada:/ # rmmod qcom_stats
> > enchilada:/ # insmod /data/qcom_stats.ko
> > enchilada:/ # ls /d/qcom_stats/
> > adsp  aosd  cdsp  cxsd  modem  slpi
> 
> Well, I run on upstream MTP, which has less enabled in devicetree.
> 
> > 
> > 
> > 
> > Weirdly, despite it succeeding it prints the following in dmesg with logging
> > added to qcom_create_subsystem_stat_files() [1]:
> > 
> > [  156.540307] Couldn't get smem object 'wpss' (item: 605, pid: 13): -2
> > [  156.546899] Couldn't get smem object 'gpu' (item: 609, pid: 0): -2
> > [  156.553260] Couldn't get smem object 'display' (item: 610, pid: 0): -2
> > [  156.559957] Couldn't get smem object 'adsp_island' (item: 613, pid: 2): -2
> > [  156.567007] Couldn't get smem object 'slpi_island' (item: 613, pid: 3): -2
> 
> See my comment below your related changes.
> 
> > > 
> > > Doing so, you'll end up having the following:
> > > adsp  aosd  cdsp  cxsd
> > 
> > I seem to get a few more, I have some out of tree patches enabling the SLPI,
> > and iirc the db845c doesn't have a full modem firmware. If these look good
> > to you I'd appreciate it if you add my Tested-by.
> 
> Looks OK to me.
> 
> > 
> > enchilada:/ # for x in /d/qcom_stats/*; do echo $x; cat $x; done
> > /d/qcom_stats/adsp
> > Count: 48
> > Last Entered At: 1199663157
> > Last Exited At: 1524359015
> > Accumulated Duration: 793060082
> > /d/qcom_stats/aosd
> > Count: 0
> > Last Entered At: 0
> > Last Exited At: 0
> > Accumulated Duration: 0
> > /d/qcom_stats/cdsp
> > Count: 35
> > Last Entered At: 1194818037
> > Last Exited At: 1194769648
> > Accumulated Duration: 3223580811
> > /d/qcom_stats/cxsd
> > Count: 0
> > Last Entered At: 0
> > Last Exited At: 0
> > Accumulated Duration: 0
> > /d/qcom_stats/modem
> > Count: 49
> > Last Entered At: 3687081003
> > Last Exited At: 3686727026
> > Accumulated Duration: 2915592136
> > /d/qcom_stats/slpi
> > Count: 53
> > Last Entered At: 3120905905
> > Last Exited At: 3120894535
> > Accumulated Duration: 3218969498
> > 
> > Am I right in thinking the aosd and cxsd being all 0 is probably a similar
> > issue to the one reported by Stephen in [2]?
> 
> Might be, I'm not sure. I'll have closer a look.
> 
> > 
> > 
> > [1]:
> > 
> > diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
> > index 121ea409fafc..56cfb20d3683 100644
> > --- a/drivers/soc/qcom/qcom_stats.c
> > +++ b/drivers/soc/qcom/qcom_stats.c
> > @@ -178,8 +178,12 @@ static void qcom_create_subsystem_stat_files(struct dentry *root,
> > 
> >         for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
> >                 stat = qcom_smem_get(subsystems[i].pid, subsystems[i].smem_item, NULL);
> > -               if (IS_ERR(stat))
> 
> Basically, the error here means the subsystem is not available right at
> this moment. We could probably return EPROBE_DEFER here, but it really
> depends on each platform's devicetree what remoteprocs they have
> enabled or not. So I guess the safest thing to to is to just skip
> quietly the ones that haven't probed yet.
> 

Not only does the/each remoteproc driver need to probe, we actually need
to wait for them to boot in order to register their parts.

Perhaps we can use qcom_register_ssr_notifier() to dynamically register
these at some later time. This does however seem like a reasonable thing
to improve upon in a follow up series.

Regards,
Bjorn
