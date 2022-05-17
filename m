Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B2E5298A7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 06:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiEQEVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 00:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238036AbiEQEVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 00:21:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1688140BC
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:21:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gg20so6236207pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0lmFLC5QURVu6XbOogEJxka6Jitm3xVNpCgUYYeF1WY=;
        b=KqhIMVYSjNMwsD3uFmY8mx2Xn2oOcT4oUTDA05XbvKsse6EbMjZv2SMKwEXGMYwZRw
         u/qvtBrZ7DlqjHUgtazfYbQjZmMoik0yARqyKhwzwnR26gJAEEq7kCDsP9nYSfd3u02W
         2J4bplalNGtW0qAGVcDNr98l+BfcxF691q7MqZjdAG9gMdvmnOL2vZHtgEnow9VCtw0q
         AXNkAoFiwHXQNyq9+GOB/YjAEHCuAuyhSiA92MjXiVpKHbx36rTqBvD29GCZCUe3ktQa
         hUUhB2IqlSuw4O1PaN/4WSnqOOhJlq6HF+BMJcssuCsfTQA1eASpW8wXer4Azkuqj1LJ
         nuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0lmFLC5QURVu6XbOogEJxka6Jitm3xVNpCgUYYeF1WY=;
        b=qz7BOZJtq3j8lE7Avd5B7rgtM2cAQ4tDplXT5D8mpKc5RsiqC0/VlpbkjkjiefHaUh
         19A8UA+z3vmaGt3j+ZDgJP/4LPLtj5tMZ6psi8dQLLU8HI+uAyTsKZeKYXOoZI4L00Cs
         GTY7zqynXBPOoNG30MtkfQfYUZsOai9m5s2ciUgQws0OfJSM11XxC//aQHgZC2MUxOYW
         WHdwm3MgrQ+UMMnkqmkt5EsqLC9ZGAOBeykEugbGfNavcnX+ofwm+iD2VkSwx8C6gG2q
         Euv+Hblm0vGfVqWa8k3cMydx6TTQhLF2dlFjFjkkfjBtAhz8IhGAPJj99MeGyu2bYyv2
         3MKw==
X-Gm-Message-State: AOAM532hsQGhJxXq1aWtad7HVp3qXMDE73rvvJbqFd+mLaB4s5Fv2H+f
        32LI8tzUhoqnUW/1oPGG7Aw=
X-Google-Smtp-Source: ABdhPJwLF06cLClyG2kEEQ3Wm+MIS/slyIBnH/7++gKTI9Y82cH9dd73coFX7Bmz3VEj2cojaJ155w==
X-Received: by 2002:a17:903:18f:b0:15e:93bd:730f with SMTP id z15-20020a170903018f00b0015e93bd730fmr20199308plg.172.1652761271004;
        Mon, 16 May 2022 21:21:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:62fc])
        by smtp.gmail.com with ESMTPSA id m14-20020a170902db0e00b0015e8d4eb228sm5998293plx.114.2022.05.16.21.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 21:21:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 16 May 2022 18:21:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] kernfs: make ->attr.open RCU protected.
Message-ID: <YoMitbmf5hIm7QRh@slm.duckdns.org>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-3-imran.f.khan@oracle.com>
 <YnQtL7+GYHwpo4n2@slm.duckdns.org>
 <f5ff2554-580c-c817-b77f-25e2ef46411f@oracle.com>
 <Yn0/RrgMRie2YPEb@slm.duckdns.org>
 <526b46a7-7daa-9050-1276-e19836816991@oracle.com>
 <YoKna/Ty+k9O+pjt@slm.duckdns.org>
 <4532123f-4c03-0303-1480-a51faabca806@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4532123f-4c03-0303-1480-a51faabca806@oracle.com>
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

On Tue, May 17, 2022 at 12:30:26PM +1000, Imran Khan wrote:
> +/**
> + *     kernfs_deref_open_node - Get kernfs_open_node corresponding to @kn.
> + *
> + *     @kn: target kernfs_node.
> + *     @val: RCU dereference will take place only if val is true.
> + *
> + *     Fetch and return ->attr.open of @kn when current updater of ->attr.open
> + *     ensures that as long as @val is true, other updater(s) of ->attr.open
> + *     can not change it. The caller needs to pass value of the condition
> + *     (@val) that prevents value of ->attr.open from changing.
> + *
> + *     This should ONLY be used by updaters of ->attr.open.
> + */
> +static struct kernfs_open_node *
> +kernfs_deref_open_node(struct kernfs_node *kn, bool val)
> +{
> +       return rcu_dereference_protected(kn->attr.open, val);
> +}
> +
> +/**
> + *     kernfs_check_open_node - Get kernfs_open_node corresponding to @kn.
> + *
> + *     @kn: target kernfs_node.
> + *     @val: RCU dereference will take place only if val is true.
> + *
> + *     rcu_dereference and return ->attr.open of @kn. This is used in cases
> + *     where we can access ->attr.open outside RCU read-side critical section
> + *     as long as specified conditions are correct i.e @val is true.
> + *
> + *     This should ONLY be used by readers of ->attr.open.
> + */
> +static struct kernfs_open_node *
> +kernfs_check_open_node(struct kernfs_node *kn, bool val)
> +{
> +       return rcu_dereference_check(kn->attr.open, val);
> +}

You gotta put the conditions inside these wrappers. These wrappers are
supposed to describe as strict as reasonably possible so that the checks can
catch people making mistakes. It doesn't make much sense to defer the
condition to the callers. Just describe what the expected conditions are in
the wrappers as best as you reasonably can.

Thanks.

-- 
tejun
