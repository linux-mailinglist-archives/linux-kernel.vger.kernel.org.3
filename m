Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675AF4C4634
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbiBYN0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiBYN0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:26:05 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000D2223100;
        Fri, 25 Feb 2022 05:25:31 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hw13so10836615ejc.9;
        Fri, 25 Feb 2022 05:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=gcLAgFJ6UAC+wlMRiqdskTKEQNruEzHTuhKZh7vzXzE=;
        b=JOg+gainHqPmDqDsMWlfMvMPI7nQFxRwZSseTHbohGOWpvKQwmEIGYAXml+KhJEoBd
         W0PGOzoResYq2xmiHVS0NHJg/JFnI5xRB71+lKmAs+QW3qoD4hE6YupuCqzAxyaWE1nE
         eOP4gdKs6F/2ouFqIkOKxDnvqJLhqyVsb8V9Y+X5AXtvcDZgCU+L6s24+1OEKeK6+4Qr
         0hUHdNSiLSFeqxUPyqwqkkpZgqN90Ir0mfQ99Ge/yuWzunY8/QJV41U9uYsvl7Z5oj0/
         Pvg65r0W2XadFR/YX4IfIX5QiuMUrC02VA6tjm2RM30vbrWMf7OF5qAfymqoqbuK837v
         hLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=gcLAgFJ6UAC+wlMRiqdskTKEQNruEzHTuhKZh7vzXzE=;
        b=7vVZniMxZiI1LLAeMoP/xUaFqIGtNdbI+4yBjmCf6pJq/3Bak5gQIUQD6tMhTrRGhf
         xxElaaOQuB5m09aVLxgVa2AN/7/ij2MF6cav60v7dnsxRlDSE59KhWrxOzHke6VJlLLM
         WTs7NlHRwwrvZIpvey+W6Id4yC37905AxrU/UCkpvdHKlTiE8PqdXdonsxRUBFyHLQDV
         odJBwTs/6C9i9PxdmYAWLn9Z6zP1ZjER1IjG8v/avFAZ3GNbeCZiDuVYMxj3ssB48th1
         YU9oEtChBhTJXO1H6cNgTMB15Xt+ZZj0LUw4RdHjtO2+vL001NXOKuOY5DtqGwYipgo/
         wUWw==
X-Gm-Message-State: AOAM532gdhpmhJFJ38xWeoVrFhR2CNV716iFUg/NJhrmlku9NxRZ5nsH
        8tzktyxNnQpXX2aOeWIe1TefI4EVp3HwLnnCaqT8BHbF
X-Google-Smtp-Source: ABdhPJz8Djbty/w23wxvUK4n9BlOZFJePoyKwaBXcOyMZVw44qnK1bcgHTr/TdtuuhN1divdYsKuxlZbJcoV4c8XIls=
X-Received: by 2002:a17:906:2695:b0:6ce:b94d:9f07 with SMTP id
 t21-20020a170906269500b006ceb94d9f07mr6349508ejc.297.1645795530367; Fri, 25
 Feb 2022 05:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20220221115234.2544665-1-clabbe@baylibre.com>
In-Reply-To: <20220221115234.2544665-1-clabbe@baylibre.com>
Reply-To: jglauber@digitalocean.com
From:   Jan Glauber <jan.glauber@gmail.com>
Date:   Fri, 25 Feb 2022 14:25:18 +0100
Message-ID: <CAEiAFz30J_C2GbbObL2E7Y=YB3FkRSB+S8Ce2WU73CqifueWxQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: cavium: zip: register algorithm only if hardware
 is present
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jan Glauber <jglauber@cavium.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,
your patch looks good to me, but I also lost access to the hardware.

-- Jan

Am Di., 22. Feb. 2022 um 05:34 Uhr schrieb Corentin Labbe <clabbe@baylibre.com>:
>
> On my renesas salavator-X, I saw some cavium driver failing crypto
> self-tests.
> But salvator does not have such hardware.
> This is due to cavium/zip driver registering algorithms even if hardware
> is not present.
> The solution is to move algorithm registration in the probe function.
> This permits also to simplify module init/exit by using
> module_pci_driver.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>
> WARNING: this is boot tested only on salvator-X to be sure that the
> cavium/zip driver no longer registers algorithms.
> I do not have any cavium hardware unfortunatly.
>
>  drivers/crypto/cavium/zip/zip_main.c | 83 ++++++++++++----------------
>  1 file changed, 35 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/crypto/cavium/zip/zip_main.c b/drivers/crypto/cavium/zip/zip_main.c
> index 812b4ac9afd6..dc5b7bf7e1fd 100644
> --- a/drivers/crypto/cavium/zip/zip_main.c
> +++ b/drivers/crypto/cavium/zip/zip_main.c
> @@ -55,6 +55,11 @@ static const struct pci_device_id zip_id_table[] = {
>         { 0, }
>  };
>
> +static void zip_debugfs_init(void);
> +static void zip_debugfs_exit(void);
> +static int zip_register_compression_device(void);
> +static void zip_unregister_compression_device(void);
> +
>  void zip_reg_write(u64 val, u64 __iomem *addr)
>  {
>         writeq(val, addr);
> @@ -235,6 +240,15 @@ static int zip_init_hw(struct zip_device *zip)
>         return 0;
>  }
>
> +static void zip_reset(struct zip_device *zip)
> +{
> +       union zip_cmd_ctl cmd_ctl;
> +
> +       cmd_ctl.u_reg64 = 0x0ull;
> +       cmd_ctl.s.reset = 1;  /* Forces ZIP cores to do reset */
> +       zip_reg_write(cmd_ctl.u_reg64, (zip->reg_base + ZIP_CMD_CTL));
> +}
> +
>  static int zip_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>         struct device *dev = &pdev->dev;
> @@ -282,8 +296,21 @@ static int zip_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>         if (err)
>                 goto err_release_regions;
>
> +       /* Register with the Kernel Crypto Interface */
> +       err = zip_register_compression_device();
> +       if (err < 0) {
> +               zip_err("ZIP: Kernel Crypto Registration failed\n");
> +               goto err_register;
> +       }
> +
> +       /* comp-decomp statistics are handled with debugfs interface */
> +       zip_debugfs_init();
> +
>         return 0;
>
> +err_register:
> +       zip_reset(zip);
> +
>  err_release_regions:
>         if (zip->reg_base)
>                 iounmap(zip->reg_base);
> @@ -305,16 +332,17 @@ static int zip_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  static void zip_remove(struct pci_dev *pdev)
>  {
>         struct zip_device *zip = pci_get_drvdata(pdev);
> -       union zip_cmd_ctl cmd_ctl;
>         int q = 0;
>
>         if (!zip)
>                 return;
>
> +       zip_debugfs_exit();
> +
> +       zip_unregister_compression_device();
> +
>         if (zip->reg_base) {
> -               cmd_ctl.u_reg64 = 0x0ull;
> -               cmd_ctl.s.reset = 1;  /* Forces ZIP cores to do reset */
> -               zip_reg_write(cmd_ctl.u_reg64, (zip->reg_base + ZIP_CMD_CTL));
> +               zip_reset(zip);
>                 iounmap(zip->reg_base);
>         }
>
> @@ -585,7 +613,7 @@ DEFINE_SHOW_ATTRIBUTE(zip_regs);
>  /* Root directory for thunderx_zip debugfs entry */
>  static struct dentry *zip_debugfs_root;
>
> -static void __init zip_debugfs_init(void)
> +static void zip_debugfs_init(void)
>  {
>         if (!debugfs_initialized())
>                 return;
> @@ -604,7 +632,7 @@ static void __init zip_debugfs_init(void)
>
>  }
>
> -static void __exit zip_debugfs_exit(void)
> +static void zip_debugfs_exit(void)
>  {
>         debugfs_remove_recursive(zip_debugfs_root);
>  }
> @@ -615,48 +643,7 @@ static void __exit zip_debugfs_exit(void) { }
>  #endif
>  /* debugfs - end */
>
> -static int __init zip_init_module(void)
> -{
> -       int ret;
> -
> -       zip_msg("%s\n", DRV_NAME);
> -
> -       ret = pci_register_driver(&zip_driver);
> -       if (ret < 0) {
> -               zip_err("ZIP: pci_register_driver() failed\n");
> -               return ret;
> -       }
> -
> -       /* Register with the Kernel Crypto Interface */
> -       ret = zip_register_compression_device();
> -       if (ret < 0) {
> -               zip_err("ZIP: Kernel Crypto Registration failed\n");
> -               goto err_pci_unregister;
> -       }
> -
> -       /* comp-decomp statistics are handled with debugfs interface */
> -       zip_debugfs_init();
> -
> -       return ret;
> -
> -err_pci_unregister:
> -       pci_unregister_driver(&zip_driver);
> -       return ret;
> -}
> -
> -static void __exit zip_cleanup_module(void)
> -{
> -       zip_debugfs_exit();
> -
> -       /* Unregister from the kernel crypto interface */
> -       zip_unregister_compression_device();
> -
> -       /* Unregister this driver for pci zip devices */
> -       pci_unregister_driver(&zip_driver);
> -}
> -
> -module_init(zip_init_module);
> -module_exit(zip_cleanup_module);
> +module_pci_driver(zip_driver);
>
>  MODULE_AUTHOR("Cavium Inc");
>  MODULE_DESCRIPTION("Cavium Inc ThunderX ZIP Driver");
> --
> 2.34.1
>
