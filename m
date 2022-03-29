Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5254F4EB266
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbiC2RCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiC2RCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:02:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0434E3EB88
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:00:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r23so21449021edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BPKs3suq1SgwSX2Q9VZX8LKJW7ayWPXQUfm1Ivff7Yg=;
        b=F/2SYHD88iDJ7+pjQBONixePXir6QXcvw8CfxAJqR8XP7+Y5PhUSIgoAqVmMU+jmbc
         hIPpXnmU8FZa3G85hY6f9oG77VaQi2vhrO/Zx1Hl1Ol4nJVnRESIZYT0MKxpQKG20myz
         ijUqrtKbN4pUIXFBR+koaQg5nqwRuQu5piJeJGZpzEjKvVEeflBtxdf3oFnSBIyhfAX2
         HZfmlTC32O0zmhEnDWeCzyLVQtqpXMBysZSbn06xzxq5mhrTTylJSOxMOdJ/zk0zxoM9
         NVxMaVbzHV/L4I3ppSWTxUauBVImumSbms90mWkBvL/TqeknNzVaXhbf34czzAJqjgJn
         7upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BPKs3suq1SgwSX2Q9VZX8LKJW7ayWPXQUfm1Ivff7Yg=;
        b=ybXllko0mWF1wZBcaNbdtgomLWdLXqzHCTEendtFY1XaeOt/zQFiPBEiNVgSZTOpAt
         JTr6nH9MJRzIFEu6HNRfTH41XVaeT0mQqFUWGj99iUbkWAhIB5p1+Fd+0cgWh265074p
         GiKBbPLUiMNyrmqGTi4EAs3GOw0F5AvoLpDmJ6TAfhNVAfYX7eTx6ArwRicvgytyJukz
         qcxNoDWI8UAm3ZPogKjWObyVgVqeDbF3SiFBDJ274g4rW2A06LhL+utasCbhmbuaxnCx
         +AcqTLjOJrrkjLF6kd10aGSGdENHH14tNOLrYodwsEusT3tc/92jIzVGJWf30pWcAn2s
         QKCQ==
X-Gm-Message-State: AOAM533KqpuWtAxgDthBDmpcZPjQi7lIKCeymSShJ/um7Zp65WMvzhdg
        5Sf4iQpnZM8j00Xhz3VXFSw=
X-Google-Smtp-Source: ABdhPJw37lXtVfuQrFwFlV0EXWgi+RpMtuLezJR109NVeOyq7+/UWRXue9+RusATHM8TRMeZnCqahA==
X-Received: by 2002:a05:6402:914:b0:419:a627:ef6f with SMTP id g20-20020a056402091400b00419a627ef6fmr5731279edz.67.1648573252351;
        Tue, 29 Mar 2022 10:00:52 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906604a00b006e07c76f3d7sm6851961ejj.210.2022.03.29.10.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 10:00:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dan.carpenter@oracle.com
Cc:     David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: unisys: Properly test debugfs_create_dir() return values
Date:   Tue, 29 Mar 2022 19:00:49 +0200
Message-ID: <2030244.KlZ2vcFHjT@leap>
In-Reply-To: <20220322083858.16887-1-fmdefrancesco@gmail.com>
References: <20220322083858.16887-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=EC 22 marzo 2022 09:38:58 CEST Fabio M. De Francesco wrote:
> debugfs_create_dir() returns a pointers to a dentry objects. On failures
> it returns errors. Currently the values returned to visornic_probe()
> seem to be tested for being equal to NULL in case of failures.
>=20
> Properly test with "if (IS_ERR())" and then assign the correct error=20
> value to the "err" variable.
>=20
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/unisys/visornic/visornic_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/st=
aging/unisys/visornic/visornic_main.c
> index 643432458105..58d03f3d3173 100644
> --- a/drivers/staging/unisys/visornic/visornic_main.c
> +++ b/drivers/staging/unisys/visornic/visornic_main.c
> @@ -1922,11 +1922,11 @@ static int visornic_probe(struct visor_device *de=
v)
>  	/* create debug/sysfs directories */
>  	devdata->eth_debugfs_dir =3D debugfs_create_dir(netdev->name,
>  						      visornic_debugfs_dir);
> -	if (!devdata->eth_debugfs_dir) {
> +	if (IS_ERR(devdata->eth_debugfs_dir)) {
>  		dev_err(&dev->device,
>  			"%s debugfs_create_dir %s failed\n",
>  			__func__, netdev->name);
> -		err =3D -ENOMEM;
> +		err =3D PTR_ERR(devdata->eth_debugfs_dir);
>  		goto cleanup_register_netdev;
>  	}
> =20
> --=20
> 2.34.1
>=20
Hi Greg, Dan,

Now I have time to rework this patch but, if I'm not misunderstanding, you=
=20
asked for two contrasting works to do here...

Dan wrote that "[in] this case you can delete the whole devdata->eth_debugf=
s_dir=20
and the related code.".

Greg wrote that "We really shouldn't be checking this value at all.  There'=
s=20
no reason to check the return value of a debugfs_* call. Can you fix up the=
 code to
do that instead?".

I'm confused because they look like two incompatible requests. What should =
I do?

Thanks,

=46abio M. De Francesco


