Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A355911DA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbiHLOFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiHLOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:05:50 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A64A28722
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:05:49 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id w27so748537qki.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=3Fi1VTtDFgyZAXD5ict/NicDWj9+d/F9avdnvytM5Yo=;
        b=CqKUxs9HWvgk5EACnCWAc4IABQ81zQ5HxyhhzOwel9K82MNYA5ZpimTG2n/G/CZoj6
         2biBPqLvZGzKN2QgBG2PshKuMmlgoUKalrEXqoJiew9yNntYLZEydSpxMikj9pMOOJys
         XkRg28HFxcvZt+BJ/xCbkaKj3xS8nheYn78igbl1YBwN6BI7jV3Pb9uIZEHaHSu6e7TJ
         FtRUyZe27glwYb/yHjMHO1+kfD2xl6BCSDpP+RcBVWff/GaeKp90oupVNBtu/VY7oJi3
         8aItvPHy5I1E36ul/9VLB5dM9uGH9wLmJT/Mr4T7l15k40Ep82PClCmYUGEVGTd26Ba3
         kAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3Fi1VTtDFgyZAXD5ict/NicDWj9+d/F9avdnvytM5Yo=;
        b=exMGQklrm1m4McSSOhsMaWs33+H7RHudF9zZLBILuER+eyLegpx1TKCfxYtZTadgN0
         YkYziz7l5Bdznv+jQw3KwytZLOqFEd91VEWdIK76ZLrXKpvAGjtMAeGB7PnOMK9hwFAJ
         ak89L1msQ5YT4jxFvl6Wv5BEecPNHDy3KnGQpgsFnnA0pK9nt3SO0sqKMXXa7e5DGlR/
         no9DIzI3TJBG2kx87KedPDhyiUhMINfiTkID94bALNS56SDuEutIsV0988tkRQhk3j1I
         ERab1OOEqRYkx7/iKToXIkc8XPwT1gyTwLhcO60YxudAjMo3WPZTB+srcG0DvCudQZDg
         Q92Q==
X-Gm-Message-State: ACgBeo21GkylEuMNHiaPxPa29KB2ff/N2t7nILBkaM3W2u/mJzHYY5cT
        DKo2q71zb+wNWVYlzaK8BO38Xw==
X-Google-Smtp-Source: AA6agR6rVO/mlp2whKyQ+m6Evhgl5o+7HirB+451gg9nOuhJ3xNjn898fYAaT1rtyGmDyk6Q4LMiEA==
X-Received: by 2002:a37:a853:0:b0:6ba:ceba:9656 with SMTP id r80-20020a37a853000000b006baceba9656mr1704225qke.466.1660313148548;
        Fri, 12 Aug 2022 07:05:48 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a400500b006b615cd8c13sm1173685qko.106.2022.08.12.07.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:05:48 -0700 (PDT)
Date:   Fri, 12 Aug 2022 10:05:46 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] NTB: EPF: set pointer addr to null using NULL
 rather than 0
Message-ID: <YvZeOkd1wrdYJXqs@kudzu.us>
References: <20220623165709.77229-1-colin.i.king@gmail.com>
 <20220627202858.GA1776067@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627202858.GA1776067@bhelgaas>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 03:28:58PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 23, 2022 at 05:57:09PM +0100, Colin Ian King wrote:
> > The pointer addr is being set to null using 0. Use NULL instead.
> > 
> > Cleans up sparse warning:
> > warning: Using plain integer as NULL pointer
> 
> Another one for Jon; fixes this commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ff32fac00d97
> 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index ebf7e243eefa..fb31c868af6a 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -605,7 +605,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  
> >  		ntb->epf->bar[barno].barno = barno;
> >  		ntb->epf->bar[barno].size = size;
> > -		ntb->epf->bar[barno].addr = 0;
> > +		ntb->epf->bar[barno].addr = NULL;
> >  		ntb->epf->bar[barno].phys_addr = 0;
> >  		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> >  				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> > -- 
> > 2.35.3
> > 

Sorry for the extremely long delay in response.  This series is in my
ntb branch and will be in my pull request for v5.20 which should be
going out later today.

Thanks,
Jon
