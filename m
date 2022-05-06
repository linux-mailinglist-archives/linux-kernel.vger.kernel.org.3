Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D3A51D1B8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387330AbiEFG7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385364AbiEFG7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:59:35 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD51FA69
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:55:53 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id a191so5421464pge.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 23:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D4NXdd3YqkdO3IMXdjbzk+SiXyDFtdTRliIhRaIF0uU=;
        b=csOcQIqCeppAw0bnbA0PAK/KLSkBNEXJGvbbRFUL5u1FD8EeshJ8vsm100ssR6Ppxn
         usAcP8u5hf++Ngp/PQREyHwtTO1BXYNFWbPhngnUM5A7eYKdOxSqyxRYDf4yMnDC/8NM
         ij7hJ/5HT+HSdWf/+sNGuOS5UEvbAIu00uFL7dGUbAKptzl/2/7aMt5b9n+BggK+0n5E
         a6NEub1mlV0DxGT5mVJxfUZ1rvWIVQVJK1R9UspPKKAZrXXjJMlImCJB5TvpKyb9IdM+
         aaR5Lro6szV2wpztncRzcZLhUGBOd2xR1lxDeN17+mqBaLt70aw0kMBFWLa9/rM2UTcg
         +ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D4NXdd3YqkdO3IMXdjbzk+SiXyDFtdTRliIhRaIF0uU=;
        b=b/3XciwOU3CP3CAOo3kXTgXw5PkM+Fc9RtUPQMBPu/BtRLwnPDrmksNCpLAe2pMj2K
         AGNX962xoB8nS3BJmzso01rMeAa5VVGXg79ZBvFDSHNKMgX+8ktxdh8NDH4L7rFlqQcf
         4WP8V+GNvy2mbHZjG4NQESteOUbeMeBJDd65iLKGwNte6dEwAa1+UwepkeorqsjhAtWg
         JNF3IyHu+bNmewIB3s+35a8+B/ww1mWUw1C8eSxCGYvOWi5XNSRus6GEAd+Ar8h9Srkr
         H2NWLih/zKjc5uJq5vU1u0FFTXVwQjmM4tYxgwlKQd/DLZTnyz0X2WfUcM038cU60OnH
         pqLA==
X-Gm-Message-State: AOAM530IrrAT4Z0abD9og0MdgtFTQtVaFSZ+oEFyJEBFTaJCplZK1pzp
        JfCX/whq7KQ7HaCTHoTD+7JZ
X-Google-Smtp-Source: ABdhPJwtcPALIBrmTItLjcphWrDRFNx0TIk+f7DOIPALma//Tvoi/Vyk1N3h9fQS2zZjkCfYSZ8U4g==
X-Received: by 2002:a65:6a4c:0:b0:39c:f169:b54a with SMTP id o12-20020a656a4c000000b0039cf169b54amr1651752pgu.384.1651820152757;
        Thu, 05 May 2022 23:55:52 -0700 (PDT)
Received: from thinkpad ([117.207.26.33])
        by smtp.gmail.com with ESMTPSA id y19-20020aa78f33000000b0050dc76281b0sm2568308pfr.138.2022.05.05.23.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 23:55:52 -0700 (PDT)
Date:   Fri, 6 May 2022 12:25:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ARM: dts: qcom: sdx65: Add USB3 and PHY support
Message-ID: <20220506065546.GA17659@thinkpad>
References: <1651482395-29443-1-git-send-email-quic_rohiagar@quicinc.com>
 <1651482395-29443-4-git-send-email-quic_rohiagar@quicinc.com>
 <YnQtQ7Il95bfrif9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnQtQ7Il95bfrif9@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 10:02:11PM +0200, Greg KH wrote:
> On Mon, May 02, 2022 at 02:36:34PM +0530, Rohit Agarwal wrote:
> > Add devicetree nodes for enabling USB3 controller, Qcom QMP PHY and
> > SNPS HS PHY on SDX65.
> > 
> > Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> > ---
> >  arch/arm/boot/dts/qcom-sdx65.dtsi | 83 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> 
> Does not apply to my tree :(

DTS patches are supposed to go through ARCH trees. So Bjorn will pick it
through linux-qcom.

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
