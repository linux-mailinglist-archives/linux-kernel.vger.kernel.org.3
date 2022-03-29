Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FA94EA7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiC2GUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiC2GUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:20:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920DA1D0E9;
        Mon, 28 Mar 2022 23:18:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id c10so14511161ejs.13;
        Mon, 28 Mar 2022 23:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxPgdBQQC3nvKiCqKYz22ZEE+i7Osztfjv38pMakZLE=;
        b=R+BfxrGJLt0SZPbnGaBsRgbALnOF0p2fZEqJ8h60B3D+9kfqX5z2/rDuIIbpGUTcX5
         HY4Olf4eoTcxEXTPe5nh0iO2KV5S2/rN4+leuypbsk3J1vtUp1yoYol8oNxTI+4lp8IJ
         yyCMLtsBi5LAmg8SRUFS4iPyiXMiw2gOPA8MP0SLDfJVqwcXmszlNsW6Xr//7DOhyi/P
         QAJuEVUsLDX7mjiooosTXY2szMtLedjJn962PgzhrMCUyZND07bgIJNWvmjp63yXCyrm
         0Nh74PEBQvGlDqm9w85rm7D9O5JW/XsZA6Ip9icjWDQlSAyAVhzC3KQOLsVw5pZQBmX+
         1Etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxPgdBQQC3nvKiCqKYz22ZEE+i7Osztfjv38pMakZLE=;
        b=nYeJKCoB1gZP0IewaHOw37sQvOp46MIMYG+9AJEv5SNEHJwXWEKwDPwrJ7oFJw3VFW
         xd2Aze723FwwW93Bl209baJ/Sl2H+/PLQmc5/aV1Vn8PdrtImW9ExGeZPGZO3aH44cYD
         Wpzy5tpfV4b/eTnbq8yhK3/F5f37cENbeNpztUs+Z1hJl99w8nUtf5051/7K8Cjzh2D/
         sZ+V4tDmWBcLXPkPALhc8all1g/FcSE0dyHT3E3LLFfNgTLii2L+PHkXXxODVYl8b1j1
         303cAs50eetrCDYOrNy7o3dEMg4cU6Vf/j0L09p4ZCKaT3i0I2WVsraoBADAyOxLxCoV
         ghpA==
X-Gm-Message-State: AOAM532ouhoRJvns5df+KCTTGa3/uQuxtCNFxbrDEkuZ/JopDHw+AwKv
        ymAmOrfsgxw88xb53bPBFrZexB/TnHU=
X-Google-Smtp-Source: ABdhPJwQs4Pjl3tkslk/hhSVlWXpViGaANZnJzhoW4oLeq1liIOJCA6r/KnUCcbBc+gQynOj+zJTDQ==
X-Received: by 2002:a17:906:7304:b0:6e0:6918:ef6f with SMTP id di4-20020a170906730400b006e06918ef6fmr32037673ejc.370.1648534700121;
        Mon, 28 Mar 2022 23:18:20 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id t19-20020a056402525300b0041952a1a764sm8181556edd.33.2022.03.28.23.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 23:18:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
Subject: Re: [PATCH] scsi: sd: Jump to out_free_index if device_add{,_disk}() fail
Date:   Tue, 29 Mar 2022 08:18:16 +0200
Message-ID: <2179817.iZASKD2KPV@leap>
In-Reply-To: <20220328143853.GU3293@kadam>
References: <20220328084452.11479-1-fmdefrancesco@gmail.com> <20220328143853.GU3293@kadam>
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

On luned? 28 marzo 2022 16:38:53 CEST Dan Carpenter wrote:
> On Mon, Mar 28, 2022 at 10:44:52AM +0200, Fabio M. De Francesco wrote:
> > Currently, if device_add() or device_add_disk() fail, the code jumps to
> > the "out" label. Doing so we get a memory leak as Syzbot reports.[1]
> > 
> > Fix this bug by jumping to the "out_free_index" label.
> > 
> > [1] https://groups.google.com/g/syzkaller-bugs/c/BvuqG6YGb6I
> > 
> > Reported-and-tested-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
> > Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
> > Fixes: 265dfe8ebbab ("scsi: sd: Free scsi_disk device via put_device()")
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/scsi/sd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index a390679cf458..61fcf653ef5a 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -3434,7 +3434,7 @@ static int sd_probe(struct device *dev)
> >  	error = device_add(&sdkp->disk_dev);
> >  	if (error) {
> >  		put_device(&sdkp->disk_dev);
> > -		goto out;
> > +		goto out_free_index;
> 
> The put_device calls scsi_disk_release() so this change will introduce
> use after frees and double frees.

Yes, correct. I've just looked at how put_device() is implemented. I didn't 
know how it works until you made me notice. Thanks!

Aside this I sent another diff to Syzbot. Today, at 4.30 CET, it replied again
that, after applying and testing my new patch, Syzkaller was not anymore able 
to trigger the memory leak that it had reported.

This is the new diff...

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a390679cf458..6fac62f00b37 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3433,6 +3433,7 @@ static int sd_probe(struct device *dev)
 
        error = device_add(&sdkp->disk_dev);
        if (error) {
+               ida_free(&sd_index_ida, index);
                put_device(&sdkp->disk_dev);
                goto out;
        }
@@ -3474,6 +3475,7 @@ static int sd_probe(struct device *dev)
 
        error = device_add_disk(dev, gd, NULL);
        if (error) {
+               ida_free(&sd_index_ida, index);
                put_device(&sdkp->disk_dev);
                goto out;
        }

As it can be seen, I tried to simply free the IDA and jump to the "out"
label (exactly as it is in the current code).

The test passed today at 04.30 CET but, can it really be that not freeing 
the allocation of the IDA could trigger that memory leak? I'm not so sure, 
therefore, I'll wait for comments before submitting any v2.

> There is a larger process issue here.  We need to figure out why syzbot
> did not detect that this patch introduces bugs.

This is something that the people who run Syzbot/Syzkaller should help to
figure out.

Regards,

Fabio M. De Francesco

> regards,
> dan carpenter



