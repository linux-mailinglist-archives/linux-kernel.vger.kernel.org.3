Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D8D587975
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiHBI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiHBI6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:58:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477524D83F;
        Tue,  2 Aug 2022 01:58:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z19so12884153plb.1;
        Tue, 02 Aug 2022 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=nWqh6KG5a1Ft7mZyLnhDTkUYadJU0/RKzxkHOlg+eQk=;
        b=dqtssUq3NP8S6rOLiBW510fa535GnJ1INIodTRrzqZ8N5ar+LkDdXfLF5juIgDLCra
         DwLb0QLd4EMhapQbXv6qPwaDTt3iElMs33rthDr5DWVbjtTA2Z9zpQNfPDyrzZFN+rrs
         Hpw02es/Zivahi/5Lwfb/CBjncGhK8sykPeY70edIEXWkDAyc2KEVAa5akzBA8ImDoCe
         eDEAzAcGhhebYYdj1EG+CVuFihRxzeCaCaDnEARWjUeS8pwcYdY5/bak0kewnwY7TYyW
         U7clUrt+dEt2VDWStq7AX7F1CmC5lVZhErU8Z55MwAxUKdroclCSU8pJZYRIoXC3x3l0
         khgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=nWqh6KG5a1Ft7mZyLnhDTkUYadJU0/RKzxkHOlg+eQk=;
        b=kJY00mSeFMDF1vgg/CBgwyvRJNfIEm/GrO11zHyN2NVNTl3l18kylIOcTGVbHl9l2E
         WJhyZzWFYUUzAlX6YEqmzP5xSCdPhxj6hT0Gn0LMqtDKZKbeJecxgUq5bsMSg11IKYOv
         GnNAcNRQCej/35BvIy0k7k8SNIOvBCJwW1i+YrYb6XzdHjfW76iHNzk+pGLX65FIQWCy
         bDpbb79Qxgyg1FSicI0+5XaNEk9Vw/GhuPa+szXPlwjrl8HDlqWsUTGyk3DAKxp//bxz
         DGi5V9Vb/i0xCq9QP4stRCjUjgZQZvyyCvyYmGbGh+ZVazHW6HDJwrK7VKeQphzkxlat
         GkYw==
X-Gm-Message-State: ACgBeo2IRRE+PG1zlEbWlVOMQ14DTSLPOaMyecwg3XGaE3LyfUALUFuF
        4F07Pu+4Xf+D8OhPbLJ9sw0=
X-Google-Smtp-Source: AA6agR6P8z2E8EFi66AxmUjTPwBg/ty9OUo6EdUPvZB6uqRlwYESXq8ZiAlIRhTsegZxVs3eXQwJ+A==
X-Received: by 2002:a17:90a:e2cc:b0:1f3:1151:e0ff with SMTP id fr12-20020a17090ae2cc00b001f31151e0ffmr23828121pjb.50.1659430731586;
        Tue, 02 Aug 2022 01:58:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903244900b0016dc307aef4sm11277071pls.36.2022.08.02.01.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 01:58:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 2 Aug 2022 01:58:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Gene Chen <gene.chen.richtek@gmail.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        gene_chen@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v3 4/7] usb: typec: tcpci_rt1711h: Add initial phy setting
Message-ID: <20220802085848.GA3096405@roeck-us.net>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
 <20220801101447.86207-5-gene.chen.richtek@gmail.com>
 <YujeA2pHG2WnZjaF@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YujeA2pHG2WnZjaF@kuha.fi.intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:19:15AM +0300, Heikki Krogerus wrote:
> Hi Gene,
> 
> On Mon, Aug 01, 2022 at 06:14:44PM +0800, Gene Chen wrote:
> > From: Gene Chen <gene_chen@richtek.com>
> > 
> > Add initial phy setting about phy dicard retry,
> > rx filter deglitech time and BMC-encoded wait time
> 
> I'm sorry, but what does "deglitech" mean? Is it just a typo?
> 

deglitch ?

> > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > index df7bfe299987..33d8ea95b7c1 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> > @@ -20,6 +20,9 @@
> >  #define RT1711H_VID		0x29CF
> >  #define RT1711H_PID		0x1711
> >  
> > +#define RT1711H_PHYCTRL1	0x80
> > +#define RT1711H_PHYCTRL2	0x81
> > +
> >  #define RT1711H_RTCTRL8		0x9B
> >  
> >  /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
> > @@ -107,8 +110,18 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
> >  		return ret;
> >  
> >  	/* dcSRC.DRP : 33% */
> > -	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> > +	ret = rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Enable phy discard retry, retry count 7, rx filter deglitech 100 us */
> > +	ret = rt1711h_write8(chip, RT1711H_PHYCTRL1, 0xF1);
> > +	if (ret < 0)
> > +		return ret;
> >  
> > +	/* Decrease wait time of BMC-encoded 1 bit from 2.67us to 2.55us */
> > +	/* wait time : (val * .4167) us */
> > +	return rt1711h_write8(chip, RT1711H_PHYCTRL2, 62);
> >  }
> >  
> >  static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
> > -- 
> > 2.25.1
> 
> thanks,
> 
> -- 
> heikki
