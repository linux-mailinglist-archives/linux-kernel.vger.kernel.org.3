Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D056768A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiGESdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGESdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:33:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C821D0D0;
        Tue,  5 Jul 2022 11:33:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so8943947pjf.2;
        Tue, 05 Jul 2022 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2LGq1pXebat0furaJTv8eGKw+ZX3/YmHNfBp9GTd/AE=;
        b=Q1c6RsV5v7yMJC+JQ1l74sdVkBRxQNVUcLpu96nk0hftMhMabGGmU+69seiltM7hX0
         l9HKG3Zc6mfwCR0hUCTgQxjyTtcRXnzLnYmVpHy6L7GWO+wmOCNOwFCdVTLmc7jwSr1T
         8muK4x7KKh+E75SsgwGQiCHfrLqECBxJRDqx6W1dZ1VfinHBoDd1iRjZI9Pmom+I9ZW3
         3Sxfbx03GnLYHZHQBkR+nA00AjAfl2q9/NErmEMguZB0W2/MlRSCms/k2cvSK5wHS8AH
         QS9wX/PRWFDglXJYL3tpNrCW8IL/AbTtBADWEjhgQM6KPWu7AY+QAg+HLkL90lzSO6C7
         IkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2LGq1pXebat0furaJTv8eGKw+ZX3/YmHNfBp9GTd/AE=;
        b=psGQEG+4GAAMdSfQF+NapSMZFit7yoiyvCd9GN7Wlz+xAasYkKv+fxBiZIUgS0y3ta
         sMrJeQmy11uOcsE0tzVM6MENVM+S/rm2qENv9PCM1pHFPvpZD4RFqsY6ol5QlV7oe+tX
         m5CzlOZ5BsEvBPabCqzXFgSxMW5Q02bGBg/eUfu8epOLaoHClByEBj48cbZWUP37aWyG
         I2VS0nLKm+yAXS/mHmGY8PyFHGberAXbbwLC30SaKWDEcZOa6UrNcwPvg08B6eP78aMI
         UnV+uYxTLU+qYRxyXf5RSCNzTkSg7wFNvldSPrURtppdNDNLFtwI9SC4TzdDy/k78S0Z
         /5lQ==
X-Gm-Message-State: AJIora9mW1oJ6fCqoAMTh7F7l8w5QckMCGjuUEIpi623gOCBtCOxGAi5
        5vswGZfytVPKk5i/WJAt0WI=
X-Google-Smtp-Source: AGRyM1u9pBKcpOZ+bYQbG2CgQIyJQiMYSDBa09l+hG8UM78rf0LQdSYEcckXw1SyTWVN051PFrkYMg==
X-Received: by 2002:a17:902:c950:b0:16a:6b0c:a2e with SMTP id i16-20020a170902c95000b0016a6b0c0a2emr42268116pla.36.1657045988703;
        Tue, 05 Jul 2022 11:33:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a568])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b0016bc947c5b7sm8074842plg.38.2022.07.05.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 11:33:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 5 Jul 2022 08:33:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        m.szyprowski@samsung.com, nathan@kernel.org, michael@walle.cc,
        robh@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com,
        pmladek@suse.com
Subject: Re: [RESEND PATCH] kernfs: Avoid re-adding kernfs_node into
 kernfs_notify_list.
Message-ID: <YsSD4k0o6PPYpMBe@slm.duckdns.org>
References: <20220701154604.2211008-1-imran.f.khan@oracle.com>
 <Yr9U1q0BBinCgyrT@mtj.duckdns.org>
 <deaaabe5-0a0c-b6f9-c85b-5080874f6437@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deaaabe5-0a0c-b6f9-c85b-5080874f6437@oracle.com>
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

On Sun, Jul 03, 2022 at 09:09:05PM +1000, Imran Khan wrote:
> Can we use kernfs_notify_lock like below snippet to serialize producers
> (kernfs_notify):
> 
> spin_lock_irqsave(&kernfs_notify_lock, flags);
> if (kn->attr.notify_next.next != NULL) {
> 	kernfs_get(kn);
> 	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
> 	schedule_work(&kernfs_notify_work);
> }
> spin_unlock_irqsave(&kernfs_notify_lock, flags);

But then what's the point of using llist?

> As per following comments at the beginning of llist.h
> 
>  * Cases where locking is not needed:
>  * If there are multiple producers and multiple consumers, llist_add can be
>  * used in producers and llist_del_all can be used in consumers simultaneously
>  * without locking. Also a single consumer can use llist_del_first while
>  * multiple producers simultaneously use llist_add, without any locking.
> 
> Multiple producers and single consumer can work in parallel but as in our case
> addition is dependent on kn->attr.notify_next.next != NULL, we may keep the
> checking and list addition under kernfs_notify_lock and for consumer just lock
> free->next = NULL under kernfs_notify_lock.

It supports multiple producers in the sense that multiple producers can try
to add their own llist_nodes concurrently. It doesn't support multiple
producers trying to add the same llist_node whether that depends on NULL
check or not.

> Having said this, I am okay with reverting the llist change as well, because
> anyways it is not helping in the contentions that we are chasing here, but I
> thought of sharing the above idea to see if it is reliable and better than
> revert option.

The original conversion is broken and the right thing to do, for now, is
reverting it.

Thanks.

-- 
tejun
