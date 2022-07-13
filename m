Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652DB572EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiGMHNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiGMHNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:13:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9313DEA9;
        Wed, 13 Jul 2022 00:13:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 275B960BCA;
        Wed, 13 Jul 2022 07:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A83C34114;
        Wed, 13 Jul 2022 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657696384;
        bh=TQNeEGV3rKJ8ew7HDAUcPp3TPAeemTm6ChOgvZkJsrk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Hf895GfwxtmCMtfREvKug/f47fG4hj127g+YzBM6DUD4hMNkSssB3eqXO5BS8zKfR
         owUnaBDPGiCODXPxLW+tdjbtQgJFD2eGvLP9fPOIKl+kuoz8PbUQEkh0yrJk+POrVd
         jc8OCU+pfepT9hTW0L/FvcBzpwvVIrliPWrxISGDN1EvFCVGy3BYEGeaTOxfraf0bj
         PXgzkuAgyXVGyCEWdnFJ577hhEkIUa49U2g//JIq+hGmQSMMFvKDeWpJIJVxEi33hA
         tH2fdXhQEdrVwcD6RXhL9bs1vfqkxFb4pwzdmBi7Lm9W74DP0mXwL3kpPVIu9gpnAw
         /VBNCHv8eub4A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-modules\@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "atomlin\@redhat.com" <atomlin@redhat.com>
Subject: Re: [PATCH] modules: move module symbols from init/Kconfig
References: <20220711162049.761342-1-mcgrof@kernel.org>
        <74dcc785-f3e7-6832-9af3-e0a0f69c58c9@csgroup.eu>
        <Ysx1C9IkJiFL+OH5@bombadil.infradead.org>
        <09f3ec9a-3a8e-d116-d38a-2fdb55f125c6@csgroup.eu>
        <Ys3G+ZGr9k+2fTsx@bombadil.infradead.org>
Date:   Wed, 13 Jul 2022 10:12:58 +0300
In-Reply-To: <Ys3G+ZGr9k+2fTsx@bombadil.infradead.org> (Luis Chamberlain's
        message of "Tue, 12 Jul 2022 12:09:45 -0700")
Message-ID: <87zghdmqo5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Tue, Jul 12, 2022 at 05:57:35AM +0000, Christophe Leroy wrote:
>>=20
>>=20
>> Le 11/07/2022 =C3=A0 21:07, Luis Chamberlain a =C3=A9crit=C2=A0:
>> > On Mon, Jul 11, 2022 at 06:33:08PM +0000, Christophe Leroy wrote:
>> >>
>> >>
>> >> Le 11/07/2022 =C3=A0 18:20, Luis Chamberlain a =C3=A9crit=C2=A0:
>> >>> This moves all the module symbols from init/Kconfig to its
>> >>> own dedicated file now that we have all of the module code in
>> >>> its own directory.
>> >>>
>> >>> This does not introduce any functional changes.
>> >>>
>> >>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> >>
>> >> It is similar to the patch I sent in February, isn't it ?
>> >> (https://patchwork.kernel.org/project/linux-modules/patch/4042712961d=
42186c449734c253511ea7076c780.1645543105.git.christophe.leroy@csgroup.eu/)
>> >=20
>> > Sorry, I had missed that. Can you send a new v2 based on today's
>> > modules-next? And I'll just drop my patch?
>> >=20
>>=20
>> I sent out v2 rebased on today's modules-next=20
>> (c76654e22da1e0cb830bd0eb5832072fb76df358)
>>=20
>> I see all my patches still have status 'new' in modules's patchwork=20
>> (https://patchwork.kernel.org/project/linux-modules/list/?submitter=3D19=
2363).
>>=20
>> Don't you maintain it ?
>
> Yes but I never knew we used to have patchwork for modules, but glad we h=
ave
> that now. Anyway all your patches are applied, is patchwork dumb to not
> pick that up?

patchwork does not have that functionality built in, you need to enable
the bot separately:

https://korg.docs.kernel.org/patchwork/pwbot.html

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
