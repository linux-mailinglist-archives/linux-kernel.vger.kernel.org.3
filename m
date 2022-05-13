Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7637152648C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381201AbiEMOdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380925AbiEMO3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:29:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F479941B2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:28:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d22so8086977plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+QQdCynx9R6U6w/GBf0MKxMrNELH2gn+H5u0wn8VzXI=;
        b=qV51SP4bOcD0/cAU86xbrh+y3FdrsrCiQ/Bqp4lxWyyZjye8rk5+XElov551PASVRY
         D4ESwLtpEly+3JTdCMw99va5kEsNbH50qP3PhuThC3W4qFU0FjfCbTZ2jEd/xkEvfhzd
         xTe4pmEvx2R/9j+wbCJXDI9d3THSMLg2xlWA4VsLGVxhRr2uRRDbL3kPvt0dAU9WT5Iu
         JuiVzhfSCWcytG3zd7br6Gob8cSnaJyInz/2DsEMmzzcsE/P+2uhWz6w/ZD8JjGB+9w2
         CCJo6kPnJSaLlVja/gYUUe7C9pYOKQoZAHtTb4vdtf5wfpNhYFESthNKiO+pc1yb80Br
         7vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+QQdCynx9R6U6w/GBf0MKxMrNELH2gn+H5u0wn8VzXI=;
        b=36KHjdDU4T5GEgBwz1Bo9dCYAINrtr59cEEeXHclg2eSa7DUwrVw3Ooj5/x768HlvL
         PWR/qghSASGy6kVUmYIflA85psWCmTf46jwzvGoTh41sOtAxws3+18Zov/JwMamQeEtO
         Ecng6rJunM5FXoWnOfvHw1dyzZfJWTaOGgxTXLkefC25GrnhJnBm2LQl2RmOsqrxay1+
         uGYC+HyLQ10L/SqGhjNHCzQEaTTkpuhNpBkrWVUCTKEsR8EjyuqKUN3YVs4AndjxP981
         M/677UjSgXmTCL4qtngWBVzMQDRIJQjXCdzXZPbi1SZNGuxMfmJdYdNCnWfRfn3deRCw
         w55A==
X-Gm-Message-State: AOAM533qb502a2WD/d7kSRlQt7QvgbMIfxlxIinHdgyvEB6kndypldDb
        5sssD31oY326V487J1cY7Y6OMQu/XeCIGQ==
X-Google-Smtp-Source: ABdhPJyUkw0Dot81TbFysPPUNr3WVmg1+FbhuOz8hiv6Yq1uHVvAQecgrf+in/8vjWiDz1CBG7OujQ==
X-Received: by 2002:a17:902:aa85:b0:155:ceb9:3710 with SMTP id d5-20020a170902aa8500b00155ceb93710mr4874209plr.59.1652452080864;
        Fri, 13 May 2022 07:28:00 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id j16-20020a634a50000000b003c14af50639sm1650442pgl.81.2022.05.13.07.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:28:00 -0700 (PDT)
Date:   Fri, 13 May 2022 22:27:47 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Andrew Morton' <akpm@linux-foundation.org>,
        liqiong <liqiong@nfschina.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: change "char *bdi_unknown_name" to "char
 bdi_unknown_name[]"
Message-ID: <Yn5q43kblRPTvpDD@FVFYT0MHHV2J.usts.net>
References: <20220512082637.24649-1-liqiong@nfschina.com>
 <20220512130051.94a0c53e5d1498292473975d@linux-foundation.org>
 <4b21dec7e98243b89daea96286c33434@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b21dec7e98243b89daea96286c33434@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 11:06:23AM +0000, David Laight wrote:
> From: Andrew Morton
> > Sent: 12 May 2022 21:01
> > 
> > On Thu, 12 May 2022 16:26:37 +0800 liqiong <liqiong@nfschina.com> wrote:
> > 
> > > "char bdi_unknown_nam[]" string form declares a single variable.
> > > It is better then "char *bdi_unknown_name" which creates two
> > > variables.
> > >
> > > ...
> > >
> > > --- a/mm/backing-dev.c
> > > +++ b/mm/backing-dev.c
> > > @@ -20,7 +20,7 @@ struct backing_dev_info noop_backing_dev_info;
> > >  EXPORT_SYMBOL_GPL(noop_backing_dev_info);
> > >
> > >  static struct class *bdi_class;
> > > -static const char *bdi_unknown_name = "(unknown)";
> > > +static const char bdi_unknown_name[] = "(unknown)";
> > >
> > 
> > heh, fun patch.  We actually do this quite a lot.
> > 
> > 	grep -r "^[a-z].*char \*[a-z].*= \"" .
> > 
> > is a pathetic pattern which catches a lot of them.
> > 
> > 
> > However.  I expected your patch to shrink the kernel a bit, but it has
> > the opposite effect:
> > 
> > hp2:/usr/src/25> size mm/backing-dev.o
> >    text	   data	    bss	    dec	    hex	filename
> >   21288	   9396	   3808	  34492	   86bc	mm/backing-dev.o-before
> >   21300	   9428	   3808	  34536	   86e8	mm/backing-dev.o-after
> > 
> > Even .data became larger.  I didn't investigate why.
> 
> The linker can merge replicated strings
> (ie data in .rodata.str1.n sections)
> but I don't think the compiler puts variables into that section.
> 
> So if you have:
> static const char *const foo_xxx = "foo";
> in multiple source/object files you get lots of pointers
> but only one string.
> OTOH with:
> static const char foo_xxx[] = "foo";
> you get lots of copies of the string.
> Which is smaller depends on the number of variables and the length
> of the string.
>

Good point. I have searched the whole code.  There are 19 places
where use the string "(unknown)".  Seems it is better to drop
this change.

arch/mips/alchemy/devboards/db1xxx.c:48:                return "(unknown)";
drivers/acpi/device_pm.c:44:            return "(unknown)";
drivers/base/component.c:101:                      component ? dev_name(component->dev) : "(unknown)",
drivers/block/rbd.c:5137:                           spec->image_id, spec->image_name ?: "(unknown)",
drivers/gpu/drm/i915/display/intel_dsi_vbt.c:570:               return "(unknown)";
drivers/i3c/master/mipi-i3c-hci/ext_caps.c:50:          "(unknown)", "master only", "target only",
drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c:85:             return "(unknown)";
drivers/platform/x86/thinkpad_acpi.c:7506:                      thinkpad_id.ec_version_str : "(unknown)");
drivers/usb/gadget/udc/omap_udc.c:2800:         type = "(unknown)";
fs/cifs/cifs_swn.c:653:                 seq_puts(m, "(unknown)");
fs/cifs/cifsfs.c:434:           seq_puts(s, "(unknown)");
fs/ext4/super.c:835:                    path = "(unknown)";
include/drm/drm_mode_object.h:118:              return "(unknown)";                             \
lib/error-inject.c:187:         return "(unknown)";
mm/backing-dev.c:23:static const char *bdi_unknown_name = "(unknown)";
mm/filemap.c:3664:                      path = "(unknown)";
net/ipv4/cipso_ipv4.c:444:                      type_str = "(unknown)";
net/ipv6/calipso.c:384:                 type_str = "(unknown)";
sound/firewire/dice/dice-proc.c:35:     return "(unknown)";


Thanks.
