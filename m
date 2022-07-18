Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D18577CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiGRHpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiGRHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:45:29 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199286447
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:45:29 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h132so9843852pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qPG5f5XlsbAdv/pqkYarWJ8wMcfg6//ahYHY17VbN5U=;
        b=fKA2hRQVdeW/NA6c8c2q1ZV6wYKR6+JN3/s8yMF9je69q8wSovPOM9vfcvkcriciqM
         aTUf2PApOm1RBJ6rpX87hfeZE9iBcUeXWk6dM8/KHkiYwWQPGdced5Zni+mQCblN7/78
         Ybf18N9vo4PPjhQJm2fFlPi9NSuerX1EyZs5LTvB1fnsVDOxrZVw3aZ4BydWl5/cIolc
         SSvR3bRzCF/UpCSMFe9yphSUVuETw4ejoqCeyIvda/oxlxg8Yn+36clichzSMkrPkmoj
         rXjAL8Yl6oeEO3xv19An1HGWmpVG94qYZWH9XC4eh/q7VL9OuhfvRrdMILACwVVdDb0L
         Mybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qPG5f5XlsbAdv/pqkYarWJ8wMcfg6//ahYHY17VbN5U=;
        b=B5uGL/vrUcNetVgJMhEpjvcXltcl9qirVP9LKXd9XTNz95FWVx3b2x5W8nmRH9ULPc
         4dncG0UaLi1VkkLY2M1jflli0EB7t55TcQbhYzB3Jg/1EZJq3cLsnNEcxy/FY2cEIoOi
         3Ttz2kjwpR6IP9R5txvfiFWBDD6xhaJ+SBuu3e0JxigiOXb6Npek+pbnmi+kHM9qoyHn
         1bdxKwzUiDcLlnPCbDwno2glktpJI30GQwCjAutG6wRXIK82Bs9OFzfIGSCJ6nHT3rTT
         FS2Do8U6DbUfSEauTH+rBoxCusrRDdX4tvJtXn7D+Iqem1rZ1OOUXS1WTP0/LRCGSsfu
         t9XQ==
X-Gm-Message-State: AJIora+bShQK0ye7Vwq78XbOFhlzOEoDPShQ0rysoQUg5pdyzKuwaGrV
        cehO9UijiacB8x0CBeJ3K/KnntPyUH96QQPh
X-Google-Smtp-Source: AGRyM1sQprqWVlzlJ1WxL5CGdZG2fd3EVR6uSrUck2XLqKdokl+RzFwU24VXCtx9eUjRpgtPPT0Afg==
X-Received: by 2002:a05:6a00:1410:b0:528:5a5a:d846 with SMTP id l16-20020a056a00141000b005285a5ad846mr27369239pfu.9.1658130328453;
        Mon, 18 Jul 2022 00:45:28 -0700 (PDT)
Received: from sebin-inspiron ([103.165.167.46])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001677fa34a07sm8564103plq.43.2022.07.18.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 00:45:27 -0700 (PDT)
Date:   Mon, 18 Jul 2022 13:15:18 +0530
From:   Sebin Sebastian <mailmesebin00@gmail.com>
To:     "Somalapuram, Amaranath" <asomalap@amd.com>
Cc:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
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
Message-ID: <YtUPjqJyB/X+TnTi@sebin-inspiron>
References: <20220710132911.399325-1-mailmesebin00@gmail.com>
 <21df71a6-44d4-48a6-17d2-d463174a10c7@igalia.com>
 <YtAw4dra+g1rcAXd@sebin-inspiron>
 <1106b107-6373-9f89-5310-ea29db9fdf75@igalia.com>
 <5ad24101-8db7-06eb-f28d-5e0c455592ce@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ad24101-8db7-06eb-f28d-5e0c455592ce@amd.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 01:48:56PM +0530, Somalapuram, Amaranath wrote:
> 
> On 7/14/2022 9:13 PM, André Almeida wrote:
> > Às 12:06 de 14/07/22, Sebin Sebastian escreveu:
> > > On Tue, Jul 12, 2022 at 12:14:27PM -0300, André Almeida wrote:
> > > > Hi Sebin,
> > > > 
> > > > Às 10:29 de 10/07/22, Sebin Sebastian escreveu:
> > > > > Fix two coverity warning's double free and and an uninitialized pointer
> > > > > read. Both tmp and new are pointing at same address and both are freed
> > > > > which leads to double free. Freeing tmp in the condition after new is
> > > > > assigned with new address fixes the double free issue. new is not
> > > > > initialized to null which also leads to a free on an uninitialized
> > > > > pointer.
> > > > > Coverity issue: 1518665 (uninitialized pointer read)
> > > > > 		1518679 (double free)
> > > > What are those numbers?
> > > > 
> > > These numbers are the issue ID's for the errors that are being reported
> > > by the coverity static analyzer tool.
> > > 
> > I see, but I don't know which tool was used, so those seem like random
> > number to me. I would just remove this part of your commit message, but
> > if you want to keep it, you need to at least mention what's the tool.
> 
> new variable is not needed to initialize.
>
But if new is not initialized to null, won't it trigger a free on an
uninitialized pointer in the first if block inside the do while loop?

> The only condition double free happens is:
> 
> tmp = new;
>                 if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
>                         ret = -EINVAL;
>                         goto error_free; *//    if it hits this*
>                 }/
> /
> 
> and can be avoided like:
> 
>  error_free:
> -       kfree(tmp);
> +       if (tmp != new)
> +               kfree(tmp);
>         kfree(new);
>         return ret;
>  }
> 
> 
> Regards,
> 
> S.Amarnath
>
This seem's like the best way to avoid the double free. Thanks for the
suggestions.

> > > > > Signed-off-by: Sebin Sebastian<mailmesebin00@gmail.com>
> > > > > ---
> > > > >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 8 +++++---
> > > > >   1 file changed, 5 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > index f3b3c688e4e7..d82fe0e1b06b 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > > > @@ -1660,7 +1660,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> > > > >   {
> > > > >   	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> > > > >   	char reg_offset[11];
> > > > > -	uint32_t *new, *tmp = NULL;
> > > > > +	uint32_t *new = NULL, *tmp = NULL;
> > > > >   	int ret, i = 0, len = 0;
> > > > >   	do {
> > > > > @@ -1692,17 +1692,19 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> > > > >   		goto error_free;
> > > > >   	}
> > > > If the `if (!new) {` above this line is true, will be tmp freed?
> > > > 
> > > Yes, It doesn't seem to free tmp here. Should I free tmp immediately
> > > after the do while loop and remove `kfree(tmp)` from the `if (ret)`
> > > block? Thanks for pointing out the errors.
> > If you free immediately after the while loop, then you would risk a use
> > after free here:
> > 
> > 	swap(adev->reset_dump_reg_list, tmp);
> > 
> > So this isn't the solution either.
> > 
> > > > >   	ret = down_write_killable(&adev->reset_domain->sem);
> > > > > -	if (ret)
> > > > > +	if (ret) {
> > > > > +		kfree(tmp);
> > > > >   		goto error_free;
> > > > > +	}
> > > > >   	swap(adev->reset_dump_reg_list, tmp);
> > > > >   	swap(adev->reset_dump_reg_value, new);
> > > > >   	adev->num_regs = i;
> > > > >   	up_write(&adev->reset_domain->sem);
> > > > > +	kfree(tmp);
> > > > >   	ret = size;
> > > > >   error_free:
> > > > > -	kfree(tmp);
> > > > >   	kfree(new);
> > > > >   	return ret;
> > > > >   }
