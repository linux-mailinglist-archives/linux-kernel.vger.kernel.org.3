Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FB25710AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiGLDOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGLDOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:14:08 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FBA1274B;
        Mon, 11 Jul 2022 20:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657595632; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=bacQR/baKY0de56t2Uz3txqbdVyIoP6DWYZrIoy1Q4/jVg5bL3cv7JoHeubtWOLvzocZLqsS5bChMSJLJlROhcLSAqXxoydHeENDAXBg1u2decIfrBKQHyzOdwj+6Ql2l+IsOxa1tDYuKp97HUj+cUtrGNW3r2rOOlcRdSaIxYA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657595632; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=EA5z6YjBCuOgn0sSNEge40fBG5QIZgwF8W8bHwuDa5Q=; 
        b=cl4PFB9eFqNSyqGTaqG6Ks2KzI3B1Jdc9XhReMcesusDSIB/KSHr1zI4cKZXPk0tghaONd3gT4NC8m6zPq/zEtHpGf2y7ApU/XOdMrzg98ribw5kox2WlRwLHyWbhhICmJh/QbeGLuIuJQY3tbuJqC4YhLHsCJUaKRx/hAO2d38=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657595632;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=EA5z6YjBCuOgn0sSNEge40fBG5QIZgwF8W8bHwuDa5Q=;
        b=qGDdDUbYkpvCDN/2Mh3vrijp6vYPV5Tn/Op1KrK1gTiiKppw/KPJIq89Am5yUKvf
        WVWAfBxiMqo69k1PbRnGiG8iiotI42QAfcmHjhLC4Lvw2HbASgQNnJfieP4jzsA4JEf
        Bey9WPctTFb1vwtZYDeA8/D13wRDj2v7NqvihNYY=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1657595631492858.3699768117431; Mon, 11 Jul 2022 20:13:51 -0700 (PDT)
Date:   Tue, 12 Jul 2022 11:13:51 +0800
From:   Li Chen <me@linux.beauty>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Li Chen" <lchen@ambarella.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "DTML" <devicetree@vger.kernel.org>,
        "Linux-MM" <linux-mm@kvack.org>
Message-ID: <181f0661719.f70e29d3505822.5974565955538700441@linux.beauty>
In-Reply-To: <CAK8P3a0Qo=xexUDs=XA2gRe4p-FPoXUpuxWrnqWrr43FTViA3w@mail.gmail.com>
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-2-me@linux.beauty>
 <CAK8P3a1WbJSWHsfegTtLhzSRwAoN8WfdezTTedRk9-FCiM8+GA@mail.gmail.com> <181edbe0f3d.e1336ef3387914.4730240512950880256@linux.beauty> <CAK8P3a0Qo=xexUDs=XA2gRe4p-FPoXUpuxWrnqWrr43FTViA3w@mail.gmail.com>
Subject: Re: [PATCH 1/4] of: add struct page support to rmem
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
 ---- On Mon, 11 Jul 2022 23:06:50 +0800  Arnd Bergmann <arnd@arndb.de> wrote --- 
 > On Mon, Jul 11, 2022 at 4:51 PM Li Chen <me@linux.beauty> wrote:
 > >  ---- On Mon, 11 Jul 2022 21:36:12 +0800  Arnd Bergmann <arnd@arndb.de> wrote ---
 > >  > On Mon, Jul 11, 2022 at 2:24 PM Li Chen <me@linux.beauty> wrote:
 > >  >
 > >  > > +config OF_RESERVED_MEM_DIO_SUPPORT
 > >  > > +       bool "add Direct I/O support to reserved_mem"
 > >  > > +       depends on ZONE_DEVICE && ARCH_KEEP_MEMBLOCK
 > >  > > +       help
 > >  > > +          By default, reserved memory don't get struct page support, which
 > >  > > +                means you cannot do Direct I/O from this region. This config takes
 > >  > > +                uses of ZONE_DEVICE and treats rmem as hotplug mem to get struct
 > >  > > +                page and DIO support.
 > >  >
 > >  > This probably does not need to be user visible, it's enough to select it from
 > >  > the drivers that need it.
 > >
 > > When you say "user visible", do you mean the config can be dropped or something else like Kconfig type other than bool?
 > 
 > I mean this can be a hidden option, which you can do by leaving out the
 > one-line description after the 'bool' keyword. The option will still
 > be selectable
 > in Kconfig files from other options, but not shown in 'make menuconfig'.
 > 
 >         Arnd
 > 

Roger that. I will do it in v2.

Regards,
Li
