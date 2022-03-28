Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB5E4E9BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbiC1Ptt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbiC1Prr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:47:47 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA17562107
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:45:50 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id k125so11728973qkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=gpKxm33hG9nlHcEeqdiWQbm6h6iJLFhuhpxRsRgto7o=;
        b=oCkITZZSAoa7y+hGguyS6MYAAj6clot3WbUGb1bkh0zxW36mOa42SJn/W7VWs+qBzF
         NZWwsjDdWthp62hG/h8MmtbSEcLYbfRknvuL0KVqLDbvlGDgV25H2MZ+luWOI8W0GBmC
         7ilc8G3nDSUAJHjXaKUYJFNRJgvKsHYwEn3QjLfJgkhIJXPI4seFdwdHykmR1Vky+60W
         9974Z8xqR812yGnZ9M1hbeoqigYJTlvOhVCaXmPVQE3n3BWNI/8PELi/qEz0IpjGoUKw
         UgNBqux8eyhkUgs1IZajaw2zxupS3J8FZhQ2h9iFQBaEvV3+7G38+ty5kNoEF4CzMOEi
         mPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=gpKxm33hG9nlHcEeqdiWQbm6h6iJLFhuhpxRsRgto7o=;
        b=qRaMJqh/oRe7npH901MErn1dMTufPPnPX/GTsaI3w6/U2rPxritpnxSX3HzmZxC423
         HOIu7CP+zXTkKIYzZmQGzDEiUdBN6PGzArVPPJSBzivJ7Ewx5wpTZzbKDjTwi6c7DXRl
         V3QswC4lKoxJArpA517nqTzG+4UJikIvMXIea9Dtxj9qP7FytoyByTjXN91DMoTOjoMR
         qN5sVlDji5CHTyh3h9gOeylIHSbj7VXgVFmFab/UgB3Hm78GtF5rM3es0QTRmKu9kqwV
         2unLKhwLEXO4w3cqbfNfFF2p9G34N3IFIutE5lTxVkrPlcEQwyNwR6Fyf4fYCk7XcPJI
         KAqw==
X-Gm-Message-State: AOAM530+4dBLFbIHz/13/odkO8Tay/7mjkJTo2W6ix5umMCxCon1OTh3
        9ECYM+RngBy4LXfcQA+e3A==
X-Google-Smtp-Source: ABdhPJy+d0vkilsCh1sUV4QY8DsbGQhl3yNH29Gx6ttYWR/k7mndA1lBvqqUvDWmjH1iCrQlT31YAw==
X-Received: by 2002:a37:a693:0:b0:67e:c38b:c938 with SMTP id p141-20020a37a693000000b0067ec38bc938mr16124821qke.206.1648482349800;
        Mon, 28 Mar 2022 08:45:49 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id u20-20020a05620a455400b0067ec0628661sm9141522qkp.110.2022.03.28.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 08:45:49 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:80fb:65f7:c1f1:9f2])
        by serve.minyard.net (Postfix) with ESMTPSA id C43301800BB;
        Mon, 28 Mar 2022 15:45:46 +0000 (UTC)
Date:   Mon, 28 Mar 2022 10:45:45 -0500
From:   Corey Minyard <minyard@acm.org>
To:     chenchacha <chen.chenchacha@qq.com>
Cc:     Chen Guanqiao <chen.chenchacha@foxmail.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ipmi: msghandler: check the users and msgs causing
 the system to block
Message-ID: <20220328154545.GP3457@minyard.net>
Reply-To: minyard@acm.org
References: <tencent_BD6D4CB98B6D7FAA04F63D28F6457F10F40A@qq.com>
 <20220328013842.GN3457@minyard.net>
 <tencent_071EACFAEE3F0CFA14A674C4603E39026F09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_071EACFAEE3F0CFA14A674C4603E39026F09@qq.com>
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

On Mon, Mar 28, 2022 at 11:27:06PM +0800, chenchacha wrote:
> 
> > Anyway, a better solution for the kernel side of things, I think, would
> > be to add limits on the number of users and the number of messages per
> > user.  That's more inline with what other kernel things do.  I know of
> > nothing else in the kernel that does what you are proposing.
> 
> The precondition for add limits, is that people known that ipmi has too many
> users and messages cause problems, this patch is to let administrator known
> that.
> 
> In addition, different machines have different limit, My server my block
> 700,000 messages and it's fine, and my NAS pc went to OOM when it probably
> blocked for 10,000 messages. So, to limit the number of users and messages,
> can wait until we have accumulated some online experience?

I don't mean a limit on the total number of messages, but a limit on the
total number of oustanding messages, and a limit on the total number of
users.  No user should have more than a handful of oustanding message,
and limiting the number of users to 20 or 30 should be more than enough
for any system.

Having those limits in place would probably help you trace down your
problem, as you would hit the limits and it should report it at the
source of the problem.

-corey

> 
> > 
> > Does that make sense?
> > 
> > -corey
> > 
> 
> thanks
> --
> 
> Chen Guanqiao
> > > 
> > > This patch provides a method to view the current number of users and messages in
> > > ipmi, and introduce a simple interface to clear the message queue.
> > > 
> > > Chen Guanqiao (3):
> > >    ipmi: Get the number of user through sysfs
> > >    ipmi: Get the number of message through sysfs
> > >    ipmi: add a interface to clean message queue in sysfs
> > > 
> > >   drivers/char/ipmi/ipmi_msghandler.c | 159 ++++++++++++++++++++++++++++
> > >   1 file changed, 159 insertions(+)
> > > 
> > > -- 
> > > 2.25.1
> > > 
> 
