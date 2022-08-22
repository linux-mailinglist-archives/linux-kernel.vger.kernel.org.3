Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E108259CAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiHVVSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbiHVVSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D6ADEF3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661203116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJeumykxcZZw8oNVKcWzNJSONhGOMMsSh4arv2eUX+M=;
        b=Xe+DG2XqzEf8+twBYaXGqRRBHA0jfqGHUJzMJ1CUFlydSq10H5sKBl17rZmOdzYNEfDPwc
        DgwwDTWrQYfLDuhu1aIS9RRtOkS7yEu5qxIWMZ1ybU6XNZv+/glSt4c1Ywur9dMgs8+/4R
        1MbzhaNSqAJsqp/W99r2d7IznJfZLc0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-4IaTL74AMz6lVTlOgVq5mQ-1; Mon, 22 Aug 2022 17:18:35 -0400
X-MC-Unique: 4IaTL74AMz6lVTlOgVq5mQ-1
Received: by mail-qv1-f71.google.com with SMTP id lj8-20020a0562145c8800b00496ceb190d4so3093706qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc;
        bh=DJeumykxcZZw8oNVKcWzNJSONhGOMMsSh4arv2eUX+M=;
        b=p0GK7nfaAXBL7RoaNSZQg8FarjhpGgx0weRnQLWqDIb+DqexQ89epLbNH8Rwm4nKal
         bxphfBjn8JQIbDLh1bvp9MtwynATDKBahtB04ytcAdFharnT166bohAwFoEJs1mUrwaq
         gnt93Sl711f4mvJ89yZZvDNCyVcRx9gqLRvUdl1VsEFW7h6C5bAQhjn8q83qfmvc+GE4
         SRcnXUpNk4+Vfh/DG7Zr1zPrCLyLsIwCQ/RfUDNBld0zeHlK9PeswK/XzkEZwkRljmRj
         ztu1+LMNfs1005eR8QWH045OL/4tFEQXEHjjzyZTLqd+FuZkCUKY+NrsIkMfC2ItjkLN
         K5cw==
X-Gm-Message-State: ACgBeo3QJufQqx4YiMDK/VS11XUuC/xJ5ANm6t89pvj/Z+bvLy3HduSI
        3hG+BWW9EUwDeE9H+Bx0bf+sXmCi2fNsjX07P2MQkF0RyvT7/x0dZ5fXxPS8wE/92rrMnTTTUZB
        jsDFyfnwAtLTKRRB1+5KBXigN
X-Received: by 2002:a05:620a:28cf:b0:6b5:e32f:febb with SMTP id l15-20020a05620a28cf00b006b5e32ffebbmr13553581qkp.258.1661203114670;
        Mon, 22 Aug 2022 14:18:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6+9qLo83O0mLbsZyHDek2m8yS+QZB9LX8Ukv8aD4lC2dlCzOu/Y8OucuLSKNaJGJ6EQi+vUQ==
X-Received: by 2002:a05:620a:28cf:b0:6b5:e32f:febb with SMTP id l15-20020a05620a28cf00b006b5e32ffebbmr13553561qkp.258.1661203114420;
        Mon, 22 Aug 2022 14:18:34 -0700 (PDT)
Received: from [192.168.8.139] (pool-100-0-245-4.bstnma.fios.verizon.net. [100.0.245.4])
        by smtp.gmail.com with ESMTPSA id l8-20020ac84cc8000000b0031f0b43629dsm9328941qtv.23.2022.08.22.14.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:18:29 -0700 (PDT)
Message-ID: <c10b243a7be185ba119bdfce9a46e609db3bdd3b.camel@redhat.com>
Subject: Re: [RFC 0/2] Stop the abuse of Linux-* _OSI strings
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, Len Brown <lenb@kernel.org>,
        nouveau@lists.freedesktop.org, hdegoede@redhat.com,
        ddadap@nvidia.com, kai.heng.feng@canonical.com,
        Dell.Client.Kernel@dell.com
Date:   Mon, 22 Aug 2022 17:18:28 -0400
In-Reply-To: <CACO55tuw_2QWFMr0t6-JfUiQ4M7V3ZMKC7jHYTyERypaU3TekQ@mail.gmail.com>
References: <20220819142519.5684-1-mario.limonciello@amd.com>
         <CACO55tuw_2QWFMr0t6-JfUiQ4M7V3ZMKC7jHYTyERypaU3TekQ@mail.gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-19 at 17:44 +0200, Karol Herbst wrote:
> On Fri, Aug 19, 2022 at 4:25 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> > 
> > 3 _OSI strings were introduced in recent years that were intended
> > to workaround very specific problems found on specific systems.
> > 
> > The idea was supposed to be that these quirks were only used on
> > those systems, but this proved to be a bad assumption.  I've found
> > at least one system in the wild where the vendor using the _OSI
> > string doesn't match the _OSI string and the neither does the use.
> > 
> > So this brings a good time to review keeping those strings in the kernel.
> > There are 3 strings that were introduced:
> > 
> > Linux-Dell-Video
> > -> Intended for systems with NVIDIA cards that didn't support RTD3
> > Linux-Lenovo-NV-HDMI-Audio
> > -> Intended for powering on NVIDIA HDMI device
> > Linux-HPI-Hybrid-Graphics
> > -> Intended for changing dGPU output
> > 
> > AFAIK the first string is no longer relevant as nouveau now supports
> > RTD3.  If that's wrong, this can be changed for the series.
> > 
> 
> Nouveau always supported RTD3, because that's mainly a kernel feature.
> When those were introduced we simply had a bug only hit on a few
> systems. And instead of helping us to debug this, this workaround was
> added :( We were not even asked about this.
> 
> I am a bit curious about the other two though as I am not even sure
> they are needed at all as we put other work arounds in place. @Lyude
> Paul might know more about these.

Some of the _OSI strings are totally fine. From my recollection:

[    0.242993] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
^ this one is needed to do a couple of ACPI tricks at startup to get the PCIe
device for audio on nvidia's GPU to be detected properly

[    0.242993] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)

I don't actually know how necessary this is, but I'm hesistant to call this
one bad as it may be related to the funny mux configurations that I'm learning
may exist on HP machines.

> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

