Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F3575166
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbiGNPGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGNPGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:06:20 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA1E62A4C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:06:19 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b9so2082727pfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j0LSdE+fCOqdRkGMsmtCcuEfKXl1MqEyCdK/8aiiq/8=;
        b=ICzAq/cvRjKkDHYKDFwX4rSKYPiRBAWLdocQ4gnWwMRaGL31Q3WgE7qqR97dNriVN0
         UImV1+I8wo/y47Ca98xjWXBdZVX0HNF5yU6NsnVeSdiKfRG8xqtRp79xcysNMBcwFOJM
         oVVfuIpawjxgSXKW3vqnNSqWlsdzMvMIQ5rnY9LJglRZXc8G3f9l4gBCkYJ3yzbTICZs
         QtnMZCR15A511u/cmJCJ5eRRxbeW4A/PBf6KJVuCKMQSEUHBvevBJG0bx+iNE/tWO935
         6kKubKZnzIPLR2IqhQZHGxNuQaHKQbBNyq+IeKbUcG0gtXgJElKi0PuazliKk0FRyoBp
         HPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j0LSdE+fCOqdRkGMsmtCcuEfKXl1MqEyCdK/8aiiq/8=;
        b=kF2BNuu4iYEk2MgjummWNCxn2tjemBev+5Nd382B8mBkLbOUkZdVZGF3YKqYXy7e48
         K0r8aeql4g5T9nMZLSvfvsIBzqZIA2Gg9COnObPG2OkhTeeUbtf37Pwxxuy9usEkpkt+
         FXxjR9gQaDdBb+s6eNJFgfRP5BUhvrqA29PbVx9x6xcif2ff+QdMeUYY4Wv3gQ6UtWZR
         WbmRr6YMpCoSrih/YjY2w3q9stY7wgV3ThzokBYhsvTEvOfEgK22TkqhDwiPkcAJU1ng
         Ob9usO7c0fc2NPGk0Fu5rF/wGzl+etsKh2u23CS+Q3JtYjjRONmsJhwHqnk+551//g04
         F3cA==
X-Gm-Message-State: AJIora/eXfQpFY47CUP8K7+njNRZppXos1TbwbIKNoIpvrdTEnBu1TjR
        SAATDocMLhNVq+DyT1dGi9U=
X-Google-Smtp-Source: AGRyM1t/OAY/Y7yVsM5mAXCJjJ9lZPQkb8VPf9zKdWGCxC4CTtSobb/vFxjbZMH7HQxewBrcQHHkbg==
X-Received: by 2002:a05:6a00:1a:b0:52a:dec1:308c with SMTP id h26-20020a056a00001a00b0052adec1308cmr9030811pfk.52.1657811178593;
        Thu, 14 Jul 2022 08:06:18 -0700 (PDT)
Received: from sebin-inspiron ([103.160.233.83])
        by smtp.gmail.com with ESMTPSA id f67-20020a62db46000000b00525161431f5sm1815704pfg.36.2022.07.14.08.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:06:17 -0700 (PDT)
Date:   Thu, 14 Jul 2022 20:36:09 +0530
From:   Sebin Sebastian <mailmesebin00@gmail.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/amdgpu: double free error and freeing
 uninitialized null pointer
Message-ID: <YtAw4dra+g1rcAXd@sebin-inspiron>
References: <20220710132911.399325-1-mailmesebin00@gmail.com>
 <21df71a6-44d4-48a6-17d2-d463174a10c7@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21df71a6-44d4-48a6-17d2-d463174a10c7@igalia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:14:27PM -0300, André Almeida wrote:
> Hi Sebin,
> 
> Às 10:29 de 10/07/22, Sebin Sebastian escreveu:
> > Fix two coverity warning's double free and and an uninitialized pointer
> > read. Both tmp and new are pointing at same address and both are freed
> > which leads to double free. Freeing tmp in the condition after new is
> > assigned with new address fixes the double free issue. new is not
> > initialized to null which also leads to a free on an uninitialized
> > pointer.
> > Coverity issue: 1518665 (uninitialized pointer read)
> > 		1518679 (double free)
> 
> What are those numbers?
>
These numbers are the issue ID's for the errors that are being reported
by the coverity static analyzer tool.

> > 
> > Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index f3b3c688e4e7..d82fe0e1b06b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1660,7 +1660,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> >  {
> >  	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> >  	char reg_offset[11];
> > -	uint32_t *new, *tmp = NULL;
> > +	uint32_t *new = NULL, *tmp = NULL;
> >  	int ret, i = 0, len = 0;
> >  
> >  	do {
> > @@ -1692,17 +1692,19 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> >  		goto error_free;
> >  	}
> 
> If the `if (!new) {` above this line is true, will be tmp freed?
> 
Yes, It doesn't seem to free tmp here. Should I free tmp immediately
after the do while loop and remove `kfree(tmp)` from the `if (ret)`
block? Thanks for pointing out the errors.

> >  	ret = down_write_killable(&adev->reset_domain->sem);
> > -	if (ret)
> > +	if (ret) {
> > +		kfree(tmp);
> >  		goto error_free;
> > +	}
> >  
> >  	swap(adev->reset_dump_reg_list, tmp);
> >  	swap(adev->reset_dump_reg_value, new);
> >  	adev->num_regs = i;
> >  	up_write(&adev->reset_domain->sem);
> > +	kfree(tmp);
> >  	ret = size;
> >  
> >  error_free:
> > -	kfree(tmp);
> >  	kfree(new);
> >  	return ret;
> >  }
