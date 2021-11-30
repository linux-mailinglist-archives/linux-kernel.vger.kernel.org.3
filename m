Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DAA463CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbhK3Rlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:41:40 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:41965 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhK3Rlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:41:36 -0500
Received: by mail-oi1-f180.google.com with SMTP id u74so42714849oie.8;
        Tue, 30 Nov 2021 09:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IVskb/ISpBqZuEtdpCnNgJLJvCNne/nWtwhEnf4hzBQ=;
        b=OJVG+6wCVNJXhl19HKSUUND3LkqMdmkjruD1JmQcWRv9uMr/zr7VhGHLemu5aeQwWG
         Q3ZQrJW0oIdC3fLjRTCuMN5fuhwPGV3ePRXpxvlhh5h5JJL04ZhJfJ36cI2KFYzd8JJ2
         pxbiK9Qee3Yz4V9dnpmhr0OPFI1S8tnb2Ihvj6weovMm7+HNnmIp/HOyCfmraGCUf3f8
         eVljGXxRt3ni/Wr92EfNJyPCU0eGgTNVzIu91TOHYyrR0fjwDargDTk59qELCB39fQ5Z
         +4gH206ibdSElBkOt3i6xOJbLIFMohceFrRakmJp6QmPB7ZekjfomyszFwU6LjllElHX
         5oFg==
X-Gm-Message-State: AOAM532jxz/DYB4FlKLQfVDRf3Pndcg/rM5fQh5LzEeM9JQ4OU5xwgHk
        IL0zYy1hbrpgJPCeoBGWew==
X-Google-Smtp-Source: ABdhPJx5iNLS5t/74IBuyIZJqeX+F2q/SZvRGhTOtfzD31IeDiUb8q9xNANuVkbmrO5YvcQOtnX0Kg==
X-Received: by 2002:aca:1a05:: with SMTP id a5mr350709oia.146.1638293897229;
        Tue, 30 Nov 2021 09:38:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d3sm3215159otc.0.2021.11.30.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 09:38:16 -0800 (PST)
Received: (nullmailer pid 2706219 invoked by uid 1000);
        Tue, 30 Nov 2021 17:38:15 -0000
Date:   Tue, 30 Nov 2021 11:38:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of: base: Skip CPU nodes with "fail"/"fail-..." status
Message-ID: <YaZhhxB1RmXTPJpt@robh.at.kernel.org>
References: <20211122114536.2981-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122114536.2981-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 12:45:36 +0100, Matthias Schiffer wrote:
> Allow fully disabling CPU nodes using status = "fail".
> 
> This allows a bootloader to change the number of available CPUs (for
> example when a common DTS is used for SoC variants with different numbers
> of cores) without deleting the nodes altogether, which could require
> additional fixups to avoid dangling phandle references.
> 
> Unknown status values (everything that is not "okay"/"ok", "disabled" or
> "fail"/"fail-...") will continue to be interpreted like "disabled",
> meaning that the CPU can be enabled during boot.
> 
> References:
> - https://www.lkml.org/lkml/2020/8/26/1237
> - https://www.spinics.net/lists/devicetree-spec/msg01007.html
> - https://github.com/devicetree-org/dt-schema/pull/61
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: Treat unknown status values like "disabled", not like "fail"
> 
> 
>  drivers/of/base.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Applied, thanks!
