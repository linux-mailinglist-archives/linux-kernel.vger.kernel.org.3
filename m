Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EA64B7A88
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiBOWjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:39:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBOWjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:39:08 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA81BBF51A;
        Tue, 15 Feb 2022 14:38:57 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id p23so346272pgj.2;
        Tue, 15 Feb 2022 14:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pmu0kzHupXHbf/q4IYLdojHnEWj4eQimF9pY5ure/SY=;
        b=bea8ynOaRdl22JCKg/Weqxl0uPFQW3daaV6s6gDRLIQLJED36t1TwLjhWoVaRY33J3
         L9hNX4ZEm49bOnnXdK7kXCWvsLGONYf2NPIa51ME08YuvgI3PeVCBzkztTXVQX05m2CM
         M3locmPP9P1W7zG5Tr8gCfotbnYk328B/tYrRBtq+jWc31fzTyMnuHL26x/ATcWua/kr
         OWmo9amaLfKuO7ZgZi3UotWcbErNSXURm3wZc08Am3G4g3z+EFLJuvj4H/kN1RWVHcu/
         mIUk9VQLddjyC8Vs2pi5uMVWEPhWvDx/ILnp8UG9Mldkl6yPd5vNuAAUA6gpZnnlyj2r
         3BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pmu0kzHupXHbf/q4IYLdojHnEWj4eQimF9pY5ure/SY=;
        b=ZxGasYmLXGv8407cEt67e+CU+/8raHy51XPc+zIWpMA1rnIzBJm+slDiAV19bCsYvs
         +N2bdvL/yFLb6PrCIXDHm3/uI/sBHdxv4sv9hILFVFVpOjDowl8Ow53AFb8JzHd7iEXq
         B9aJd+mNd5qxPZ8wmaJdizo3wvvD4zgF0cd2XlqRosNeu23IZcMWxkal8WXn7T8JfcXA
         EE8HP1RlFPmxF7tSa3X5pj7rC+RFzmmnKZRGTQgGbQZ+NJkzA+KOSfO6bkz7/lz5yuS/
         Bw7SVmh/MGptKyS1Gkp5jFTx5x8421Jli5VOjbhROaw/pPaG6zhZz/kxkiwI8vHEDm6+
         e7Rw==
X-Gm-Message-State: AOAM532r3AdIuz0TsQddNiiPuhqNEyxyDq5U+KBdi1NilhemkUsHp9PN
        +B266GpWrWhMkFFf92wG5jY=
X-Google-Smtp-Source: ABdhPJznZ0IpeTM+ttjQzn3ISkxHiNPMnva2B6w0fM+Q+N+4m9T5KceFcQ/+nz160UQLBeVgBNajlg==
X-Received: by 2002:a05:6a00:190e:: with SMTP id y14mr888751pfi.52.1644964737244;
        Tue, 15 Feb 2022 14:38:57 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4e4a:b0ff:e926:40e2])
        by smtp.gmail.com with ESMTPSA id c14sm39445059pfm.169.2022.02.15.14.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 14:38:56 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:38:54 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 1/4] input: ps2-gpio: refactor struct ps2_gpio_data
Message-ID: <YgwrfhIp44GMF/OV@google.com>
References: <20220215160208.34826-1-danilokrummrich@dk-develop.de>
 <20220215160208.34826-2-danilokrummrich@dk-develop.de>
 <YgwhJkRGdduf5oYc@google.com>
 <Ygwn1ZhLGuWctfkP@pollux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygwn1ZhLGuWctfkP@pollux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 11:23:17PM +0100, Danilo Krummrich wrote:
> Hi Dmitry,
> 
> On Tue, Feb 15, 2022 at 01:54:46PM -0800, Dmitry Torokhov wrote:
> > Hi Danilo,
> > 
> > On Tue, Feb 15, 2022 at 05:02:05PM +0100, Danilo Krummrich wrote:
> > 
> > > +static inline struct ps2_gpio_data *
> > > +to_ps2_gpio_data(struct delayed_work *dwork)
> > > +{
> > > +	struct ps2_gpio_data_tx *txd = container_of(dwork,
> > > +						    struct ps2_gpio_data_tx,
> > > +						    work);
> > > +
> > > +	return container_of(txd, struct ps2_gpio_data, tx);
> > > +}
> > > +
> > >  static void ps2_gpio_tx_work_fn(struct work_struct *work)
> > >  {
> > >  	struct delayed_work *dwork = to_delayed_work(work);
> > > -	struct ps2_gpio_data *drvdata = container_of(dwork,
> > > -						    struct ps2_gpio_data,
> > > -						    tx_work);
> > 
> > This can simply be written as:
> > 
> > 	struct ps2_gpio_data *drvdata = container_of(dwork,
> > 						     struct ps2_gpio_data,
> > 						     tx.work);
> > 
> > No need to resubmit unless you disagree - I can change it on my side.
> Thanks, please do so.
> 
> The tx and rx members of struct ps2_gpio_data can then be anonymous structs.
> Do you mind changing that too? Or should I resubmit?

I will.

Thanks.

-- 
Dmitry
