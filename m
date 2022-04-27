Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8D5113BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359553AbiD0Iss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359545AbiD0Iso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:48:44 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F88D8D6A1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:45:33 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y3so647940qtn.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=RB8+FqJ1IEgAxvX3bqMX+LwZyBF33/dYNV+lewufcOs=;
        b=YiudLaujLbqxUmAQ5oA0hXxrRSlSYMybJoHK7kRC6iIpCYEK7XdRtfbGQ2uq5GYXi3
         ac4JZpTKvvpYLB8W+8iWO5quKkZhSu3u/4OkQIN8PxrjhtZJXbfg3oT0Vp5x+Cz64xzi
         lZFmazS4izkXhcG29TTT12ka2ErmX2c3ZOKog38Gn6UXcQnAhDyVeoRpl5C1ojTkH42/
         mFbNO2RuksUCNwQALhwtf/kag7KxMMajgT9frnMz/4MwhPVRXoB33ndBNGVT8bv9Gu3y
         zjINfNt7FemtkmYJdXysv82NTRN/XF/WT/6QOlv7kJ8KjuV8uvf42RlImhQ/gGyR1XS7
         JkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=RB8+FqJ1IEgAxvX3bqMX+LwZyBF33/dYNV+lewufcOs=;
        b=BWX7uXPY7EbK+n6IKAkWboamGG0afbeZOLDGQgj4Cmg4OBUlMSMZ4IkEftE3Ak50VE
         9GrOjoYXtu5spa9c3dk5VgOnB8g9umV/TJffLVwR6Kv+C6ugJ/o69nvvq1D6z/cRQS/U
         WCq1IKJM+oLBY9rD1ghxemSmKIuGzXxa4F83cKNNv0smWPGxCe184ESYWQBYFmVVRO9Y
         2mzr+Z+l9bUDMGSpjaQLgPC1owHpGlzTWpMR8ShHuj/M7T2NciBwSTedexu1nW3B6XRf
         sUZ+0tf8qO0c22PBAqvkQSUGbxBcseN5hPlYs4j1OtKmGdMt5Z+TQ/dE86QAKCiw9jtv
         ocaQ==
X-Gm-Message-State: AOAM5308zcmytuaJyQvpPug0tah76VMp39aAq0uR4rMs104ZCDyOT/7M
        s/iBhfBqA4rycMJBU2B5cCtAT/tO0VM=
X-Google-Smtp-Source: ABdhPJyocxPC0ZydQKbFq36fs4NYuBw9VXrJ5Oi4ajVGkBxamLejWLMn3aRuq6VJly/vNpkqn2nsgw==
X-Received: by 2002:a05:622a:284:b0:2f2:bf5f:4bd9 with SMTP id z4-20020a05622a028400b002f2bf5f4bd9mr18174425qtw.503.1651049132446;
        Wed, 27 Apr 2022 01:45:32 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p12-20020a05622a00cc00b002ebdd6ef303sm10061443qtw.43.2022.04.27.01.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 01:45:31 -0700 (PDT)
Message-ID: <626902ab.1c69fb81.44f01.9c06@mx.google.com>
X-Google-Original-Message-ID: <20220427084529.GA3844528@cgel.zte@gmail.com>
Date:   Wed, 27 Apr 2022 08:45:29 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     glider@google.com, akpm@linux-foundation.org, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] mm/kfence: fix a potential NULL pointer dereference
References: <20220427071100.3844081-1-xu.xin16@zte.com.cn>
 <CANpmjNM8hKG+HH+pBR4cDLcU-sUWFO6t4CF89bt5uess0Zm3dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM8hKG+HH+pBR4cDLcU-sUWFO6t4CF89bt5uess0Zm3dg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:33:52AM +0200, Marco Elver wrote:
> On Wed, 27 Apr 2022 at 09:11, <cgel.zte@gmail.com> wrote:
> >
> > From: xu xin <xu.xin16@zte.com.cn>
> >
> > In __kfence_free(), the returned 'meta' from addr_to_metadata()
> > might be NULL just as the implementation of addr_to_metadata()
> > shows.
> >
> > Let's add a check of the pointer 'meta' to avoid NULL pointer
> > dereference. The patch brings three changes:
> >
> > 1. Add checks in both kfence_free() and __kfence_free();
> > 2. kfence_free is not inline function any longer and new inline
> >    function '__try_free_kfence_meta' is introduced.
> 
> This is very bad for performance (see below).
> 
> > 3. The check of is_kfence_address() is not required for
> > __kfence_free() now because __kfence_free has done the check in
> > addr_to_metadata();
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> 
> Is this a static analysis robot? Please show a real stack trace with
> an actual NULL-deref.
> 
> Nack - please see:
> https://lore.kernel.org/all/CANpmjNO5-o1B9r2eYS_482RBVJSyPoHSnV2t+M8fJdFzBf6d2A@mail.gmail.com/
> 
Thanks for your reply. It's from static analysis indeed and no actual
NULL-deref event happened yet.

I'm just worried that what if address at the edge of __kfence_pool and
thus addr_to_metadata() returns NULL. Is is just a guess, I'm not sure.

But if __kfence_free make sure that the given address never is at the
edge of __kfence_pool, then the calculation and check in
addr_to_metadata()  is extra performance consumption:

	"index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2) - 1;
	 if (index < 0 || index >= CONFIG_KFENCE_NUM_OBJECTS)  240
	 	return NULL;"


> >Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> > ---
> >  include/linux/kfence.h | 10 ++--------
> >  mm/kfence/core.c       | 30 +++++++++++++++++++++++++++---
> >  2 files changed, 29 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> > index 726857a4b680..fbf6391ab53c 100644
> > --- a/include/linux/kfence.h
> > +++ b/include/linux/kfence.h
> > @@ -160,7 +160,7 @@ void *kfence_object_start(const void *addr);
> >   * __kfence_free() - release a KFENCE heap object to KFENCE pool
> >   * @addr: object to be freed
> >   *
> > - * Requires: is_kfence_address(addr)
> > + * Requires: is_kfence_address(addr), but now it's unnecessary
> 
> (As an aside, something can't be required and be unnecessary at the same time.)

Oh, I'm sorry for this. In my opinion, inner addr_to_metadata(),
is_kfence_address is executed for the second time, so not necessary here. 
