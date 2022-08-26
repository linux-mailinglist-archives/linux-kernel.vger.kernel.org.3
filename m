Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB815A2BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243659AbiHZQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiHZQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:06:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F40D0759;
        Fri, 26 Aug 2022 09:06:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 55EC233691;
        Fri, 26 Aug 2022 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661529971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IADvgfLi4pVbaZ2ly4ov4y2NzGZG3Q1HYppqR1gka9g=;
        b=0fUn+ut5tvMrX2r6DpP5DBcVV+r+NPjL8MTnuFtum2sUDG1yZs/1cYJEJmzaXvYbgc6+Ky
        ec405pTyG7jF1mNdOknDdEkahH92qsgoCyr60uIGiJSjOa2xDt7WTFTJUELqaptBYS2aDW
        RA8tzOt7w88NU3V+Xr8PArNZddCX3Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661529971;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IADvgfLi4pVbaZ2ly4ov4y2NzGZG3Q1HYppqR1gka9g=;
        b=7o5ZvsPuDG5H/frTJFUNeJbQT6FTLwQ6bpPYf1bqXVckgUWKk8hfZGiCoHXw7ZOuSwNzea
        ppf5fwubR4vUDoAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AF8413421;
        Fri, 26 Aug 2022 16:06:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Px/dBHPvCGP8agAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 26 Aug 2022 16:06:11 +0000
Date:   Fri, 26 Aug 2022 18:06:09 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio:accel:dmard06: Optimize when CONFIG_OF isn't set
Message-ID: <20220826180609.01262f0a@endymion.delvare>
In-Reply-To: <CAHp75VcGopXaksmvXP_vMM-iGK0o_g5Fw_F5zvH+PXcCUx_cDQ@mail.gmail.com>
References: <20220825144012.24a33bb0@endymion.delvare>
        <CAHp75VeSgmO_=mXVR4uSpbQDO8MBGZu4O2vLEqunHYuoPfJbbQ@mail.gmail.com>
        <20220826124603.4a28a154@endymion.delvare>
        <CAHp75VcGopXaksmvXP_vMM-iGK0o_g5Fw_F5zvH+PXcCUx_cDQ@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 18:18:20 +0300, Andy Shevchenko wrote:
> On Fri, Aug 26, 2022 at 1:46 PM Jean Delvare <jdelvare@suse.de> wrote:
> > therefore of_match_ptr() should be
> > removed from the kernel entirely?  
> 
> (...) But for some cases it still
> makes sense: platform is known to never be non-OF, component is known
> to be used only on such platforms, etc.

Well, I can't see the value of of_match_ptr() in such case either. In
fact I've submitted a couple patches to remove such occurrences lately:

https://patchwork.kernel.org/project/linux-mediatek/patch/20220730144833.0a0d9825@endymion.delvare/
https://patchwork.kernel.org/project/linux-pm/patch/20220804135938.7f69f5d9@endymion.delvare/

-- 
Jean Delvare
SUSE L3 Support
