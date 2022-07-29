Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5005A5850D8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiG2NX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiG2NXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:23:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0346759E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:23:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE9EA1FACC;
        Fri, 29 Jul 2022 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659101030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FMeB7gNzDdPBcB0grv6dwqtsT3RsWnwrpI2BT3+73M=;
        b=OyhcVXwJEDTEnywR51HSrlFRd3VcmWxHiufTNsvD83+QpZ4KJZiDh79T+20FNSZyLp3Rix
        p3sZ1WJBG6t2S+VMiaQ/WT4rxYb+aZr55x5FqyXm18qX8/5yywgFz+Zp57pZdWCpIYi+I1
        y0HyvAd553z2CmEWrxGmvLq1TfcUtuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659101030;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5FMeB7gNzDdPBcB0grv6dwqtsT3RsWnwrpI2BT3+73M=;
        b=os5OdYUSfFMSQBT3slgxbpu2pzJSEDtwvJQygrEH95h25oYKy173Yqp9oc7kNH3TmM54BL
        de/nFXErN45gjdCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 704EF13A8E;
        Fri, 29 Jul 2022 13:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J9C5GWbf42JiSwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 29 Jul 2022 13:23:50 +0000
Date:   Fri, 29 Jul 2022 15:23:49 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH RFC] regulator: mt6380: Fix unused array warning
Message-ID: <20220729152349.6a4801a5@endymion.delvare>
In-Reply-To: <decb7338-eeb8-3c0c-88f2-c0b00fb8b0e7@collabora.com>
References: <20220727132637.76d6073f@endymion.delvare>
        <decb7338-eeb8-3c0c-88f2-c0b00fb8b0e7@collabora.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 13:15:14 +0200, AngeloGioacchino Del Regno wrote:
> Il 27/07/22 13:26, Jean Delvare ha scritto:
> > With the following configuration options:
> > CONFIG_OF is not set
> > CONFIG_REGULATOR_MT6380=3Dy
> > we get the following build warning:
> >=20
> >    CC      drivers/regulator/mt6380-regulator.o
> > drivers/regulator/mt6380-regulator.c:322:34: warning: =E2=80=98mt6380_o=
f_match=E2=80=99 defined but not used [-Wunused-const-variable=3D]
> >=20
> > Fix this by annotating that array with __maybe_unused, as done in
> > various regulator drivers. =20
>=20
> I know I'm late to the party, but I would've preferred to see the
> of_match_ptr() dropped instead of adding a __maybe_unused.

Doing that for this driver would basically prevent the compiler from
dropping out the variable in the !CONFIG_OF case. If this is a valid
case (and I really would like Mediatek people to comment on that) then
I can't see how that would be an improvement.

--=20
Jean Delvare
SUSE L3 Support
