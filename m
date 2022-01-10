Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4073D488EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 03:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiAJCnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 21:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbiAJCnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 21:43:18 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C84C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 18:43:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p14so10718875plf.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 18:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qyKCKCCmcuULoAA1E8bR7TAp/hXUDe7XCt+iKUscsLk=;
        b=d204BN7YeRalLSQLTofWmZ6ROqqMwa0ciqG++whwPpQZ8LnMOSnF622TXHwDxURXep
         RIrcvqT9AQU09Lfw5mMe2Ip4VaO5vINC+TVSz8L2XCTzjKrrm5Fzatae3eT+9hocFK3w
         MMkAu13bYACIkkU53ka3q6+el8HPWVkQIUm7IRExDGqM2QHr613LuUZTOneEw8j67LSB
         cK8vcN4suSP+xcV1jmqO56uKFvmYV4yvPXvM90fgxEzw660DbCuDMjZ8Ez2rWe9hGZvL
         TH5VHSl9lP8SNsRCrTbLYmymDTqXYLrLvJ4NKjHfhAXR/S4wRLMgrT8iNAxk+ndXg7AZ
         yShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qyKCKCCmcuULoAA1E8bR7TAp/hXUDe7XCt+iKUscsLk=;
        b=RT7vnCXsLMuuZZBJVF0vghmIdKtx+aH7A0xhV4IZuRQxD15Lw4oBMN6/M1iSJZ2kZs
         9KdkOfT3VHkqpZMx3Tea+CzOshuQx22da9sn7fa50lgJvFayHlZRWps1EJ2WFtOdAUEl
         ItFkNyX234dPIAlj56YWr6k/HYc4ryRTVhjN1v2EBiNqCpv5A9/AMqBkR8FiIw/s5bzY
         tMYFeUbwxLLEW3nGsH9jRZGIEaRt6Csv2txb8i/8RjF72BbWYjtxNHsbUbzzH4gY07Qf
         eFP0pjc0rpnnVkIeFkDwpRFeFKsVbFbYbRopLoH/TveXgsp6n+Gm0qXoKoB0hE0WxUrJ
         RBIQ==
X-Gm-Message-State: AOAM533WCH+JNpB5vt8MUvMpfI2LEXfQmMYykuwUP1d2+mmjZVQ3G/fu
        vpjx3yueKuPBJ17cS8LRjGE=
X-Google-Smtp-Source: ABdhPJzHvpcwy8jtSMlMuIpFbtSWWCI2itQfdxxE917XOCLsIRhv3vWHpnz1Tp+2gCkbVLApMuioeQ==
X-Received: by 2002:a17:902:9a8b:b0:149:be04:40ab with SMTP id w11-20020a1709029a8b00b00149be0440abmr32242215plp.159.1641782596662;
        Sun, 09 Jan 2022 18:43:16 -0800 (PST)
Received: from VICKYMQLIN-NB1.localdomain ([159.226.95.33])
        by smtp.gmail.com with ESMTPSA id o11sm4883817pfu.150.2022.01.09.18.43.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jan 2022 18:43:16 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:43:13 +0800
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Suman Anna <s-anna@ti.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Nagalla, Hari" <hnagalla@ti.com>
Subject: Re: [PATCH] iommu/omap: Fix missing put_device() call in
 omap_iommu_probe_device
Message-ID: <20220110022531.GA61@VICKYMQLIN-NB1.localdomain>
References: <20220107080428.10873-1-linmq006@gmail.com>
 <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman Anna,
On Fri, Jan 07, 2022 at 08:42:16AM -0600, Suman Anna wrote:
> Hi Miaoqian,
> 
> 
> > Add the corresponding 'put_device()' in the error handling paths.
> 
> Also, need it in the regular path, not just in error handling path.
I think after calling platform_get_drvdata() normally, the
reference will be released in other functions, so don't need it in the
regular path.
