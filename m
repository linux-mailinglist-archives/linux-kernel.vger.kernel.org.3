Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD07A4E53CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244574AbiCWOBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244580AbiCWOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:01:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4AC7EA12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:00:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r23so1990949edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4d3TC6ucZyuq0GaJLfYb56R+2q2cWcG09rOvKNcww+Y=;
        b=rFUzZvUj9PsjZGaz0GrV+BnYRedhsb5f6r1ptV1gfdWwY3xslFCdzrM4x24fCLycBF
         9MmlSkTxmB5ZKWfAkT//oYix5YBcg1GZ4A2hycMnzXs6IYSldeqDJ8lhln4BxNICUIAj
         mGDJBuAQAWmHOfAHbGGJKcoRyTOtF9/dlWLZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4d3TC6ucZyuq0GaJLfYb56R+2q2cWcG09rOvKNcww+Y=;
        b=upk2T4J/QxUkxQiBAHUAoyIO6mbzeFVMM37595EVG+SLaP0k3ZaGSvqaiOiwHNnQhi
         Rs3C9eTijd5OiJL56r7E4KDKhktGs+qVhlfvwnuBNjUZeoDwe1cCHQlW1xZ3OTZAFxYm
         Kodg1yTphp/QdeqMC0peLyW4HeQWmzsbbbzTBqKn/CMTZGoCJ+dlLRLGb4r9KooKOvTH
         9ak3yxEwChM2RfLHwL5ZK9REHVLO6h5Yp60QdOtxuGb4KogLbEW3zyvZ3Bag/c/Uz11h
         hT8DmomSQx8G09OLY3FxmKlLFWebPq7DcUKpPRQ6lpxsgOe9elct8iUStgMvUdhBQ+7b
         /CUg==
X-Gm-Message-State: AOAM532C2XWXQXJ4eBY+ZanVefk+kE820xNKKsKRxS9kWbClGeDwQugW
        lLx976SevWBRxYjFKcxzlxibmNpf4ivUmEhWPjh9Bg==
X-Google-Smtp-Source: ABdhPJydsCbI4K1DE26qhLWLhXVBLuexIeZknzjGHVibPwTP54CzEhxreoeycnCPeXjsI3G4qYdNmj5hUJK4kLkYjKo=
X-Received: by 2002:a05:6402:5106:b0:419:45cd:7ab0 with SMTP id
 m6-20020a056402510600b0041945cd7ab0mr235899edd.116.1648044014041; Wed, 23 Mar
 2022 07:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220322192712.709170-1-mszeredi@redhat.com> <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com> <d3333dbe-b4b7-8eb9-4a50-8526d95b5394@schaufler-ca.com>
In-Reply-To: <d3333dbe-b4b7-8eb9-4a50-8526d95b5394@schaufler-ca.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Mar 2022 15:00:01 +0100
Message-ID: <CAJfpegvwTmaw0bp70-nYQAvs8T=wYyxnDEoA=rOvX8HDZnxCTg@mail.gmail.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 at 14:51, Casey Schaufler <casey@schaufler-ca.com> wrote:

> You also need a way to get a list off what attributes are available
> and/or a way to get all available attributes. Applications and especially
> libraries shouldn't have to guess what information is relevant. If the
> attributes change depending on the filesystem and/or LSM involved, and
> they do, how can a general purpose library function know what data to
> ask for?

Oh, yes.  Even the current prototype does that:

# ~/getvalues / ""
[] = "mnt" "mntns" "xattr" "data" (len=21)
# ~/getvalues / "mnt"
[mnt] = "id" "parentid" "root" "mountpoint" "options" "shared"
"master" "propagate_from" "unbindable" (len=76)
# ~/getvalues / "mntns"
[mntns] = "21" "22" "24" "25" "23" "26" "27" "28" "29" "30" "31" "32" (len=36)
 ~/getvalues / "mntns:21"
[mntns:21] = "id" "parentid" "root" "mountpoint" "options" "shared"
"master" "propagate_from" "unbindable" (len=76)

I didn't implement enumeration for "data" and "xattr" but that is
certainly possible and not even difficult to do.

Thanks,
Miklos
