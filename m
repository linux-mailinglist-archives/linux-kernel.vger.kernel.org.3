Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538D04E7E87
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 03:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiCZCZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 22:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiCZCZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 22:25:10 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC59D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 19:23:25 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id EE77621E63;
        Sat, 26 Mar 2022 02:23:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id A04FB1E;
        Sat, 26 Mar 2022 02:23:17 +0000 (UTC)
Message-ID: <0641d577f58f836a6c14a73e78d4545e44e61631.camel@perches.com>
Subject: Re: [PATCH] platform/x86: acerhdf: Cleanup str_starts_with()
From:   Joe Perches <joe@perches.com>
To:     Wei Li <liwei391@huawei.com>, Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.xiang@huawei.com
Date:   Fri, 25 Mar 2022 19:23:16 -0700
In-Reply-To: <20220326020249.3266561-1-liwei391@huawei.com>
References: <20220326020249.3266561-1-liwei391@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A04FB1E
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: hk4j7joqepxzxtriwinaxhpxtan9t6fk
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Xtu31bFcK6k4cm2+mxix8XAv5THAQtxo=
X-HE-Tag: 1648261397-942810
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-03-26 at 10:02 +0800, Wei Li wrote:
> Since there is already a generic function strstarts() that check if a
> string starts with a given prefix, cleanup str_starts_with().
[]
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> @@ -651,9 +636,9 @@ static int __init acerhdf_check_hardware(void)
>  		 * check if actual hardware BIOS vendor, product and version
>  		 * IDs start with the strings of BIOS table entry
>  		 */
> -		if (str_starts_with(vendor, bt->vendor) &&
> -				str_starts_with(product, bt->product) &&
> -				str_starts_with(version, bt->version)) {
> +		if (strstarts(vendor, bt->vendor) &&
> +				strstarts(product, bt->product) &&
> +				strstarts(version, bt->version)) {

IMO: It'd be easier for humans to read if aligned like:

		if (strstarts(vendor, bt->vendor) &&
		    strstarts(product, bt->product) &&
		    strstarts(version, bt->version)) {


