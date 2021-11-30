Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C6E463C3E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbhK3QxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244431AbhK3Qwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:52:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF4DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:49:34 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b1so55220224lfs.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y+9tzdDCGsDUUrL8c3qTMvpYPvBp/D8362sjA+sSoxc=;
        b=b1YdeDgvuEBYxuKI5iRpU0uIL2G7IvIn23HtKfuf4Hu2s4ACAcbx21l/1IBuBD5haG
         0c0nAuUIz27f9DBsXonJIoP2UimM6JXNlwFSyq18HBoZx1ab/eajk7U7rSzZsf2GDW5l
         tFkNESpU7qRULDVUmZO6JfaomBw58IzyWkPiNi61lPpkM10mU5ULje4MEkEutwWoFb/q
         ZdX/q1tAcuQtyp3H8SFBVto0UMUV66NV455soQ/BRjS2KhShnygJtxBYTiEwW6HehZj6
         yqVs/DZwFONqhZaVUW8BP11WNYL/DBVKoEBnlqB6olE/zTlzHMq93mzQujRbzrETif7K
         gxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y+9tzdDCGsDUUrL8c3qTMvpYPvBp/D8362sjA+sSoxc=;
        b=kLOMoCbYJaQzv0dKJn2lgEcAmA8f9WkSqxeUBqIfGyOakUtyqiURQ0s+9LAwvC1Zb7
         Wfx5adJc0VgaChwoNA/Ts/ZYTAlkOsjKgv2W7KfAeROOibvkELV/NrgrASB8xIYKjYdj
         s8akG/w7o/HQkcQ0Db5RJc9MSSuitnciUcMLSsDgpoeO+/PQAFjvuo/JZbSMPGXosnYs
         YrZy9XiEUjgbIEWKCbktG7LQ2VIakI5kaCsjaPiG+tEUc3U36nXBpkJsRNgFHtai19Bn
         jKlTbyE2/7YUE8SMz7tqkG0K3iSzeGfyfa3Ev8DPQkAMK9+q0EJS+rqJuwdoFoCGw1U/
         X0Ug==
X-Gm-Message-State: AOAM532BK1yDtmEVCxzq6bwckKAbMgaiSZ3PHZZIuV1rfakWTtTxehZk
        YZMw/Pfz66MvIOpTTXLPtFNtHA==
X-Google-Smtp-Source: ABdhPJwW9pz1BIYwEbsOEzh9cfE3squ8ovlpDNkHfSy6oLtimjIT/JCgbbdRu/Nn+7KfqkAj2sjejA==
X-Received: by 2002:a05:6512:3217:: with SMTP id d23mr367957lfe.572.1638290972757;
        Tue, 30 Nov 2021 08:49:32 -0800 (PST)
Received: from localhost (h-46-59-88-219.A463.priv.bahnhof.se. [46.59.88.219])
        by smtp.gmail.com with ESMTPSA id q1sm1771260lfh.234.2021.11.30.08.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:49:32 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:49:31 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/9] arm64: dts: renesas: Thermal binding validation
Message-ID: <YaZWG6+ty4UCeQu8@oden.dyn.berto.se>
References: <20211104224033.3997504-1-kieran.bingham+renesas@ideasonboard.com>
 <CAMuHMdXVBj58ZM3LqCN3cudsE3VJV8AQC5OCOJP96RaqYf4NDQ@mail.gmail.com>
 <YYo0syH9m/CYlB2d@oden.dyn.berto.se>
 <YYo62jdzSTxqCMtk@oden.dyn.berto.se>
 <CAMuHMdUNZ+TOGU-H9dZu08WKO2fO2sbgL1BbN3JzEVBkOyMhdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUNZ+TOGU-H9dZu08WKO2fO2sbgL1BbN3JzEVBkOyMhdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 2021-11-30 17:45:11 +0100, Geert Uytterhoeven wrote:
> Given Rob said he applied your patch[1], does that mean this series
> is good to be applied?
> Thanks!
> 
> [1] https://lore.kernel.org/all/YaU4XuiaJgEjGCdQ@robh.at.kernel.org/

Yes, with that patch applied this change won't generate any (new)
warnings from DT :-)

-- 
Kind Regards,
Niklas Söderlund
