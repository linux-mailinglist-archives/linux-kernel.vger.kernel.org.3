Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E5F58261A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiG0MIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiG0MIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:08:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17B24B0FC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:08:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6E933865C;
        Wed, 27 Jul 2022 12:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658923690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+EyzJscg4VpJjU66cXo33wSaPO1c5T2jdLer+vEbsw=;
        b=phkAUvtrEaJzhXVspDR3xbFHwnPuPF6hRWG6wXCiXyiYnx++zrEcr+I8/BW5pGgeD7GfJ9
        ATTvr70Hiwhr046SR20q3nQ2OCwJ39kowKTYcVvTKDu8m7DSpyBl3+3rVdZsUPPu/tCA2y
        6L/r45fdixv4ZSjLKpd1nGkjiniVPo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658923690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+EyzJscg4VpJjU66cXo33wSaPO1c5T2jdLer+vEbsw=;
        b=WsrR5yGL3KARAxekQE3TpX1xe+494uIZcY/zfMzV/Q/Amis0en1bFets9ndhOEK4lXlMby
        IUvcFC1dl5xfplAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6603E13A8E;
        Wed, 27 Jul 2022 12:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 34NDF6oq4WJnFQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 27 Jul 2022 12:08:10 +0000
Date:   Wed, 27 Jul 2022 14:08:09 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH RFC] regulator: mt6380: Fix unused array warning
Message-ID: <20220727140809.0951b72d@endymion.delvare>
In-Reply-To: <YuEpGTD/DbC1T9Z0@sirena.org.uk>
References: <20220727132637.76d6073f@endymion.delvare>
        <YuEpGTD/DbC1T9Z0@sirena.org.uk>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 13:01:29 +0100, Mark Brown wrote:
> On Wed, Jul 27, 2022 at 01:26:37PM +0200, Jean Delvare wrote:
> 
> > This assumes that the mt6380 driver can be used without OF support.
> > However, I can't find any in-tree piece of code instantiating the
> > "mt6380-regulator" platform device by name. So unless there's an
> > out-of-tree user, a better fix would be to remove mt6380_platform_ids
> > and make the driver depend on OF. Chenglin, would that be OK with
> > you?  
> 
> It's helpful to keep the build coverage high.

OF does not depend on the architecture, anyone can enable it. So I
can't see any problem of coverage with making drivers depend on OF.

-- 
Jean Delvare
SUSE L3 Support
