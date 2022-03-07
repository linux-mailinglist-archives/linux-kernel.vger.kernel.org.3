Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059AB4D0066
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbiCGNsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbiCGNsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:48:41 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312722C10C;
        Mon,  7 Mar 2022 05:47:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q14so7815571wrc.4;
        Mon, 07 Mar 2022 05:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FYcnnY3a68jWtSqdLK3VWTTnpJQcGBd8FzPnK+XKCDM=;
        b=dEjDDc0rHc39ZYPylXJA1H3/xgJUo8F2NmQGqwr+qxITXbcRjMXybv16fH9mSdb1m7
         bJSIVdjppYKvvvLTXggFzsabqxtIOCm0gYoOMUXpVdYoU5TADkVxkPjpJVAzQagtkpcH
         ahEGVhrwMicgaHDIV6N1sRpMVGspQnL8kBdp5C+LTj653ZGAN2vF9U2DDF75hWUjnI5m
         SjLd3ojmOnGIF3r7/zRWQN7+T6TXxJJC1jFCg2r83SAoTztzmOb9ThUW/TwMn/NOmRxh
         1EAaR4E45wmYRKaHKN/o8U3EzzERq62uSBrs56OFgMT0wDIEPMB9D8nQRbSZTdHQSiCR
         Smkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FYcnnY3a68jWtSqdLK3VWTTnpJQcGBd8FzPnK+XKCDM=;
        b=ObTWZwstAAAXcDhm1pkUFDenMzplOkqcdR6ggLsSSSexbMIJ3aunX3j5je6vxJDowI
         X3XuI7R8WStnvs1c4MvwITri/s7Hmircd5GQb5jJWsGQptfpqFja5iQfJ7WjTGb1QDSg
         sGDQzNabs5f/+18R2VNvqUwPBcOMn64jRPXRD3BCXkhbbewVMbrdUeiKmS8UXLS+2hHv
         dQKChDfN5OW9ch03uiPW6BsxNKJk9zRy0Z9FuNOD9tdO9sLPi7h29vg9e2cZmsyQK6yC
         QC5K14rYh0mataYFxZNX37Frx4pA0929GXYCEzZx8hfgXmkmTP/27lbIpCMCzI76ZfUV
         caMg==
X-Gm-Message-State: AOAM530nwEXCOLJh/HaOnZDpR/iPlSGypJC2E5ebI4r4chOH+7s0vPFw
        YiBMvtiPEgKaj/NWxs1kpG0=
X-Google-Smtp-Source: ABdhPJwcc6jrKsnCRGUOB3/K0O9qHuayorLEHuaCcoEiHxDNDFu3cfYXw0q3x/QLp6zrrZfETfZ58A==
X-Received: by 2002:adf:fa41:0:b0:1f0:2118:4832 with SMTP id y1-20020adffa41000000b001f021184832mr8276499wrr.571.1646660865842;
        Mon, 07 Mar 2022 05:47:45 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id f20-20020a05600c4e9400b003898e252cd4sm8467209wmq.12.2022.03.07.05.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:47:45 -0800 (PST)
Date:   Mon, 7 Mar 2022 14:47:43 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen
 = authsize =0
Message-ID: <YiYM/0ueUKDbyyE6@Red>
References: <YhOcEQEjIKBrbMIZ@Red>
 <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red>
 <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red>
 <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
 <YiXxOqfF21q5LAxR@Red>
 <CAOtvUMd3=EME0S6Q1URgS5V1hSvhzLnGEwSy_im=S+1x2-koJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOtvUMd3=EME0S6Q1URgS5V1hSvhzLnGEwSy_im=S+1x2-koJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Mar 07, 2022 at 01:59:00PM +0200, Gilad Ben-Yossef a écrit :
> Hi Corentin,
> 
> A bug in the DMA API it is not.
> 
> What is the call site that calls into the crypto driver in your case?
> Is it the drbg like in the cryptocell case or something else?
> 

In my case, it is a user call from libkacpi test.

