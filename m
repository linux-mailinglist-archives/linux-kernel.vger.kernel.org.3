Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A240C48D192
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 05:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiAMEOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 23:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiAMENi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 23:13:38 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3603AC06175B;
        Wed, 12 Jan 2022 20:12:29 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id bl18so5882521qkb.5;
        Wed, 12 Jan 2022 20:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbtW5GNEznZHiafA75unnHcFZvdczANI1PgQ6YwC50I=;
        b=ibjmvFEuzUnUj0P4/dhygtlpXkwqsmCbtqtSnsfMo8cpFNuhzqPWC58ZSdU3L1JTwt
         0JbiyhvXcxCguvtxAY6qa9hCdayN57icMXEHv5DOV32DSMkflySg0TSy0Uod6ngnhHaT
         A+M5uaveL8e8wlbe7AJqTbAjOrKQ1vG8fia6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbtW5GNEznZHiafA75unnHcFZvdczANI1PgQ6YwC50I=;
        b=DCSq349x/8mLa4oBTbhmPe9amY8CCKiXSqQY2EkMvaLiFTOQE0/rYViIkX1Y652tl+
         vH3UWVYsvRaDPFvzEIS1eTQ9QLY+mAfmUHx8y7za9oZschFQS1SALOqXBz9J3wIiCzX6
         L+Wg1IW+iI4lvpS+XORYkK58G3LjNIQUD0RxAKGF0KtI71UjL8xgvTjaxyaRjYKuEYnG
         WLauJ95mxDtL0VB7xKwA8LXYH3eO8vPeTb+PHLS3p0OoRvw8zMVc5e+4eLvdBw3+MzXl
         +XoEUyMDkMr+KoywviXWaVJUP7HN6eTGvkaOh4ojGymnTynf4EcPSW9VJD2pY6Lvbaqw
         KEtQ==
X-Gm-Message-State: AOAM532ze74qwpbmEdKRkKuOS4rL1JIpPwTBz2H8Orr/gtXUImxuzPBB
        czWX/QQH1g1OY/5T8a12PiQqldo5szdPS4pHibE=
X-Google-Smtp-Source: ABdhPJwOVBaayKDH/i9TEqiJA4jUpG5Q9ZPM20KYYIs0XA0wcVXkAniMBmivwNgSlbtXPJKggVHdozQRsoV+5JJNw5E=
X-Received: by 2002:a37:a342:: with SMTP id m63mr272966qke.347.1642047148268;
 Wed, 12 Jan 2022 20:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20220112230247.982212-1-iwona.winiarska@intel.com> <20220112230247.982212-6-iwona.winiarska@intel.com>
In-Reply-To: <20220112230247.982212-6-iwona.winiarska@intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 13 Jan 2022 04:12:16 +0000
Message-ID: <CACPK8XewQJBvwssM6zQKQoxT=JLpk-qjGhsiTAa980OtbU7JBw@mail.gmail.com>
Subject: Re: [PATCH v5 05/13] peci: Add peci-aspeed controller driver
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 23:06, Iwona Winiarska <iwona.winiarska@intel.com> wrote:
>
> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>
> ASPEED AST24xx/AST25xx/AST26xx SoCs support the PECI electrical
> interface (a.k.a PECI wire) that provides a communication channel with
> Intel processors.
> This driver allows BMC to discover devices connected to it and
> communicate with them using PECI protocol.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The driver looks good to me. I would be happy to see it merged in its
current state.

Reviewed-by: Joel Stanley <joel@jms.id.au>

I've a few questions below that can be followed up later if need be.

> +
> +static void aspeed_peci_init_regs(struct aspeed_peci *priv)
> +{
> +       u32 val;
> +
> +       /* Clear interrupts */
> +       val = readl(priv->base + ASPEED_PECI_INT_STS) | ASPEED_PECI_INT_MASK;

Should that be & MASK?

As you're just sanitising the registers, you could clear the status
unconditionally:

 writel(ASPEED_PECI_INT_MASK, priv->base + ASPEED_PECI_INT_STS);

> +       writel(val, priv->base + ASPEED_PECI_INT_STS);
> +
> +       /* Set timing negotiation mode and enable interrupts */
> +       val = FIELD_PREP(ASPEED_PECI_TIMING_NEGO_SEL_MASK, ASPEED_PECI_1ST_BIT_OF_ADDR_NEGO);

That's a complicated way to set val to zero :)

> +       val |= ASPEED_PECI_INT_MASK;
> +       writel(val, priv->base + ASPEED_PECI_INT_CTRL);
> +
> +       val = FIELD_PREP(ASPEED_PECI_CTRL_SAMPLING_MASK, ASPEED_PECI_RD_SAMPLING_POINT_DEFAULT);
> +       writel(val, priv->base + ASPEED_PECI_CTRL);

This will clear the rest of the ctrl register, including the divisor
settings. Was that your intention?

Reading the rest of your driver you only call _init_regs after
_controller_enable, so I guess you're fine.

> +}
> +
> +static int aspeed_peci_check_idle(struct aspeed_peci *priv)
> +{
> +       u32 cmd_sts = readl(priv->base + ASPEED_PECI_CMD);
> +       int ret;
> +
> +       /*
> +        * Under normal circumstances, we expect to be idle here.
> +        * In case there were any errors/timeouts that led to the situation
> +        * where the hardware is not in idle state - we need to reset and
> +        * reinitialize it to avoid potential controller hang.
> +        */
> +       if (FIELD_GET(ASPEED_PECI_CMD_STS_MASK, cmd_sts)) {
> +               reset_control_assert(priv->rst);
> +
> +               ret = reset_control_deassert(priv->rst);
> +               if (ret) {
> +                       dev_err(priv->dev, "cannot deassert reset control\n");
> +                       return ret;
> +               }
> +
> +               aspeed_peci_init_regs(priv);
> +
> +               ret = clk_set_rate(priv->clk, priv->clk_frequency);
> +               if (ret < 0) {
> +                       dev_err(priv->dev, "cannot set clock frequency\n");
> +                       return ret;
> +               }
> +
> +               aspeed_peci_controller_enable(priv);
> +       }
> +
> +       return readl_poll_timeout(priv->base + ASPEED_PECI_CMD,
> +                                 cmd_sts,
> +                                 !(cmd_sts & ASPEED_PECI_CMD_IDLE_MASK),
> +                                 ASPEED_PECI_IDLE_CHECK_INTERVAL_US,
> +                                 ASPEED_PECI_IDLE_CHECK_TIMEOUT_US);
> +}
> +
> +static int aspeed_peci_xfer(struct peci_controller *controller,
> +                           u8 addr, struct peci_request *req)
> +{
> +       struct aspeed_peci *priv = dev_get_drvdata(controller->dev.parent);
> +       unsigned long timeout = msecs_to_jiffies(priv->cmd_timeout_ms);
> +       u32 peci_head;
> +       int ret;
> +
> +       if (req->tx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX ||
> +           req->rx.len > ASPEED_PECI_DATA_BUF_SIZE_MAX)
> +               return -EINVAL;
> +
> +       /* Check command sts and bus idle state */
> +       ret = aspeed_peci_check_idle(priv);
> +       if (ret)
> +               return ret; /* -ETIMEDOUT */
> +
> +       spin_lock_irq(&priv->lock);
> +       reinit_completion(&priv->xfer_complete);
> +
> +       peci_head = FIELD_PREP(ASPEED_PECI_TARGET_ADDR_MASK, addr) |
> +                   FIELD_PREP(ASPEED_PECI_WR_LEN_MASK, req->tx.len) |
> +                   FIELD_PREP(ASPEED_PECI_RD_LEN_MASK, req->rx.len);
> +
> +       writel(peci_head, priv->base + ASPEED_PECI_RW_LENGTH);
> +
> +       memcpy_toio(priv->base + ASPEED_PECI_WR_DATA0, req->tx.buf, min_t(u8, req->tx.len, 16));
> +       if (req->tx.len > 16)
> +               memcpy_toio(priv->base + ASPEED_PECI_WR_DATA4, req->tx.buf + 16,
> +                           req->tx.len - 16);
> +
> +#if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
> +       dev_dbg(priv->dev, "HEAD : %#08x\n", peci_head);
> +       print_hex_dump_bytes("TX : ", DUMP_PREFIX_NONE, req->tx.buf, req->tx.len);
> +#endif

The ifdef is unfortunate. Could you do this?

dev_dbg(priv->dev, "HEAD : %#08x\n", peci_head);
if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG))
       print_hex_dump_bytes("TX : ", DUMP_PREFIX_NONE, req->tx.buf,
req->tx.len);

Not a biggie though, don't let this hold up merging.

> +       priv->status = 0;
> +       writel(ASPEED_PECI_CMD_FIRE, priv->base + ASPEED_PECI_CMD);
> +       spin_unlock_irq(&priv->lock);
> +
