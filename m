Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76B6563ABA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiGAULp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbiGAUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:11:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4471310FF6;
        Fri,  1 Jul 2022 13:11:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cv13so3607141pjb.4;
        Fri, 01 Jul 2022 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pk0NGGb9r+FqmcTRJ1itk919b2sN93teEfpD3LNfJ/k=;
        b=JI8XK8o3IXgKyr7Zb/eHZk7ebOpn14F1ePPsmVHX7GLCf/D+ZTYpQ5HIycB/I/i8kB
         UpMpq0uS3tSs7VZn6XP/+Uqqaa4nn37kWfBZSN2yUZRokkLxJj3ieh5M5RSdah7bo6WX
         NZF9tn+owkpy43KknU4pAxkVW3ZxskwyzzhexwwBuuh9RbmnVh/U306d5cP3tTRyEn+J
         Fkz9WlRdMwegxfvnlhVjxgDvYJjrBxNUep/6oBKSidBB8aY5eZLuCYYAJwITT28O65rB
         meLbWA8z1qD/9/UyjY+QEHEJKDAWV93AxhKkVnk8/SjybrdUtHY5V8f6HeE6QfTflAnS
         OotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pk0NGGb9r+FqmcTRJ1itk919b2sN93teEfpD3LNfJ/k=;
        b=zPmpd+p1Us2FsXAq6qLbzD52aDYaTTTisxkFrWKhWehuClrspULvoRYgKi51eHuQQa
         zD+xWeTjXUArWtAkzIhBe/oYPvCZ1rlNq7edZ9CsLUvPI9IMCb7xhW5vfRfRzh+7V9y7
         lGKl4hruK7+mHZCcSCvP144+gP01t8zacxEpdBTlxb8T+Z3yNNF5x3LTlqFst3tNwsGu
         cJ9jtLOnCCjioGGy04j2BSvac3PSyyEEs6zMtODRMzZtVpJeTpXsHVeHwUfV7a4+c0D0
         k65N17fD/hhRGjqamt0IYK1jCHTWfmll+EKxF0M/GyYj7+7mvU63ILgGx/bmkZmYDmht
         BgKw==
X-Gm-Message-State: AJIora8cDuFJL76JArGmI9w1rr2dWfvgryKk4regfTgOCo3FSCXX1QiY
        3+ptiNMRJPmpOt/QEdkGSlA=
X-Google-Smtp-Source: AGRyM1v5R46gGmBcDUcDE7DA8GNk8E2uqXjYXmJjkvDHPUF2NtotFdJKAS8mY4nvk0TGo4dcgncR5w==
X-Received: by 2002:a17:902:6b42:b0:15d:3603:6873 with SMTP id g2-20020a1709026b4200b0015d36036873mr22533189plt.30.1656706266582;
        Fri, 01 Jul 2022 13:11:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b551])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b0016a3db5d608sm55226plx.289.2022.07.01.13.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:11:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 2 Jul 2022 05:11:02 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        m.szyprowski@samsung.com, nathan@kernel.org, michael@walle.cc,
        robh@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com,
        pmladek@suse.com
Subject: Re: [RESEND PATCH] kernfs: Avoid re-adding kernfs_node into
 kernfs_notify_list.
Message-ID: <Yr9U1q0BBinCgyrT@mtj.duckdns.org>
References: <20220701154604.2211008-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701154604.2211008-1-imran.f.khan@oracle.com>
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

On Sat, Jul 02, 2022 at 01:46:04AM +1000, Imran Khan wrote:
> @@ -992,9 +993,11 @@ void kernfs_notify(struct kernfs_node *kn)
>  	rcu_read_unlock();
>  
>  	/* schedule work to kick fsnotify */
> -	kernfs_get(kn);
> -	llist_add(&kn->attr.notify_next, &kernfs_notify_list);
> -	schedule_work(&kernfs_notify_work);
> +	if (kn->attr.notify_next.next != NULL) {
> +		kernfs_get(kn);
> +		llist_add(&kn->attr.notify_next, &kernfs_notify_list);
> +		schedule_work(&kernfs_notify_work);
> +	}

Aren't you just narrowing the race window here? What prevents two
threads simultaneously testing for non NULL and then entering the
addition block together?

Looked at the llist code and it doesn't support multiple producers
trying to add the same node, unfortunately, so I'm not sure llist is
gonna work here. For now, the right thing to do prolly is reverting
it.

Al, is there something I'm missing about llist?

Thanks.

-- 
tejun
