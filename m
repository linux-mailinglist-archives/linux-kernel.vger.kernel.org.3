Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EB450E0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiDYNDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239806AbiDYNC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2308113FB3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650891578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DnYEkw8ulZZ9zI2h3SIen3Sz7tMMDf8FghFH38SaqtA=;
        b=TdvZFGNNiKXbuw5TfT+DufT5lE6My53TbGe3/1LmTXUYJxpngjVK7GFkN5kuK7EvKkEIu1
        iVLCIiHQmts/sFgLRlZrsZhohJERN2v139BNMQwxwgC/K9kZ5+lFL+qvAttXVm5fi6Aki5
        YjvaPcNJuy16/EuioXbem90EWYF9CDk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-eekxLXqQO-OJFkKCj6nInw-1; Mon, 25 Apr 2022 08:59:37 -0400
X-MC-Unique: eekxLXqQO-OJFkKCj6nInw-1
Received: by mail-qk1-f198.google.com with SMTP id s63-20020a372c42000000b0069ec0715d5eso9617847qkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DnYEkw8ulZZ9zI2h3SIen3Sz7tMMDf8FghFH38SaqtA=;
        b=pEhKsKeFj4y1zSrOo8o7gXE2GNIeuR/+f4wjt+Nh1W7iyR1gW4SKtgcTeYk9sGBLMv
         8hqj1jO8jqsGBf7mvi8wmhKnz5iux++lCWVfkUOegQ33CGTGgoFg3uxpCOgVzFB9RbMo
         gHVXgqKr0/pFQGFLC540C6w4U9CdIU2yLN96BSrnVkku1u2gnBiZBbnkw50was0h0bz0
         8Mf4exIHufj5+YBc+3+lBq5vVt3KgmR7xyV2LO4jss5akt8IB6PUe9mTant1hbQG+LyA
         1i6bjC6floVXhBttOMJDvY4Ei67Ly+psCPlyavSir4AodDfvDavZ3IXN5ixLwveDT07D
         xxuw==
X-Gm-Message-State: AOAM532YGaRtRGRT621W1dZ2OpuYdrnnnVcuPzUXpQ/MgLSaA3V699JO
        f2ptxYuDUfnIC91+Dys2JfmL8QTR8C39QEDUEJNsJzVeiEoKFTjOJSu+C1m14Ha6mHYx4SbXrNH
        jD1BTIEbrJc69L2icqnqGa0Wm
X-Received: by 2002:ad4:5be8:0:b0:44e:b1dd:49dd with SMTP id k8-20020ad45be8000000b0044eb1dd49ddmr12215251qvc.57.1650891575420;
        Mon, 25 Apr 2022 05:59:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysjc4g9+k5z/ZgAsfyFPnG8gT7QemK7pZ8EjCjjux5cSOsib6kKtaTFEXjZGt0O10zOOulRg==
X-Received: by 2002:ad4:5be8:0:b0:44e:b1dd:49dd with SMTP id k8-20020ad45be8000000b0044eb1dd49ddmr12215241qvc.57.1650891575205;
        Mon, 25 Apr 2022 05:59:35 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id v14-20020a05622a144e00b002f1f32f86a6sm5974951qtx.5.2022.04.25.05.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 05:59:34 -0700 (PDT)
Date:   Mon, 25 Apr 2022 07:59:31 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com,
        linux-arm-msm@vger.kernel.org, quic_asutoshd@quicinc.com,
        quic_cang@quicinc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bvanassche@acm.org
Subject: Re: [PATCH v2 1/5] scsi: ufs: qcom: Fix acquiring the optional reset
 control line
Message-ID: <20220425125931.g3ub2fprsfa56bl6@halaneylaptop>
References: <20220423140245.394092-1-manivannan.sadhasivam@linaro.org>
 <20220423140245.394092-2-manivannan.sadhasivam@linaro.org>
 <YmQURV7yQMof4RB8@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmQURV7yQMof4RB8@ripper>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 07:59:17AM -0700, Bjorn Andersson wrote:
> On Sat 23 Apr 07:02 PDT 2022, Manivannan Sadhasivam wrote:
> 
> > On Qcom UFS platforms, the reset control line seems to be optional
> > (for SoCs like MSM8996 and probably for others too). The current logic
> > tries to mimic the `devm_reset_control_get_optional()` API but it also
> > continues the probe if there is an error with the declared reset line in
> > DT/ACPI.
> > 
> > In an ideal case, if the reset line is not declared in DT/ACPI, the probe
> > should continue. But if there is problem in acquiring the declared reset
> > line (like EPROBE_DEFER) it should fail and return the appropriate error
> > code.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/scsi/ufs/ufs-qcom.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> > index 0d2e950d0865..bee81b45299e 100644
> > --- a/drivers/scsi/ufs/ufs-qcom.c
> > +++ b/drivers/scsi/ufs/ufs-qcom.c
> > @@ -1002,13 +1002,13 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> >  	host->hba = hba;
> >  	ufshcd_set_variant(hba, host);
> >  
> > -	/* Setup the reset control of HCI */
> > -	host->core_reset = devm_reset_control_get(hba->dev, "rst");
> > +	/* Setup the optional reset control of HCI */
> > +	host->core_reset = devm_reset_control_get_optional(hba->dev, "rst");
> >  	if (IS_ERR(host->core_reset)) {
> >  		err = PTR_ERR(host->core_reset);
> > -		dev_warn(dev, "Failed to get reset control %d\n", err);
> > -		host->core_reset = NULL;
> > -		err = 0;
> > +		if (err != -EPROBE_DEFER)
> 
> dev_err_probe() does this comparison internally, so you can omit it
> here.
> 
> With that removed, feel free to add my:
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Regards,
> Bjorn

+1; well with that change in place:
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

Thanks,
Andrew

> 
> > +			dev_err_probe(dev, err, "Failed to get reset control\n");
> > +		goto out_variant_clear;
> >  	}
> >  
> >  	/* Fire up the reset controller. Failure here is non-fatal. */
> > -- 
> > 2.25.1
> > 
> 

