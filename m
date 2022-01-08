Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED19487FEC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiAHA1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiAHA1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:27:06 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E623C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 16:27:05 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a18so27146031edj.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 16:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g8lNqsy8ublAWRVRctguE7C3OHje+gvxxLG1/8WrReA=;
        b=V/opRMDfmGZ3UR/I/nH/iLnIY5DJ8Mn3Xv17uOGmjjT8WKd3BSaikbXNYSg338NVhl
         NTUqX6cK5E/yWq/tBS7FMhBVihg1TGb0j9APG+oBPButxzIMtfjArcIPrZEXic427LA3
         rp+seYx5/uQ1GC9KSB2aWZClxItaJLSofKP8idoHyfHR5xPBMhmwTlMJL92x8ZU6RVSB
         luuM4CDE0Pq9buq0yzQgb29sSrc0I78uc52Oi4Ta0m8bSM/wRH9Uf87bPhIqrRbOzI4B
         KA2t4UbCWmUAe4JyQ5SyNagOLQYj/HaZsh+qYs7AJMU9wmht8+89BIChQvhbDFoXLSMZ
         Tsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=g8lNqsy8ublAWRVRctguE7C3OHje+gvxxLG1/8WrReA=;
        b=wn/QztTMqSG3Ed9aTQytQd7HSchk+fUK9EKm3iUnbM1aAvRK6KaJnQTbXiYOqwDNR6
         2cw3/Xvvcf7AR1yBtoO7D68Kma1a8PgCS5RM/1Oec1yUJV1yJxbo/h+mY3BdgwgmUA00
         hqFuuZL3fXyBGEKyLxTc/Xi/1rJD9pRfr0bDWKNnNK4rAg/Mi0EFW9KudXPydFnPOf5O
         VQoxuYFGffSm9i8s8DnPlvpmk+0MWGrO456eWKkHd8mHZBAGRHIhNejvZnF0vhB3bv+6
         XpvSbLJpgTLIZaWc3d5hZjj9LBMjVxaC8e7hCWwZNZr0ClCdDVLMeQvsML/phgm5mwsL
         V+Ag==
X-Gm-Message-State: AOAM532R/sCUEGNdEDWfzpFW9SzbbvqRg+vg887H+FATZPXWmbpM6PWa
        IXsiL4XFPHawADUb3W1VAkc=
X-Google-Smtp-Source: ABdhPJwdXd2tObaML1fQkThy7z0XKxId3MxwaR9ZmDKJbguM1W137xs79x7rAIIZcBoHa6/rrHVB5A==
X-Received: by 2002:a17:907:a42c:: with SMTP id sg44mr50430311ejc.166.1641601624217;
        Fri, 07 Jan 2022 16:27:04 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id dn10sm45070ejc.139.2022.01.07.16.27.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jan 2022 16:27:03 -0800 (PST)
Date:   Sat, 8 Jan 2022 00:27:03 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, peterz@infradead.org,
        akpm@linux-foundation.org, vbabka@suse.cz, will@kernel.org,
        linyunsheng@huawei.com, aarcange@redhat.com, feng.tang@intel.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-ID: <20220108002703.o44i55ncxuagv4wk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
 <Yde6hZ41agqa2zs3@casper.infradead.org>
 <20220107134059.flxr2hcd6ilb6vt7@master>
 <Ydi6iMbSZ/FewYPT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydi6iMbSZ/FewYPT@casper.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:11:20PM +0000, Matthew Wilcox wrote:
>> Hi, Matthew
>> 
>> Would you mind sharing some insight on this check?
>
>It's right there in the comments.  If you can't be bothered to read,
>why should I write?

I am not sure which comments it refers to.

Maybe we can add a "Refer to comment" above this code?

-- 
Wei Yang
Help you, Help me
