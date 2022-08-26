Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FEE5A1F57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 05:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244663AbiHZDNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 23:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiHZDNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 23:13:17 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A21635C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 20:13:16 -0700 (PDT)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DAB773FFB5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1661483594;
        bh=UWuPzi9cHt1QseAbEBNkjSeBAtIghoArUEkJhacB2Es=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=RQ0bAsRaK3jDZhXT7UuF7Xrs25nuXTIZJt8mE8Z91Rv3e59nJILk/zpWGRBwKrQT1
         7eHqYNYoKL78BByhjyQsx+X1kQe+KdlQRrUtp/fzw9689+11L5mYBGyekYEkZgRQA/
         fIPQ9KZvYF/j7Bs8QcF6AVH8bs0VG3AGa4joZqYv5CcpVmUpZMj8gk12a4qkzj+c6H
         tpIyPMRbalUki+ZInCsBQX/fGVHskDuU9cig2pwBucvQ8boC7X1QDduRMN5+JDbMMq
         3RK8jB7q6Q27brsWcFQeZxhX+92nUBx+oAjKMnvL8UWeRY/XrmOaXoVd4ZeJwAP8Eq
         JiebCdkJOhqGg==
Received: by mail-oi1-f199.google.com with SMTP id w82-20020acadf55000000b003358f467974so89828oig.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 20:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UWuPzi9cHt1QseAbEBNkjSeBAtIghoArUEkJhacB2Es=;
        b=muAeZ3WdGGu+wxs4+r1QrvW7j65GCkuEIAz0AWL0lFnN4NU6FImjTOiUW91n2JpdAj
         PTbsJkOHPOWCScsStJ3iqPRSNaiX7GeloxSV3LFj0Uzh8slKpIOpMVrd0ViFt3lIlmKl
         Mfl3PvGrMqcAvTLi0o/S2cXDiJPn+bIFMVsT6mpbD5BM3rLpTn6k29pjklKhs7FMCRn/
         9VRAhh3a9YpjnwfMMXkGWBaU8qGySpb1iqC0sxSyX9aH+qFbc6abhHFwKYmd9Zu+YdVP
         UGdlqxGhjp8rlRTeMyafztOrnzbveF7TayG7WsGLUNIiT1pmWQSv1RuUXtlImnS5yPHb
         /Cgw==
X-Gm-Message-State: ACgBeo322L5+HbS55q0tJhdH4vWC6QYKvrabHn/nME4EMIy324wbSbZb
        Mg1KeWXEk9SwvpiXhcNWuwB61DI78t6+nAAi3u6d+DB8Gbp6JYB0fz4XDdJMuUVGI0MNut2g9QI
        K12QsW3LpiNXvXut8m34F6Fcx7QCrfW4pPr80JNsuMa27degfXLKEAWgL6A==
X-Received: by 2002:a05:6808:209f:b0:344:8f50:1f29 with SMTP id s31-20020a056808209f00b003448f501f29mr764031oiw.42.1661483593535;
        Thu, 25 Aug 2022 20:13:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5c9YbTcAE+7VvnW8j5l8YwrY2ns+YbapGDGJIEUdlPYSpKB7QY7uzjfrpKKnzcU6j3ujba8CE9jvrYEBmvM7w=
X-Received: by 2002:a05:6808:209f:b0:344:8f50:1f29 with SMTP id
 s31-20020a056808209f00b003448f501f29mr764015oiw.42.1661483593249; Thu, 25 Aug
 2022 20:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p7WWxyvvB54ADkFSZE1oJweaoNK25g6YNcNxCqkeWiVKg@mail.gmail.com>
 <20220825230121.GA2879965@bhelgaas>
In-Reply-To: <20220825230121.GA2879965@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 26 Aug 2022 11:13:01 +0800
Message-ID: <CAAd53p5+WCKjSeWEV6ZCZixwow39Ot5GwpE6PUaumDH68t_4RA@mail.gmail.com>
Subject: Re: [PATCH V2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, Lukasz Majczak <lma@semihalf.com>,
        Rajat Jain <rajatja@google.com>,
        Ben Chuang <benchuanggli@gmail.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, refactormyself@gmail.com, kw@linux.com,
        kenny@panix.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 7:01 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Aug 23, 2022 at 10:55:01PM +0800, Kai-Heng Feng wrote:
> > On Tue, Aug 9, 2022 at 12:17 AM Vidya Sagar <vidyas@nvidia.com> wrote:
> > >
> > > Thanks Lukasz for the update.
> > > I think confirms that there is no issue with the patch as such.
> > > Bjorn, could you please define the next step for this patch?
> >
> > I think the L1SS cap went away _after_ L1SS registers are restored,
> > since your patch already check the cap before doing any write:
> > +       aspm_l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
> > +       if (!aspm_l1ss)
> > +               return;
> >
> > That means it's more likely to be caused by the following change:
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> > +       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
> >
> > So is it possible to clear PCI_L1SS_CTL1 before setting PCI_L1SS_CTL2,
> > like what aspm_calc_l1ss_info() does?
>
> Sorry, I've totally lost track of where we are with this.  I guess the
> object is to save/restore L1SS state.
>
> And there are two problems that aren't understood yet?
>
>   1) Lukasz's 01:00.0 wifi device didn't work immediately after
>   resume, but seemed to be hot-added later? [1]
>
>   2) The 00:14.0 Root Port L1SS capability was present before
>   suspend/resume but not after? [2,3]
>
> I thought Lukasz's latest emails [4,5] indicated that problem 1) still
> happened and presumably only happens with Vidya's patch, and 2) also
> still happens, but happens even *without* Vidya's patch.  Do I have
> that right?

Thanks, so root port already losing its L1SS cap before applying the patch.

>
> If adding the patch causes 1), obviously we would need to fix that.
> It would certainly be good to understand 2) as well, but I guess if
> that's a pre-existing problem, ...

I wonder if checking parent device's L1SS cap in
pci_restore_aspm_l1ss_state() a good workaround?

If this is indeed a firmware side issue, it explains why Kenneth's XPS
doesn't have this issue anymore after some BIOS updates.

Kai-Heng

>
> Bjorn
>
> [1] https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3#file-dmesg-L1762
> [2] https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3#file-lspci-before-suspend-log-L136
> [3] https://gist.github.com/semihalf-majczak-lukasz/fb36dfa2eff22911109dfb91ab0fc0e3#file-lspci-after-suspend-log-L136
> [4] https://lore.kernel.org/r/CAFJ_xbr5NjoV1jC3P93N4UgooUuNdCRnrX7HuK=xLtPM5y7EjA@mail.gmail.com
> [5] https://lore.kernel.org/r/CAFJ_xboyQyEaDeQ+pZH_YqN52-ALGNqzmmzeyNt6X_Cz-c1w9Q@mail.gmail.com
