Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200785A2E23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbiHZSRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245175AbiHZSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:17:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE6CCE3D
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:17:05 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b16so3077853edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XnP47D2a+NfTs/kKZwaTdIdxwiCYCTPoKf3Nst+QNqM=;
        b=MJccE0t6UXng4JnP+czJWRP/siy5ayy03+Ez+0NNbsvQizm+awEbThpgN9ow4KbUoK
         ZFvbNdkR8HtTVUXE0cULcfDZdg/S2X3m1kwyP+vtJcDjfgH8VNiL6ePm2CFX8D4xiAn7
         u3i3a2MqU4YJ71SZsSRiBuckf80cBMQXe/6r989HTxkdLpKoLQDAKPCEft5CHiSMfom6
         CCvtry2Tm2AwyewqahV+Q4DRjgeeRxqWl5B04qUO/L4UIgbCcKT5OBwIr8r8t3I/pidj
         copqlXuXFCRP/k5wSA79EcFTx7fhvjY/UrSOYIJDwKkMPfs7PYmFNkcWZJFbQH1XGRj/
         iR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XnP47D2a+NfTs/kKZwaTdIdxwiCYCTPoKf3Nst+QNqM=;
        b=Fe/8eKnHyfiJRH7gTO4HDTkbWgPdaW8oV5CcXzxWO86aueolcTb6NC4ChJjsYbvtlg
         bKKuWBSc+aUKAljyVapxoQEOFJamrOLiTxY0BjwnvFVtO//QQ2/VpAALuwWlPhH/K2BY
         +HL+mWWeNL7kIQPiGPcQNm3iEXkK5Vq6RsH4iXs7+jXzACenCE8JqZCrDKwjLtVTZ28n
         NPiFInJ+thKQQbbM0c11u0ta5zKaH2wCpdUZmdOwmeYOTF4XtcTtwujCs71NsI8Dlmsx
         VN7sTePMIYs9MX1NrVNMIUo9eYNqXyqgcqjWo7NodcNutviHjCkBRpErJfNB/Es61Si1
         tQjg==
X-Gm-Message-State: ACgBeo2b2qy2YGZ7mqd/TJ1OIA1eK6cxRoNq99MarrV7qLb9C1nARcgD
        g6UA48CUKSOFh5bGAoPbHqM=
X-Google-Smtp-Source: AA6agR4E6ZpdSAyC1bg3h1uG81oJplLP4E6Oe+c1BC7qlmZr7SCAj4LjCsevF5NflhRLZVl4ReP6CA==
X-Received: by 2002:a05:6402:448b:b0:43b:5ec6:8863 with SMTP id er11-20020a056402448b00b0043b5ec68863mr7522282edb.377.1661537823830;
        Fri, 26 Aug 2022 11:17:03 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id y3-20020aa7c243000000b004479ef996b8sm1640963edo.11.2022.08.26.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:17:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date:   Fri, 26 Aug 2022 20:16:59 +0200
Message-ID: <2887364.VdNmn5OnKV@opensuse>
In-Reply-To: <YwVjpTW6vWvdVQTK@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com> <20220822142438.5954-2-fmdefrancesco@gmail.com> <YwVjpTW6vWvdVQTK@ZenIV>
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

On mercoled=C3=AC 24 agosto 2022 01:32:53 CEST Al Viro wrote:
> On Mon, Aug 22, 2022 at 04:24:38PM +0200, Fabio M. De Francesco wrote:
> > Therefore, replace the kmap() of sg_page(sg) with a page_address() and
> > delete the "nr_mapped" field from "nvmet_tcp_cmd" and instead pass a
> > local variable to iov_iter_kvec() from the call site in
> > nvmet_tcp_map_pdu_iovec().
>=20
> I'd suggest looking into switching to ITER_BVEC...

Hello Al,

It's interesting that, for the second time in a few days, I've been suggest=
ed=20
to switch to the use of BVEC. Christoph asked for first[1]

I responded to Christoph and, in the same email, I also asked Sagi
(the author of nvmet_tcp_map_pdu_iovec()) if he wanted to add something to=
=20
that discussion.

As you may have already read, I'm so new to kernel development that I still
know very little about many subsystems and drivers. I am not currently
able to tell the difference between BVEC and KVEC. I could probably try to=
=20
switch from one to the other (after learning from other code), however I wo=
n't=20
be able to explain in the commit message why users should better use BVEC i=
n=20
this case.

My task is to remove as many kmap() call sites I can from the entire kernel=
,=20
and this is all I did in nvmet-tcp. After doing many tens of call sites=20
removals or conversions to kmap_local_page(), I learned to not go deep into=
=20
those details which aren't needed to accomplish the task I've been given.

However, since you and Christoph suggested doing more (I suppose in a separ=
ate
patch), I did some research which seems to confirm that iov_iter_kvec() may=
 be=20
good for what it is supposed to do.

Since you are talking again about BVEC, soon after Christoph did the same, =
I'd
like to understand better which improvements do we expect from BVEC and why
and when should developers prefer this or KVEC.

Can you please provide further information or links to documentation?

Thanks for your time,

=46abio

[1]   https://lore.kernel.org/all/8107517.T7Z3S40VBb@opensuse/



