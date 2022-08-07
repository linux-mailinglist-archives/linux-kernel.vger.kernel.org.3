Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2F58B9A6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 07:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiHGFN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 01:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiHGFN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 01:13:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2F9EE02
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 22:13:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d16so5921545pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 22:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nx10j46QnLYkPlFtaKdKvgDL9d2RO3KLzzuzS0wS7hs=;
        b=Lln8/jiGIWm2glgrj+kqAk5b+G08qCLmzemx4iZ5Cz9Mz/T71DhvpBja4FaChLaxpQ
         wi859ElALHU9VziDiE3uCSf58x+HRaNhN2drL0ARxeJVaVFmymfl2agGAurv5JEOJD1R
         8Vyc407c03Lne+Aeg+w8h3ZzFVwIQ6vHWZiuNst47zhacac9n2CSpPTnbv2S7aIdtpbD
         ZA33+b5Kb2vo4KX2ii9hYqaoHnDe7Uf/RAscO7pP7Zjs9BHTByUWhDzDBCVeDjLeH452
         4b6Vw38XM3v5+w9TOXqqWFuezoeh6gcjs0uTLIVmFDZWU/lqXFbCFaA5RuVR9X3lRY2f
         AM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nx10j46QnLYkPlFtaKdKvgDL9d2RO3KLzzuzS0wS7hs=;
        b=Cwy9zPYzC0YjcmzRBtlaSJILMwAEUaxOxmfk1jrGL4CsIcd9Al1U+szlpVDXVTp5ov
         x9TWVmNUUI413cu5iWX+x8Lgo1Yl19DucnWbe7yxbFkyGIGxTlV9gx++Vs9TeAKhGNRC
         ioaxt2cnCiCNVUwDHdPWNQO2FpQtpRbLeIDWd44OV9y++3i8GEJg05V5tIWdoNt7xJ58
         krSfCANpPBNGXClifcFs1OelTdR93p1l4tXpo3Zf/dYRT6biARY93TLl37/tapQx03ij
         6szhLigGNkvBl3n24ZyHhHZHXa5LH9D8zAaJZcHiSUjhTy6qITRc/oBkBbMQrcBOUNIz
         mQOg==
X-Gm-Message-State: ACgBeo1TDiKKiAwZ+REWn38NevoDqSSJAPanoAS6awXeNpachPLt5Jyo
        6SJiyxEhm9Be8/EnxJtvaW1NMpvezNLlRKQPu4I=
X-Google-Smtp-Source: AA6agR4YKqg1DLXRVT4yXI+jovP7x71itGuab/MbP3kqmkyP6ikgFQNp5VSWtbEiCWJbcYO3zs6yjQ==
X-Received: by 2002:a17:902:f705:b0:16b:9b6d:67a1 with SMTP id h5-20020a170902f70500b0016b9b6d67a1mr13820431plo.39.1659849204593;
        Sat, 06 Aug 2022 22:13:24 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id c19-20020a621c13000000b0052ac5e304d0sm6020255pfc.179.2022.08.06.22.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 22:13:24 -0700 (PDT)
Date:   Sun, 7 Aug 2022 13:13:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 09/14] perf test: Add thread loop test tool
Message-ID: <20220807051319.GG34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-10-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-10-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:51PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add test tool to be driven by further test scripts. This is a simple C
> based loop with threads test to drive from scripts that can output TIDs
> for tracking/checking.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
