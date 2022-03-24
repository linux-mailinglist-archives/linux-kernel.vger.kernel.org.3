Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D912A4E60FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349173AbiCXJVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiCXJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:21:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3545A592
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:20:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x34so4852967ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wUxU3fOD5HvLRSIgRUZrOG93Jscp2CK4Bk5FgxkJpUs=;
        b=I0f7XIFUmiIz6T697ESW/6vQEHTCQR/9iqVii1Nu5YP2M/w1xM8JFezUeoDTA3NS94
         wm+3sKh20V8YgFadenrWLm2evSLbF6u6oi5/2eLfCRQI3ixaJDsvn6FmISO1sp+nl/gg
         0qPd4JuOfjA3UZsvBQWsqTd4Z1Rv2946U24xNHJRl8oM8FLnpp7k4x9f7VS78tpOH//8
         pXgio5iQRHjZdZkJqQbPJN4tscUgS9yXepEC57kLQWK8cfnrhVHCpvLtvER6JHdwC0i6
         nVlQDXvL9NNapHXnNp1UiNzQLYcK7ARo/xgQuNX/UCc088UgdvAO2KHlXnIvPrso2UGJ
         kQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wUxU3fOD5HvLRSIgRUZrOG93Jscp2CK4Bk5FgxkJpUs=;
        b=FjtM1I4lI0AF3LWfeaT6yri+IUU4aVl+TD9pWW8g4/5gGmoTvz3YTCfYR+SqdcNnNp
         no8kbeHaCiq3kEAQKC8Kdho5Hag4ZnSmNgx6wApguMLA9COjFCIUBhizEATeKABPxKws
         cEo0qfjMf1NB7myTcZ1+UHkYClXoy+kdJ/MZfQ+NgohXl+c7qBiXttRw/0JPbV0jUaD9
         7jcbwrGDwznLpaogEdH6JP7x9xVkQQLJcTzBf5mZujsKbDKZO7Zu9Lvs4rTOVTDNQ9qP
         2oYvcLzWlNiEXFRw/NPmFTErU24tu3ACLDjcskxYW2eP4ssobWMyn+Cfqi1UoSCBQWCy
         MTww==
X-Gm-Message-State: AOAM531jloTF34TVXSN0VChRpfsaZEv+IaXTyTyNCDD8m9CP0XMcgwF8
        kNI4N7531sAU5pwl6J5+8V8Unpe9EJQ=
X-Google-Smtp-Source: ABdhPJxNBk5JbP3n28V5DXRcTZC07vtWRCQie1QiNDHq9oGOareElYrBOfNi6xqMhs2W7xjFU9pIGg==
X-Received: by 2002:a50:99cd:0:b0:418:d6c2:2405 with SMTP id n13-20020a5099cd000000b00418d6c22405mr5469314edb.342.1648113619282;
        Thu, 24 Mar 2022 02:20:19 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm1125552edb.14.2022.03.24.02.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 02:20:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: unisys: Properly test debugfs_create_dir() return values
Date:   Thu, 24 Mar 2022 10:20:15 +0100
Message-ID: <3480204.R56niFO833@leap>
In-Reply-To: <YjmNIX4RsbG8LpyF@kroah.com>
References: <20220322083858.16887-1-fmdefrancesco@gmail.com> <YjmNIX4RsbG8LpyF@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted? 22 marzo 2022 09:47:29 CET Greg Kroah-Hartman wrote:
> On Tue, Mar 22, 2022 at 09:38:58AM +0100, Fabio M. De Francesco wrote:
> > debugfs_create_dir() returns a pointers to a dentry objects. On failures
> > it returns errors. Currently the values returned to visornic_probe()
> > seem to be tested for being equal to NULL in case of failures.
> > 
> > Properly test with "if (IS_ERR())" and then assign the correct error 
> > value to the "err" variable.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/unisys/visornic/visornic_main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
> > index 643432458105..58d03f3d3173 100644
> > --- a/drivers/staging/unisys/visornic/visornic_main.c
> > +++ b/drivers/staging/unisys/visornic/visornic_main.c
> > @@ -1922,11 +1922,11 @@ static int visornic_probe(struct visor_device *dev)
> >  	/* create debug/sysfs directories */
> >  	devdata->eth_debugfs_dir = debugfs_create_dir(netdev->name,
> >  						      visornic_debugfs_dir);
> > -	if (!devdata->eth_debugfs_dir) {
> > +	if (IS_ERR(devdata->eth_debugfs_dir)) {
> 
> We really shouldn't be checking this value at all.  There's no reason to
> check the return value of a debugfs_* call.  Can you fix up the code to
> do that instead?
> 
> thanks,
> 
> greg k-h
> 

Yes I'll do the work that you requested by this weekend, notwithstanding 
what I replied to Dan. 

While I reiterate all my considerations, it seems that, if not the people 
from Unisys, someone else still cares about this driver :)

Thanks,

Fabio



