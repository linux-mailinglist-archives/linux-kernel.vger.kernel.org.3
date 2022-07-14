Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461FF5750CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiGNO3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiGNO3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E77FC5C36A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657808988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N8oBD289dGEOPLHJiPefuD87Ky4LKaAMPVE1HnT2THU=;
        b=iClZfEDVgDNQghCEk4+SnhMQIcBbKbDL2Z+MxiEBtgAgVbHQOHFHTmfeXPBmFjVWZHIFuQ
        qPwHoJ3OFx7CKTOW1acjtsyXbsJUhptCnByGmd6xp1szTboRq6IjF42NBqclU65CWyS/jV
        ffJiT+xRn23Ml10HLk4lIcZed438paQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-6VIuOQN8M3ettKrVrzyakA-1; Thu, 14 Jul 2022 10:29:46 -0400
X-MC-Unique: 6VIuOQN8M3ettKrVrzyakA-1
Received: by mail-qk1-f197.google.com with SMTP id bk21-20020a05620a1a1500b006b5c24695a4so1258098qkb.15
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N8oBD289dGEOPLHJiPefuD87Ky4LKaAMPVE1HnT2THU=;
        b=5BhhCIWFKg9bIJzJzE/lx+MHba5s5ksnyHmOKQ5CSXEwrgcwbyt9KWopBs2SG1qXtu
         uXb+XqXcZruVHbtBptbE2ifTU/fScAP76f7OdSNNUaibIIa2ru8OJyhAvEV09Qcx1tdq
         htzzYWzy6ZFC8rsaXBwdv3eTdgeh/syNkuxn7A+aspJBaYo1Bq8+7ruy5qOkhEz5FdTX
         1odxYXgy58MyS73MLH0U9FiUpwv6vpptvQ5oFWpk/fXZcu/+ImI0mdg0rRXjmFVfidb5
         +T3zy6q658TYvSpxe1amc3qT97nKkYDndOQJzXgoYc3XCA/t9Vu+VYbSyZXOSmjnLuFA
         djPQ==
X-Gm-Message-State: AJIora81OztOpkS9rYey5eBHvKhX4Zp5LrM1ahDCYDkPGJOi2dtY+xml
        Yt/e8juyK8dzBwh+9tB+bUL21H6VQNYGtOAyB4YpI6TOXOxAu7Gkj/mJNV7bsSs8emR0XM+oH4S
        NvuBT0BmiU2Vj2VgaRuF/QzJt
X-Received: by 2002:a05:620a:490b:b0:6b5:50ba:df51 with SMTP id ed11-20020a05620a490b00b006b550badf51mr6154034qkb.53.1657808986445;
        Thu, 14 Jul 2022 07:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t16Q/9bg8jc78Kiv5IS34JX5fMV5xULfn6e6fF+bl1rBRgdTiM9zrPFe4bMltLNPjW6XLFWQ==
X-Received: by 2002:a05:620a:490b:b0:6b5:50ba:df51 with SMTP id ed11-20020a05620a490b00b006b550badf51mr6154013qkb.53.1657808986204;
        Thu, 14 Jul 2022 07:29:46 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id v11-20020a05622a014b00b0031e99798d70sm1719199qtw.29.2022.07.14.07.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:29:45 -0700 (PDT)
Date:   Thu, 14 Jul 2022 10:29:44 -0400
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 3/8] dt-bindings: PCI: qcom: Add SA8540P to binding
Message-ID: <YtAoWOngodHMLY9L@xps13>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714071348.6792-4-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:13:43AM +0200, Johan Hovold wrote:
> SA8540P is a new platform related to SC8280XP but which uses a single
> host interrupt for MSI routing.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

