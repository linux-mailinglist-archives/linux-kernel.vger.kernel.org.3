Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A53B4EA935
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiC2IaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbiC2IaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:30:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C644BC2E;
        Tue, 29 Mar 2022 01:28:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bq8so19558172ejb.10;
        Tue, 29 Mar 2022 01:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0CBK7H5KAD0lnlnKP0frM2mtSUqhfuGB3eg/LBvMJg=;
        b=J5JKsxvCrCpujexBruGCPLspO7CMQXYu49WX4i9M9rtV6h0HSNzHjxyZfd1qZyisAf
         tEAlGuoLsdqF4dD+BPLX7LY+EZo5TmpbaabjWUS0fSBPJfbdEI2iGeyOCtThHAFeTy4E
         TExxV4nvxn7zrkJ+jQLke/vkAFtnBmd/87zOZba1VA6CfRTnE+FBPW4oNmuM8HO8fW8r
         KVZP+jDE74+wiUE96Ziprd1AgQv9B4dpDFVxcpF1tOydUO/H65mFN9ThADaRPTe8WwEb
         M7dRamwqK/Vucskuxmcvg6jDGoRfN14bYDVrGH9BMew2lvYB22Ma1/8ZHVxQkw1OjGGF
         04iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0CBK7H5KAD0lnlnKP0frM2mtSUqhfuGB3eg/LBvMJg=;
        b=0x5J0LbEWorFvXZdMg4MukqbHHxtOT4wUG1sFi/V4nKyucOXWjmPDeUL2ImJVvPyRN
         2Ti11dVF4ZRudfIDMeQ7yhlmu5U17LnPOXHPkUU1lrSwJB2+RxNktEzPsgPvmBfMV5UO
         0iEME/UWaX/85dPKG85a8XGLl0FZTclNk1ZiVsxJd9Y3W3MsVhQ8Ii+oZGzb2x3NxYHz
         PLslW5YGnOG7tVOvG6TtJ0KBx+hsGi6/oxqJujQdcpE5peneoyAc3I5rpA01osqW1a49
         mSTt00mDlfsK2JBGHhiEMSMUboXUgARNfZhmkbIYoyM+RPBstHoUxx3flI2PIkmN7PGg
         4k1A==
X-Gm-Message-State: AOAM530h+Z5bXux9EtoUnDA/ITkpIuCwRTSL/hXhpuSEwi05xR44Tul8
        kJzObjh3uG6gNAOaPdjbvd4=
X-Google-Smtp-Source: ABdhPJwbGRcP1Tkz9eusm9vJyR+e5qdqMqvo2Ts6vHPTU+xbbckzgWIj9FTgVDAhVvz6nKPnMT5RdQ==
X-Received: by 2002:a17:906:9b85:b0:6db:ab80:7924 with SMTP id dd5-20020a1709069b8500b006dbab807924mr32941857ejc.160.1648542507580;
        Tue, 29 Mar 2022 01:28:27 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id hb6-20020a170907160600b006dff6a979fdsm6912468ejc.51.2022.03.29.01.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 01:28:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
Subject: Re: [PATCH] scsi: sd: Jump to out_free_index if device_add{,_disk}() fail
Date:   Tue, 29 Mar 2022 10:28:24 +0200
Message-ID: <824276213.0ifERbkFSE@leap>
In-Reply-To: <20220329075752.GS12805@kadam>
References: <20220328084452.11479-1-fmdefrancesco@gmail.com> <20220329074744.GR12805@kadam> <20220329075752.GS12805@kadam>
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

On marted? 29 marzo 2022 09:57:53 CEST Dan Carpenter wrote:
> On Tue, Mar 29, 2022 at 10:47:45AM +0300, Dan Carpenter wrote:
> > No, this patch is wrong.  That is supposed to be freed in scsi_disk_release()
> > but apparently that's not getting called.  Is the ref counting off?
> > 
> 
> Yeah.  The device_add() needs a matching device_del().
> 
> regards,
> dan carpenter
> 
Thanks, Dan.

I've just just checked other similar code and saw the following pattern 
whenever we have an error:

device_del(dev);
put_device(dev);

Therefore, I suppose that you are suggesting the following simple change:

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a390679cf458..13d96d0f9dde 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3474,6 +3474,7 @@ static int sd_probe(struct device *dev)
 
        error = device_add_disk(dev, gd, NULL);
        if (error) {
+               device_del(&sdkp->disk_dev);
                put_device(&sdkp->disk_dev);
                goto out;
        }

Did I get it?

Regards,

Fabio


