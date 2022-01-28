Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788EE4A012F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbiA1T4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbiA1T4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:56:46 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A83FC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:56:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so7366584pjp.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qxYjpbNorHAO8wOm0edQ0bPBW87I7+SrXzhJE8v6af0=;
        b=LL3zfti731/Lxt4RBbrhZ7p2VTt3hFBMsFdtRe6RumFBlSbEKl3mGCrVtoHSvNqXgV
         ryGnqNynksnFNojCkxn5LkzwfLfodly7gcXpy3ZTWw3UW8fokWcay2efUM8kmhFqmV2q
         CnMdtUE+0PfB6kmjkizGq/YUFJsIqyKUi0Hoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qxYjpbNorHAO8wOm0edQ0bPBW87I7+SrXzhJE8v6af0=;
        b=0DHoco583KPzrTFHummNxc760aQ/lT+G9yr3B88ADlFjMgltDnFnfu9is/7/1T2GrK
         mE47vD8Gx73P+G93Zw2CmPHUsf3DuwYbJ3cYMJadfRLpVMqF7Rr2RvzyqL3WQ53Zp5cz
         mRBdBFaArmSwwjEwIr3qxRVukPcx7h1iYqkudqcE2HpgNk+cHGmaU2ga+KVeYtmjU06E
         OB3HcVF4yo7Aa+FLIggnbJ/w67pQN+/q9NEsMnjiTmcDd19+tZq+PFlg3mYoyHe98UxQ
         y08I8+8NYyCbfjdSu+qlEZzhrcDHXkhd0OLcAbY2StkcPjovOo+e+8MarkGqdzYK0Wkf
         zgXQ==
X-Gm-Message-State: AOAM530kihvW6A1PIhQpCvU9Beks3aj+LffPWg0Fcg0auoRi3sqLv4zc
        JK1BVt3C6DQ3DVgQll47eupM5Q==
X-Google-Smtp-Source: ABdhPJyrKlS/ACVpHgzb9f2n2haAr1ci1E4efkYZ6PK1+VMn1nTvSHFejxmwc29N9VWycHXUvR28Xg==
X-Received: by 2002:a17:90a:4811:: with SMTP id a17mr11474979pjh.159.1643399805700;
        Fri, 28 Jan 2022 11:56:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j15sm10626572pfj.102.2022.01.28.11.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 11:56:45 -0800 (PST)
Date:   Fri, 28 Jan 2022 11:56:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Akira Kawata <akirakawata1@gmail.com>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        lukas.bulwahn@gmail.com, kernel test robot <lkp@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] fs/binfmt_elf: Fix AT_PHDR for unusual ELF files
Message-ID: <202201281146.C8BC042C6@keescook>
References: <20211212232414.1402199-1-akirakawata1@gmail.com>
 <20211212232414.1402199-2-akirakawata1@gmail.com>
 <202201261955.F86F391@keescook>
 <20220127125643.cifk2ihnbnxo5wcl@gmail.com>
 <202201270816.5030A2A4B5@keescook>
 <20220128111034.jf3i4arhahfwwd6n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128111034.jf3i4arhahfwwd6n@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 08:10:34PM +0900, Akira Kawata wrote:
> On Thu, Jan 27, 2022 at 08:23:51AM -0800, Kees Cook wrote:
> > And now I'm thinking about the excellent ELF loading analysis at:
> > https://nathanotterness.com/2021/10/tiny_elf_modernized.html
> > 
> > ;)
> 
> I think you have interested in https://shinh.skr.jp/obf/bingolf.html
> also.

Ah, nice! The 104b one great. :)

-- 
Kees Cook
