Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0525605E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiF2Q2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiF2Q2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:28:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C691BEAF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:28:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so16551532pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5H2TncGeZHlVgF0rSy+eJip9+xYU/JmV0WmAXgh7ZSM=;
        b=iQ8gweKuAZ5V6W28bDDyKzpxZFrV3Dpyy4y254On/3Db9I7vc9ssGwW3Mj3msP3fH/
         36GQoHsTnNaZ+Us8G1yTix4PbWYfR8lP1XcqvQm0EmLYVTxCNefnlXQ83UPMXoMMSPRC
         clN5GiPH+ktzdtyDsT9W9gquw+FWhkpZ97GnsMXcVxsDmgSWm5Tmw3HyqdQSlbBe8FMq
         w+z4wB0r+pjRhFAoLJaIY0KxTd2mIH4+ChcbFRrQuuwCSuDMsXFTit1B3vVL3n+6Qh3k
         IHVVx3JJnSwcmhBwzTy05G7/aBdFf/gDWGSc9SQtHnePnB64KEuNMZM7w5o0pMKer9zm
         B68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5H2TncGeZHlVgF0rSy+eJip9+xYU/JmV0WmAXgh7ZSM=;
        b=Vh2yQOPvBET/8y8Hoj93DlEh4H9lG1rKrJreIH3UDRim+c3o+DdCSOBQwWx8g1gjVr
         eItj0ns5pWQkLbKO2RLnIeBmqnvVRRpT9m6HPsoMwHGB8OWcVli2vQnG76O8a8KMiEk+
         o1NR6NGOrAHmNwm2/7zuXBRxUOy1g8mqMki+hWEPQTr8zkse23n21h4pEl31IeBNNobO
         10bnX+/LBeyb2pYiWbw+L2uznxCT5ocR+s0QOYaLblaPuWPJ9L02zn1phNCcDrk/kN+C
         l2GmOU6i3+hqVu0ACYVy9THq3MPr3/ED2OGPHX5R1iTZsULzYWBpQRS0QjgoFEZc1ua/
         ZAdg==
X-Gm-Message-State: AJIora+T7fqVtjkklmY+x7S6RYhZ8dXHggcWe40wtgCjVVjkgsNosrLb
        3QvGingbL8mpZg3vwGSQV+JKdw==
X-Google-Smtp-Source: AGRyM1uQlnixmQuuX5yZ8e4AcTn7YXgUCxjK/ku0GJgTHDXm2pRVLefUxGJ0ixDUObCpTattuXXqVw==
X-Received: by 2002:a17:902:f642:b0:169:714:b079 with SMTP id m2-20020a170902f64200b001690714b079mr9833597plg.117.1656520114584;
        Wed, 29 Jun 2022 09:28:34 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b16-20020a170903229000b001696751796asm11660712plh.139.2022.06.29.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 09:28:33 -0700 (PDT)
Date:   Wed, 29 Jun 2022 10:28:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] dt-bindings: Arm CoreSight binding schema
 conversions
Message-ID: <20220629162831.GB2013207@p14s>
References: <20220603011933.3277315-1-robh@kernel.org>
 <20220620165541.GA1458883@p14s>
 <20220628180118.GA703354-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628180118.GA703354-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:01:18PM -0600, Rob Herring wrote:
> On Mon, Jun 20, 2022 at 10:55:41AM -0600, Mathieu Poirier wrote:
> > Hi Rob,
> > 
> > On Thu, Jun 02, 2022 at 08:19:30PM -0500, Rob Herring wrote:
> > > This series converts all the CoreSight debug bindings to DT schema
> > > format. These bindings are at the top of the list of occurrences of
> > > bindings without a schema. For arm64 dts files:
> > > 
> > >     702 ['arm,coresight-etm4x', 'arm,primecell']
> > >     536 ['arm,coresight-cpu-debug', 'arm,primecell']
> > >     509 ['arm,coresight-dynamic-funnel', 'arm,primecell']
> > >     213 ['arm,coresight-tmc', 'arm,primecell']
> > >     143 ['arm,coresight-dynamic-replicator', 'arm,primecell']
> > >      97 ['arm,coresight-stm', 'arm,primecell']
> > > 
> > > I'll send a reply to these with the errors in dts files that this
> > > causes. I've reviewed them and they all look legit. Xilinx Zynq though
> > > has 3 clocks instead of 2.
> > > 
> > > v2:
> > >  - Rename other Coresight bindings to use compatible string for filename
> > >  - Add missing arm,coresight-dynamic-replicator.yaml and
> > >    arm,coresight-static-funnel.yaml
> > >  - Update MAINTAINERS
> > >  - Fix coresight.txt references
> > 
> > What a massive undertaking... I have looked scrupulously and everything adds up.
> > Let me know if you were looking for me to pick this up.  Otherwise:
> > 
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Can you apply. I think there was another series from QCom touching 
> the MAINTAINERS entry that will conflict.

I just tried a rebased on today's linux-next and it didn't blow up.

> 
> There's a couple of indentation fixups. Can you fix when applying or do 
> you want me to resend?

Fixed and applied.

Thanks,
Mathieu

> 
> Rob
