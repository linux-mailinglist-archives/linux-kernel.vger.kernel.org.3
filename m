Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658164D66F6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350497AbiCKRAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350488AbiCKRAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:00:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E677A692A4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:59:03 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 19so5466069wmy.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k+sAaPZ6B7SnVTAYchLFauNVj/7hDIru6DfQ96n92S4=;
        b=Ji4/o3rF1hjtnWTA9Rd2MUj5r5t9XJSUwTJ2lMRuXkrxIgPXuh9KN6PElwI6dBLeod
         zGcO5TxZqo8kIsVS8wN0x6qNHVcO11pPSFvbDvRZbauDLuvmZ3ND11IuGiPGHIifk/8s
         B2MkGMgef35/jl9O7tcrdYxz5hFQ1/udTsOlNT5NtVZTevyHQ1z3gHVZq55ycERUNEhZ
         hS3Eyj4p+V3CfQXLeBOYz5OHkUB6OGJL5bV1nTn7N4g3T6HfOaYzyYu7Iym3fFmtAESW
         EzT+QXvK+l/7O0my9ejaL9pYFM8TXUEUd7JvsrXrml4p0ThyRBFu8sdgRpvUxkQHNtzQ
         SdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k+sAaPZ6B7SnVTAYchLFauNVj/7hDIru6DfQ96n92S4=;
        b=pr6r3rj/1NXXZCWM+6TJwxlkBPf/79Q5WRP12IzRjvntldleABJq6EhxX315AKzNtf
         Er+sIDS32Np9Mbi4v/ADjtK6vn0jaKvVgKiWJf4Fq+62RDel8wYuReSx4kBK1N0aPR7s
         wr5KvL9MABTqF8i96FTVjHU8PDSjtl5PTpntZoNwGPJcpPUVes1xpYhZwsEdbsov79y+
         t+Qu/eSPht374PT/kWWEg3hRi03He+mWPZ3gMDC7HOPrDBw39wAwfyxuckDjC+2mFx9R
         g4KvEukY0Tti3weZJRybsfBGkjSCnbkkeNRcsRho+OYrikCI37Frg+gKb977r1+ds7ZN
         xnig==
X-Gm-Message-State: AOAM5321F79FtUYbt2begSs85uwsP5onzFCp2v/U5mRkIDBfqYSRytUj
        nOd4QxUmfleIQUc5zWmPo4mAlrBt6g==
X-Google-Smtp-Source: ABdhPJyVP6VGaQyGh30esA1uZYqyfmz014jsRc+0ay1k03iIbsMWl3+anVDMGkE9VeAAFxLkR2/JmQ==
X-Received: by 2002:a7b:ce02:0:b0:381:2007:f75c with SMTP id m2-20020a7bce02000000b003812007f75cmr16619260wmc.6.1647017942448;
        Fri, 11 Mar 2022 08:59:02 -0800 (PST)
Received: from localhost.localdomain ([46.53.250.95])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b00389d4bdb3d2sm9142281wml.36.2022.03.11.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:59:02 -0800 (PST)
Date:   Fri, 11 Mar 2022 19:59:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] x86/unwind/orc: delete dead write in __orc_find()
Message-ID: <Yit/1Ba5IIHl8eKt@localhost.localdomain>
References: <20220311144312.88466-1-adobriyan@gmail.com>
 <20220311144312.88466-5-adobriyan@gmail.com>
 <6257b01104da4891af46eec530df1dcb@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6257b01104da4891af46eec530df1dcb@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 03:13:02PM +0000, David Laight wrote:
> From: Alexey Dobriyan
> > Sent: 11 March 2022 14:43
> > 
> > Also move "mid" variable to the innermost scope and delete useless
> > parenthesis while I'm at it.
> 
> Hiding the definition of 'mid' in the inner scope is pointless.

Not, it is not.

> I'm also not 100% sure that 'found' is always set.

"found" is left as-is by the patch.

> Consider the ip < orc_ip(first) case.

> > --- a/arch/x86/kernel/unwind_orc.c
> > +++ b/arch/x86/kernel/unwind_orc.c
> > @@ -35,7 +35,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
> >  {
> >  	int *first = ip_table;
> >  	int *last = ip_table + num_entries - 1;
> > -	int *mid = first, *found = first;
> > +	int *found = first;
> > 
> >  	if (!num_entries)
> >  		return NULL;
> > @@ -47,7 +47,7 @@ static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
> >  	 * ignored when they conflict with a real entry.
> >  	 */
> >  	while (first <= last) {
> > -		mid = first + ((last - first) / 2);
> > +		int *mid = first + (last - first) / 2;
> > 
> >  		if (orc_ip(mid) <= ip) {
> >  			found = mid;
