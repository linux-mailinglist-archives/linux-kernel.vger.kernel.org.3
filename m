Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1A484C13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 02:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiAEBWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 20:22:36 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42959 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiAEBWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 20:22:35 -0500
Received: by mail-oi1-f175.google.com with SMTP id w80so23660824oie.9;
        Tue, 04 Jan 2022 17:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FgDoCEUq/SN5KGkNrcQtXFkwJwsIpetMQ1yOjOAUPyo=;
        b=slumdkhO0H0dgUJAcul7NxHxl7pFoRuXE/PAs9WaxV8cR/h9ERoeb4KFnGhXvv4DoN
         HK/xa6QI/+cRj7KIhlHHLDItOPtxaVfpIyZVDYSctmv4a5rbr89dilDTl+MErKZI4dmH
         mHQEN7uR1gDOpiH5fwnw3jZacYqkx0tKwKTLZ6zL5kCE6v72dGo+cEpcJwGGKAI1uVHJ
         serd5eDekw8LioZMasZR7ffI6ctZ4Y4iuCsN7tU32GjQYrTaC0IGMfI9XGoxAQ5Ht11G
         ZyxBNRbLMjm1I3c45+jpm6OsLgZmFnzCGfmBhzYWQZxJArHQOLlmqznRkSiytG9ZgEJe
         /lNw==
X-Gm-Message-State: AOAM53199MnzxLYa4E87whZL9Xb3h71p5vrqbwMdTVrP4MBXDAMUE4wF
        UF+1k1xsu/CpXJI0aaQwHQ==
X-Google-Smtp-Source: ABdhPJyTu3qXBUR4II4VY8pFe0N93+AXUWHbNRYcXb+nYSShA9S2itmxAKW0Dvd+Fm3Q8e+UR7+atg==
X-Received: by 2002:aca:a953:: with SMTP id s80mr793106oie.164.1641345755097;
        Tue, 04 Jan 2022 17:22:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c29sm8378282otd.14.2022.01.04.17.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 17:22:34 -0800 (PST)
Received: (nullmailer pid 1842977 invoked by uid 1000);
        Wed, 05 Jan 2022 01:22:33 -0000
Date:   Tue, 4 Jan 2022 19:22:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     linux-kernel@vger.kernel.org, erhard_f@mailbox.org,
        Rob Herring <robh+dt@kernel.org>, yinxiujiang@kylinos.cn,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] of: unittest: re-implement overlay tracking
Message-ID: <YdTy2TmEzR+eLHVx@robh.at.kernel.org>
References: <20220101033329.1277779-1-frowand.list@gmail.com>
 <20220101033329.1277779-3-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220101033329.1277779-3-frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 21:33:29 -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Some overlays are tracked when they are applied.  The tracked overlays
> are later removed after the overlay tests are completed.  The old
> implementation makes assumptions about the expected values for
> overlay changeset id created by the overlay apply which result
> in fragile code.  The new code removes the assumptions.
> 
> A symptom that exposes a problem with the tracking code is a
> warning "UBSAN: shift-out-of-bounds in drivers/of/unittest.c:1933:36",
> Kernel Version: 5.15-rc7, PPC-64, Talos II.  This results from variable
> "id" value of -1 in the final line of of_unittest_untrack_overlay().
> 
> Reported-by: erhard_f@mailbox.org
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/unittest.c | 110 +++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 61 deletions(-)
> 

Applied, thanks!
