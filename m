Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171E854BDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbiFNW3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345198AbiFNW3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:29:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761A652526
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:28:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so2094346pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KRnsDnmzLVNJLD4XQT4OOkfWd3Wv3kaVliobD56LDKY=;
        b=eeK29CNLmpmnGvffPElFI3R5kizjdYTm2bmjh3/DAtzRv4bxOEbQtqE0k+ChAX8hPf
         BdhRkSeyr0admaHZEvD8srfe/iRbFt2VSGfoVBL/CepvGCqAde+/m2WJSuQTyzMSSKWI
         bm2R37DaoGnSuaDulrkvjmT4YcyK9tZN5f+4xihtv73rOLWxgheTePZyjXVafO3kRfDx
         KbIgjzGONeT6zfgdCRJoamh5GQ1+eM6MgqzhoQK2nLq/QIG3PY6DCHU/3Av+ZHxHHPo+
         9wiIlwS1ynUbq7L9V2zB9dD37ek9s2NoG5NgEbUPyqqctLiGbCiHE5EctHu9GckDdfH+
         v5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KRnsDnmzLVNJLD4XQT4OOkfWd3Wv3kaVliobD56LDKY=;
        b=I2dHyfoBgK1r25xGmdItU6YSPd1GUSO0YBPAdkkPFjlzmSqzsSp6KMgP19a1FOQWM2
         tn9IQtl705fT61LLbT81ZoQGNgD+2H4tg5ZqrdDVbCYpZRPTrYApV1883ijOY5w82r3q
         zv70u010Eq01YUQgofs8wL+YZ74PlfULGsiNRGOmTUIAV2tVO6G4Cdl0QgkCCfNBkc56
         aEGqwT5umXa2lklUsx+22kIjvgIwnJ6SxbBWLW71nrjhRXp1Jyq/YnS3gvZvtJFrdki0
         OBh68qZ65j1AA1sLci+bOVjllz16ONhT8KobbwpEk0/gp3CHOSSVWtUHz6rGXWQ9uu2z
         RuXw==
X-Gm-Message-State: AJIora8mya4rehJ8zW+d8m96LSVZsW30lYTJ+geYtJob1KNP6qU4dSgG
        VcFaqP7O43ukVe9A6Dy2z40pyg==
X-Google-Smtp-Source: AGRyM1v+i/wHlb7BJZUwkeZoDYuk2cZeUxb+qwT1JnX5NVO7/5IejyC4N3W0/iW3bCy4FUzjTlNAtQ==
X-Received: by 2002:a17:90b:4c0c:b0:1ea:87ef:546a with SMTP id na12-20020a17090b4c0c00b001ea87ef546amr6724342pjb.209.1655245738693;
        Tue, 14 Jun 2022 15:28:58 -0700 (PDT)
Received: from p14s ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d90300b00163c0a1f718sm7746920plz.303.2022.06.14.15.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 15:28:57 -0700 (PDT)
Date:   Tue, 14 Jun 2022 16:28:54 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: Re: [RESEND PATCH] rpmsg: char: Add mutex protection for
 rpmsg_eptdev_open()
Message-ID: <20220614222854.GA1236509@p14s>
References: <1653104105-16779-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653104105-16779-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 11:35:05AM +0800, Shengjiu Wang wrote:
> There is no mutex protection for rpmsg_eptdev_open(),
> especially for eptdev->ept read and write operation.
> It may cause issues when multiple instances call
> rpmsg_eptdev_open() in parallel,the return state
> may be success or EBUGY.
> 
> Fixes: 964e8bedd5a1 ("rpmsg: char: Return an error if device already open")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in resend:
> - add fixes tag
> 
>  drivers/rpmsg/rpmsg_char.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

I have applied your patch.

Thanks,
Mathieu

> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index b6183d4f62a2..4f2189111494 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -120,8 +120,11 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  	struct rpmsg_device *rpdev = eptdev->rpdev;
>  	struct device *dev = &eptdev->dev;
>  
> -	if (eptdev->ept)
> +	mutex_lock(&eptdev->ept_lock);
> +	if (eptdev->ept) {
> +		mutex_unlock(&eptdev->ept_lock);
>  		return -EBUSY;
> +	}
>  
>  	get_device(dev);
>  
> @@ -137,11 +140,13 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
>  	if (!ept) {
>  		dev_err(dev, "failed to open %s\n", eptdev->chinfo.name);
>  		put_device(dev);
> +		mutex_unlock(&eptdev->ept_lock);
>  		return -EINVAL;
>  	}
>  
>  	eptdev->ept = ept;
>  	filp->private_data = eptdev;
> +	mutex_unlock(&eptdev->ept_lock);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
