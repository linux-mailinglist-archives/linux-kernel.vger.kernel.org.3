Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3232B597E56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 08:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbiHRGBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 02:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbiHRGBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 02:01:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118882856
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:01:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u14so499535wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 23:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=bZty3y2darx5s7m8eOWVGV+bKL3GxP3dVhk/MBA5fWU=;
        b=f+orhQX9Aqm2vt86cAoz3fiZf50H35jqr/TNHqkMa0UF3dukyQrgs61PyJg9OBc0K2
         fAc9jEui95sT2PJMyw+Yb8O7evo/Ey1XnGjWwUf70sAkvmieksb2OPLCfi5XUWvPA84X
         geM4Rt5xnkFgxRaORd6pyt5qA20/A63EsKQMcmAbj6t/6DGisbDELa9Am2u9El99gH8M
         ckXBnp79uq3NwQmOUOUIkZXtntavZu5tuAbynf2kFLbAlBLnHn+qYsVEcOLVnI43xAnv
         lF9GGCYgx0yePaR/UsQu5OV4ITk07wiZP7+XJueTckNSZOgQdj4kDKaIdWYqPeuSd9zZ
         hLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bZty3y2darx5s7m8eOWVGV+bKL3GxP3dVhk/MBA5fWU=;
        b=XyeR0I9UoDOW+I3KCZIQdyKvyw1CW0m9AiPJ2gmfRlaNBZARWRouI+DyE/oNv0UZbl
         Rtiya9uMs8Q9v1t9E8pk2GEVv/pJirpu7xvLbDvxyywGMUb5eh24+aZ19NBXJIzMasol
         sXackzUzlnuGRDf+jGkM0Lr0eHuCytybHiVFK1HRJ8SWjIHlpntzOmeUOX4jk300UAAJ
         pHVjzElOh2aRktgHOVpvHianGcCtGDWEBHvOG6hw4jijXlud0pUprHLwwgB3UhC8ZwGd
         ggtMFA8dM8qZBRKh3tiftSOZR9Yw5MPaT7X2h2+A+A/yGSAuBtHLVvO/NQqSmVq0i9j2
         994w==
X-Gm-Message-State: ACgBeo0zMZbMlIdG+8bEcbPjWw/Ba2iwN/AEb7dydW74W9MQIv2nl/94
        odZ6r6LEh/tQQEKzqDgnfIfd6A==
X-Google-Smtp-Source: AA6agR7Xs87Dr0m2dsNGP8woPhz8tse750xuLe9TeNweuVK7GcLyu4MnOAU99SNrItyaik7Axun68A==
X-Received: by 2002:a5d:5a0f:0:b0:220:5930:dc65 with SMTP id bq15-20020a5d5a0f000000b002205930dc65mr598687wrb.229.1660802490217;
        Wed, 17 Aug 2022 23:01:30 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q14-20020adff94e000000b00225232c03fdsm514173wrr.27.2022.08.17.23.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:01:29 -0700 (PDT)
Date:   Thu, 18 Aug 2022 09:01:28 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sdm845: Add the RPMh stats node
Message-ID: <Yv3VuDvvpyNziZEq@linaro.org>
References: <20220812101240.1869605-1-abel.vesa@linaro.org>
 <T2Uz7zs4Ht58lYc5zWg1VBY0ju6bVaSKa9y3RhBQWDDHmPXBHbAxI2J34jSeY0BFQy2y4JtFn3nQS0Lz4xI5jw==@protonmail.internalid>
 <20220812101240.1869605-3-abel.vesa@linaro.org>
 <e6821eef-4fcb-97b1-24be-e2bb62b99039@linaro.org>
 <Yvtx2aK1Uu51hTPM@linaro.org>
 <b34b2fa6-7dbf-e4d3-9833-57efd42f9137@linaro.org>
 <Yvu4o1bFdKLfvaiL@linaro.org>
 <Yv2aK52MzRPUIztr@baldur>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv2aK52MzRPUIztr@baldur>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-17 20:47:23, Bjorn Andersson wrote:
> On Tue 16 Aug 10:32 CDT 2022, Abel Vesa wrote:
> 
> > On 22-08-16 14:50:50, Caleb Connolly wrote:
> > > 
> > > 
> > > On 16/08/2022 11:30, Abel Vesa wrote:
> > > > On 22-08-15 21:34:07, Caleb Connolly wrote:
> > > > > 
> > > > > 
> > > > > On 12/08/2022 11:12, Abel Vesa wrote:
> > > > > > SDM845 is a special case compared to the other platforms that use RPMh
> > > > > > stats, since it only has 2 stats (aosd and cxsd), while the others have
> > > > > > a 3rd one (ddr).
> > > > > > 
> > > > > > So lets add the node but with a SDM845 dedicated compatible to make
> > > > > > the driver aware of the different stats config.
> > > > > Hi,
> > > > > 
> > > > > I gave this a go on the OnePlus 6, I noticed the driver is also meant to
> > > > > read the stats for remote procs via smem, however this seems to fail for me
> > > > > - it can't find any of the SMEM items even if I probe the driver manually
> > > > > after ensuring remoteprocs have booted. Is this an unsupported feature on
> > > > > SDM845?
> > > > 
> > > > Thanks for giving it a test.
> > > > 
> > > > Actually, you need to probe the qcom_stats after the remoteprocs have
> > > > booted.
> > > 
> > > Hi, thanks for getting back to me. I did try this as mentioned above but I
> > > think I must have been doing something wrong as I get different behaviour
> > > now:
> > > 
> > > 
> > > enchilada:/ # cat /sys/class/remoteproc/remoteproc*/state
> > > 
> > > running
> > > 
> > > running
> > > 
> > > running
> > > 
> > > running
> > > 
> > > enchilada:/ # ls /d/qcom_stats/
> > > aosd  cxsd
> > > enchilada:/ # rmmod qcom_stats
> > > enchilada:/ # insmod /data/qcom_stats.ko
> > > enchilada:/ # ls /d/qcom_stats/
> > > adsp  aosd  cdsp  cxsd  modem  slpi
> > 
> > Well, I run on upstream MTP, which has less enabled in devicetree.
> > 
> > > 
> > > 
> > > 
> > > Weirdly, despite it succeeding it prints the following in dmesg with logging
> > > added to qcom_create_subsystem_stat_files() [1]:
> > > 
> > > [  156.540307] Couldn't get smem object 'wpss' (item: 605, pid: 13): -2
> > > [  156.546899] Couldn't get smem object 'gpu' (item: 609, pid: 0): -2
> > > [  156.553260] Couldn't get smem object 'display' (item: 610, pid: 0): -2
> > > [  156.559957] Couldn't get smem object 'adsp_island' (item: 613, pid: 2): -2
> > > [  156.567007] Couldn't get smem object 'slpi_island' (item: 613, pid: 3): -2
> > 
> > See my comment below your related changes.
> > 
> > > > 
> > > > Doing so, you'll end up having the following:
> > > > adsp  aosd  cdsp  cxsd
> > > 
> > > I seem to get a few more, I have some out of tree patches enabling the SLPI,
> > > and iirc the db845c doesn't have a full modem firmware. If these look good
> > > to you I'd appreciate it if you add my Tested-by.
> > 
> > Looks OK to me.
> > 
> > > 
> > > enchilada:/ # for x in /d/qcom_stats/*; do echo $x; cat $x; done
> > > /d/qcom_stats/adsp
> > > Count: 48
> > > Last Entered At: 1199663157
> > > Last Exited At: 1524359015
> > > Accumulated Duration: 793060082
> > > /d/qcom_stats/aosd
> > > Count: 0
> > > Last Entered At: 0
> > > Last Exited At: 0
> > > Accumulated Duration: 0
> > > /d/qcom_stats/cdsp
> > > Count: 35
> > > Last Entered At: 1194818037
> > > Last Exited At: 1194769648
> > > Accumulated Duration: 3223580811
> > > /d/qcom_stats/cxsd
> > > Count: 0
> > > Last Entered At: 0
> > > Last Exited At: 0
> > > Accumulated Duration: 0
> > > /d/qcom_stats/modem
> > > Count: 49
> > > Last Entered At: 3687081003
> > > Last Exited At: 3686727026
> > > Accumulated Duration: 2915592136
> > > /d/qcom_stats/slpi
> > > Count: 53
> > > Last Entered At: 3120905905
> > > Last Exited At: 3120894535
> > > Accumulated Duration: 3218969498
> > > 
> > > Am I right in thinking the aosd and cxsd being all 0 is probably a similar
> > > issue to the one reported by Stephen in [2]?
> > 
> > Might be, I'm not sure. I'll have closer a look.
> > 
> > > 
> > > 
> > > [1]:
> > > 
> > > diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
> > > index 121ea409fafc..56cfb20d3683 100644
> > > --- a/drivers/soc/qcom/qcom_stats.c
> > > +++ b/drivers/soc/qcom/qcom_stats.c
> > > @@ -178,8 +178,12 @@ static void qcom_create_subsystem_stat_files(struct dentry *root,
> > > 
> > >         for (i = 0; i < ARRAY_SIZE(subsystems); i++) {
> > >                 stat = qcom_smem_get(subsystems[i].pid, subsystems[i].smem_item, NULL);
> > > -               if (IS_ERR(stat))
> > 
> > Basically, the error here means the subsystem is not available right at
> > this moment. We could probably return EPROBE_DEFER here, but it really
> > depends on each platform's devicetree what remoteprocs they have
> > enabled or not. So I guess the safest thing to to is to just skip
> > quietly the ones that haven't probed yet.
> > 
> 
> Not only does the/each remoteproc driver need to probe, we actually need
> to wait for them to boot in order to register their parts.
> 
> Perhaps we can use qcom_register_ssr_notifier() to dynamically register
> these at some later time. This does however seem like a reasonable thing
> to improve upon in a follow up series.

Sounds like a good idea. Will give it a try and sent a patch a soon as I
have something working.

Thanks,
Abel

> 
> Regards,
> Bjorn
