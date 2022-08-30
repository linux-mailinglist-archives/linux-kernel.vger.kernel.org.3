Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83AD5A6E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiH3UHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiH3UHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:07:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B3974DE4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:06:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b16so8015953wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=quPrc0QIsuz1NKdESYuLftRz7jRQA9QoPFRh/8Iokok=;
        b=ItJACpqJn+un8MmB1oaVNotCCyq8RQ4xPF6dBt1VRVv0ETdWFC95NwxR2LcTv7r2S6
         GAoZ0BBJ/vPjFKGZeVrjUpP1BrgZrMpVTG/ne7Uux2JpIM3WqT/Cc4yMBwAEMpkWEKhd
         eyKuPLiN9QzvlGqpSw58vEuFRgOks9L623kAbAOHLpV4Sq8Vkkw8tNCFv1RKmQoA6+B3
         tTdlCipGfI5WXXXKiOWEVyvE5Oxy2AeMRqMtiy49/iSLivwtRGkEAn8v/qcH1uCchz3v
         ra9HsSkGrzYJyzjh7S6Xu6/MRblZymR7SpfnnDOHu5/FViVYH6Ye+Yj6/IAnUprh01DQ
         kFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=quPrc0QIsuz1NKdESYuLftRz7jRQA9QoPFRh/8Iokok=;
        b=xsnUPx3NqXnY8mguj+UqLx6OQf/NXpmsL20SwMu0C6N02kUUieCx2f2gjVIbmMFRPt
         PVxbeGSOLabvTPN8mMiRGKUc6daObPMAxi/D8mfxwAYxNx4XRrRNkQhK+n3RLEsYr+QZ
         eTAQaWCpAOw8ZqwCttmTYnHQul+nvl+H3boAR6kGYDcpf6NQi+bLGDcoWi3u/SOeT+k2
         YLRKrPc5ex5GCrqtIAFuMVl4d54VNdYKe3aRv632kLmVQ+QBm5XG/JiZ4A8plaJLypvN
         BMEXMsF9kys48H3Ciiu8ryQBA94oBB6UeaXtRXjzGexffDZPkmjV6INwOtNE0yQVpmK+
         BYsw==
X-Gm-Message-State: ACgBeo2MqqfP9V7sXVNCucnMazPnMJrNBQbqkkQXr5zEtlSare7nyTfp
        UEADK64SRvVSpmjzQjnBcSM=
X-Google-Smtp-Source: AA6agR5HLvAHkx1e6748LuYIDVeH3GMrvVPWnUmBdS/sV+yDv3vrCIxtQ/50OS4HDxutgYtDsL3NmA==
X-Received: by 2002:a5d:4d12:0:b0:226:d878:e096 with SMTP id z18-20020a5d4d12000000b00226d878e096mr7374164wrt.377.1661890017093;
        Tue, 30 Aug 2022 13:06:57 -0700 (PDT)
Received: from opensuse.localnet (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4108000000b0021eed2414c9sm10405186wrp.40.2022.08.30.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 13:06:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date:   Tue, 30 Aug 2022 22:06:54 +0200
Message-ID: <1924196.usQuhbGJ8B@opensuse>
In-Reply-To: <Ywkf3NJQ7/8SSV+e@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com> <2887364.VdNmn5OnKV@opensuse> <Ywkf3NJQ7/8SSV+e@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=C3=AC 26 agosto 2022 21:32:44 CEST Al Viro wrote:
> On Fri, Aug 26, 2022 at 08:16:59PM +0200, Fabio M. De Francesco wrote:
> > As you may have already read, I'm so new to kernel development that I=20
still
> > know very little about many subsystems and drivers. I am not currently
> > able to tell the difference between BVEC and KVEC. I could probably try=
 to
> > switch from one to the other (after learning from other code), however I
> > won't be able to explain in the commit message why users should better =
use
> > BVEC in this case.
>=20
> struct kvec: pairs of form <kernel address, length>
> struct bio_vec: triples of form <page, offset, length>
>=20
> Either is a way to refer to a chunk of memory; the former obviously has it
> already mapped (you don't get kernel addresses otherwise), the latter=20
doesn't
> need to.
>=20
> iov_iter instances might be backed by different things, including
> arrays of kvec (iov_iter_kvec() constructs such) and arrays of
> bio_vec (iov_iter_bvec() is the constructor for those).
>=20
> iov_iter primitives (copy_to_iter/copy_from_iter/copy_page_to_iter/etc.)
> work with either variant - they look at the flavour and act accordingly.
>=20
> ITER_BVEC ones tend to do that kmap_local_page() + copy + kunmap_local().
> ITER_KVEC obviously use memcpy() for copying and that's it.
>=20
> If you need e.g. to send some subranges of some pages you could kmap them,
> form kvec array, make msg.msg_iter a KVEC-backed iterator over those and
> feed it to sendmsg().  Or you could take a bio_vec array instead, make
> msg.msg_iter a BVEC-backed iterator over that and feed to sendmsg().
>=20
> The difference is, in the latter case kmap_local() will be done on demand
> *inside* ->sendmsg() instance, when it gets around to copying some data
> from the source and calls something like csum_and_copy_from_iter() or
> whichever primitive it chooses to use.
>=20
> Why bother with mapping the damn thing in the caller and having it pinned
> all along whatever ->sendmsg() you end up calling?  Just give it
> page/offset/length instead of address/length and let lib/iov_iter.c
> do the right thing...

Hi Al,

Thanks so much for the time you spent writing this detailed explanation. I=
=20
really appreciated that you spend time for teaching newcomers with kindness=
=20
and patience.

I apologize for this late response, but for the past few days I've been out=
 of=20
city with no PC to email the lists (therefore, the lists would have rejecte=
d=20
my messages from phone with a Gmail app).

Yesterday I saw that Sagi sent an reworked version of my patch according to=
=20
your suggestions. This evening I will send it again as a patch v4 and with =
the=20
cover letter it had in the previous version.

You will be acknowledged with a "Suggested by" tag. Instead Sagi with a "Co-
developed-by" and, of course, with a "Signed-off-by" immediately after the=
=20
previous tag. There will be more information after the three dashes.=20

Again thanks,

=46abio



