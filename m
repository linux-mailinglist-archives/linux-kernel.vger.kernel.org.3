Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70969510A37
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354899AbiDZUUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355032AbiDZUTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:19:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0527F29826
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:16:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y38so3223182pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uvJxHyXfgLj1ZgKVawFWQdRMgkOnfWjoHaxt/IGWjk8=;
        b=UTbLbXRNJ0dAd026mrJNwVSpoYi1Cdsph/ZnyFL5LkZ6PaGTmkK5tePkW5vAI4PhHe
         xG8C70wpuoZYzxz6L5wCi4vClB3C+gNK5yvCACYd9V6sv6ibU04j1wSWE65e5TXg4OX1
         pTfT82P1KQnVnZDuF63yABZM4xbXevoLv87bORkeAm4kS4BLvGBi+1X0wscUSmMvG3O7
         J1N4/j4i6oiVVEGJEtyguAs0v54ZVTsV82qCezDOCxvA83erRrqIpdXuSuBsdwk92/Jr
         w1JPY0PCiU/syvAq8zKD/wHO8vpO4ZA93we8likeyc4jZgwQr/giwqg6ZzOKd8RVOb8O
         0CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uvJxHyXfgLj1ZgKVawFWQdRMgkOnfWjoHaxt/IGWjk8=;
        b=ureO9wnLRgs4iRqN2myxd+gZXT6tNIGNcBtWVxk15Cvn9b+TBmrF3gwm9bI9wQW+E0
         Nsma4XjXi9XkAnDjLWst4AY4jZdtAatUMPS04HZqpJOENnLvC3tGExbxWMQTYyw3lf66
         Q6Wgf67ekM+hA8XZoVsiO4KCpfq6Nu2fNLR78XvUQE8ZfYX2iFh2EEwU9HQNBqqqFmKO
         ZC02bJetAavIWiGqRUmR2U/tDzgla31/Lwui1jnxkd14lB3t8J25nVbGYjln8I4fNfYn
         3WtKUG4sMItsiJoEC8oBYFVtlEuxzbuHob27h7nbwcTN5yR+K90KLRTrqYUEvaGT9y6Y
         96qw==
X-Gm-Message-State: AOAM532J6HXvJPAIPvEYa5vNC+lOBN0Xgnn4t5/kqWGIPPhbBFujImQZ
        8yW5P9o5dYD/dBkfBLuJpwk=
X-Google-Smtp-Source: ABdhPJzHkxcGsfj1J9sFWJfFLme527CXJJ0r0HD/JQCnI0bQ1SneyVCF4mOhjCSyoyVXOXSZLZCqSA==
X-Received: by 2002:aa7:9852:0:b0:50d:6d10:2094 with SMTP id n18-20020aa79852000000b0050d6d102094mr1721384pfq.4.1651004184324;
        Tue, 26 Apr 2022 13:16:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7a3e])
        by smtp.gmail.com with ESMTPSA id co21-20020a17090afe9500b001cd4989fedcsm3713684pjb.40.2022.04.26.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:16:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Apr 2022 10:16:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Imran Khan <imran.f.khan@oracle.com>, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/10] kernfs: Remove reference counting for
 kernfs_open_node.
Message-ID: <YmhTFZ5zCGhWJOry@slm.duckdns.org>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <20220410023719.1752460-2-imran.f.khan@oracle.com>
 <YmLRxWUnF/zflEO2@slm.duckdns.org>
 <e30f95c3-ab55-bb1b-75c1-8bd2f91787b5@oracle.com>
 <Ymg6AazfnwdZXkXx@slm.duckdns.org>
 <YmhSYkXp0KBXOyFc@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmhSYkXp0KBXOyFc@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:13:22PM +0000, Al Viro wrote:
> On Tue, Apr 26, 2022 at 08:29:21AM -1000, Tejun Heo wrote:
> 
> > The code is just wrong. You can end up:
> > 
> >         on = kn->attr.open;
> >         if (!on)
> >                 return;
> > 
> >         // we get preempted here and someone else puts @on and then
> >         // recreates it
> 
> Can't happen - the caller has guaranteed that no new openers will be
> coming.  Look at the call chain of kernfs_drain_open_files()...

Ah, okay. It can only transition to NULL from there. It's still a weird way
to go about it tho.

Thanks.

-- 
tejun
