Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169A748B8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiAKUsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244133AbiAKUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:48:28 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F83C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:48:28 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id g21so505771qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/CWoufOVy2cXdjaEmGa+laP4GrgKDj14h+owfIQdMZs=;
        b=T4p447Ky43yc0e6jqjZUTLxWwyMD+RifYTHXhQWthxwJdkkY3/heOrpcVKpDozJwfy
         0s6LnNiG9QSQWuKrkZHYrQCarAvlrnbL8KQi/Pob7jxRzbJbQakhOsYij1DlQ5+Tz5ZV
         CtZwXWLfGz9mMRXM/KGlBgHSASh8oQ7xX1MquqvW1+98zciLXskpDQhrer5wWNzpYor4
         ZRE6THCiZRtzs/eWgSiFpXANg44Cj/dJQjWLZQTQf/jTO5woLuqpyQ5bsBa1po8Oapql
         t/7rSvqwvaAn/nqO4BZip78+Upu2OOPZAzLIIMWfolpbEe2nj1vlHiIzHy9XVyXrcvNf
         +N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/CWoufOVy2cXdjaEmGa+laP4GrgKDj14h+owfIQdMZs=;
        b=sxSGAUaqSUpk4MJtuh9E49k34P1xuNwqo6xQCXIe1lhXNi49kD0XImRjGEtkZauWh6
         BTPPADxWJI92DINkoxDASI1YXPp8RWqNep8j3LrXKwR4Eb1uTUgkAWvwhF+g35ulVLZg
         LcsL5rXh4Dkcfg9vYIsL7I/IF+O9x33PGWbJUC9Scx+eq9Yc/ia6ZCF9ZGQ5i5jShBSF
         DTwZjcg3rRhXd8Ht3XVLqGTqhqZSTbvuWS2wR8pA5zMWpB8huIXK8mqgNIeJhIiU8jeR
         APsshDv7jr8veYJun7+Unul2mcPJeYoZUgiGpHSfCItcxYLmLUrgTst/IRejyRSwNYEP
         +sGw==
X-Gm-Message-State: AOAM533pM0UtQM36MA3Ab0y9UTnik1wDIZBIVzQuc+rM+8dToqNzFj0o
        Gu8aTbMgwlLba7NFjstbHHDoFKRseZGHhQ==
X-Google-Smtp-Source: ABdhPJzMRa844YMkoSJ5ymgGCoG9qKD53haefRWdKjKnzzPIHIlzH6vALyHzGbci6gn/HDSZys3VIw==
X-Received: by 2002:a05:622a:13c8:: with SMTP id p8mr2879249qtk.506.1641934107744;
        Tue, 11 Jan 2022 12:48:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id ay18sm2615665qkb.40.2022.01.11.12.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:48:27 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n7O4A-00EZLA-4l; Tue, 11 Jan 2022 16:48:26 -0400
Date:   Tue, 11 Jan 2022 16:48:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH rdma-next 08/10] RDMA/rxe: Implement flush execution
 in responder side
Message-ID: <20220111204826.GK6467@ziepe.ca>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-9-lizhijian@cn.fujitsu.com>
 <20220106002804.GS6467@ziepe.ca>
 <347eb51d-6b0c-75fb-e27f-6bf4969125fe@fujitsu.com>
 <20220106173346.GU6467@ziepe.ca>
 <daa77a81-a518-0ba1-650c-faaaef33c1ea@fujitsu.com>
 <20220110143419.GF6467@ziepe.ca>
 <56234596-cb7d-bdb2-fcfd-f1fe0f25c3e3@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56234596-cb7d-bdb2-fcfd-f1fe0f25c3e3@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 05:34:36AM +0000, lizhijian@fujitsu.com wrote:

> Yes, that's true. that's because only pmem has ability to persist data.
> So do you mean we don't need to prevent user to create/register a persistent
> access flag to a non-pmem MR? it would be a bit confusing if so.

Since these extensions seem to have a mode that is unrelated to
persistent memory, I'm not sure it makes sense to link the two things.

Jason
