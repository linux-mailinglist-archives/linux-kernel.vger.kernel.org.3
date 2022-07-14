Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109475750D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiGNOa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiGNOa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DBC25C9CB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657809025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ntTuSjA4Qbr6GUmqmKDR9KDLjR1tsalNNR6HXiXW8Mg=;
        b=GiYqKn1ff7RUOk3qt+76EGWtg61gjvg0TZ+8G87rxqEB4nJT8llpO1r2Mkq3tIP3dO3Cje
        yZqdsYEyDfB5B5QwwYDjX2bsTRWGdlkXQeG8/WtROzcVT+89sV3QJW3TqHJH60dZy69TJW
        vhVJarHLfbwWYUwfXSaSUuCPKPNnC2U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-TfryIuktN5-w76v-7qEC8w-1; Thu, 14 Jul 2022 10:30:24 -0400
X-MC-Unique: TfryIuktN5-w76v-7qEC8w-1
Received: by mail-qk1-f198.google.com with SMTP id bp14-20020a05620a458e00b006b59195c391so1252204qkb.19
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ntTuSjA4Qbr6GUmqmKDR9KDLjR1tsalNNR6HXiXW8Mg=;
        b=3gIIBgBbznEju69IvxEbHlHfPfB6oE3r1IyGqlGxSgvbYcrnGNjK8vOqTCecvljaGf
         K5Ps+E/kOQChWwGZkX9aXVgZbWbqxHInMHWMOFTqfQvmJ0r7tE7N8ivnbSPgHpr83hqu
         6jteuZVB10vcCznRe2x4Kb5kVu5sXmaYsFSbyruKqTShZGdLYmBgh6QUYDX3q0Q0STOS
         rwY4/Imv0QHmkxZAQ1Qs5qv/q1+V5Rh1kQ0zMQY4yvPtzJ2EC4vLmQNmdihDjN2zW6HX
         eU2oQIDz0POG/QYEPTtMeYQlizmWq2tpONINadY8KAK6TKVlyvslk3qbdG/ZJuXzijQZ
         HoYw==
X-Gm-Message-State: AJIora9rj5slW+R3MoO0DbDr0xzPlehWjcpB7odBJy0qTjIbj5UB5+F6
        0gSZ10sXYfS3sdBjmcT403Zhvm+EZQtJRCJMsN0+wnej7cwPruw4O/KvyNm/qGwPR+ZWe4G2r7c
        5OTynIW5ffj5LqPpA3shZ7nXA
X-Received: by 2002:a37:c444:0:b0:6b5:bb9b:94ef with SMTP id h4-20020a37c444000000b006b5bb9b94efmr5122273qkm.411.1657809023365;
        Thu, 14 Jul 2022 07:30:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vHB5XxL+b05VlwhYR1I2Pf+3ogfGMLZm4EL5k8yaXQWkjJU/o0PvlbmbMRhd+zQrATU/ckpQ==
X-Received: by 2002:a37:c444:0:b0:6b5:bb9b:94ef with SMTP id h4-20020a37c444000000b006b5bb9b94efmr5122258qkm.411.1657809023140;
        Thu, 14 Jul 2022 07:30:23 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a0d8700b006b57b63a8ddsm1502612qkl.122.2022.07.14.07.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 07:30:22 -0700 (PDT)
Date:   Thu, 14 Jul 2022 10:30:21 -0400
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
Subject: Re: [PATCH v2 5/8] PCI: qcom: Add support for SA8540P
Message-ID: <YtAoffqhZQi1vIHa@xps13>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
 <20220714071348.6792-6-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714071348.6792-6-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:13:45AM +0200, Johan Hovold wrote:
> The SA8540P platform has five PCIe controllers: two 4-lane, two 2-lane
> and one 1-lane.
> 
> Add a new "qcom,pcie-sa8540p" compatible string and reuse the 1.9.0 ops.
> 
> Note that like for SC8280XP, the SA8540P controllers need two or three
> interconnect clocks to be enabled.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

