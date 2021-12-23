Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D76C47DEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346455AbhLWFji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346414AbhLWFjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:39:37 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5301C061401
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 21:39:37 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v13so4275724pfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 21:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHZT/7aJwsxi3dG+yEgww9PUyV8cY+pCnUH+jdLMTW4=;
        b=hbs62bIUjpuQkklYQjNDXqbKVHNA1ewOzzjYY5XEk5tRD0WSlo9NTFT/7Kr5b0w3be
         ROhJ2vBZaAX50mrxOG4Y8frvvQQRV7GigSM8urLfM6JOHTiwbHwg23hGen0jNkUAy9Go
         zpTkcHNCl8ZcyeL+7oCAgrJRkmYeCcM+80Mr2KuFIjfRWcNgyJT9hPRWKPG8Anibadr6
         o/olHKzOQbLwPa3Ji3zuHZG62KnOHKAxxmCUVRgB9tFOfdouQ7Z6KcNdifjzZqdnqOYt
         NVlQ3nPG3OxV9zMASD7QmpDBbi3ayV4nMM5JGqhn9xnSXlm6XgMsw+ysM2mUr5gS8fIF
         ftKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHZT/7aJwsxi3dG+yEgww9PUyV8cY+pCnUH+jdLMTW4=;
        b=34h7dzI34tIgi8EvTAtQWQf7kMYtbdk5vfrcxAPdJ8x2SBA19QCrACZPFYARCcxmTv
         e9wVJGIhPL68r5A5AHCkRaDF+RsRIjkYHx8IgJ1KkkFV4eZpzy2dZad+jQsd2J5+q0j0
         86eDm0If14J1dO8lffX0grLCRyj4vqCyZ5rkvGsmn8ixvZGcZ6wKfuW2swdEswwVqmfx
         ZwwDbXgxdfZLT4XID0iyh9Q0+us7q8SsVhpj+i+QVae/oEmoCk/HaFNqmIpJZ2jMOXZt
         nDbK/7NfQ/hHMg3uXUSZQcLTBcGUuvGU/ZSjNZKj//Y8uJ5Jzc8NLsijmNwFnZP89wzY
         Nf8A==
X-Gm-Message-State: AOAM531Eu4kdIgjKW/miwMzyAG+8/6k9ke5QaP1FHc2ZAPAHoVJpKJhb
        eV/6gKju2SybeWOdg5YfTpb1Wphkjb+pO17X8hgJ+g==
X-Google-Smtp-Source: ABdhPJz3SirNIEKhE18gtTPE/SElzykPmy1dOF2UVvhkY/VKLiYQBaCD/d6soQnENwOCZPwWi22kVhIEruouZDuhUTg=
X-Received: by 2002:a63:824a:: with SMTP id w71mr937105pgd.74.1640237977197;
 Wed, 22 Dec 2021 21:39:37 -0800 (PST)
MIME-Version: 1.0
References: <20211221065047.290182-1-mike.ximing.chen@intel.com>
 <20211221065047.290182-2-mike.ximing.chen@intel.com> <YcGkILZxGLEUVVgU@lunn.ch>
 <CO1PR11MB51705AE8B072576F31FEC18CD97C9@CO1PR11MB5170.namprd11.prod.outlook.com>
 <YcJJh9e2QCJOoEB/@lunn.ch> <CO1PR11MB5170C1925DFB4BFE4B7819F5D97C9@CO1PR11MB5170.namprd11.prod.outlook.com>
 <YcOYDi1s5x5gU/5w@lunn.ch> <20211222194746.3480dea8@hermes.local>
In-Reply-To: <20211222194746.3480dea8@hermes.local>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 22 Dec 2021 21:39:28 -0800
Message-ID: <CAPcyv4jLdC_tp2Qx+AHXLvUtvpDbOrxEUD14rse=UjFc9K60=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v12 01/17] dlb: add skeleton for DLB driver
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "Chen, Mike Ximing" <mike.ximing.chen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "pierre-louis.bossart@linux.intel.com
        <pierre-louis.bossart@linux.intel.com>, netdev@vger.kernel.org
        <netdev@vger.kernel.org>, davem@davemloft.net <davem@davemloft.net>,
        kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 7:48 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 22 Dec 2021 22:26:38 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > pointing to skbufs? How are the lifetimes of skbufs managed? How do you get skbufs out of the NIC? Are
> > > > you using XDP?
> > >
> > > This is not a network accelerator in the sense that it does not have
> > > direct access to the network sockets/ports. We do not use XDP.
> >
> > So not using XDP is a problem. I looked at previous versions of this
> > patch, and it is all DPDK. But DPDK is not in mainline, XDP is. In
> > order for this to be merged into mainline you need a mainline user of
> > it.
> >
> > Maybe you should abandon mainline, and just get this driver merged
> > into the DPDK fork of Linux?
>
> DPDK is all userspace and runs on stock kernels from Debian, Redhat, SUSE, ...
> There is no special fork for DPDK.

Appreciate the help Stephen. Netlink and taking this through
drivers/net/, where there are other folks that care about DPDK, seems
a better fit than drivers/misc/. I'll huddle with Mike after the
holidays.
