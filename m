Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF94C8476
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiCAG72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiCAG7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:59:24 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4456D5BD32;
        Mon, 28 Feb 2022 22:58:44 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id k1so2844305pfu.2;
        Mon, 28 Feb 2022 22:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/AOz6Dw1JtsymBiTGNnegbiJwv4+5x9HVJ++91SKk8g=;
        b=Jdj9Yip5Qnv5RVJsT1rpYbhROmx9iK8d7CEEUOJNIxZjykLsiCNboYukCMhKDrTjIl
         NhsDXheGuxNwRDhXHmbtlv0Kg/r5cOJPMg8WSHxAdMSEcDlQa3uCO0T8xxXZFsQ68kGk
         RITs+SRLqbDH7VvR3y89heCEIevuG4QzT7aQPtYZK9tscwvI2xzugmQuu5w6kzxDb3QZ
         aG0/EOnxSSFeHNB+pXbtuvF/B/xDI6kGvyAmxy0D/JHIZTXbFrG9VYR6P42J0JYMpalU
         ftVujL5RAAF2sEdpV+xtXdBGc1A2yvrqY75A1E1PWhUMEHo46KDXTmLPUsLnUy4hiCoH
         BwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/AOz6Dw1JtsymBiTGNnegbiJwv4+5x9HVJ++91SKk8g=;
        b=n2RAnbKZ++7SRb5SH5Nrf6wZvVPez9ZnQG6E7ZgDzFKzEEuptnqNBGpWnIG42TaocE
         0UiPZjQC6gnhth82QXdwCaN9+OvovfF2MZ88Op/dXO5CXVSgMF1duljvlui1wrZG68WF
         jTz6pN/13TAVng1rHVQu+7iqmUCmRK49Ws4tHqEyt2uhvGaRLtfE+LvV4yv5zwluT8Nv
         iOzAn+lyJK9Ba8KIgw+ln44C2D5upmhxsE5LqoGhDFkuZOQ7VtZhfXxBiUwxHpOcvxqh
         Zs79JA7opE3NILTCji0OhMjslQ/G+E4c1zEG7bv3l2fibGxi7gclACLiEISVqYKo8j9L
         0glg==
X-Gm-Message-State: AOAM531tKcO5G1GMvFVK4O6CuIst7AUgCGGzT4THZLaiC2v0WqKyJhFK
        p6psnKs/Jeyy+3TI80cvpS4=
X-Google-Smtp-Source: ABdhPJwEgZ+AzZYKv8fA8bfXZUkohbocb9ZzAtZULVy3z5nCKcYryQqkLVLu5vagpeC1CMw5+wkJLA==
X-Received: by 2002:a05:6a00:10c9:b0:4ce:146e:6edf with SMTP id d9-20020a056a0010c900b004ce146e6edfmr26035374pfu.6.1646117923787;
        Mon, 28 Feb 2022 22:58:43 -0800 (PST)
Received: from VICKYMQLIN-NB1.localdomain ([5.44.249.43])
        by smtp.gmail.com with ESMTPSA id l2-20020a056a0016c200b004e10af156adsm16285292pfc.190.2022.02.28.22.58.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Feb 2022 22:58:43 -0800 (PST)
Date:   Tue, 1 Mar 2022 14:58:37 +0800
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        Brian Masney <masneyb@onstation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: ocmem: Fix missing put_device() call in
 of_get_ocmem
Message-ID: <20220301065837.GA106@VICKYMQLIN-NB1.localdomain>
References: <20220107073126.2335-1-linmq006@gmail.com>
 <YfhfT0EC393GxSRd@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfhfT0EC393GxSRd@builder.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andersson:

> Your patch solves the particular problem, so I'm applying it.
> 
> But it seems that we never release pdev in the case of successfully
> return the ocmem object either... So there's more to improve here.
> 
Thanks for your time. Should I submit another patch to release pdev 
in the regular path?

> >  drivers/soc/qcom/ocmem.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
> > index d2dacbbaafbd..97fd24c178f8 100644
> > --- a/drivers/soc/qcom/ocmem.c
> > +++ b/drivers/soc/qcom/ocmem.c
> > @@ -206,6 +206,7 @@ struct ocmem *of_get_ocmem(struct device *dev)
> >  	ocmem = platform_get_drvdata(pdev);
> >  	if (!ocmem) {
> >  		dev_err(dev, "Cannot get ocmem\n");
> > +		put_device(&pdev->dev);
> >  		return ERR_PTR(-ENODEV);
> >  	}
> >  	return ocmem;
> > -- 
> > 2.17.1
> > 
