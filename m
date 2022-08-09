Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7914758DA81
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbiHIOqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiHIOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:46:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6FC1B7B4
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:46:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z12so14571349wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc;
        bh=GU85vH0JwZyYgfvgPi4uNIOzQTqcxTNpZf0fdkfbw3E=;
        b=cGqWfEM031PLNJ3KzfPfP+udllMIZG1weeQeYwd/jHYlN+GzXSzPZDD/+a7LgB0GzI
         nM3sOrM0M2uKJKnGth6xfOifFqiAinTk2krgDkCfyxbaFrY5ocdohAnd0H/a/vVwe0lS
         yovylzfg11jKLpxKZL27PpulfArYd+AjLllp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc;
        bh=GU85vH0JwZyYgfvgPi4uNIOzQTqcxTNpZf0fdkfbw3E=;
        b=oSYgxe2JNi7iWqSdzion0O5seHDbbNsrVH8j/DeujLf/kOIDB6wLoFE/71lYj4sBSs
         31fZ1znQvGPX7HT7rq0JTQ4O4gD4ErmfQL4ECDQUmf+5iFTss4VDFfqDhVo5Fh+aRT17
         nfADdkASlAp9Z8CVm0iqgIOuZDs4r057wQ/nO5waoFP65mctf+LzVzfeuKKb5/JKFCYp
         WdLTpVmocbrKfEWgwFlc6hZXwdXfl5BMoNDV7eySK6H3W8Ut6uu5kx5GoenN+BfKLgQN
         iCmrXFumsINd+eQwlh6n8VLzxDWueVhZguLqJbKmYpLjuzHtY/TCLueg7qJPnPIKuovf
         zqbA==
X-Gm-Message-State: ACgBeo1U6Q1mBBRqfapckWe3eDhXdvYRj9/v2K+LV0H5kNy46OLpPvYX
        c5M6KlBTBqDpqHG12tG1fymG/A==
X-Google-Smtp-Source: AA6agR4wNTRW3WH6s5IDTVPaHbcPGt8ACxu8E3GaSvcFwrkbIoiXBDALV6KyScP+LquedtXpwKq6nQ==
X-Received: by 2002:a05:6000:381:b0:221:7507:bb24 with SMTP id u1-20020a056000038100b002217507bb24mr12253940wrf.373.1660056374190;
        Tue, 09 Aug 2022 07:46:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe88d000000b0021e13efa17esm13713701wrm.70.2022.08.09.07.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 07:46:13 -0700 (PDT)
Date:   Tue, 9 Aug 2022 16:46:11 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        "Sharma, Shashank" <Shashank.Sharma@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media <linux-media@vger.kernel.org>
Subject: Re: [Linaro-mm-sig] Re: DMA-buf and uncached system memory
Message-ID: <YvJzM1km0iJ3eFnR@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        "Sharma, Shashank" <Shashank.Sharma@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media <linux-media@vger.kernel.org>
References: <fbb228cd78e9bebd7e7921c19e0c4c09d0891f23.camel@pengutronix.de>
 <e691bccc-171d-f674-2817-13a945970f4a@amd.com>
 <95cca943bbfda6af07339fb8d2dc7f4da3aa0280.camel@pengutronix.de>
 <05814ddb-4f3e-99d8-025a-c31db7b2c46b@amd.com>
 <708e27755317a7650ca08ba2e4c14691ac0d6ba2.camel@pengutronix.de>
 <6287f5f8-d9af-e03d-a2c8-ea8ddcbdc0d8@amd.com>
 <CAPj87rOykZv7bjNhHPT4StrsPz8Y_DWqab4Ryq=Qqh77LS2e=Q@mail.gmail.com>
 <578953dd-6298-2bfe-a8fb-52004b84fd17@amd.com>
 <YrY0cQY1BTL5H7Xp@phenom.ffwll.local>
 <5eeefadd-7804-3876-c8da-3e6f1bcb9dc0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5eeefadd-7804-3876-c8da-3e6f1bcb9dc0@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 03:48:03PM +0200, Christian König wrote:
> Hi Daniel,
> 
> Am 25.06.22 um 00:02 schrieb Daniel Vetter:
> > On Thu, Jun 23, 2022 at 01:32:18PM +0200, Christian König wrote:
> > > Am 23.06.22 um 13:27 schrieb Daniel Stone:
> > > > [SNIP]
> > > > If it's really your belief that dmabuf requires universal snooping, I
> > > > recommend you send the patch to update the documentation, as well as
> > > > to remove DRIVER_PRIME from, realistically, most non-PCIE drivers.
> > > Well, to be honest I think that would indeed be necessary.
> > > 
> > > What we have created are essentially two different worlds, one for PCI
> > > devices and one for the rest.
> > > 
> > > This was indeed not the intention, but it's a fact that basically all
> > > DMA-buf based PCI drivers assume coherent access.
> > dma-buf does not require universal snooping.
> > 
> > It does defacto require that all device access is coherent with all other
> > device access, and consistent with the exporters notion of how cpu
> > coherency is achieved. Not that coherent does not mean snooping, as long
> > as all devices do unsnooped access and the exporter either does wc/uc or
> > flushes caches that's perfectly fine, and how all the arm soc dma-buf
> > sharing works.
> 
> We should probably start documenting that better.

Agreed :-)

Are you volunteering to type up something that reflects the current sorry
state of affairs? I'm not sure I'm the best since I guess I've been too
badly involved in this ...

> > We did originally have the wording in there that you have to map/unamp
> > around every device access, but that got dropped because no one was doing
> > that anyway.
> > 
> > Now where this totally breaks down is how we make this work, because the
> > idea was that dma_buf_attach validates this all. Where this means all the
> > hilarious reasons buffer sharing might not work:
> > - wrong coherency mode (cpu cached or not)
> > - not contiguous (we do check that, but only once we get the sg from
> >    dma_buf_attachment_map, which strictly speaking is a bit too late but
> >    most drivers do attach&map as one step so not that bad in practice)
> > - whether the dma api will throw in bounce buffers or not
> > - random shit like "oh this is in the wrong memory bank", which I think
> >    never landed in upstream
> > 
> > p2p connectivity is about the only one that gets this right, yay. And the
> > only reason we can even get it right is because all the information is
> > exposed to drivers fully.
> 
> Yeah, that's why I designed P2P that way :)
> 
> I also don't think it's that bad, at least for radeon, nouveau and amdgpu
> all the migration restrictions are actually handled correctly.
> 
> In other words when a DMA-buf is about to be used by another device we use
> TTM to move the buffer around so that it can actually be accessed by that
> device.
> 
> What I haven't foreseen in here is that we need to deal with different
> caching behaviors between exporter and importer.

Yeah we should have done caching explicitly and full opt-in like with p2p.
The trouble is that this would have been a multi-year fight with dma api
folks, who insist it must be all transparent. So the politically clever
thing was to just ignore the problem and land dma-buf, but it comes back
to bite us now :-/

> > The issue is that the device dma api refuses to share this information
> > because it would "leak". Which sucks, because we have defacto build every
> > single cross-device use-case of dma-buf on the assumption we can check
> > this (up to gl/vk specs), but oh well.
> > 
> > So in practice this gets sorted out by endless piles of hacks to make
> > individual use-cases work.
> > 
> > Oh and: This is definitely not limited to arm socs. x86 socs with intel
> > at least have exactly all the same issues, and they get solved by adding
> > various shitty hacks to the involved drivers (like i915+amdgpu). Luckily
> > the intel camera driver isn't in upstream yet, since that would break a
> > bunch of the hacks since suddently there will be now 2 cpu cache
> > incoherent devices in an x86 system.
> > 
> > Ideally someone fixes this, but I'm not hopeful.
> > 
> > I recommend pouring more drinks.
> > 
> > What is definitely not correct is claiming that dma-buf wasn't meant for
> > this. We discussed cache coherency issues endless in budapest 12 or so
> > years ago, I was there. It's just that the reality of the current
> > implementation is falling short, and every time someone tries to fix it we
> > get shouted down by dma api maintainers for looking behind their current.
> 
> Well that explains this, I've joined the party a year later and haven't
> witnessed all of this.

Yay, cleared up another confusion!

> > tldr; You have to magically know to not use cpu cached allocators on these
> > machines.
> 
> Or reject the attachment. As far as I can see that is still the cleanest
> option.

Yeah rejecting is always an ok thing if it just doesn't work.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
