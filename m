Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9395155A2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiFXUlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXUlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:41:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F6363630;
        Fri, 24 Jun 2022 13:41:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w20so6385682lfa.11;
        Fri, 24 Jun 2022 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/jG5W+ePlStAo427FPsgRmaP+U/0rD3zZzMdqRYYbmg=;
        b=J+tGRTrSFTb1R8Vpr8cSIVIm/o2Vqxs+I2fXmSTA2UCTtbWmE8Fg0sRokRImAhBYJw
         xq7CLvEwVzlTrLtsqp1g006ujV5OnJj6pfhLyOXJVcvgkrAaVPto4YFjTBaYYLnZklOc
         RvhVBLvpez2CY1JRQ9ku0JYimoPj+tDA9JkYdy9BkhyGCoZWIqk092HsH7cBc3aIziGu
         TkTChrOWEoXvt6JpnGete/IfDHoeui49vS+4xpjhT6JRSieX1d7duusa0LwdX9qk+Bnw
         AX5WP9DSydJ1DC6VDm1jnKdb1rbFKACQ2BUrbWYCFK32Rs0jp3v3FvMwz9aYq+5feFhg
         HGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/jG5W+ePlStAo427FPsgRmaP+U/0rD3zZzMdqRYYbmg=;
        b=4g633KW7j9ex4QmL5MknDRJlC566VDtFOQ3ajoCrqEZbfrZwfLB+L5vkkm0kQXBP4A
         3kyHzeO+8E20MObWfvJAxc70tiZfhzvvhxMHEhddSkpL3ZALJ/0OItLMG7o5HJg2vOkb
         efZXLfKwL/fHefrv5cJLzGtv6qyzjoKDd0T+GmiNqL1kJqx0UnkNlOvBudkhU03p/yCc
         BG6Mrp1uymkKdMH78+C6P6YR7jcLKX/F0tp21kEKrrpnZqWL2WV+0x1s7fDlIN9gFtM6
         lqlSkaiOynY6zO0FaJwg6d+/2pJJWv1kwtb6acjcdYN/k9AxH9ItqwUrrb+JVPy7Rfn0
         /wkA==
X-Gm-Message-State: AJIora9MgOVNkvknWycY94gxfhV+IawDQ86jaw6jLmmKZ8MTfEdZuqVP
        VVmF/bIKPLY5tATNZCmHoSQYBgzhJkapUg==
X-Google-Smtp-Source: AGRyM1uctHDCNUKjjxfR1aVDBN/pntJ2Pv6ctSxnvIPYmNdb7JIuhWvHsn1bfb+oEyhecmXfDr12sw==
X-Received: by 2002:ac2:5616:0:b0:47f:8d53:f602 with SMTP id v22-20020ac25616000000b0047f8d53f602mr419029lfd.169.1656103302868;
        Fri, 24 Jun 2022 13:41:42 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512314900b0047f88d15ec0sm506070lfi.251.2022.06.24.13.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:41:42 -0700 (PDT)
Date:   Fri, 24 Jun 2022 23:41:39 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-snps-arc@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v9 2/5] arm: dts: lpc18xx: Harmonize EHCI/OHCI DT
 nodes name
Message-ID: <20220624204139.ndyi437ye7c2gl45@mobilestation>
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141622.7149-3-Sergey.Semin@baikalelectronics.ru>
 <1f426a67-2cf2-b67e-3cd0-a4c452591baa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f426a67-2cf2-b67e-3cd0-a4c452591baa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 07:14:44PM +0200, Krzysztof Kozlowski wrote:
> On 24/06/2022 16:16, Serge Semin wrote:
> > In accordance with the Generic EHCI/OHCI bindings the corresponding node
> > name is suppose to comply with the Generic USB HCD DT schema, which
> > requires the USB nodes to have the name acceptable by the regexp:
> > "^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
> > nodes are correctly named.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Acked-by: Vladimir Zapolskiy <vz@mleia.com>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm/boot/dts/lpc18xx.dtsi | 4 ++--
> 

> You should split the patchset per architecture, because maybe that's why
> no one picks it up?

Each patch is sent out to the corresponding mailing list and the
maintainers. I don't think splitting the patchset into the subsets will
be more efficient especially seeing the initial patchset consisted of
30 patches of which only five left.

I was very busy last year with another activities so what was left of this
patchset was stalling on my local repo all that time. I have been very
surprised to realise that the submitted part still hasn't been merged in for
all that time. So I've got back to resubmitting the series.

* Though the Qualcom dts have been fixed by you lately.

> 
> Let me pick up ARM bits through my cleanup series. If anyone objects,
> please let me know.

Ok. Thanks.

-Sergey

> 
> Best regards,
> Krzysztof
