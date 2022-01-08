Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B86B488244
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiAHINo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiAHINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:13:43 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9C1C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 00:13:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id k15so30968262edk.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 00:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rDgQB2WQGWX9720sxuWCxT3SKKrWGiMNACS2WvpxMAU=;
        b=DeAR8/+8l5pwv1J2VGumrnx2FieUuu/jkq9FDwEmJ+dgjZfGB/fxA4vsfMtZq91UJ2
         GMxtfzeNc28rpvYQzaVfxfW4f252+KWi+9RPCxeYw6rmzNSS3jN80yH2eP/cqQtfDrtB
         B84dEH6N9xMiXD/jl/E6juupsvvhKl/fhtrJNRYERwV2Wf5KO9+WBYZx8ywol4cFBGiv
         kURSZ0d6SzdYarYE52tC/qU/7km2JWNeHpPqbNGLoU2A4CDLXWWNk0EyKFqwa4iHY8+b
         KTByxR15/S3aIE/vJsZU1tGNab44bTR20eJbquGBCGGkyclyov7nLjoGWIOBUAehmM/a
         nskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rDgQB2WQGWX9720sxuWCxT3SKKrWGiMNACS2WvpxMAU=;
        b=eKbjt7Lk7jfJJ6rHk9IhPCtrJbUelmYmVhU62M66pJ/X77xXCu/bem2lgPXxHY6r3s
         uqLQeEb94SBh3Bevodc4q943kCbo0G1kQRa9rdvrVMVyuC1i7zqs/zKZc1279hsW+tuX
         M5tPTvrlXMT1k2f5SgryiUW816ptFLQa4ybSsw4vdaVZ6V2YjW3rX4V+/1quovLuftgx
         j2AnM1orrp7YREg8BDFcO4apxiN4bB9FxHKWrR/dOIuNxnaqESXBt33dwABjIj7t5Jg+
         8coWlQW8/zzIyCc8Ijo4elbzQLHXXbr/gt0bNz+jpP1BfURXxSFhFmFwZn/+H4HWwkL2
         OafA==
X-Gm-Message-State: AOAM533BtxaTxgeN2ZLfmZDXLcnUbbi/ZrR5T0DVDArB5bfBRutYJ1iv
        Sh5sX6Ck9oB2modbi2Sz9N0=
X-Google-Smtp-Source: ABdhPJynWWoXXXQdPA4JeYcho7Gw4NaOApAXcfV+jQY4TT6fvwSe4FLshQZMR1rTuusyduUZpFK6IA==
X-Received: by 2002:aa7:d547:: with SMTP id u7mr64870494edr.76.1641629621722;
        Sat, 08 Jan 2022 00:13:41 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 21sm305935ejz.24.2022.01.08.00.13.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Jan 2022 00:13:41 -0800 (PST)
Date:   Sat, 8 Jan 2022 08:13:40 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>, peterz@infradead.org,
        vbabka@suse.cz, will@kernel.org, linyunsheng@huawei.com,
        aarcange@redhat.com, feng.tang@intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove offset check on page->compound_head and
 folio->lru
Message-ID: <20220108081340.3oi2z2rm3cbqozzt@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220106235254.19190-1-richard.weiyang@gmail.com>
 <Yde6hZ41agqa2zs3@casper.infradead.org>
 <20220107134059.flxr2hcd6ilb6vt7@master>
 <Ydi6iMbSZ/FewYPT@casper.infradead.org>
 <20220107160825.13c71fdd871d7d5611d116b9@linux-foundation.org>
 <YdjfsbAR0UlwyC6b@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdjfsbAR0UlwyC6b@casper.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 12:49:53AM +0000, Matthew Wilcox wrote:
>On Fri, Jan 07, 2022 at 04:08:25PM -0800, Andrew Morton wrote:
>> On Fri, 7 Jan 2022 22:11:20 +0000 Matthew Wilcox <willy@infradead.org> wrote:
>> 
>> > > Hi, Matthew
>> > > 
>> > > Would you mind sharing some insight on this check?
>> > 
>> > It's right there in the comments.
>> 
>> Well I can't figure out which comment you're referring to?
>
>         * WARNING: bit 0 of the first word is used for PageTail(). That
>         * means the other users of this union MUST NOT use the bit to
>         * avoid collision and false-positive PageTail().
>

I know this requirement on bit 0 of first word. But I don't see the connection
between this and the check of page->compound_head and folio->lru.

This is more like a internal requirement on struct page. There are 8 struct in
this five words union. And this requirement apply to bit 0 of first word of
all those five struct.

To me, if folio has the same layout of page, folio meets this requirement. I
still not catch the point why we need this check here.

-- 
Wei Yang
Help you, Help me
