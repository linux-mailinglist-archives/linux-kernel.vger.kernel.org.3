Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F34F48C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385986AbiDEVuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392232AbiDEPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301D92DE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23933618B3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AD0C385AA;
        Tue,  5 Apr 2022 13:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649166502;
        bh=L940+BjtIFTE/F2hK7zJ5314fCg6+o2jSl+cZo4AB4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FNuQeoqhWp7RKDV5m0kQMwRKrARsSVoOgz0olHveaHVLxFYUjdbVZffcnzjXejyQr
         mf8FSBreaRxwnvRMY/OY7wmmp6BJ015NqBl5ORDOnL+N96VODQ6srMUkpNeTGmAFA9
         2krQIhtoV8wwCwd7kPPkIjaPLFa/2ev4jyw+X9Pu5zPIJuggg1Ftz5LxOECCuLRiP4
         Pe3qUEbcDVpZokm30yH44Y41SZ4mzmfDq4KKvY7qbx0G6hdaA9GY8nV4BcwwXJbZIZ
         GHPSDkA4aq3ZYrg1yfyffUmvOjylqxRct/CybycerRgkggSilFau1F0xcPrQrWheav
         KQZ5zaK5yoWeg==
Date:   Tue, 5 Apr 2022 15:48:16 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Make headphone work on Huawei Matebook D15
Message-ID: <20220405154816.5cfdc49c@coco.lan>
In-Reply-To: <168fe6c3-6a7d-4019-16e3-066caf394b8a@redhat.com>
References: <cover.1649147890.git.mchehab@kernel.org>
        <168fe6c3-6a7d-4019-16e3-066caf394b8a@redhat.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 5 Apr 2022 11:00:44 +0200
Hans de Goede <hdegoede@redhat.com> escreveu:

> Hi,
> 
> On 4/5/22 10:44, Mauro Carvalho Chehab wrote:
> > At Huawei Matebook D15 two different GPIOs are used to control the output:
> > 	- gpio0 controls the speaker output;
> > 	- gpio1 controls the headphone output.
> > 
> > Changing both at the same time cause spurious events that are mis-interpreted
> > as input events, causing troubles on apps. So, a delay is needed before turning
> > on such gpios.
> > 
> > With this patch, plugging a headphone causes a jack event to trigger the speaker
> > supply, powering down the speaker and powering up the headphone output.
> > Removing the headphone also triggers the power supply, powering up the speaker
> > and powering down the headphone.
> > 
> > Mauro Carvalho Chehab (2):
> >   ASoC: Intel: sof_es8336: support a separate gpio to control headphone
> >   ASoC: Intel: sof_es8336: Huawei Matebook D15 uses a headphone gpio  
> 
> There is something weird with the patches here, at least for me in Thunderbird
> both patches show up as nameless attachments to emails with empty bodies.

Weird... I tested here on Thunderbird (Fedora 35), reading it from the ML
and they opened ok here.

There *is* an issue on such patches though: they ended using my past
e-mail :-) 

I'll re-send those with your ack using the right SoB/From
mchehab@kernel.org.

> 
> After saving the attachments the patches look good to me, so:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Thanks!

Regards,
Mauro
