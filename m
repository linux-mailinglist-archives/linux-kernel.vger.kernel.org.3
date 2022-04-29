Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501C85150E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379190AbiD2Qcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379176AbiD2Qb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D98DAA1D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o69so6184615pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8o1g1pc1Zo4mdrCDNvDc1CgrtJ8NQHSuN+bpLSURGl8=;
        b=ElAPM0Q3mcvn5oehIQusEMmbTDC+Tdgr9DqEFZ4e/tgDU5vyB6ZS/+cLvyyGcuo8oc
         C/0ilD5BPnZuM6mkYjXz3UbEFnuDWtK4dtUPRAjeD+SBy6h7BJROAR+6bF8FEsmPgXIe
         xna4rWFAgG6K5r3Dz2NDQkPetJpJbDPaZYL0qFiMHfNHOM/IZcIm+ORZgm4DyB70mGOM
         5EEZO449flHI5al9KIDLWQRt/0BaibHb+UGU0UamjPJOH9s8j90UnfIwBOPhuqGOjTSH
         Dl2ZKa6xjTxQ6ZuVD7G2GemGFJe+4ob06HhIGd6b6MNIHVn/0PpsiSqBG4h1PmtB8CQh
         vPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8o1g1pc1Zo4mdrCDNvDc1CgrtJ8NQHSuN+bpLSURGl8=;
        b=RVKsFnARNtzf+YjdE1GmkFTg62n6hnYQjd/7Ex2pCHAXzG45vlp3Zv/Q/LmL5QRNDH
         rWkRKaFjyaXxuwQoo6xvTavmFC5HSbxSaI8V2fh7wWyS0pR1oOrx39L8LbsqSCSGEjx2
         DmmIhPP5Ufg+2VYXeZiqNC97e10a7F6hfvPy4k35PncYm9xU50lXEmwKFYqHo3dYpUPV
         BbfCP15tFMxQDQWGqpoRCGDhLCKp0ACGk9Liw0MC6yf4iVPixvOaYggNfBupFhoTLqY6
         H4g0IWyGAOL5s1JHIcK63cg1CwB2kHYzwDgrrwVV82bgfvQr+ETL3BvOI6IbKBrki5w5
         n1Pw==
X-Gm-Message-State: AOAM532aToih+W9UVOTw4I7KRG1oqiqWz7e0Rc2iUsat59uQXYD51jnv
        /krmfM8ul/Szybj6fYNvcrrtVA==
X-Google-Smtp-Source: ABdhPJyvdpbS70C6vXVgKYdx6dM5RdCk6nlSpEqUBzE4WMG2pJQzRuzdjOIfLA0gRuSH51lH8EJhzg==
X-Received: by 2002:a17:902:ba93:b0:157:1905:f4bc with SMTP id k19-20020a170902ba9300b001571905f4bcmr39283151pls.83.1651249706427;
        Fri, 29 Apr 2022 09:28:26 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id e126-20020a621e84000000b0050567191161sm3603680pfe.210.2022.04.29.09.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:28:26 -0700 (PDT)
Date:   Sat, 30 Apr 2022 00:28:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, james.clark@arm.com, mike.leach@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] coresight: etm4x: Expose default timestamp source in
 sysfs
Message-ID: <20220429162821.GA653442@leoy-ThinkPad-X240s>
References: <20220429123100.268059-1-german.gomez@arm.com>
 <20220429123100.268059-2-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429123100.268059-2-german.gomez@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:30:59PM +0100, German Gomez wrote:
> Add a new sysfs interface in /sys/bus/coresight/devices/etm<N>/ts_source
> indicating the configured timestamp source when the ETM device driver
> was probed.
> 
> The perf tool will use this information to detect if the trace data
> timestamp matches the kernel time, enabling correlation of CoreSight
> trace with perf events.
> 
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
