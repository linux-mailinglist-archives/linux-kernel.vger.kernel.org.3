Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DF0501889
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiDNQLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347430AbiDNQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 224CD107A89
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649951556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZcHVGo/3hjepseUtr0ltzIAuc2afERmgABxI5vgqJI=;
        b=VkZw+2Phq3GAo7/Eigk6SWjrOw1/BhmS/9jhNM7s0aVHuA7pQ9YRJVEd9D9i/eTSnGEAWl
        LhnypHBgPMdAu/K7kDRRjHApEKtGA3RCcgayrLpYYBCoKyguNHUlqHiSWHWg/xwmfvjEhy
        qo0c2igfypF6ZJjsEi+Coey1isHkiSQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-_ol7CKOHPjSIgBfwqksx4g-1; Thu, 14 Apr 2022 11:52:35 -0400
X-MC-Unique: _ol7CKOHPjSIgBfwqksx4g-1
Received: by mail-qv1-f71.google.com with SMTP id fw9-20020a056214238900b0043522aa5b81so4652471qvb.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZcHVGo/3hjepseUtr0ltzIAuc2afERmgABxI5vgqJI=;
        b=lKXeoiQLIDi93DzBI+gz8rtmYin1sFJCacVsncNiUwvyhTzSWauYQBKGeuXQdRSjOB
         ozRjOaUb3jZjkQxl+yIaxXmFD1Ne7BKWEA8OGabsCVYD8DTP4nUNP/ZQks9Qn+0llFnY
         jf9iLS+fHrPl6h34bVzYyo8RnJs3FfAYUTGPr/tIWFt3WXVG87CXfnsPXUxImmFIAXlg
         7gxkZZ42SvJ9erhtA+OGZvClV0Mr06sQnUFdwLdQp5fU+6fUGSSmLfz7EW1d9EwhV/qb
         7rTs8Zi8yqTda2x3ycbY1u6dO9Vfua7o7mFAyf7vyJQaH2RBzLUs236OAJMfGITNvV46
         4eNg==
X-Gm-Message-State: AOAM533VPyNbWPzAq6XgdKBLFo5D+ibcD02pL/BA+I6wnySucRph6C4U
        ARAGMM3l9lIL0ylGkCssT7oWgeGK3xAZlzx7LPmS8xL3bl27kLhq01yyj15nFtUbVlQgypZoZnF
        jLVPk1mlcMPQ+k1XsRmV9ul+e
X-Received: by 2002:a0c:bf12:0:b0:42c:536d:52d7 with SMTP id m18-20020a0cbf12000000b0042c536d52d7mr3978183qvi.33.1649951554379;
        Thu, 14 Apr 2022 08:52:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPQU9d7rWq46oH3t+MTUBJ8n7cmnMZrE7faJd21N/NKLyR2APvYUIXKEyut9n2h/ALekaQ2g==
X-Received: by 2002:a0c:bf12:0:b0:42c:536d:52d7 with SMTP id m18-20020a0cbf12000000b0042c536d52d7mr3978166qvi.33.1649951554119;
        Thu, 14 Apr 2022 08:52:34 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id p66-20020a374245000000b0069c387c5449sm1194405qka.9.2022.04.14.08.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:52:33 -0700 (PDT)
Date:   Thu, 14 Apr 2022 08:52:31 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 09/18] objtool: Add stack validation cmdline option
Message-ID: <20220414155231.2kkpwl5oq2saef5t@treble>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <a13c502a91ae0bef8dfeb502d7dee88e73039355.1649891421.git.jpoimboe@redhat.com>
 <YlferZa7SP6hVgcA@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlferZa7SP6hVgcA@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:43:25AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 13, 2022 at 04:19:44PM -0700, Josh Poimboeuf wrote:
> > +	if (opts.stackval || opts.orc || opts.uaccess) {
> > +		ret = validate_functions(file);
> > +		if (ret < 0)
> > +			goto out;
> > +		warnings += ret;
> >  
> > +		ret = validate_unwind_hints(file, NULL);
> >  		if (ret < 0)
> >  			goto out;
> >  		warnings += ret;
> > +
> > +		if (!warnings) {
> > +			ret = validate_reachable_instructions(file);
> > +			if (ret < 0)
> > +				goto out;
> > +			warnings += ret;
> > +		}
> >  	}
> 
> Doesn't SLS also depend on validate_functions() ?

Doh, I had the intention of splitting that out from validate_branch()
like I did for ibt.

-- 
Josh

