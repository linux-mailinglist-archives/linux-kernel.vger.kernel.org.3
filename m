Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7C553BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353980AbiFUUpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352430AbiFUUpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:45:25 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1468322280
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:45:24 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x75so11060633qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxxavArv6bHTDCjJqaMpmIOW30F1ecOmAELEb+m5GVk=;
        b=ZG0WnQngxUzT5Q1kiPNKQh14vpNCDgUtYeGxpMvQ1ZeL698E/tq4mib0atRP2u68p2
         7q8lFfXWU5ECFepec1nssFSFwZZxQR5CEqnp8x/sUg3DsycY2Jrgzk/caifHQIghx+on
         jFeeZrSUVD2bpjaWnUhqkG6d8ltmDYBRdvkvDIQbVP8PP5w/WohGseoX6lYyoX2reuwp
         l3w+oLoSqSb7i1MWiw4gchkQ15OdgF5xY5xbjIqLiHFJKJrUA0GuEmCKLOcZVE30SzEO
         wbTczA8yJQBi2HM+OCgdd/C/7x7UTn8UnXl1cH32JCyYusXpM4VQwa5Ec3iIQ+PcBN/j
         BWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxxavArv6bHTDCjJqaMpmIOW30F1ecOmAELEb+m5GVk=;
        b=aCutiZxKD7cwAH9Izs/flg1IUZDdJUKCfx1iOp3FjDPyBCcNHh1PzQalOGYO7RWYiM
         gMY/svDaTlqDnNTAeyhJAUfjGCQwIu2CKKX/rAT4DLChuXLWeLwWByB67Vu5uC/7ngUc
         WjVyHs08olK2lDsV0HiyAuVP5aN+xTBCvi163Dy05qntttzG2wi8NOgHYJOqoFl1R1ff
         CfoNfxoMISQ6cmtibTKa0tyX1VAd+hdK/oD9g02Oswe2NxTsHXEAZUQY8LjDTfRGwbLi
         1E3/tkKxKK3fxdDot+67YM+8CW4tbDKLvU91KQe3ja6c7x5J7l5zP7/+PWV3VgRGdpew
         YX3A==
X-Gm-Message-State: AJIora+oM1RpBs/HLI9JGhFLwqguqmWiZ8yOUxwLOarWEi74wccpMtpX
        d5hyMZwpVcKNmmJjd531hmNPLVsZaZwy+fqDAUrysg==
X-Google-Smtp-Source: AGRyM1tqzDEVSDLWWuL5jVT+3WrpC0MpZwpm2m51kWcxKgsv2A6bSg2K+JlJGs0ni0v+FLEvbzTJavhstYXa0wXrcy4=
X-Received: by 2002:a05:620a:4156:b0:6a6:f8d2:6d9e with SMTP id
 k22-20020a05620a415600b006a6f8d26d9emr21913647qko.30.1655844323174; Tue, 21
 Jun 2022 13:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220621112330.448754-1-robimarko@gmail.com> <20220621203211.GA1330530@bhelgaas>
In-Reply-To: <20220621203211.GA1330530@bhelgaas>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 23:45:12 +0300
Message-ID: <CAA8EJprMYiTAfKjT-GeWOt_Fk0EjR2tBRe-jAwb-2A+-zO6Gkw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, svarbanov@mm-sol.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, p.zabel@pengutronix.de, jingoohan1@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 23:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 21, 2022 at 01:23:30PM +0200, Robert Marko wrote:
> > IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
> > cause the system to hang as its using DBI registers in the .init
> > and those are only accesible after phy_power_on().
>
> Is the fact that IPQ8074 has both a Gen2 and a Gen3 port relevant to
> this patch?  I don't see the connection.
>
> I see that qcom_pcie_host_init() does:
>
>   qcom_pcie_host_init
>     pcie->cfg->ops->init(pcie)
>     phy_power_on(pcie->phy)
>     pcie->cfg->ops->post_init(pcie)
>
> and that you're moving DBI register accesses from
> qcom_pcie_init_2_3_3() to qcom_pcie_post_init_2_3_3().
>
> But I also see DBI register accesses in other .init() functions:
>
>   qcom_pcie_init_2_1_0
>   qcom_pcie_init_1_0_0      (oddly out of order)
>   qcom_pcie_init_2_3_2
>   qcom_pcie_init_2_4_0
>
> Why do these accesses not need to be moved?  I assume it's because
> pcie->phy is an optional PHY and phy_power_on() does nothing on those
> controllers?
>
> Whatever the reason, I think the DBI accesses should be done
> consistently in .post_init().  I see that Dmitry's previous patches
> removed all those .post_init() functions, but I think the consistency
> is worth having.
>
> Perhaps we could reorder the patches so this patch comes first, moves
> the DBI accesses into .post_init(), then Dmitry's patches could be
> rebased on top to drop the clock handling?

I don't think there is a need to reorder patches. My patches do not
remove support for post_init(), they drop the callbacks code. Thus one
can reinstate necessary code back.

>
> > So solve this by splitting the DBI read/writes to .post_init.
> >
> > Fixes: a0fd361db8e5 ("PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common code")
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v2:
> > * Rebase onto next-20220621
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 48 +++++++++++++++-----------
> >  1 file changed, 28 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 51fed83484af..da6d79d61397 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1061,9 +1061,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> >       struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
> >       struct dw_pcie *pci = pcie->pci;
> >       struct device *dev = pci->dev;
> > -     u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >       int i, ret;
> > -     u32 val;
> >
> >       for (i = 0; i < ARRAY_SIZE(res->rst); i++) {
> >               ret = reset_control_assert(res->rst[i]);
> > @@ -1120,6 +1118,33 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> >               goto err_clk_aux;
> >       }
> >
> > +     return 0;
> > +
> > +err_clk_aux:
> > +     clk_disable_unprepare(res->ahb_clk);
> > +err_clk_ahb:
> > +     clk_disable_unprepare(res->axi_s_clk);
> > +err_clk_axi_s:
> > +     clk_disable_unprepare(res->axi_m_clk);
> > +err_clk_axi_m:
> > +     clk_disable_unprepare(res->iface);
> > +err_clk_iface:
> > +     /*
> > +      * Not checking for failure, will anyway return
> > +      * the original failure in 'ret'.
> > +      */
> > +     for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> > +             reset_control_assert(res->rst[i]);
> > +
> > +     return ret;
> > +}
> > +
> > +static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
> > +{
> > +     struct dw_pcie *pci = pcie->pci;
> > +     u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +     u32 val;
> > +
> >       writel(SLV_ADDR_SPACE_SZ,
> >               pcie->parf + PCIE20_v3_PARF_SLV_ADDR_SPACE_SIZE);
> >
> > @@ -1147,24 +1172,6 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
> >               PCI_EXP_DEVCTL2);
> >
> >       return 0;
> > -
> > -err_clk_aux:
> > -     clk_disable_unprepare(res->ahb_clk);
> > -err_clk_ahb:
> > -     clk_disable_unprepare(res->axi_s_clk);
> > -err_clk_axi_s:
> > -     clk_disable_unprepare(res->axi_m_clk);
> > -err_clk_axi_m:
> > -     clk_disable_unprepare(res->iface);
> > -err_clk_iface:
> > -     /*
> > -      * Not checking for failure, will anyway return
> > -      * the original failure in 'ret'.
> > -      */
> > -     for (i = 0; i < ARRAY_SIZE(res->rst); i++)
> > -             reset_control_assert(res->rst[i]);
> > -
> > -     return ret;
> >  }
> >
> >  static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > @@ -1598,6 +1605,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
> >  static const struct qcom_pcie_ops ops_2_3_3 = {
> >       .get_resources = qcom_pcie_get_resources_2_3_3,
> >       .init = qcom_pcie_init_2_3_3,
> > +     .post_init = qcom_pcie_post_init_2_3_3,
> >       .deinit = qcom_pcie_deinit_2_3_3,
> >       .ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> >  };
> > --
> > 2.36.1
> >



--
With best wishes
Dmitry
