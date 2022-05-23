Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB34B5310FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiEWNUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiEWNUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:20:11 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6A826AC0;
        Mon, 23 May 2022 06:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653311945; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=JeCbVuXy0u8G8Pa3wAqvVFfnYGYKmoKKpIYio+ur6pJKsyuautEUAyn5E+tUD26JMO6oA9NCIUDSYVT3R9zPeiJ47BqKVusvcNj+VI83EfsnVVZTZrPc+HbpRHLMJVsMbvQM4lxsNh1hOeGE6bzYzqFd4l0bFaUTkJYqTqg2/lo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653311945; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Y5xsWt3tLYwb1E1F4wk9G1AMYoLyASq9njoU/+tcTAM=; 
        b=WXo4rCLC6/rtHvKTwVGIbM0rq1hZjkVg3NTmZZuNTmvxuNH0HXjuxRvoDT2FEpiVVB8p6tGnJWxANZlfAfdKHo2JICo59Wk5pRtFStzz1IBzrAhDxI4XXPB2daJhWwDF7pf/LzEe7fCWPGQjpwf96PS1EQI2ShMlHF1lbBT3DbE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653311945;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
        bh=Y5xsWt3tLYwb1E1F4wk9G1AMYoLyASq9njoU/+tcTAM=;
        b=U/k6SNF3Q7Vq7SjwZZ4OEOqHHchD7guEe4cZQoUmMm1Yn+etLMUIPAZnUzogn7fr
        95L1VNRfEWiVmaWD0ULUQE5WnzjZEaVYjmhzF1Uo91E8n+Q8ZeDt37YXJRf8esl/FI+
        c4bll+NrlR3jD59giQjB7lditQ4hFt8U08AzdOs8=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653311941409685.4155842465059; Mon, 23 May 2022 06:19:01 -0700 (PDT)
Received: from  [178.128.49.8] by mail.zoho.com
        with HTTP;Mon, 23 May 2022 06:19:01 -0700 (PDT)
Date:   Mon, 23 May 2022 06:19:01 -0700
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Mark Brown" <broonie@kernel.org>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-gpio" <linux-gpio@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        "linux-sunxi" <linux-sunxi@lists.linux.dev>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Message-ID: <180f1122b08.e6446e1066781.7509618678223081484@zohomail.com>
In-Reply-To: <YotygqDAkAXRRo9d@sirena.org.uk>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
 <180eeb93909.12110e2de60158.391061173597432851@zohomail.com> <YotygqDAkAXRRo9d@sirena.org.uk>
Subject: Re: [PATCH v2 0/4] Add regmap_field helpers for simple bit
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011226609f90866ffc175af022d0ab0000919cb4bbb101339a78166a92ad03d5e2e779eeecb8924159:zu08011227b3e435ea850177f73ae9ee41000050bfadb467b41bb49e225f013460c1833a5ef6e83a7c1fb2bc:rf0801122c01457621e0db0818ca91fc5c00006b539b79163fdcdee7cbcfdfd0e8cc2261fadfed13e4da4e20361c09864b:ZohoMail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

 ---- On Mon, 23 May 2022 04:39:46 -0700 Mark Brown <broonie@kernel.org> wrote ----
 > On Sun, May 22, 2022 at 07:22:37PM -0700, Li Chen wrote:
 > > From: Li Chen <lchen@ambarella.com>
 > > 
 > > This series proposes to add simple bit operations for setting, clearing
 > > and testing specific bits with regmap_field.
 > 
 > Please don't send new patches in reply to old patches or serieses, this
 > makes it harder for both people and tools to understand what is going
 > on - it can bury things in mailboxes and make it difficult to keep track
 > of what current patches are, both for the new patches and the old ones.
 > 

Thanks for letting me know, I won't do this again.

Regards,
Li
