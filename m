Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BE2520303
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbiEIQ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiEIQ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:59:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF32B24F4;
        Mon,  9 May 2022 09:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A9806138B;
        Mon,  9 May 2022 16:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724D6C385BD;
        Mon,  9 May 2022 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652115315;
        bh=H9ZzoCsU7OPFUVgovkRT4qyt5DBVCY0Rle9z2kImzrk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eijuKVmjFWQILCm+d4ejW1OnRFrE2oH1rPX5DzgPA4UNvJXhmSkQvi+zEF/6MLRzr
         hcYxot6V+PMCx6l1T9bcxi+1TDJTNszcZLLY31TSV5DXKL9Ho4Ok2lPezUH3IMNzcw
         cIY724cFq+e4gmMB6ri1hvMvyiCAqWYC1rdbQMh34v9szEb9jOXQlfTMRp3rZRYehX
         4+YoCOo0ghgT6X1ce8QPu0akgUsYBybZJDHa1yCHcm6UYSPradmWLZJGdogEBAIAOh
         cAt6UVpojzv+oRDwzEtNFBW9H+hP44EdlVihopWHkIw4SwhDZz4Lzf3ZcYeaghsiLW
         J2mrZxaI3zAxQ==
Received: by mail-pl1-f172.google.com with SMTP id n8so14450657plh.1;
        Mon, 09 May 2022 09:55:15 -0700 (PDT)
X-Gm-Message-State: AOAM530iWMAGzK79mtEgInt6L1DLY4RSlqIqJ0N2BAXGdua/AMrZuTcN
        CH6/aKnCADeqG+VS/GFlz2WyTJVW5iae27bNuQ==
X-Google-Smtp-Source: ABdhPJykBkhHUMt8k4qEM3EG8Muzu5edkjXzGUFd+xneIQ1RUYzfb43ThAvp2F2oq+zfpsKhmllOfvQ8ieanSR38mM0=
X-Received: by 2002:a17:902:7c0a:b0:15e:f63b:9a14 with SMTP id
 x10-20020a1709027c0a00b0015ef63b9a14mr13293242pll.35.1652115314773; Mon, 09
 May 2022 09:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220504154033.750511-1-clement.leger@bootlin.com>
 <20220504154033.750511-3-clement.leger@bootlin.com> <YnQo+mdDBuoKA6Fq@robh.at.kernel.org>
 <20220506124339.2c772fa0@fixe.home>
In-Reply-To: <20220506124339.2c772fa0@fixe.home>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 May 2022 11:55:02 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+RvygJDe5mug2b9E-gD7LfDt9dBmCx0rOSUEY1yWwHtw@mail.gmail.com>
Message-ID: <CAL_Jsq+RvygJDe5mug2b9E-gD7LfDt9dBmCx0rOSUEY1yWwHtw@mail.gmail.com>
Subject: Re: [PATCH 2/3] of: dynamic: add of_node_alloc() and of_node_free()
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 5:45 AM Cl=C3=A9ment L=C3=A9ger <clement.leger@bootl=
in.com> wrote:
>
> Le Thu, 5 May 2022 14:43:54 -0500,
> Rob Herring <robh@kernel.org> a =C3=A9crit :
>
> > On Wed, May 04, 2022 at 05:40:32PM +0200, Cl=C3=A9ment L=C3=A9ger wrote=
:
> > > Add functions which allows to create and free nodes.
> > >
> > > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > > ---
> > >  drivers/of/dynamic.c | 59 ++++++++++++++++++++++++++++++++++++------=
--
> > >  include/linux/of.h   |  9 +++++++
> > >  2 files changed, 58 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > > index e8700e509d2e..ec28e5ba2969 100644
> > > --- a/drivers/of/dynamic.c
> > > +++ b/drivers/of/dynamic.c
> > > @@ -455,6 +455,54 @@ struct property *__of_prop_dup(const struct prop=
erty *prop, gfp_t allocflags)
> > >                              prop->length, allocflags);
> > >  }
> > >
> > > +/**
> > > + * of_node_free - Free a node allocated dynamically.
> > > + * @node:  Node to be freed
> > > + */
> > > +void of_node_free(const struct device_node *node)
> > > +{
> > > +   kfree(node->full_name);
> > > +   kfree(node->data);
> > > +   kfree(node);
> > > +}
> > > +EXPORT_SYMBOL(of_node_free);
> >
> > This shouldn't be needed. Nodes are refcounted, so any caller should
> > just do a put.
>
> Acked. Do you want the name to be allocated as part of the node
> allocation also ?

Yeah, I think that would be fine.

Rob
