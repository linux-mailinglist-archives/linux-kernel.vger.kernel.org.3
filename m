Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AA4495D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379740AbiAUJvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiAUJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:51:13 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09CDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:51:12 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id s12so9293234qkg.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=z1FINpzDsQPI0PUajwhqnDxhxA4dZ+cIwmmEukBNCPI=;
        b=EbyA23v4IdYcSSNOOEme3+yuAPNlAw/CEp+nfLDkBym5L8yhuZALXoNYQcDczAGKJi
         vo++fLaJl2YQNSC7G+KGpS4E+GymFjuJMg+c5tu6LR/xgF0vE7ZB3tfJ/eheu9Y38Bdr
         rJ6HHlPXxg0ZYZAQ4JFrPFnAndAHCFoXZq51boDgy6fFZ+8J0GuxingrkytYrbnzbRvD
         r9aHnbDn/wh4a/TF2PPNOJ8LHG5mfo1z0ejTTLG9kIga+BeQOM3/uCcmnQyi3lRflKYd
         PQuaYkUohknt6XJBUT7Tq47+unvLO4fPe+Ltbj4HfgXrkl8JXh17YvU+arw2va3E/4jk
         JArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=z1FINpzDsQPI0PUajwhqnDxhxA4dZ+cIwmmEukBNCPI=;
        b=C7hGSFVIxZspME9Gsi/66WJMLpGZJrHaM4q9jDcRjDzMgC1qu00S2ob5G4Una4P+j5
         /+hmTI1jtZuOBIL3urFcakhrFaCClrx1O2IUWV2qX/eQsXweNOKT75Hf3bv6DRvImMkK
         wlJoHO8K1LsJR2jtaHVIGqZplw1bLqzES93zHNYTMPMZiIE3+kScT8IifgNbmGAU43KZ
         5rcAOX+36/PeY5auvIslLkT3Xws/jRQ7ZZ6hw3P/jMDgcU5nah20nzxvWf9BE0zyIHP4
         vxKmPJUoUu6LhdCPCZCjaX+v73sK9kB8GlC/Sw7r7EGlJcxBJaLQ3ioOmiSPyw4+ZRg0
         3CGQ==
X-Gm-Message-State: AOAM533H/BOYWir1H6HQ+HWvcG36WE1/3hiTVnJQhdvnrB6PDksJTRVR
        JNbW59u5E1+2ssO+gPqq2uc=
X-Google-Smtp-Source: ABdhPJyQVVSGRAag0A6AHd3n5hs3zX1Hidbo65RISgZJEtvTDZgw1i554pbF4gnze89jc1Z1c4UNDA==
X-Received: by 2002:a05:620a:24c7:: with SMTP id m7mr2077240qkn.35.1642758672129;
        Fri, 21 Jan 2022 01:51:12 -0800 (PST)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y19sm2764090qtx.75.2022.01.21.01.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 01:51:11 -0800 (PST)
Message-ID: <61ea820f.1c69fb81.e79d5.09c9@mx.google.com>
X-Google-Original-Message-ID: <20220121095108.GA1002138@cgel.zte@gmail.com>
Date:   Fri, 21 Jan 2022 09:51:08 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] psi: Treat ksm swapping in copy as memstall
References: <20220116152150.859520-1-yang.yang29@zte.com.cn>
 <YeVdvVVBvrXH5U0L@cmpxchg.org>
 <61e7ac25.1c69fb81.e8938.bc67@mx.google.com>
 <YegK7+oKFG8EPRp9@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YegK7+oKFG8EPRp9@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Wed, Jan 19, 2022 at 07:58:23AM -0500, Johannes Weiner wrote:
> On Wed, Jan 19, 2022 at 06:13:54AM +0000, CGEL wrote:
> > I did a test, when we use zram, it takes longer time for ksm copying than
> > swap_readpage(). Ksm copying average takes 147263ns, swap_readpage()
> > average takes 55639ns. So I think this patch is reasonable.
> 
> Ok, that sounds reasonable to me as well. Please add the
> PageWorkingset() check and resubmit the patch. Thanks!
I am a litte confused about adding PageWorkingset(), since I
think ksm_might_need_to_copy() memstall is like swap_readpage()
memstall and swap_readpage() doesn't add PageWorkingset().

Would please make it cleaner? Thanks!
