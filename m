Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EFC4ED686
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiCaJJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiCaJJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:09:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EEB1342CE;
        Thu, 31 Mar 2022 02:07:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bi12so46780416ejb.3;
        Thu, 31 Mar 2022 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yleowqqhp3Wp931KZ3m/sv7GFXxGTcDyzcmGmDmbgHI=;
        b=MJcEYra4ISYsaTLHyz/zPckZ1W+v582WNIP7BA/z+gbbFk5Vd+l3XOWFknL2FUEnU4
         6quPQfaj6miMmi4bBFTBdLTZvVrZKEMmncK/XLththqOXXC6DwavVea4vIkz4aHTKX6Q
         Q9/Z5de9JLHYtPFKm5SWHuHwEIAehIzKmBfYLxK3xo2OI0NzaudHe0mz/aUVtTL7xTBA
         FXVxMNpqRPLLCB8oAMmeNnv4WwrC6OXcpxovSiXeJWLwzOdswy2nNV9z6Obxf5OZe6v1
         y0OElE7NNd/j6JZd9/AbO7tlSFhyHlucVCVEvO56kgOa9DvoMUxOw/XwUiTyq7FicAT7
         kOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yleowqqhp3Wp931KZ3m/sv7GFXxGTcDyzcmGmDmbgHI=;
        b=zozXaBTHrhgYS9JnqlFeZiCKjNhr5MYij4e4uOnLMush5N0q9JiE6h+1/6FcTQFvFK
         svpPCCdA0NyaYpcmH2po1kmzObesAgazR3fpqrvyinh+BcqZ08OhP+41iNN7rWQzpMko
         uRbuTONkx32eoONA974YaFJUUIDm4W2MU3Kjvw2yFH25t+SZfFw6xQXRgn4UHQHtNshw
         3bSCIFPgZnRvF+0KLaiK2b7D8jhqAat7dkuRjNkc4KQH6oiow3BR7QMU/7XYzkJRiPXY
         hur2uFKJx/iQpyFDmCXEFF51zjaewTZMr4GEbGSVojikAmr2c946QixCMpdbO6hQqZ8e
         20FA==
X-Gm-Message-State: AOAM530AmpZ1lUqer4XQzptlPFg8YaX/OBO0bcQPKlhGQ75H718uLati
        ly9Ag3Mjr6NgFlHb7cAp0IQ=
X-Google-Smtp-Source: ABdhPJzYfpoUpfLnNo0BLs69thKYJ/H88xRMD5X1RrfWy000YdIwjqGUGStyPVbbIAHQzOjB5SAADQ==
X-Received: by 2002:a17:907:7e8c:b0:6dc:b357:2f4 with SMTP id qb12-20020a1709077e8c00b006dcb35702f4mr4048945ejc.434.1648717668745;
        Thu, 31 Mar 2022 02:07:48 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id jg39-20020a170907972700b006e047c810dbsm9198644ejc.56.2022.03.31.02.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:07:47 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Wenchao Hao <haowenchao@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, linfeilong@huawei.com
Subject: Re: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
Date:   Thu, 31 Mar 2022 11:07:45 +0200
Message-ID: <10056508.nUPlyArG6x@leap>
In-Reply-To: <YkU/6KB+0fPU5Hie@infradead.org>
References: <20220329154948.10350-1-fmdefrancesco@gmail.com> <20220331054156.GI3293@kadam> <YkU/6KB+0fPU5Hie@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC? 31 marzo 2022 07:45:12 CEST Christoph Hellwig wrote:
> > The temptation was to call device_unregister() which is a combined
> > device_del(); device_put(); but when the device_initialize() and
> > device_add() are called separately, then I think it is more readable to
> > call del and put separately as well.
>=20
> I think we should also consolidate the initialization side.  Using
> device_register and device_unregister would have prevented this bug
> and I should have switched to that before refactoring the code.
>=20
If I don't misunderstand what you wrote, I think you mean something like
the following changes:

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a390679cf458..7a000a9a9dbe 100644
=2D-- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3431,7 +3431,7 @@ static int sd_probe(struct device *dev)
        sdkp->disk_dev.class =3D &sd_disk_class;
        dev_set_name(&sdkp->disk_dev, "%s", dev_name(dev));
=20
=2D       error =3D device_add(&sdkp->disk_dev);
+       error =3D device_register(&sdkp->disk_dev);
        if (error) {
                put_device(&sdkp->disk_dev);
                goto out;
@@ -3474,7 +3474,7 @@ static int sd_probe(struct device *dev)
=20
        error =3D device_add_disk(dev, gd, NULL);
        if (error) {
=2D               put_device(&sdkp->disk_dev);
+               device_unregister(&sdkp->disk_dev);
                goto out;
        }

@Dan, @Christoph: what do you think of the changes that I've copy-pasted ab=
ove?

Thanks,

=46abio M. De Francesco



