Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0A757A8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbiGSU5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbiGSU5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AAC446DB3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658264268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BU1ysNnuX0LIwiZ3pTBxSfBXfotqqRrKjBzOcGKldO4=;
        b=SpMLcAdQ1YpCNTJ0piaNblM3ntZxBP2twOSB02p2eaXY8lMO8I+fR/1ttJehoBUXpZCNrx
        g/RqCFH3npLdCIM6KyDBI8Rl0hROegRw+z+EUsAK2O/PVbaMBowk0tVpajPeczuURA+c9W
        YKT/O3j6kOdANdvnrpuLdHvmNP7EuYI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-j69eLED-NZ-fvpr0UbQc8A-1; Tue, 19 Jul 2022 16:57:41 -0400
X-MC-Unique: j69eLED-NZ-fvpr0UbQc8A-1
Received: by mail-qt1-f198.google.com with SMTP id a18-20020a05622a02d200b0031ed7ae9abeso9443165qtx.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BU1ysNnuX0LIwiZ3pTBxSfBXfotqqRrKjBzOcGKldO4=;
        b=m+SoYdlBeo0MkVN7D5/bcZ2yt22p1ou3W93f3DXeuz+vAGf6yKo5XSuIOVobw5EZbb
         QQf+eAkKSZ3LamgClmIm+9LHMYfS/UbNj30Befq8GmF6J17f08V12Bj828aHhwYGJcvw
         8L7aK8+WjWQbEkKnsRZZuN5M7YpceqJr7U1NoPdA9YMbFDG80Tm08zSCUSUEtBI2H8vm
         Y/jLJxAb50eHIBbWWr2pH48+YtUu3WV0i5WvK/gcALsv08svZNBOftNKCpe2XZnsVPNh
         p2FvLnLaNWOLwaZ0HVR9nNcKFOBlvqTK5l6lDlyMTQCyLrjNT53DRcbp1lG4ISom4KhD
         OrzA==
X-Gm-Message-State: AJIora/888tr6hTq07mliLOmY4K54UTsRhV9UYKEqBj52LfR0UJln8KH
        8/I/AXScoicwmOoJVb2K4bUELc70g/fGvJ06OLcDIbR2OYZy9QGEfgEcMj9n+sydaoqJ7yN5NdW
        qtm05P6m2RSA65FOjT1VNZO69
X-Received: by 2002:a05:6214:c4e:b0:473:276:9a0d with SMTP id r14-20020a0562140c4e00b0047302769a0dmr26679739qvj.34.1658264260551;
        Tue, 19 Jul 2022 13:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tgsBqiDB0vtpYN6xkBWfSCmwv8Yq3yxes/XhPK91Pu3WugSMA0l7MwHatd1f2v4sbX84YIRA==
X-Received: by 2002:a05:6214:c4e:b0:473:276:9a0d with SMTP id r14-20020a0562140c4e00b0047302769a0dmr26679729qvj.34.1658264260350;
        Tue, 19 Jul 2022 13:57:40 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::2e])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a0c4c00b006a6ebde4799sm15890370qki.90.2022.07.19.13.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:57:40 -0700 (PDT)
Date:   Tue, 19 Jul 2022 15:57:38 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] i2c: qcom-geni: Propagate GENI_ABORT_DONE to
 geni_i2c_abort_xfer()
Message-ID: <20220719205738.j6cxwuogbqtqfjnw@halaneylaptop>
References: <20220717035027.2135106-1-bjorn.andersson@linaro.org>
 <20220717035027.2135106-3-bjorn.andersson@linaro.org>
 <20220719205054.rdhinuwxgabbsiht@halaneylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719205054.rdhinuwxgabbsiht@halaneylaptop>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:50:54PM -0500, Andrew Halaney wrote:
> On Sat, Jul 16, 2022 at 08:50:26PM -0700, Bjorn Andersson wrote:
> > Waiting for M_CMD_ABORT_EN in geni_i2c_abort_xfer() races with the
> > interrupt handler which will read and clear the abort bit, the result is
> > that every abort attempt takes 1 second and is followed by a message
> > about the abort having times out.
> > 
> > Introduce a new state variable to carry the abort_done state from the
> > interrupt handler back to geni_i2c_abort_xfer().
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/i2c/busses/i2c-qcom-geni.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> > index 3bec7c782824..e212e7ae7ad2 100644
> > --- a/drivers/i2c/busses/i2c-qcom-geni.c
> > +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> > @@ -97,6 +97,7 @@ struct geni_i2c_dev {
> >  	struct dma_chan *tx_c;
> >  	struct dma_chan *rx_c;
> >  	bool gpi_mode;
> > +	bool abort_done;
> >  };
> >  
> >  struct geni_i2c_err_log {
> > @@ -203,9 +204,14 @@ static void geni_i2c_err(struct geni_i2c_dev *gi2c, int err)
> >  		dev_dbg(gi2c->se.dev, "len:%d, slv-addr:0x%x, RD/WR:%d\n",
> >  			gi2c->cur->len, gi2c->cur->addr, gi2c->cur->flags);
> >  
> > -	if (err != NACK && err != GENI_ABORT_DONE) {
> > +	switch (err) {
> > +	case GENI_ABORT_DONE:
> > +		gi2c->abort_done = true;
> > +		break;
> > +	default:
> >  		dev_err(gi2c->se.dev, "%s\n", gi2c_log[err].msg);
> >  		geni_i2c_err_misc(gi2c);
> > +		break;
> >  	}
> >  }
> >  
> 
> If I'm reading this right this changes the behavior on a NACK error now,
> right? Was that intentional?
> 
> Otherwise looks good to me.
> 

Hmmm (I should really review the whole series before hitting send :P ),
it seems you cleaned the NACK stuff up in the next patch in the series.

I guess one more thing, does this patch deserve a Fixes: tag? If so
might be nice to make NACK not so loud in this patch in case it gets
backported without the next patch.

Thanks,
Andrew

> > @@ -311,21 +317,21 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
> >  
> >  static void geni_i2c_abort_xfer(struct geni_i2c_dev *gi2c)
> >  {
> > -	u32 val;
> >  	unsigned long time_left = ABORT_TIMEOUT;
> >  	unsigned long flags;
> >  
> >  	spin_lock_irqsave(&gi2c->lock, flags);
> >  	geni_i2c_err(gi2c, GENI_TIMEOUT);
> >  	gi2c->cur = NULL;
> > +	gi2c->abort_done = false;
> >  	geni_se_abort_m_cmd(&gi2c->se);
> >  	spin_unlock_irqrestore(&gi2c->lock, flags);
> > +
> >  	do {
> >  		time_left = wait_for_completion_timeout(&gi2c->done, time_left);
> > -		val = readl_relaxed(gi2c->se.base + SE_GENI_M_IRQ_STATUS);
> > -	} while (!(val & M_CMD_ABORT_EN) && time_left);
> > +	} while (!gi2c->abort_done && time_left);
> >  
> > -	if (!(val & M_CMD_ABORT_EN))
> > +	if (!time_left)
> >  		dev_err(gi2c->se.dev, "Timeout abort_m_cmd\n");
> >  }
> >  
> > -- 
> > 2.35.1
> > 

