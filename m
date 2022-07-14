Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00CB575101
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbiGNOnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237715AbiGNOnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0531247B86
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657809777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eIdNk8O1gW+R+g6m9uiQ7NltrhT3ipP3bmVkK691BR8=;
        b=B4mymdd+Hv+CsDWGO1TSTA3wc8l8TK199QpocwWWSuDsNYkYCf0YSHeTMF+haqkDGnk3t+
        B2Xfs6wTxXUSNVVIrsRy14qze9GrvhLWTRNUl7j5b3GMtrkxOG7kU57JhrwXwrAFtGZmGL
        Gv3xpWIPmyMXuEM25eiVW05mAmVrwUA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-Q_THs04iMB-GRnnDJkzUMg-1; Thu, 14 Jul 2022 10:42:56 -0400
X-MC-Unique: Q_THs04iMB-GRnnDJkzUMg-1
Received: by mail-qt1-f197.google.com with SMTP id w24-20020ac843d8000000b0031ecbfedc25so1620002qtn.15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eIdNk8O1gW+R+g6m9uiQ7NltrhT3ipP3bmVkK691BR8=;
        b=3yqLJ8AAITdH2y6pJnqc/X5uDsYPqBEuMkZAx7HywGbEsWLrQMVc4+C+oNrUGc4Xo8
         1zv/3iOIwNuO+A067ysEELgD1smjCeSwAxhO9RoOB6TW2i2H+hNj9o+rwT5Sw31Azbe3
         l879VzwU/46BbUje47XttkRA8bM/FIaXRAhQdB+ymOnftezpUYuZQkZmV3FV4maoj/HT
         fJ+JAz1/EbYT9N2CMgIXKlvsmqOBryHJZj9Ca5VATDyibyhGkX/lqpcBF0tLI/RwjZTi
         3h6QWXK80dJakBTUKNlaqYxRhFzeqrpx3uFMchSWkKa4C3TkfSE/mJU+MPQZAcc4k0+m
         pCFg==
X-Gm-Message-State: AJIora9f8WtKjKe5mdgW3cmhzbdfjwq9xdK4d+DqOXnNysny0l+2urtf
        M1bEQ3q2NXV4XPA5HwyvCKcWF5lX7Aa2LDp+okFjfYHUA+a06obVbEPH8b3+sVTUTVT4xoZTYWA
        uRHhMKFWQeO266M40nnRaFN94
X-Received: by 2002:a05:620a:e86:b0:6b5:4fc9:c0e5 with SMTP id w6-20020a05620a0e8600b006b54fc9c0e5mr6014491qkm.246.1657809776287;
        Thu, 14 Jul 2022 07:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u2p7lnj/YvP13oXDzpbzDj2LWU9ar42HAS8jRvmxUOpAd7BSRKi0iPqQbo+IpZSJ6Yqxpisw==
X-Received: by 2002:a05:620a:e86:b0:6b5:4fc9:c0e5 with SMTP id w6-20020a05620a0e8600b006b54fc9c0e5mr6014463qkm.246.1657809776056;
        Thu, 14 Jul 2022 07:42:56 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id e17-20020ac84911000000b0031eaabd2117sm1606432qtq.12.2022.07.14.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:42:55 -0700 (PDT)
Date:   Thu, 14 Jul 2022 10:42:54 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 7/8] PCI: qcom: Clean up IP configurations
Message-ID: <YtArbrYztI3FHZsb@xps13>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-8-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714071348.6792-8-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:13:47AM +0200, Johan Hovold wrote:
> The various IP versions have different configurations that are encoded
> in separate sets of operation callbacks. Currently, there is no need for
> also maintaining corresponding sets of data parameters, but it is
> conceivable that these may again be found useful (e.g. to implement
> minor variations of the operation callbacks).
> 
> Rename the default configuration structures after the IP version they
> apply to so that they can more easily be reused by different SoCs.
> 
> Note that SoC specific configurations can be added later if need arises
> (e.g. cfg_sc8280xp).
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

