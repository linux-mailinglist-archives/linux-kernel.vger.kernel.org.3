Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A641B547804
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 02:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiFLA31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 20:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiFLA30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 20:29:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B193F89D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 17:29:24 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 184so2486004pga.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iJKfIba7J14BSxtoD/osZaaoF6YSgB4hRqWLWlecPW4=;
        b=JipljsGnPx8nvmWYBFo3Vp1qJl2urtbohRBbP2hgycF4G+WKrPdRLNoU+5ufsoLE6k
         DFFAn8jysTGY02WLaUyte5++BEq4ihjlIqDQ2IRxZW9q6RhWOk7f0u+F1G1WY1Jiz7Oa
         9bSLOtOd6+n8ASivVAynkgO0rCV/hooZd+NUV11Rcazr2O2k/5RcoGV9AkeMdFSjnvKf
         sa3fvMzAMrhmqwZHnokrD+heE/23xcS/a8jzUmO6owuPXFjhCc+Jl9zz2c+ZWhmhV62F
         66qpOQdWkKk5MaNzw4BXpO/jp15oIdMXElBmrYTQA4U3UCZkPVDiDVtuCacV17WxOM9O
         HzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=iJKfIba7J14BSxtoD/osZaaoF6YSgB4hRqWLWlecPW4=;
        b=UmbxdNdDNd1JCXfRal0qzmpzte4zU1YYDImuR19GbzlO4ZO4BPptdbR3z83CGFvA7q
         X4MwEYrN58rAJ01zon0esGtqncnhBCw+CDx/pG4/1uT4uDwyPGs1x0vHU+ESs9g9KZTx
         N/VGbZl/Sf33GaHT3RrkKDTmVg7m2MFjjZlgyvu2LoGfaCNgr125t1aM1vAfSGetoOKf
         pMS9XT2O3z501+rmObNFtFNcEQx7dqs7p85hy1DjjFLpg1ZjOxFx25G/POo8++LA/Srs
         obdugQtHpy0Vfu9/fm0v6zLZwJplKfD+wYFvvugdD3xSlQDeR7fUGfqxZOAXJ89SxvXC
         4mWQ==
X-Gm-Message-State: AOAM533jEapP1wH2u3r9Umhjj56bdXNlrmA1hvwaJRGjtQ3i4U4k4sZR
        Kv9HH9Xyvzt8x0uHfWaXnAYulPasbRk=
X-Google-Smtp-Source: ABdhPJyMKuJFIP+qOmw+1D1U8C56k/L0pxEn6nLeufQPam4iFdDotDUgVfD5rHPhgcudUL8YXK6FDQ==
X-Received: by 2002:a62:7b94:0:b0:51b:c723:5724 with SMTP id w142-20020a627b94000000b0051bc7235724mr51092566pfc.8.1654993764298;
        Sat, 11 Jun 2022 17:29:24 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a8e8300b001e2d4ef6160sm2050648pjo.27.2022.06.11.17.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 17:29:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 11 Jun 2022 14:29:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH RESEND] workqueue: Switch to new kerneldoc syntax for
 named variable macro argument
Message-ID: <YqUzYirSMpfm3vos@slm.duckdns.org>
References: <20220609234111.226879-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609234111.226879-1-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 01:41:10AM +0200, Jonathan Neuschäfer wrote:
> The syntax without dots is available since commit 43756e347f21
> ("scripts/kernel-doc: Add support for named variable macro arguments").
> 
> The same HTML output is produced with and without this patch.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Acked-by: Tejun Heo <tj@kernel.org>

Applied to wq/for-5.19-fixes.

Thanks.

-- 
tejun
