Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1244DE0CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbiCRSMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiCRSMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 015372EAF46
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647627057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kc+pmtHfxIpRTamp8EGNmCLlGgRlmecF3rxkTdAqUlY=;
        b=T6gRMrIZ0x3SDWltmcieSGUahXnvvOJsokA+UPJy5qr9ZzZ82FMivYs3ND3HVbhTO2NXwh
        liKsWwKb6Baxr7qd5Znwe5D6Fs1t+sy6XEzrDJS+LjJE35XFNMu8R9TOB18Ur1rJx9VJMc
        jCvfkCP5D7jR6lIb6vZgs6cAtSfORnA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-A46hvKVNP8eL6gNDGi7D_Q-1; Fri, 18 Mar 2022 14:10:55 -0400
X-MC-Unique: A46hvKVNP8eL6gNDGi7D_Q-1
Received: by mail-qt1-f199.google.com with SMTP id p6-20020a05622a00c600b002e1cb9508e8so6101311qtw.20
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=kc+pmtHfxIpRTamp8EGNmCLlGgRlmecF3rxkTdAqUlY=;
        b=5/O0oXRrhBWjF5gU6iUqCH2HE6oWI3JG9NHwrgvK0cxGF+P4v01ds1S/xmngV/x2BR
         MKvrEVEkPCSnYYz0BAytKCrhQiBmMavZGx1ETiOQ16Bh7ljOHLYirLziCGA///fI9bpx
         RXw4i2hI4cbaiw0QkqJaXOql3lAmBonBRwq7/oaMPOk/UhS+nZrtuVGPbzkcb11J1H/+
         mWfWQ7S/bcy0+Dcgq2w+3DK8CMHvKL0tYV03bme1hrfXMuZLuJ3HyB6/SEVyGCVvBn2c
         EOojPpa3Mf++3So8Sgkg4lmlBODG/kbrrsD/tWNBhNk7msVlABF7EgcURcDXwtSoeEAB
         vULA==
X-Gm-Message-State: AOAM533wZe2WNaPLuAjn02Aia9XOhP8oz1QJxMEnKBTP0Prgiv0/zAFP
        RCRoesQmKO5EQvHAZlT+fGjCkMjqTmJu3OedzLddveYKUteiH2aTytS0TN6vRwpMHKr/vmabNQc
        5vejcYl5UMpJjRCgvFNGGDrq1
X-Received: by 2002:a37:9fd3:0:b0:67b:126d:df0 with SMTP id i202-20020a379fd3000000b0067b126d0df0mr6766715qke.784.1647627054892;
        Fri, 18 Mar 2022 11:10:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzydYXtEHBUS6lsWzvgP7SJvGqnoFV/FidiOKPv4KYQyt102wQaiSPRTJbjFy4LGZSduMs8mg==
X-Received: by 2002:a37:9fd3:0:b0:67b:126d:df0 with SMTP id i202-20020a379fd3000000b0067b126d0df0mr6766693qke.784.1647627054549;
        Fri, 18 Mar 2022 11:10:54 -0700 (PDT)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net. [96.230.100.15])
        by smtp.gmail.com with ESMTPSA id d13-20020a05622a15cd00b002e1df990d01sm6200193qty.71.2022.03.18.11.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 11:10:53 -0700 (PDT)
Message-ID: <b3e5914f649a9cdc35fbbe9f399d3806f13c3a6f.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/bios: Rename prom_init() and friends
 functions
From:   Lyude Paul <lyude@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 18 Mar 2022 14:10:52 -0400
In-Reply-To: <9aebcbbf-aaba-f7e8-7397-18284e74ab0d@csgroup.eu>
References: <2d97ae92b9c06214be0e088a72cf303eb591bf01.1646414295.git.christophe.leroy@csgroup.eu>
         <47e09d6010852db928c0de29b89450ea7eee74d8.camel@redhat.com>
         <edb9aabd-09af-ae0c-348d-f0500e3405d7@csgroup.eu>
         <672043db-5290-293c-fde4-440989c78d09@csgroup.eu>
         <9aebcbbf-aaba-f7e8-7397-18284e74ab0d@csgroup.eu>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops, sorry! I was unsure of the preference in name we should go with so I
poked Ben on the side to ask them, but I can see they haven't yet responded.
I'll poke thme again and see if I can get a response.

On Fri, 2022-03-18 at 10:55 +0100, Christophe Leroy wrote:
> Hi Paul,
> 
> Le 05/03/2022 à 10:51, Christophe Leroy a écrit :
> > 
> > 
> > Le 05/03/2022 à 08:38, Christophe Leroy a écrit :
> > > 
> > > 
> > > Le 04/03/2022 à 21:24, Lyude Paul a écrit :
> > > > This mostly looks good to me. Just one question (and one comment down 
> > > > below
> > > > that needs addressing). Is this with ppc32? (I ask because ppc64le 
> > > > doesn't
> > > > seem to hit this compilation error).
> > > 
> > > That's with PPC64, see 
> > > http://kisskb.ellerman.id.au/kisskb/branch/chleroy/head/252ba609bea83234d2e35841c19ae84c67b43ec7/
> > >  
> > > 
> > > 
> > > But that's not (yet) with the mainline tree. That's work I'm doing to 
> > > cleanup our asm/asm-protoypes.h header.
> > > 
> > > Since commit 4efca4ed05cb ("kbuild: modversions for EXPORT_SYMBOL() 
> > > for asm") that file is dedicated to prototypes of functions defined in 
> > > assembly. Therefore I'm trying to dispatch C functions prototypes in 
> > > other headers. I wanted to move prom_init() prototype into asm/prom.h 
> > > and then I hit the problem.
> > > 
> > > In the beginning I was thinking about just changing the name of the 
> > > function in powerpc, but as I see that M68K, MIPS and SPARC also have 
> > > a prom_init() function, I thought it would be better to change the 
> > > name in shadowrom.c to avoid any future conflict like the one I got 
> > > while reworking the headers.
> > > 
> > > 
> > > > > @@ -57,8 +57,8 @@ prom_init(struct nvkm_bios *bios, const char
> > > > > *name)
> > > > >   const struct nvbios_source
> > > > >   nvbios_rom = {
> > > > >          .name = "PROM",
> > > > > -       .init = prom_init,
> > > > > -       .fini = prom_fini,
> > > > > -       .read = prom_read,
> > > > > +       .init = nvbios_rom_init,
> > > > > +       .fini = nvbios_rom_fini,
> > > > > +       .read = nvbios_rom_read,
> > > > 
> > > > Seeing as the source name is prom, I think using the naming convention
> > > > nvbios_prom_* would be better then nvbios_rom_*.
> > > > 
> > > 
> > > Yes I wasn't sure about the best naming as the file name is 
> > > shadowrom.c and not shadowprom.c.
> > > 
> > > I will send v2 using nvbios_prom_* as a name.
> > 
> > While preparing v2 I remembered that in fact, I called the functions 
> > nvbios_rom_* because the name of the nvbios_source struct is nvbios_rom, 
> > so for me it made sense to use the name of the struct as a prefix for 
> > the functions.
> > 
> > So I'm OK to change it to nvbios_prom_* but it looks less logical to me.
> > 
> > Please confirm you still prefer nvbios_prom as prefix to the function 
> > names.
> > 
> 
> Are you still expecting a v2 for this patch ?
> 
> As the name of the structure is nvbios_rom, do you really prefer the 
> functions to be called nvbios_prom_* as you mentionned in your comment ?
> 
> In that case, do you also expect the structure name to be changed to 
> nvbios_prom ?
> 
> Thanks
> Christophe
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

