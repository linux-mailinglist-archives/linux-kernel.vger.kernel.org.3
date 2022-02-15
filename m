Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701244B6A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbiBOLAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:00:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiBOLAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:00:14 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F0BF9562;
        Tue, 15 Feb 2022 03:00:03 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qx21so3585538ejb.13;
        Tue, 15 Feb 2022 03:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=ghHnLt9KrJYO+G0i0QzfYNVgGr31SkfKmR4sqVkFlfs=;
        b=Qgc2DVgHtdjILhRGkVrfMOxv9fz1gHVsohxebaioI2GQpfys/aMW1kuUyIfG48kORc
         g+2QE5e9NYiCG5OaEaL6aq1GQu7ywGewcW954t7/VW9n6UrZSsryS82Faz1Yyp2hUhFS
         ecuxrTqjq8emgnviOntB956S4OSQaPf8zH4XeL7qL+/C7Xmnm62KDYmfkGwR+NviiVnX
         NYxqcK5/trQY4oEn611Jv6AAQPtwsC4uRB/J1IvuHh7wAg8OWJ0dYszHwKL3j05Z8z97
         /+uaTf6kF1gpquLwlZk7MpT4Nw6OjzdJIx+x4bFeikc7pHf1pVYdg9D/+sNJEyZ4Lbzr
         O3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ghHnLt9KrJYO+G0i0QzfYNVgGr31SkfKmR4sqVkFlfs=;
        b=1GzBw6ZxrdkykNWanWPsx6mFRKyMSUt13e6qD0juyhesMukWO24snWU8YunsfNC5q0
         YLHQlEAH0gjx2PxkbACgCE+zCrVxniMpFerxi8iyXXts/FavHlR3vUJAsELFJDas9+HO
         dLSy6I4ybUIEjBxEeErH7qjrUmWajJuGnvEWb2vW3jwb3pfGyI41KY2zlXnzZA4osspv
         cPOWTLonNcyxSxvQHYZD0AuTdK/1b0zJTAC0/ed3qvfrOGW+Onmj3sXy1E9m1lscxKkq
         rVk1pd/qqDx+nZmfRDzmBlBVO3APwpzc1NDdqVFacnAW/tr7bYfVNAsEXuZ48GhAuO/o
         tRZA==
X-Gm-Message-State: AOAM530lFNzffTAIRrq0cQtjo4Oec4ie5A0GQr4GKB2feFE95fuStDhI
        B/AaLk4Cv1IUlWANvZz9vUXUBO/NsMno2A==
X-Google-Smtp-Source: ABdhPJwj/drfAuAWcIW3L+1EOkn9TG0P70eiS4wI5AnmiJdAA3KfpO1RZpUhHLgClx/hrpcheXMTHA==
X-Received: by 2002:a17:906:a212:: with SMTP id r18mr2500109ejy.598.1644922802461;
        Tue, 15 Feb 2022 03:00:02 -0800 (PST)
Received: from ubuntu-laptop (p4fd5939b.dip0.t-ipconnect.de. [79.213.147.155])
        by smtp.googlemail.com with ESMTPSA id q8sm5619340edd.10.2022.02.15.03.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 03:00:02 -0800 (PST)
Message-ID: <1cb4db5f707692afedb005e2577f667f5e48e66e.camel@gmail.com>
Subject: Re: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling
 isn't supported.
From:   Bean Huo <huobean@gmail.com>
To:     Kiwoong Kim <kwmad.kim@samsung.com>,
        'Adrian Hunter' <adrian.hunter@intel.com>,
        'Avri Altman' <Avri.Altman@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com,
        vkumar.1997@samsung.com
Date:   Tue, 15 Feb 2022 12:00:00 +0100
In-Reply-To: <000001d81fcb$3b962f30$b2c28d90$@samsung.com>
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
         <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
         <DM6PR04MB657519E60FAFA19434531CE2FC2B9@DM6PR04MB6575.namprd04.prod.outlook.com>
         <007101d81eed$4d120a60$e7361f20$@samsung.com>
         <3f2938f7-2a9e-60e8-5237-fe7ebc3b4296@intel.com>
         <000001d81fcb$3b962f30$b2c28d90$@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-02-12 at 13:44 +0900, Kiwoong Kim wrote:
> > The error handler really should have exclusive access.  One of the
> > places
> > you change does explain that:
> > 
> >  		 * Hold the scaling lock just in case dev cmds
> >  		 * are sent via bsg and/or sysfs.
> >  		 */
> > -		down_write(&hba->clk_scaling_lock);
> > +		if (ufshcd_is_clkscaling_supported(hba))
> > +			down_write(&hba->clk_scaling_lock); 
> 
> Yeah.., I saw the comment but didn't get why.
> 
> Is there anyone who knows why it's necessary for all SoCs?
> At lease, I know there is no reason to forbid concurrent executions
> of dev cmd and power mode change.
> 
> If there's nothing, how about adding a quick to ignore it?
> 
> Thanks.
> Kiwoong Kim
> 

The name of clk_scaling_lock has explained everything, for the platform
which doesn't support load-based clk scaling, doesn't need to hold this
lock.

Acked-by: Bean Huo <beanhuo@micron.com>

