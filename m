Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D556555B23C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiFZNlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 09:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiFZNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 09:41:20 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453F0DFFE;
        Sun, 26 Jun 2022 06:41:19 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id i17so11321553qvo.13;
        Sun, 26 Jun 2022 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wsr7GyWI/nrL4tsAp10vAzoFNjZ53E89T9GWndfpfdo=;
        b=me6B0zZoRRhh6rEZLz1xxKTu16H//E447EH8bpU2IQh/i/IGWhtmIVLMoZL5ErTWX4
         CVXkDF6KN/DU3EEvNO9Z2c6H/Uu11yF4H3evy4YR9xzteBRDmqVeqKfeO3MDlZVYTz7T
         DCBHTj4ddkrZ+WuquRE0C16ossEhevyr+Gbllr5aPmu+J7t+plF8OSf6wqK72jfteOPB
         Vpprz1+5jrj3jfy0OzWs43uWI2vusnlnXl9lrrARC2lbvlsbJ6owcO7i9qIiLqp5aaeA
         +ES8f2v23qmB82FGtgsSrC+c0heEn7n0gENR29zqiqcNVpxoaR5iivEnyOUUkXZrzlNG
         3TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsr7GyWI/nrL4tsAp10vAzoFNjZ53E89T9GWndfpfdo=;
        b=rA4bRjJufZ0t+4y2Fj44ZP/DDxuU0nSqa4kHqv+0Hkm60Nx9srZwaVNrn41l+VR3X+
         XWzPzm22Rx9F7csgBWCsThDcjado2DrQhJM343e4UCsBhMZAuWX/k7lCWqpKdy8/xa3C
         zlpXY5znxo/+z377WUFAtx3RJPBmj928jz4s7O+7ZWv3miUvO6Vdqf1fRqEygeO8NpbR
         tyFA58phdqUjRae4ZJbifur5czu7zVkjgXsIL8eXS0aHx+Hbxwlvrj3mZL8O48JW1rYF
         lvqGmMSQls00uuVX0azqvgwkt3466phuqzp1Q5BQB6K7U7lkwjXSeQeVf3rmTD8O28XL
         /7CQ==
X-Gm-Message-State: AJIora9PAQLVy7gdH4byjeCiMq9LcDOam86Of0L2BLppHVRbuDJjYSoA
        0NFfy5hfLqqaLEj0saK8VgpnaHOxWEvZQHwFVgc=
X-Google-Smtp-Source: AGRyM1tWY6CCIhsExLB2W7wpR6qwuX2B+MmpQkfjs8JMlfBvozH1vusWsotmarNOX9imUk6M6rPP430PXOKuc2EUKj8=
X-Received: by 2002:ac8:5dce:0:b0:305:300e:146d with SMTP id
 e14-20020ac85dce000000b00305300e146dmr6019153qtx.546.1656250878361; Sun, 26
 Jun 2022 06:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220623182542.1116677-1-robimarko@gmail.com> <26cdc24c-e0e8-1059-f6ca-11c08615eeca@linaro.org>
 <CAOX2RU7aEaBt_PYS2UA6BES+dJgx4n2QPHJ6yWYWZuTt2SLXoA@mail.gmail.com> <46ec1f38-dcbe-f87c-4f37-999d24eec522@linaro.org>
In-Reply-To: <46ec1f38-dcbe-f87c-4f37-999d24eec522@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sun, 26 Jun 2022 15:41:07 +0200
Message-ID: <CAOX2RU4zhtwacgWWwZehnRBXw9qUgVPdfOexOWeKSxe-tt=ZHA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: firmware: qcom-scm: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Sat, 25 Jun 2022 at 22:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/06/2022 10:50, Robert Marko wrote:
> > On Fri, 24 Jun 2022 at 11:52, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 23/06/2022 20:25, Robert Marko wrote:
> >>> Convert bindings for Qualcomm SCM to dtschema.
> >>>
> >>> SoC compatibles that were used, but not documented were added.
> >>>
> >>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>
> >> This was already submitted:
> >> https://lore.kernel.org/all/20211218194038.26913-1-david@ixit.cz/
> >
> > Hi Krzysztof,
> > I was not aware there was already a version sent, just used linux-next
> > as the base
>
>
> lore and "dfn" keyword. Several people are working on Qualcomm bindings,
> so that's the only way to check it.
>
> > and it wasn't there so I assumed, will search through the archives next time.
> >
> > Anyway, that attempt looks abandoned.
>
> Let's give few days to David to respond and to re-submit. If he does, I
> am for FIFO approach. If David does not resubmits, then check the review
> he got to be sure there is no need for same feedback.

I see that David sent a v2 today, I'm just glad to get this converted.

Regards,
Robert
>
>
> Best regards,
> Krzysztof
