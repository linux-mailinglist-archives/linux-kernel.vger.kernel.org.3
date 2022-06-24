Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29DF5599D1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiFXMqQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Jun 2022 08:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiFXMqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:46:15 -0400
Received: from relay3.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573BC4AE24
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:46:14 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id C52B7354B6;
        Fri, 24 Jun 2022 12:46:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 6DF7122;
        Fri, 24 Jun 2022 12:46:11 +0000 (UTC)
Message-ID: <4937c0cc9dbc9d06cb626465bd37cbcf76c80a0b.camel@perches.com>
Subject: Re: [PATCH v2 01/12] regmap-irq: Convert bool bitfields to unsigned
 int
From:   Joe Perches <joe@perches.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 24 Jun 2022 05:46:10 -0700
In-Reply-To: <YrWqAqGUuy8Z0F3x@sirena.org.uk>
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
         <20220623211420.918875-2-aidanmacdonald.0x0@gmail.com>
         <CAHp75VfTqTfMsrdqyqRj61JAAJ4a_h3rrFriY2d+rrqpVviy=w@mail.gmail.com>
         <YrWqAqGUuy8Z0F3x@sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: 3fhsotgben4sb6kxn8deyzo7yy1z9z1f
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 6DF7122
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX197b3iLlRuxa/RwFhaA89b8kqG9qhlhNus=
X-HE-Tag: 1656074771-969869
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-24 at 13:11 +0100, Mark Brown wrote:
> On Thu, Jun 23, 2022 at 11:26:10PM +0200, Andy Shevchenko wrote:
> > On Thu, Jun 23, 2022 at 11:13 PM Aidan MacDonald
> 
> > > Use 'unsigned int' for bitfields for consistency with most other
> > > kernel code.
> 
> > There is no point to convert the fields you are about to remove.
> 
> > So, either don't touch them or make this patch closer to the end of the series.
> 
> It costs us nothing to convert them, this isn't a difficult or hard to
> understand refactoring - the patch is fine the way it is.

Modulo the defects that might be introduced if an overflow occurs.

struct foo {
	unsigned int a:1;
	bool b:1;
}

Assign a non-zero int without bit 0 set to each and see if
a and b differ.

