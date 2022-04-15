Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97936502661
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351210AbiDOHvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbiDOHvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:51:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D379DA1459;
        Fri, 15 Apr 2022 00:48:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 82A1121618;
        Fri, 15 Apr 2022 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650008920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SHVQJFSF6barKXVP5eNQt8zwcx4jeHu5qFNnwwGnjLA=;
        b=bcn2jl6FWieXGxHcV7o5ppZtKfOfaMtvzEtKXIERzHvWFxF5vGbAkofujHE/CN/4038/tM
        GzcpzFui2ajY1PwNNEXSFQwsaIUNTnSL9yo/+n3+H8bKhk14at+r+DoIcfY89x9WcnPSGl
        dqBECyh/gRHwYm2aDcgcLbwnR1wmZGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650008920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SHVQJFSF6barKXVP5eNQt8zwcx4jeHu5qFNnwwGnjLA=;
        b=3II8MECqZB1GOOjxEcgbFSkk8JazJqH1Wxoxb7Yy3OdlG+YHsUCNpM//wx+ZTjgP0vB+1j
        1WLpXYKoFJqonBDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AD19139B3;
        Fri, 15 Apr 2022 07:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b51kGFgjWWIJDAAAMHmgww
        (envelope-from <iivanov@suse.de>); Fri, 15 Apr 2022 07:48:40 +0000
Date:   Fri, 15 Apr 2022 10:48:39 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: bcm: rpi: Add support for two more clocks
Message-ID: <20220415074839.5ma5n57rmhv7tk4s@suse>
References: <20220405082503.61041-1-iivanov@suse.de>
 <20220405090431.ktlybn62eueh7gqi@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405090431.ktlybn62eueh7gqi@houat>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael, Stephen,

On 04-05 11:04, Maxime Ripard wrote:
> Date: Tue, 5 Apr 2022 11:04:31 +0200
> From: Maxime Ripard <maxime@cerno.tech>
> To: "Ivan T. Ivanov" <iivanov@suse.de>
> Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
>  <sboyd@kernel.org>, linux-clk@vger.kernel.org,
>  linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 0/2] clk: bcm: rpi: Add support for two more clocks
> Message-ID: <20220405090431.ktlybn62eueh7gqi@houat>
Tags: all clk linux me ring
> 
> On Tue, Apr 05, 2022 at 11:25:01AM +0300, Ivan T. Ivanov wrote:
> > Add missing clock required by RPiVid video decoder and make HDMI
> > pixel clock more reliable.
> 
> For both patches:
> Acked-by: Maxime Ripard <maxime@cerno.tech>
> 

Any chance that this is merged in foreseeable future?
Do you have any comments or objections?

Thanks,
Ivan


