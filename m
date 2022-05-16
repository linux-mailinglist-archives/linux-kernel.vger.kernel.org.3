Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347F2528E01
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbiEPTfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiEPTfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:35:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926153EB8E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:35:10 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ev18so4759448pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L7HskJWRuMiU99+hkHXykGvfHtSWUlmm80hgvb21NIA=;
        b=gJrVJGg9f8wooWOkKB64seNV3Y9DZXpcdjoXjuuPOxiXlcP66WigXuu+Amy9BJUtn3
         u3HIuSQ3Vj7xMV3RjDAAp9HbBGxztYKpqVq1zxv8ClC5y3HQj0KT172tBAjS7GdbFELT
         yrt6iQxwGu49aljDYpDwbqHc5KCh9Ncmv1wbECFIGmCXHLRNvhWI4rbCeLkBLbfDIsGI
         VIr+rdcZn/lP13UJSV7X1aOdA/55R5a+xJP1EK7t/pmevOLtcMui/qXpmKuvkrfZKmnW
         gWfJXYJG4AhssF4f4ESfctbEvscFLqg+V+t56mdNMogk454u6SS5Fonr+BWU0aivVmYA
         OIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=L7HskJWRuMiU99+hkHXykGvfHtSWUlmm80hgvb21NIA=;
        b=fS7b6ulRKQft9P02vfKohL7ofmOvaiVjNRz5XG8H9ssAZ7O7VR3G1Pgo8SdVzIRh5g
         4y4jP8lVwR1hlLMy8rh2ud6P1lyiQVGpFe9sNtqVpqYJ5CS/pTRpA97rBlwMImFtmh3r
         UagCYI6MH6CsmKz7rqgtB1Bpp2anGqWC0Z1VwR7KpjrMyp8EI71OIO6S+MtBwGHf96AO
         GQnAwh1Eb4H2TwZQ2YXONWBiqkyNBX7kRi8BVRQoYQqnSyv53ipRSiWLZK6rfuDzyBNl
         lL433eOwTyFzrMDNdSa9wi1CX1H8VXlrKYznUFivyRH1k11aIyICv9TCMfFMmVWtCv5T
         e25A==
X-Gm-Message-State: AOAM533DNzjY1TXIvWYz1boqNrDm2K1TEkcEM8X3VizwkoLPZCG9Zqut
        zHfkNXE/mK0rLjaXzzL/Z5g=
X-Google-Smtp-Source: ABdhPJy3GngRJ0n4QNJAd+T8tx3PdZjnc7aplXGOLXY5LunKkZNBOK7Bd1JY8RjBWpSSa6k0JJeiog==
X-Received: by 2002:a17:90b:3ecd:b0:1dc:945e:41b1 with SMTP id rm13-20020a17090b3ecd00b001dc945e41b1mr21009292pjb.208.1652729709941;
        Mon, 16 May 2022 12:35:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id p23-20020a62ab17000000b0050dc76281d6sm7427269pff.176.2022.05.16.12.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 12:35:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 16 May 2022 09:35:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] kernfs: make ->attr.open RCU protected.
Message-ID: <YoKna/Ty+k9O+pjt@slm.duckdns.org>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-3-imran.f.khan@oracle.com>
 <YnQtL7+GYHwpo4n2@slm.duckdns.org>
 <f5ff2554-580c-c817-b77f-25e2ef46411f@oracle.com>
 <Yn0/RrgMRie2YPEb@slm.duckdns.org>
 <526b46a7-7daa-9050-1276-e19836816991@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <526b46a7-7daa-9050-1276-e19836816991@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, May 16, 2022 at 02:00:50AM +1000, Imran Khan wrote:
> +/*
> + * Deref RCU protected kn->attr.open.
> + * If both @of->list and @kn->attr.open->files are non empty, we can safely
> + * assume that @of is on @kn->attr.open and hence @kn->attr.open will not
> + * vanish and derefeencing is safe here.
> + */

Maybe use proper function comment starting with /**?

> +static struct kernfs_open_node *
> +kernfs_deref_on_check(struct kernfs_open_file *of, struct kernfs_node *kn)
> +{
> +       struct kernfs_open_node *on;
> +
> +       on = rcu_dereference_check(kn->attr.open, !list_empty(&of->list));
> +
> +       if (on && list_empty(&on->files))
> +               return NULL;
> +       else
> +               return on;
> +}

Why does it need to return NULL on empty on->files? We wanna trigger lockdep
warning cuz that's a bug but it's not like the caller can recover from it
(short of causing unexpected user visible error), so I don't see what the
point is.

> If this looks okay then I can replace usage of kernfs_deref_on_raw with
> kernfs_deref_on_check.

So, this is the main deref function without holding the mutex, right? Then
name it kernfs_deref_open_node() (or on but it seem a bit confusing to me).

> > and in the check condition, add the conditions that you need to make this
> > not trigger warning when used in all the places that you wanna use it.
> > 
> 
> Since ->attr.open is always accessed/modified under kernfs_open_file_mutex, I
> have included this check in helper which should be used only while holding this
> mutex. Do you mean that I should include some additional checks as well in the
> below helper:

Yeah, you're right. _protected makes sense for this one.

Thanks.

-- 
tejun
