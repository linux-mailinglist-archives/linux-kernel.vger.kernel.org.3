Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F964BC828
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 12:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbiBSLJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 06:09:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiBSLJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 06:09:22 -0500
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791513E5C8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 03:09:00 -0800 (PST)
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 3814A208BC;
        Sat, 19 Feb 2022 11:08:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 656842F;
        Sat, 19 Feb 2022 11:08:58 +0000 (UTC)
Message-ID: <60e0b4b5b1f925743d2bfbbaf170bfecfd0c92fc.camel@perches.com>
Subject: Re: fallthrough question
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sat, 19 Feb 2022 03:08:57 -0800
In-Reply-To: <858a2b13-64e1-99bc-e2f7-5b2477bb1126@infradead.org>
References: <858a2b13-64e1-99bc-e2f7-5b2477bb1126@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 656842F
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: zao5s4cakkie794jkgq6y15xtt5mnci1
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ClDQSqa4QZEA8CHkAUSaB77hB4F7WSvo=
X-HE-Tag: 1645268938-567866
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-18 at 13:57 -0800, Randy Dunlap wrote:
> Hi,
> 
> I expected this to produce a fallthrough warning, but it doesn't
> (with gcc 11.1.0):
> 
> from sound/oss/dmasound/dmasound_core.c:#1481, when falling from case 1
> into case 0: (in arch/m68k/ selected builds only)
> 
> 	case 1:
> 		if ((size = ints[2]) < 256) /* check for small buffer specs */
> 			size <<= 10 ;
>                 if (size < MIN_BUFSIZE || size > MAX_BUFSIZE)
>                         printk("dmasound_setup: invalid write buffer size, using default = %d\n", writeBufSize);
>                 else
>                         writeBufSize = size;
> 	case 0:
> 		break;
> 	default:
> 
> Can you tell me what is going on here?

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91432


