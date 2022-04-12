Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA424FCC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbiDLCSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbiDLCSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:18:32 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C312B33A3E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:16:16 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id e189so17663106oia.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yJmVOiXHRC894zOY6mDb3Ms45ex+JV6XJHfYGj0ktxs=;
        b=E6JCh905N2KkeZjfmODyDmP+/ngO2s+HrNbPj0kHEr5OD8GngGjgwFRimD1757vGxv
         bP61qrph29/vElOkxw4LK++ubx4AL1eBwIUI91ZMH3c/3mhUYEzi2YS63ZJTdMShqu6/
         kAa/GEjol69gGS6kd4vJeGhxEWSL4hP3Avt5xrxekisVNowe+D/Jbo6hQeilH1XY0Cno
         muyMbKQWUpozGCX3N2pkdCuRqR+Bq/23CXn86SLCyeu1i/CrogR3C89efvTrV1aL3NoP
         VzNoi1CldT9Q+uUm8uY0JU4pCMMpO6/FxZreLLlM5xjDvu9WNfQVBngSUiXjbP42rrRa
         uTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yJmVOiXHRC894zOY6mDb3Ms45ex+JV6XJHfYGj0ktxs=;
        b=wOlbeWMykiE7fPky/3CDelZM0Nms0lmhwuN+A+VMWBKkGKJSEPwvejfIXhTZum2mw3
         s5UBFwrL9hkV4c5JeQ5Dr8k7rtCQlMSvRS94qlQm4XAnNkLr+k4O6fulfQiQSkdcrBRy
         UjoRe21TKVZhe3hTAfWdWJjZU4HPdbu/vis9zumHgOxud06wAV0Uzn7rclGT3bR5lsB6
         MlFehvVXx21DOV/x4PI7A0sbbwyb3mc7m5fCcQNrZ1VMvrndmTpEkPybjB58+67nicBt
         Zndio+bVU75WLjwlyEDW6+DvfgKPGqsS4V+LH+FeSpWuHgQ7zVg2d7+xWcekIWcapCQQ
         ZqvA==
X-Gm-Message-State: AOAM5302afNS/HXJ8qQXnlkPAD3sx2VWoLtIrPQCfUTBHfo62a9uicp8
        YofCBeCuKFqrQFXb1V8i+gkVIg==
X-Google-Smtp-Source: ABdhPJxY6gBcnJ4YDZAXXBG3oCLvf6MOEE4hm/uV2wxXCElES4lKfHVqqCKExbMQ4KU9/Uvhnb6TRg==
X-Received: by 2002:a05:6808:1704:b0:2f9:bb17:21f6 with SMTP id bc4-20020a056808170400b002f9bb1721f6mr803262oib.23.1649729776015;
        Mon, 11 Apr 2022 19:16:16 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id v3-20020a05683011c300b005e6e4a5bd35sm2164701otq.79.2022.04.11.19.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 19:16:15 -0700 (PDT)
Date:   Mon, 11 Apr 2022 21:16:13 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: delete incorrect ufs
 interconnect fields
Message-ID: <YlTg7QPkWMBP4HAb@builder.lan>
References: <20220407172145.31903-1-jonathan@marek.ca>
 <e41c26c2-8aa4-cfd2-27b0-eb011f45eda0@linaro.org>
 <865ff6bc-95a2-8b39-5cf2-bb2d3f592c5a@linaro.org>
 <f1fb2d71-4adf-bcc7-76b3-c7102ab9f2e9@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1fb2d71-4adf-bcc7-76b3-c7102ab9f2e9@marek.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Apr 17:38 CDT 2022, Jonathan Marek wrote:

> On 4/7/22 5:16 PM, Krzysztof Kozlowski wrote:
> > On 07/04/2022 21:40, Vladimir Zapolskiy wrote:
> > > On 4/7/22 20:21, Jonathan Marek wrote:
> > > > Upstream sm8450.dtsi has #interconnect-cells = <2>; so these are wrong.
> > > > Ignored and undocumented with upstream UFS driver so delete for now.
> > 
> > This is the upstream and they are documented here, although as pointed
> > by Vladimir this was rather a reverse-documentation. The documentation
> > might be incorrect, but then the bindings should be corrected instead of
> > only modifying the DTS.
> > 
> > > 
> > > Basically the description was added by a commit 462c5c0aa798 ("dt-bindings: ufs:
> > > qcom,ufs: convert to dtschema").
> > > 
> > > It's questionable, if an example in the new yaml file is totally correct
> > > in connection to the discussed issue.
> > 
> > To be honest - the example probably is not correct, because it was based
> > on existing DTS without your patch. :)
> > 
> > Another question is whether the interconnect properties are here correct
> > at all. I assumed that DTS is correct because it should describe the
> > hardware, even if driver does not use it. However maybe that was a false
> > assumption...
> > 
> 
> writing-bindings.rst says it is OK to document even if it isn't used by the
> driver (seems wrong to me, at least for interconnects which are a firmware
> abstraction and not hardware).
> 

The devicetree, and hence the binding, should describe the hardware, so
that an implementation can make use of the hardware. So there's no
problem expressing the interconnect in the binding/dts even though the
driver isn't using it.

I'm not sure if I'm misunderstanding you, the interconnect paths
described here are a description of the hardware requirements for this
device. (I.e. it need the buses between ufs and ddr, and cpu and ufs to
operate).

> 462c5c0aa798 wasn't in my 5.17+ tree pulled after dts changes were merged (I
> guess doc changes come later), so my commit message is incorrect, but I
> think it makes more sense to have the documentation reflect the driver. Its
> also not an important issue, so I'll let others sort it out.
> 

I believe that the correctness of the interconnect property will ensure
that the interconnect provider doesn't hit sync_state until the ufs
driver has probed - regardless of the driver actually implementing the
interconnect voting. But perhaps I've misunderstood the magic involved?

Regards,
Bjorn
