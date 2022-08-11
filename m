Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4258F665
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiHKDbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 23:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHKDbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 23:31:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8F1419AA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:31:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so3988556pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 20:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=nizGAqsGvNty3FjGN1FmrbrySk9zLGzFpUrnR3N2SRk=;
        b=dJ7uOaMmQBw5zAfFc1/imTdbTvwc9jKJSsyfxM+9arNUe4P0A6TcoZhQiCY/3Xr516
         Kre6lKgerkFwTGPHSRFO68+JUEn33RJOElXL0IaOuxoGjAf+4BXQlqIZnWlZGgJWD8ef
         c6DL1hbHN/PiVm4nxzXxPPa3feYvITwWAG99CcyRILSoAIEHlTzih96qWmmyYeCqd5S4
         tm9DTdRbhO9v4lwUIYaRecD9XgOc0j8nOogeT/cUV33Ry86SV6UdqO++kuXFpsP6xmzT
         QEWAkc7mDJFd+M2rr1abUvLJ3GtI5iogY0naB8103iXl8Zlme5hQEBFeaVsBgWyOXbzz
         6A/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nizGAqsGvNty3FjGN1FmrbrySk9zLGzFpUrnR3N2SRk=;
        b=IyN9njXAG8lFxLO1t8J2JV+hfE9vAgelnk/zJg2cA3Ax87JbISE+D0oTAdy7I7Fvh/
         KucxyLwwhoHSGGLykirvTLrOhkbEFdvylxTXMCm/lKu4vsYyv+QYQ6VRCDEYUpmh8Hhv
         /S2UcB7NXusPiH6MuXgkJE0vHKpwtPLvlliqu6A8hJbSPA++dEP8JjhRGX8x8qyk5oiI
         4sUiY33MGVEbYbS1rC/yKV7uPQ4KwK1Ogh+dHOok2HlxcFydcrAJzaA/dUhjO9cfMdPf
         Uor8rmhQY/o99CgSQ9b8mPFsjBNDtzZMfcCuO4sdodxFl8DiFBCGV1OL7fDYShOCb20s
         wp6Q==
X-Gm-Message-State: ACgBeo3Qq3n+BGebJPN74/8RKt/Y4pzih2GEUafuF2G2aAMdL8hIeOU+
        Xcou68V7HWh2GFoxxgJLHgo=
X-Google-Smtp-Source: AA6agR7R/N0OwsAvUkoa9TMbFz6/N7vEM+iwa14ijVMAkK8pfq2FillX84ubn/vg4F6cJN8OAKt+Aw==
X-Received: by 2002:a17:902:b20d:b0:16d:aefa:8ef6 with SMTP id t13-20020a170902b20d00b0016daefa8ef6mr31113052plr.90.1660188704446;
        Wed, 10 Aug 2022 20:31:44 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-79-20-36.ap-northeast-1.compute.amazonaws.com. [35.79.20.36])
        by smtp.gmail.com with ESMTPSA id y23-20020a170902b49700b0016bf9437766sm13645494plr.261.2022.08.10.20.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 20:31:43 -0700 (PDT)
Date:   Thu, 11 Aug 2022 03:31:38 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: release kobject if kobject_init_and_add failed
 in sysfs_slab_add
Message-ID: <YvR4GqAqykjUwBJn@ip-172-31-24-42.ap-northeast-1.compute.internal>
References: <20220811025258.68684-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811025258.68684-1-xhao@linux.alibaba.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:52:58AM +0800, Xin Hao wrote:
> In kobject_init_and_add() function, the refcount is setted by calling
> kobject_init() function, regardless of whether the return value is zero
> or not, therefore, we must call kobject_del(&s->kobj) to prevent memory

Hello and thanks!

Should kobject_del() be called when kobject_add() failed?

its comments says:

 597  * kobject_del() - Unlink kobject from hierarchy.
 598  * @kobj: object.
 599  *
 600  * This is the function that should be called to delete an object
 601  * successfully added via kobject_add().

AFAIK kobject_put() is proper function to call when
kobject_init_and_add() failed as stated in its comment:

 417 /**
 418  * kobject_init_and_add() - Initialize a kobject structure and add it to
 419  *                          the kobject hierarchy.
 420  * @kobj: pointer to the kobject to initialize
 421  * @ktype: pointer to the ktype for this kobject.
 422  * @parent: pointer to the parent of this kobject.
 423  * @fmt: the name of the kobject.
 424  *
 425  * This function combines the call to kobject_init() and kobject_add().
 426  *
 427  * If this function returns an error, kobject_put() must be called to
 428  * properly clean up the memory associated with the object.  This is the
 429  * same type of error handling after a call to kobject_add() and kobject
 430  * lifetime rules are the same here.

> of s->kobj is leaked.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/slub.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index b1281b8654bd..63b0a8a3a71f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5981,19 +5981,18 @@ static int sysfs_slab_add(struct kmem_cache *s)
>  
>  	err = sysfs_create_group(&s->kobj, &slab_attr_group);
>  	if (err)
> -		goto out_del_kobj;
> +		goto out;
>  
>  	if (!unmergeable) {
>  		/* Setup first alias */
>  		sysfs_slab_alias(s, s->name);
>  	}
> +	return err;
>  out:
>  	if (!unmergeable)
>  		kfree(name);
> -	return err;
> -out_del_kobj:
>  	kobject_del(&s->kobj);
> -	goto out;
> +	return err;
>  }
>  
>  void sysfs_slab_unlink(struct kmem_cache *s)
> -- 
> 2.31.0
