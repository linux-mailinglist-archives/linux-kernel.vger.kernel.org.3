Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95F45555A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 23:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350182AbiFVVAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 17:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiFVVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:00:09 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F412458A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:00:07 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id p8so22748230oip.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fgFdyYaJFSrKvZRdMqgOs18OJo/zF/MNwP4V+anA3WM=;
        b=JulRJN6CW15/pPNghPSZsjlzB6OZCSLrEdRvPPYC4QGOu6r+kNrradu/1EPnbko3dI
         X1/6LIgX/Zjt6JvHW7+/KentflQKO51zFGIso4gP42pxUGm8JNyQckwxYUeVgerNWx6y
         rISL6R6lVxLuxudYnPHcvxFsslWgXW6LJXfcpD/uRcbY0T8lpA1FiLIGiNijKCA6rLXK
         YWPt3TPPDqAe28Se6cqbHmI2sc3Jt25uHeFjPqfT89knj0PJoEwnMgIjcGGWXaD/hQ2z
         5t6yY6iHmScc1wE9o7+CWxy+WMtM+GZXdBPPzBi0xd3kOduVAcgGRa7Gpk2pWdKnaWRI
         bADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fgFdyYaJFSrKvZRdMqgOs18OJo/zF/MNwP4V+anA3WM=;
        b=s2FDcGVnR2GVz18cR+mrQ6e25uFAqPbrt3K693CGq3luhU1bJNbYdB0tyOE9DLKIqk
         KmiylkuG1XFa9vWJptdfE3OGI5/ZtXigGmlvZ0ywZaSoDS9dgpD1yGCq++bXkL7NpGrG
         gm2KbNNs7JzTC5yovMwUgrksOwxiIV17FE4iipCijwCE5bzoisgpzy8MuXA3EH6js5Lk
         Sk0i0nAVRLfJgzijkMEY0AH0XwfPWCUpv8ktKqd/8EfvImYE/U/ChKMegPJTnbZOsWmZ
         tzAuewvrMsE/3UINm+io3YGlonxTBRAEkLVZIDQm4dyN8Nw93nfK3FZli2Fwt0yTnZCn
         nDIQ==
X-Gm-Message-State: AJIora/FaeHuom7E++QRiDGM5uP1BUne2MCtX2cVugbq6hyXmkv7yFgs
        A0PhFAPRXdXAoNqw/rS5MUcXWQ==
X-Google-Smtp-Source: AGRyM1uxuZwvBjlclapkGEt6hVnDIy81a+s971dC+EHX3LFo3XPVdvXpT7XPbC3lysRi066aqk9k9w==
X-Received: by 2002:a05:6808:115:b0:335:23c0:5460 with SMTP id b21-20020a056808011500b0033523c05460mr163434oie.117.1655931607014;
        Wed, 22 Jun 2022 14:00:07 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z12-20020a9d71cc000000b0060c7b0a77a8sm11746507otj.52.2022.06.22.14.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 14:00:06 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:00:04 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sc8280xp: Add reference device
Message-ID: <YrOC1CtzvcBJefvG@builder.lan>
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-5-bjorn.andersson@linaro.org>
 <099cc82f-d52f-315f-189d-bcc40c1afd49@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <099cc82f-d52f-315f-189d-bcc40c1afd49@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Jun 07:33 CDT 2022, Konrad Dybcio wrote:
> On 22.06.2022 06:12, Bjorn Andersson wrote:
[..]
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > new file mode 100644
> > index 000000000000..36ed7d808ab8
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> Is it the only configuration supported by Qualcomm, or only a reference one?
> 

It's the reference one, but reused on the devices I've seen so far.

Regards,
Bjorn
