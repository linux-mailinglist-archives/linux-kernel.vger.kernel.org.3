Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612E35A43A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiH2HRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2HRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:17:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5974DB37;
        Mon, 29 Aug 2022 00:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=y1AGFp8fhSJfnytRvA3S7bMV03PvXazGKz5zOHFVZqU=;
        t=1661757460; x=1662967060; b=g1jgCuJ0T4oT4h3TWL5XKHdMPPZLSSopI0UL+f6EeOHBpfp
        LlW2WSk9DqK5yn6Xbt8X3WJpU0y83e3DGCWf3I2OjuQDiOuIbPQnTtuIMD/upolmZVgaXNvmgnNqw
        vAO/bvYCOQTxhiQpyDMI3jOTXQEl+QPO9m4j5g9XKJPJcGYvOtJoeYA482xjkZ/JmwbX14AffQffh
        ivMNoYcDB8ZcoYNaICIGjAuuj8S8HNyRTXDMNgvPuDMisJTygTyT+b+k4cBoAKHU6DLb+kAljtYaQ
        oItGZLWm569UIsPdoQUUldUJY6uwSBM4NFHQzS1m7KVR9TrpO8nBGzPQ6Gkk4omA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oSZ1d-002fmY-32;
        Mon, 29 Aug 2022 09:17:38 +0200
Message-ID: <2bec21b921168ea67a1746f882f30d4a6cabb627.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ieee80211: Fix for fragmented action frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Aug 2022 09:17:37 +0200
In-Reply-To: <CAG_xHGO1GvSy0pC=xNfBGyAin9b58k+b78+7gWv1YoOuQ9OAHQ@mail.gmail.com>
References: <20220810224804.2137240-1-gilad.itzkovitch@morsemicro.com>
         <f97efe8ff5f466ce938f38dc26cb76c7abcc5a71.camel@sipsolutions.net>
         <CAG_xHGO1GvSy0pC=xNfBGyAin9b58k+b78+7gWv1YoOuQ9OAHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2022-08-29 at 15:43 +1200, Gilad Itzkovitch wrote:
>=20
> > This doesn't make much sense to me - why would it be allowed or
> > necessary to call this function on a frame that wasn't yet defragmented=
?
>=20
> That was partially our understanding. But, the fragmented action frame is
> being dropped by this function
>=20

Well, this function doesn't drop anything :) It just answers a question
"is this a robust management frame", but if the question is nonsense
(calling it on a fragment other than the first) then the answer will
also be nonsense, right?

> as it is part of the provisioning DPP process
> (fragmented due to S1G low rates).

Right.

> Trying to avoid a big change here for this specific action category.

It's not really related to any specific category, is it?

> As defragmentation will occur later on in the process there should be a
> safe way to avoid dropping the frame beforehand.

Sure! But this isn't really a good way, nor would I argue it is safe ...

Perhaps ieee80211_rx_h_decrypt() needs to be more careful? I'm not even
sure where the frame really is being dropped.

Anyway, I really don't think this patch makes any sense, I think you
need to back up a bit and look at the higher layer(s) to see where and
why it's being dropped, and skip that if it's fragmented?


johannes
