Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81815B012D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIGKCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiIGKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:02:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDD29F1A7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:01:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e16so261905wrx.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 03:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=a8/Cnr3+NRiTeHm77aJYOksHa5QVLbTuiIVNWMiWpbM=;
        b=QG6xanwk5cuEfiq/oJekTvPzTUk+xsrSNaWVGrOrbJAx8bjH0kv0AzvSJCXgeJj6vX
         qVEH28rDfkV74cxT7Q8+89AhD/DnNlv7x2Bpju9v+Mi/JMRIo11ifF4klTKl4rdxoibN
         THbRahYqunJdr6MdOr2CYhmKQ/5wqXqYJSnI7GAOmA2PggU0254oFrVVtfkzKToezlhB
         pm4xU+jQSVHRX6yFPKHL2tKklCNWkgGeNLBfHYhHhmCCWXApFXaCT8LFaR9nK+7B0+hC
         iwyNBTC+/XJLn4qw5niTvvvInENxqZ0diBhTvRgmSfMzPZlGvlM9B2d3T/2mZX5LuQl7
         IfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=a8/Cnr3+NRiTeHm77aJYOksHa5QVLbTuiIVNWMiWpbM=;
        b=P4e6qGbpUCkmFLtfy/nVbZQSk4ui9XB9ZxuQ8SgQ4oD86nUaK48ry2A5I/D0Ay5X8d
         6hK0p9o0Z08N7lMTksXFtFdB0D58ncF79c5ZtOJXIzaQequ+vfv6GLpKIEjaH1s6uj0s
         5I7mG3FSWno8taAFXAHXIwR3pfKHsGIb0a265RxB1eN9uT5yojw8UuBAeM/ABOoNkvEb
         yTVmFyx9sf8EXLF28p0QDRIi4KFaijkB/0tWiGMi5dfCHvehQJYT5ElS5itgUhigzMsv
         Qy/noyaZ67G+0ebPrXVYXGjM2HTVos3xSrLiR58+WnuTSnnooKad38NfsiFJpB2IMPaJ
         KUmg==
X-Gm-Message-State: ACgBeo1ngdxj4Q8lgHTpUOqV6ggIh7meC7ZHIXnUMd/cdbnDia5bRkD+
        uvkuZtTd2MMbzIMFBkc+2Cf5tQ==
X-Google-Smtp-Source: AA6agR7U1xM6IHLwwgCqdU0PlTwcu1ukzEPYF479TZ7OE12LaBASXo2WIzRmeqjQXlAU+Rk28pJkZg==
X-Received: by 2002:a05:6000:144a:b0:229:b76f:86f9 with SMTP id v10-20020a056000144a00b00229b76f86f9mr677000wrx.613.1662544906871;
        Wed, 07 Sep 2022 03:01:46 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0ac600b003a5bd5ea215sm18021930wmr.37.2022.09.07.03.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 03:01:46 -0700 (PDT)
Date:   Wed, 7 Sep 2022 13:01:44 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 00/10] misc: fastrpc: Add audiopd support
Message-ID: <YxhsCKEWFmlFgKWU@linaro.org>
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
 <87f59c6d-c2ad-25c2-a0cf-972b5df42bce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f59c6d-c2ad-25c2-a0cf-972b5df42bce@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-06 15:12:39, Srinivas Kandagatla wrote:
> Hi Abel,
> Thanks for picking up these patches and reworking.
> 
> On 02/09/2022 16:48, Abel Vesa wrote:
> > This patchset adds audiopd support to fastrpc.
> > 
> > The first version is here:
> > https://lore.kernel.org/all/20220902131344.3029826-1-abel.vesa@linaro.org/
> > 
> 
> I have tested this on sm8450 with audiopd and loading Single MIC ECNS module
> to adsp.
> 
> Which platforms did you test these patches on?

I have tested on sm8250, with memory-region property and vmids added
locally to the adsp fastrpc devicetree node.

> 
> 
> Tested-by: Srinivas Kandagatla  <srinivas.kandagatla@linaro.org>

Thanks for testing it on sm8450 too.

> 
> 
> --srini
> 
> 
> > Changes since v1:
> >   * dropped the patch 13:
> >     "misc: fastrpc: Remove unnecessary if braces in fastrpc_internal_invoke"
> >   * sent patches 1, 2 and 3 as a separate patchset
> > 
> > Abel Vesa (10):
> >    misc: fastrpc: Rename audio protection domain to root
> >    misc: fastrpc: Add reserved mem support
> >    dt-bindings: misc: fastrpc: Document memory-region property
> >    misc: fastrpc: Add fastrpc_remote_heap_alloc
> >    misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
> >    misc: fastrpc: Rework fastrpc_req_munmap
> >    misc: fastrpc: Add support for audiopd
> >    misc: fastrpc: Safekeep mmaps on interrupted invoke
> >    misc: fastrpc: Add mmap request assigning for static PD pool
> >    misc: fastrpc: Add dma_mask to fastrpc_channel_ctx
> > 
> >   .../devicetree/bindings/misc/qcom,fastrpc.txt |   5 +
> >   drivers/misc/fastrpc.c                        | 267 +++++++++++++++---
> >   include/uapi/misc/fastrpc.h                   |   7 +
> >   3 files changed, 247 insertions(+), 32 deletions(-)
> > 
