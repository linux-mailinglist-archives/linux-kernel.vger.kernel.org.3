Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB72564C37
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 05:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiGDDxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 23:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiGDDxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 23:53:02 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5F632C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 20:53:01 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h19so8366244qtp.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 20:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ReHBI0i6XEGWXYdKi3FdtC2T+uu+55nJ5gKrr+JYE7U=;
        b=L5/DhAPhVYQpWXpZmYSTMLg3B8DN7q1zLmomaB2Bhwy9W1wH4ft6XYIkaaIGH/aPZ8
         CNj6SuVCv1FjCsNwIJbmTg+S3oFPKXTgNe+JZJiGrBJ0cNfcB2VIDLVJwpdI+9/eH9wE
         5ZLvQhdViz0o9pZXtyI6jHyOgx8CUj1+YWbeRGuT4Uwz303vOo2o3iWDGgBGQoPDWWoK
         I4ODqbWUjH1hop5i1eLMqF+MjIBoCm+vnrYjK8JRL3rVXcoLnVme3xvCoQOwlU9/9Esn
         iMyagxkpHkLlIR5UTu1kDvsRNbib28SiewmfJtPvFm6HYt+RkH1x4zOsL5oqU6i7T9oh
         0Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ReHBI0i6XEGWXYdKi3FdtC2T+uu+55nJ5gKrr+JYE7U=;
        b=PgylpTdoNCASN5DXT5c7XRZFn9J3CTAAm2d4mT9VadX2TLd1ZLd/XEs9E9zF+uFeJy
         twE3XodCjAnlc743+M2jOxHkAYgCPYEhARKjDpsWZZY3QqT86a/m9nIj1LIMOEFFLHrm
         CMC/JRXawmedzJ+EW/xGxxfwXgVTrMJwBCnBfasM9a+3akZx1hz8ANmWvCd8sfZx05bF
         xQwZsMwW8yRoDa4B7aWrUu4RCk0MeVE3F6d8PNPsvfGjwaJudumc5/aPXR8nz3L3yMGw
         eS5ouGeq4ad3/RnLRxLs+FqrrYyAf4+glvfTk8OsVWhbDM2p3go9PBJlkTiT251w2j37
         SyBA==
X-Gm-Message-State: AJIora807WUZ9hR6YABwjqb47uc9BlUOCSUIrXgSwjo/ib0mFSGZrq4D
        TW2NzpKlPhv8P83C5JYePg==
X-Google-Smtp-Source: AGRyM1voovHVUyj0oOK3ITyRsReLPseI/AshNcqSgSxu5ujJgMhcudDDJNvhpgfVa4MhJFJ9kQQQHg==
X-Received: by 2002:ad4:5bc2:0:b0:470:4c7d:db56 with SMTP id t2-20020ad45bc2000000b004704c7ddb56mr25877358qvt.90.1656906780622;
        Sun, 03 Jul 2022 20:53:00 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b006addb0af23asm21469536qki.78.2022.07.03.20.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 20:52:59 -0700 (PDT)
Date:   Sun, 3 Jul 2022 23:52:58 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Message-ID: <20220704035258.yu7k6sras2eiywsp@moria.home.lan>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <20220704014243.153050-1-kent.overstreet@gmail.com>
 <20220704014243.153050-3-kent.overstreet@gmail.com>
 <YsJO8gJeRwf96yTi@codewreck.org>
 <20220704030557.fm7xecylcq4z4zkr@moria.home.lan>
 <YsJgxoTyYxX1NwyW@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsJgxoTyYxX1NwyW@codewreck.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 12:38:46PM +0900, Dominique Martinet wrote:
> > @@ -270,10 +276,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
> >  	if (!req)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	if (p9_fcall_init(c, &req->tc, alloc_msize))
> > -		goto free_req;
> > -	if (p9_fcall_init(c, &req->rc, alloc_msize))
> > -		goto free;
> > +	p9_fcall_init(c, &req->tc, 0, alloc_msize);
> > +	p9_fcall_init(c, &req->rc, 1, alloc_msize);
> 
> 
> mempool allocation never fails, correct?
> 
> (don't think this needs a comment, just making sure here)

As long as GFP_WAIT is included, yes

> This all looks good to me, will queue it up in my -next branch after
> running some tests next weekend and hopefully submit when 5.20 opens
> with the code making smaller allocs more common.

Sounds good!
