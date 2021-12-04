Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AF6468419
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhLDKhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhLDKhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:37:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77318C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:34:26 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l16so11192284wrp.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rIBi++LLRfApTygqsmDvOw4VuLRt/jFZLaE08XHXPPM=;
        b=j0G6kWrcXrJgrM/IXsIc4hjDwRAsfWPx9+uLktxBpxuXHwfLXCqn1gRxBjBd0zGQPI
         /+bk75KogNsnqx1TJ9/1LjRbR5yJ20jcoRh5MYWohEThPHJdvxsawKocCrqo1LPGTi76
         GooPDjl9ynacl60tnCdLrdBtOyfUA7OBc6WpV4MeSl0daoO5KRoW/sjB0ljg22Xa/bPN
         vsRlJ/IhIKdf9wv2Sm8OPdWB/LGi7OZ6UckTMmxLgKGUYJWu//yEBhVEpzi11L1mvq9F
         NfSUKOxknuN82kR1yR8bhie46X8eERWtslXQg9I03/a6X7QuqQ3SvK7SJopZC+Q/bZUa
         bdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rIBi++LLRfApTygqsmDvOw4VuLRt/jFZLaE08XHXPPM=;
        b=QfaoZIlcXp/5ABYK99Ypxfko5X1e/wEDrIgwRAgUOU7r8PRukyeF4M5b4nSicRE6yg
         X31k2kubFBZeBrj96McMouOKDbwntYtKbdKZLIDLWwL6dtWwLTHyaQ8Z9UFOADvuuS1L
         f0GAYF26NCzLm1qDVvsjCFh/I9OgGcquaHwCMDahSUUMTZw6XnYuh3W4ay1+P02V4yrQ
         u7+QqZNErFMxkyyfpnWJyjX99GjtrGQwyEg3Pe/asw0JJ7Br/vOP2js+FQPDoCYvijj+
         a2043mq22Qt2POicrskbtMxHKbzGWRwi6vRaAZT/ndf0yWePzxqAssH7H6ZmNXqXwL9s
         qJzw==
X-Gm-Message-State: AOAM533yVloCSCN0C5mhHOkZ+jkOQvFJ6OrzGyHawSbUabVhhluUy6i8
        jhEm+0Wl3QSIoU78mxDIKdkEzRr1YLDasgf4
X-Google-Smtp-Source: ABdhPJwYczFvU0eC4/W6aR+nTtE3ghLNASH3UQrFEIDcI74daIVXCK//bqFQ/ODSZT5mr5xfKAcKzw==
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr28048036wry.279.1638614064862;
        Sat, 04 Dec 2021 02:34:24 -0800 (PST)
Received: from hamza-OptiPlex-7040 ([39.48.222.235])
        by smtp.gmail.com with ESMTPSA id o4sm8834265wmq.31.2021.12.04.02.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:34:24 -0800 (PST)
Date:   Sat, 4 Dec 2021 15:34:19 +0500
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: fixed coverity warning by moving pr_warn outside
 lock
Message-ID: <20211204103419.GA13093@hamza-OptiPlex-7040>
References: <20211203205041.115331-1-amhamza.mgc@gmail.com>
 <YasfXUW1rNrj3Mgo@kroah.com>
 <CANAWnNyyBR3EEtT=SecqGQsc+tnJi6GiqrW0xkqRn5jrV7CpDA@mail.gmail.com>
 <YasuMNXHlJEKNSwX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YasuMNXHlJEKNSwX@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 10:00:32AM +0100, Greg KH wrote:
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top
Thank you so much sharing the useful post as I have just started my open source journey very recently

> 
> On Sat, Dec 04, 2021 at 01:50:44PM +0500, Ameer Hamza wrote:
> > Thank you Greg for your response. The link to Coverity warning:
> > https://scan5.coverity.com/reports.htm#v56991/p10063/fileInstanceId=204668511&defectInstanceId=52305699&mergedDefectId=1494148
> 
> That link does not seem to be public.  What project are you looking at?
Its Linux project under coverity scan and CID for this warning is 1494148

> 
> > I have seen similar warnings if the print operation is used inside a lock,
> > i.e., Coverity speculates a possible deadlock scenario, which might be a
> > false positive because internal printk implementation uses a separate lock.
> 
> When dealing with Coverity, it is up to you to determine if what it says
> is actually true before sending out patches for it, due to the HUGE
> number of false-positives it spits out.
I will keep keep this under consideration for now, thanks

Best Regards,
Hamza
