Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EBB55A45D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 00:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiFXW23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 18:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiFXW21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 18:28:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE721F2D2;
        Fri, 24 Jun 2022 15:28:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b7so4291401ljr.6;
        Fri, 24 Jun 2022 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M6TdAKBeetFQMmcnXoWXDBN9CpxYrPuj3DRX2P2Szoo=;
        b=Bgx80xNdrOeU9JzOMlCo3jmGu3eQEekyMqjaaQaYKMst/DnrKcGb0EE1upc7kKT8P4
         K54FHhsRXWGYw/bc1J8YMZjeG/8AiSgtYmwnI6mfwkpdX3qvy9niezyBABlqVlTdDv03
         SA+kUOtNjI2FmmvlsZORBRGSAkWAETIKpgqcYPA5tGdwxtl10+UD0RHwwxbFI3oVsb8c
         liFraUMYDWhxgIHIm7mhId9Ea+cmAHr8yUX5fRN0NMwOQNKBipnBwBpuM10qkVNClQKS
         oDA3vxhA6o1tuWr+qxufLUEBgxvZ5J1mdjVi5AQATam+lJabiaASH8u48UBhCA164Kip
         pjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M6TdAKBeetFQMmcnXoWXDBN9CpxYrPuj3DRX2P2Szoo=;
        b=Nqe2zxQTA4Glblkoy28YIOkX5XJyDnl8z0JqTNmyzQDq070FbmUIO6htrPKUgTEnqX
         gRJj8UaIyVxtZBta88jcDVMYfxVFMiz572zkqMoXEzejJ1XsgMB1ab+QngvgJy+gi3de
         Y4Onrv2q6USEdy68W/SblSb6P0w7BpcSlscmORQ5XvC8kJXJIHMHw48xG+W1iAAtb1Ne
         w02EvTVbJRNsZz0fs+8mU/K/l9o5MwZUmfUeSH+KfkASbMIisPSqops/N1QSZ0vf8r0R
         YW9l2wUJe1Ubkt1iT27LfrQRpoeTDhmxgCmiyDjwhzgDhR5dHSzJ5h7WRS3EApLI3zXI
         kVVg==
X-Gm-Message-State: AJIora+gg/HOlqT5NNBdFvCoXlnTbwVmlBjjK5GiTZ8UiWP3f8A3UDgW
        Nq5ude61rn5YubNNFgdtnK0=
X-Google-Smtp-Source: AGRyM1ve4VS6aD8h/ThKo8NNZipID8rOImhCMDMlHauNTgrARt80UIm1/HNQbY9Ll1kMIrgffG9rkQ==
X-Received: by 2002:a2e:91c4:0:b0:25a:7256:a7aa with SMTP id u4-20020a2e91c4000000b0025a7256a7aamr559661ljg.344.1656109704289;
        Fri, 24 Jun 2022 15:28:24 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id o23-20020a05651205d700b0047f62762100sm553545lfo.138.2022.06.24.15.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 15:28:23 -0700 (PDT)
Date:   Sat, 25 Jun 2022 01:28:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vineet Gupta <vgupta@kernel.org>
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
Subject: Re: [PATCH RESEND v9 1/5] arc: dts: Harmonize EHCI/OHCI DT nodes name
Message-ID: <20220624222821.552zhh5yqqhdzmca@mobilestation>
References: <20220624141622.7149-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141622.7149-2-Sergey.Semin@baikalelectronics.ru>
 <53402d57-ee3f-59b9-a8dc-59fa659f3662@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53402d57-ee3f-59b9-a8dc-59fa659f3662@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 03:11:43PM -0700, Vineet Gupta wrote:
> 
> On 6/24/22 07:16, Serge Semin wrote:
> > In accordance with the Generic EHCI/OHCI bindings the corresponding node
> > name is suppose to comply with the Generic USB HCD DT schema, which
> > requires the USB nodes to have the name acceptable by the regexp:
> > "^usb(@.*)?"  . Make sure the "generic-ehci" and "generic-ohci"-compatible
> > nodes are correctly named.
> > 
> > Signed-off-by: Serge Semin<Sergey.Semin@baikalelectronics.ru>
> > Acked-by: Alexey Brodkin<abrodkin@synopsys.com>
> > Acked-by: Krzysztof Kozlowski<krzk@kernel.org>
> 

> This slipped thru cracks. Now on for-curr.

Great! Thanks.

-Sergey

> 
> Thx,
> -Vineet
