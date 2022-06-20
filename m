Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23145524D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245455AbiFTTso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343659AbiFTTsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:48:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1F219017;
        Mon, 20 Jun 2022 12:48:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n20so16339572ejz.10;
        Mon, 20 Jun 2022 12:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5KulNPMeo7HI8Wh3XOzXN/pOGB2fVu2iIF6zPeqNoQ=;
        b=HCUgciW1F5vOG395wRxz+cu181/EMw+laM6S+0jZOffpN8a69qw7Xdt7vOIFDLAcQR
         Zoa2D3OLxtjtUfIXb3+5IpGiDiXbNYbTW1lu7HgORiTCtl5fMl7KsuCWHRroLmwsUx4h
         ftBZdKHik4Z4LrvGFmU8zeKa9cVEKksz3L8rrJwykvPwsbxlGmMmovysK6ksrloclT3f
         VPtW+N6YqIdzoAX733KTfX3lX1ULjWM0vWN6Lm9rH6yquLxURdcC9h0OFh0oAtsAGNAC
         2LEVUt8L96fz8vmWUzcnvRe49NkP1ZJu+s1KBDMvoBepKrjf8JxZlLTfv0BfPt4++L20
         XMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5KulNPMeo7HI8Wh3XOzXN/pOGB2fVu2iIF6zPeqNoQ=;
        b=wJqu5oq/fUBqUElxo1xb4XMW0w5cEHoAQZzAL3GdbZRK3Lx7xK2TO7Vi3JBpdUhfFa
         dTgTJzoiYb+qcCN0fsFG9M1PYrG5Q2G+G71X/upWL4L7CIVt7t1jBTddIND47H5tWfjK
         UKJ6RnsLsGS6C4Z8kGGCqL4nOIcphtxixJ9r5YoxRiblMmFeuazUuoUluX8xSnaOFLOL
         OSGR/k+s4ZscN1SIUlQ/OTe+H39v0pFDckpPYfBNsh3z2if4vazINZj2etxIMlwDTUgC
         xzS/M8VC4VGKf+32cMD2yCrwovgqz1GvWXvRbbv+YFgPTvcHYKnJeL40yhJM+aAmPKgh
         HV5Q==
X-Gm-Message-State: AJIora+DS1HTNQGttlYQ7yob5tSz+E+vZY9wlzIP5pCzKNUgFAcaMWFl
        Iio2UxSrmLylRV6a2KIDKsoFsYVw3LWquqJ3UXE=
X-Google-Smtp-Source: AGRyM1ta4B0jrT2K8Pn5nSnr2kzekIbKZsWJOBQOjPnQ3zKyEuRnqnZV7sJFu08rjWc7xIIIkj1oLe8LyAtycTl5v64=
X-Received: by 2002:a17:906:a202:b0:711:29a:c96c with SMTP id
 r2-20020a170906a20200b00711029ac96cmr23096630ejy.407.1655754516062; Mon, 20
 Jun 2022 12:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220501103428.111286-1-krzysztof.kozlowski@linaro.org>
 <20220501103428.111286-2-krzysztof.kozlowski@linaro.org> <DU0PR04MB9417AFDAFE3F06B3F9274E1888C49@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <09e8c5cf-12fc-a10e-dacd-338b7e271202@linaro.org>
In-Reply-To: <09e8c5cf-12fc-a10e-dacd-338b7e271202@linaro.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 20 Jun 2022 14:48:24 -0500
Message-ID: <CABb+yY25-668ara-rjBD1LqJu=VRP=dwQp9vMw8kjxmpSvC+8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: imx: fix duplicated initializer
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
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

On Mon, Jun 20, 2022 at 1:39 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/05/2022 08:52, Peng Fan wrote:
> >> Subject: [PATCH 2/2] mailbox: imx: fix duplicated initializer
> >>
> >> rxdb field is being initialized twice:
> >>
> >>   drivers/mailbox/imx-mailbox.c:889:19: error: initialized field overwritten [-
> >> Werror=override-init]
> >>     889 |         .rxdb   = imx_mu_generic_rxdb,
> >>
> >> Fixes: 315d2e562418 ("mailbox: imx: introduce rxdb callback")
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
>
> Thanks for the review. This was a month ago... Anyone willing to pick it up?
>
There was a predated fix, which was picked.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mailbox?id=262190a8ca2b1e1ec75b8a4f1c7f07e585facd6f

Thanks.
