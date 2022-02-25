Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAC34C4DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiBYSYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiBYSYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:24:07 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D284A1B45D7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:23:26 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d17so5423643pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lw2tVDAuKEfg8bijjSTLHy0bAbafPvPmOe1XuQajp7A=;
        b=mI06mSIHHJFfg1p5ZrLzTf8yyoeQ/rZigLingXhIVkNkFxDwrh1z/QmxkS/qL3b5D/
         RMbxJ6xWTK5mWL5RcL+goD/fNZngB1FneyBJBmpMjEWiBRoDpx1goVON9wAgQJxx/RHC
         IUemPeGZdgam1Lkno02aKlFhsbFvVZ7BGG4mkcYvA9H+lUfPA/7ZXDqZ1exm0BONLn+t
         9YI2lXMEnc0EX6vpYe4yqzD/qUTz5QOXC6yvsZXhdoKCckXh9s9GO0IwRSCuaejZU6xx
         KcFvynS1YgkPBmajOzq3i54ue16kgz0jPmH7PrsPBd22QFKP2MLla0GYnRdf8Xjyh+lL
         fx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lw2tVDAuKEfg8bijjSTLHy0bAbafPvPmOe1XuQajp7A=;
        b=XuplWsqnaehpSEGhuFNvaUwHNGxEDJdNaetidC601NZk3WoOSD8fsD3tVrysgJojKH
         2eua3iOZ/UAT1dYd+zUIU5OR8k3QMf5S+85KQcCgihStf+vUd7CmAoqVcgrtaOMrhTOL
         bO9g5/VWIM6RKX6eZKxtSWgUY1a+Q7vzfeRP7aGNTdlpLAAcxslz0YCwyUpl5qEjJxtv
         wPchdduNNwk7he3SFQmCHpdtbLF/pxg4F1zHh+YokJ36Z2Tfh0Qn4Un+0jZNqS+cX9fe
         EUr2zomCSaQxReU+M4p09TwLLEO1BkpiTpPkRm0UU8xfccsBKuzN5vVFEqIxSK9GaeSU
         pl5w==
X-Gm-Message-State: AOAM5317tn8BCg1jQOctMvEVSP4QUFJ4xF1dKmg6c0ALkNXBwObGbnC4
        EDeTz11O68WAsAPlyMAgi2NcC9IcQYE+y54=
X-Google-Smtp-Source: ABdhPJyMVviF/ifryo3SfljNP/FoVPf24sEk4F74H3nfQjxNlUpGcpxqW+61s2P7YKVfMLViHCmLsg==
X-Received: by 2002:a63:7742:0:b0:374:7607:afa with SMTP id s63-20020a637742000000b0037476070afamr7178017pgc.391.1645813406296;
        Fri, 25 Feb 2022 10:23:26 -0800 (PST)
Received: from thinkpad ([220.158.159.72])
        by smtp.gmail.com with ESMTPSA id f13-20020a056a001acd00b004f0f9a967basm4181042pfv.100.2022.02.25.10.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:23:26 -0800 (PST)
Date:   Fri, 25 Feb 2022 23:53:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com
Cc:     omp@nvidia.com, vidyas@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: PCI: endpoint: Usage of atomic notifier chain
Message-ID: <20220225182321.GG274289@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While working with the PCI endpoint subsystem, I stumbled upon the sleeping
in atomic context bug during CORE_INIT phase. The issue seems to be due to the
usage of "epc lock" (mutex) in functions such as set_msi, set_msix,
write_header, etc...

These functions are supposed to be used in the atomic notifier chain by the
CORE_INIT notifier. While using the lock is necessary in these functions as
pci_epc_create() would've been called, I see two possible workarounds:

1. Using non-atomic notifier chains such as blocking or raw.
2. Modifying the EPF drivers to use workqueue in CORE_INIT notifier chain. But
this has the implication of missing the workqueue execution before hitting other
PCI events as there might be a delay in scheduling the work item.

I prefer 1st option but I'd like to hear other ideas also.

Thanks,
Mani
