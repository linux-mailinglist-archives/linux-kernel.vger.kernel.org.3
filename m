Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8FD4F8C41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiDHB5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiDHB5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:57:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C23012AB8;
        Thu,  7 Apr 2022 18:55:14 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so6518616pgn.8;
        Thu, 07 Apr 2022 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hI18x8EShCh6u/OSRZhfVvmBndg8lGk6b9c0xztI+3s=;
        b=FLPhmCktgsZgvlN+18ij8yNp+Tlt2UAQMSBDxvUoTW8+a7uLlHgIo6yphYk0+dXmi/
         9UOcmLVCNotGU3YsSAu9A/wVfI5XeoL+56WfRvc2ldIoIGXnVGypyVSSktE2EeXOFTw8
         QV4UaEvepGY30uiSCoxPR1UUBsz469nwcNcWGwFUO7/Z3NuQGwrLWiQH4zXF7V7+gY56
         NdkemoQwMvJfZhuHNfw/rcwQzKFQSXl5PGGqQpMi4nuXE23x2GcWpKczywA+fCFPBU87
         vMg5Zrkzwgk0vyuqGcPzxPd1bm9111TID3Uq92LvfGQ2DDTuB/unlfUOJ8K+droHyDI2
         Zivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hI18x8EShCh6u/OSRZhfVvmBndg8lGk6b9c0xztI+3s=;
        b=xeXP2QT4ARQ4y0Q8jG9Eu0+zFJDXY3hm4GTMcr+lO4SuRFHKY/vCN6ogD3W5dF5cT5
         XjIaD1ywVjV42quip2viYfWKNXgL4cjI+35HfLkwBY7AP2bNw8toOlkJsRUwDjsjyYRj
         EjKbP0n7Ci/0yedeme935sqQ41ZuUl4GP9OYbclCKRsBZO9/vKfw873cqJj5/Mo1jERN
         1KAduL3ICURulkY0KEahLlaPIGlvNRIMwCeY6R2Z94mQ5dpuTicQLe5QtA1KaVr/egej
         /y5i9NlAeu2CRbvTKoZHFTt5+c6Cf32QPjXuOqIarDNxDb0hzaB7CarC+WXu/hwNvdi+
         v5vA==
X-Gm-Message-State: AOAM530Wl8sZpTDqBpsuVTTbII6RmxsXfYI9LaUpWuYOWaroM9kNEzmN
        h0UF2iv6ZM2gn24aEtIzGOPA7gPv64mG+Lfl
X-Google-Smtp-Source: ABdhPJxofAavVEN8O+91iZknxlfVM8u9NmqL241K/rKhsVRhl2Sgpg2gcWDVst2Wu4P0pYZPYW06HA==
X-Received: by 2002:a63:5847:0:b0:399:3452:ffe4 with SMTP id i7-20020a635847000000b003993452ffe4mr13500815pgm.406.1649382913933;
        Thu, 07 Apr 2022 18:55:13 -0700 (PDT)
Received: from VICKYMQLIN-NB1.localdomain ([159.226.95.33])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b0050567221317sm4129530pfp.94.2022.04.07.18.54.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Apr 2022 18:54:56 -0700 (PDT)
Date:   Fri, 8 Apr 2022 09:54:38 +0800
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bin Liu <b-liu@ti.com>, Roger Quadros <rogerq@ti.com>,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: musb: Fix missing of_node_put() in omap2430_probe
Message-ID: <20220408015438.GA138@VICKYMQLIN-NB1.localdomain>
References: <20220309111033.24487-1-linmq006@gmail.com>
 <YiiOj3n3ocUr+/68@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YiiOj3n3ocUr+/68@kroah.com>
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

On Wed, Mar 09, 2022 at 12:25:03PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 09, 2022 at 11:10:33AM +0000, Miaoqian Lin wrote:
> > The device_node pointer is returned by of_parse_phandle() with refcount
> > incremented. We should use of_node_put() on it when done.
> > 
> > Fixes: 8934d3e4d0e7 ("usb: musb: omap2430: Don't use omap_get_control_dev()")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> >  drivers/usb/musb/omap2430.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> > index 7d4d0713f4f0..4a963cfa385b 100644
> > --- a/drivers/usb/musb/omap2430.c
> > +++ b/drivers/usb/musb/omap2430.c
> > @@ -363,6 +363,7 @@ static int omap2430_probe(struct platform_device *pdev)
> >  	control_node = of_parse_phandle(np, "ctrl-module", 0);
> >  	if (control_node) {
> >  		control_pdev = of_find_device_by_node(control_node);
> > +		of_node_put(control_node);
> >  		if (!control_pdev) {
> >  			dev_err(&pdev->dev, "Failed to get control device\n");
> >  			ret = -EINVAL;
> > -- 
> > 2.17.1
> > 
> 
> How was this tested?

Hi, Greg Kroah-Hartman

    I mainly went through the specifications of of_parse_phandle() and
 of_find_device_by_node(), and checked their usages in the codebase
 to infer their correct usages then found out the deviant one, and
 manually confirmed it. 

    In doc of of_parse_phandle() it mentions : 
 > Return: The device_node pointer with refcount incremented.  Use 
 > * of_node_put() on it when done. 
    In the doc of  and of_find_device_by_node() it mentions:
 > * Takes a reference to the embedded struct device which needs to
 > be dropped
 > * after use.

    In this case, control_node is a local variable, and it never be used
 after of_find_device_by_node(), of_find_device_by_node() call will
 take its own reference. So the reference holded by control_node
 should be released.

    I checked the usages
 pattern——`$ret=of_parse_phandle();of_find_device_by_node($ret);` in
 codebase and most of them handle the reference after use.
 For example: 
 - function pwm_omap_dmtimer_probe in drivers/pwm/pwm-omap-dmtimer.c 
 - function mtk_smi_device_link_common in drivers/memory/mtk-smi.c, 
 - function devm_tegra_memory_controller_get in
      drivers/memory/tegra/mc.c.

    I also took similar bugfixes for reference, for exmaple:
 - commit c8d0ccfd73da ("media: mtk-vpu: fix leaked of_node references") 
 - commit 3d38faef0de1 ("ath11k: add missing of_node_put() to avoid leak") 
    
    So I sent patch for this one. Still not sure if it's correct,
    I hope the developers could double check this, Thanks.
