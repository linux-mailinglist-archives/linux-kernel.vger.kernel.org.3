Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B84A8B28
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353112AbiBCSFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiBCSFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:05:32 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B74C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 10:05:31 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a28so7650212lfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 10:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ipt2A0IXpQfKpDIz03O3RwhnKF2tn41jUPb/HJacuM8=;
        b=MJi5/d+KoCqbmk+cXUF+GdR3XZj7eLtgHTq5lk3rJenGtsKNizLO2iu5RMBRHHN2ER
         8yAbAHuYS3y6nAr/BrciSzmu/8Bs8QIQms6jdE/VAvcpk64v5jc0K6vIRAU36RxTK1hT
         ISK6lANOW7Cd6oMBF/T4r7mJTRk0jt5/DRnSqltQ5LGAQV0bB0dTvNiGu7/I5qtMZRR/
         VvOuP09s0xsKDYlXL3dRcsrNlWUyUSLhdupD32pJR3be4fEjo6P1knKd/EAuzY7yT18U
         8dWabiFoPGK96jctxpPXDmu1E+X6JnvhvBZ8WPm0naw1n8HOH41EkUstQtt0iKbsV2U1
         3D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ipt2A0IXpQfKpDIz03O3RwhnKF2tn41jUPb/HJacuM8=;
        b=AVJ29D/AB7Rav7wNzutO+TsBj4tnadt9oyrnMuJeF1pFoqAMePMEZcmyWG1np/9hYp
         qNGGvAvdf2Gwvgcjwxw5Js0+UO5YDB9g9t5I9TKeYPBUVTcNU7kaNS1OCVgvNAo2lkXc
         dr4yKi/6yUvjY6XWrT4ckLNIWI2QtbGpdlVGvPY6NOl2GIyDkHh7AuX7fgB27zd92H2N
         La85NFgb1HVwyUrb7BeF3vOBwfeoCygpZGZ1IRxQj7gAOgIJYRYN+qbZZW3yKowPINQQ
         Cobokw2sUbhTCS+Th57+YdMpNvUjmJPFJZ4cd5qDzmcgXKMETUJemNiYjf6SPEwl7r57
         WjFQ==
X-Gm-Message-State: AOAM530TRQnsuQaxv82Z0nnQicGxEaBPjWbcJ00D/NZOe/QMQjyBawgj
        QaiHqoxUZRiySzCankRepxkzK3XqkoTBPTrzLLHNUA==
X-Google-Smtp-Source: ABdhPJwV99UF8F8qYyuvCbCl0dqNkyzz05skhf6O8nRDYtALIgW3K2RkSMtH+xyVAf0PeBl56TaUKg9JQxja6cRGzJ8=
X-Received: by 2002:a05:6512:344b:: with SMTP id j11mr27396831lfr.171.1643911529822;
 Thu, 03 Feb 2022 10:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20220201222845.3640041-1-jeffreyji@google.com> <20220202205916.58f4a592@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220202205916.58f4a592@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Brian Vazquez <brianvv@google.com>
Date:   Thu, 3 Feb 2022 10:05:17 -0800
Message-ID: <CAMzD94SNEPACnp+uniXVgRDWr9oukj-xnAoqyQQCE77GH_kqdg@mail.gmail.com>
Subject: Re: [PATCH v6 net-next] net-core: add InMacErrors counter
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jeffrey Ji <jeffreyjilinux@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jeffreyji <jeffreyji@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 8:59 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue,  1 Feb 2022 22:28:45 +0000 Jeffrey Ji wrote:
> > From: jeffreyji <jeffreyji@google.com>
> >
> > Increment InMacErrors counter when packet dropped due to incorrect dest
> > MAC addr.
> >
> > An example when this drop can occur is when manually crafting raw
> > packets that will be consumed by a user space application via a tap
> > device. For testing purposes local traffic was generated using trafgen
> > for the client and netcat to start a server
> >
> > example output from nstat:
> > \~# nstat -a | grep InMac
> > Ip6InMacErrors                  0                  0.0
> > IpExtInMacErrors                1                  0.0
>
> I had another thing and this still doesn't sit completely well
> with me :(
>
> Shouldn't we count those drops as skb->dev->rx_dropped?
> Commonly NICs will do such filtering and if I got it right
> in struct rtnl_link_stats64 kdoc - report them as rx_dropped.
> It'd be inconsistent if on a physical interface we count
> these as rx_dropped and on SW interface (or with promisc enabled
> etc.) in the SNMP counters.
> Or we can add a new link stat that NICs can use as well.
>
> In fact I'm not sure this is really a IP AKA L3 statistic,
> it's the L2 address that doesn't match.
>
>
> If everyone disagrees - should we at least rename the MIB counter
> similarly to the drop reason? Experience shows that users call for
> help when they see counters with Error in their name, I'd vote for
> IpExtInDropOtherhost or some such. The statistic should also be
> documented in Documentation/networking/snmp_counter.rst

Changing the Name to IpExtInDropOtherhost and adding the documentation
makes sense to me. What do others think? I'd like to get more feedback
before Jeffrey sends another version.
