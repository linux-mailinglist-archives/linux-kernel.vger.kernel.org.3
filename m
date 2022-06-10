Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DEE546E72
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347083AbiFJU3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244799AbiFJU3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:29:18 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A663002C4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=jVE3ilMvZWY8ulhyEsb0pHfa2vvSKMMxY1N2fKgs7GA=;
        b=pbwE7X9Cwge6vAGV1ENPX+f92h7omwg6fTGR+DmDlcqkUu9KLlaUMF/rrf5A3VcrTR31RwJQbEktR
         gL90KHJCPmFgld7tbkB/UUIvoD2dPEYVbR3GP2BwESzFdItvtXH8QjtxGdKHup7JiEeHe57JENQqVW
         /gh1ilAGR7VdXh4s/M76X/fSekgCkwLFcRftWJOHYdAsGnyLlhE+q9dkSoTAqc6gkZV+L2f2KIrf41
         CUGgxsWR73gP4GJ94Y2ICN/2yYQzZoxFGkfMBkmteLvntgM1mejo9z9M/A8pbwhuVfVMbvv93LhvZE
         vXmjCGheZ2gIqGfa5RQVksG6VGr9VDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=jVE3ilMvZWY8ulhyEsb0pHfa2vvSKMMxY1N2fKgs7GA=;
        b=3WPqGsdp8JyO2QUhe9rqiozMBx2X4xWbmHpb86WISBX2TwkV0DtCJIU6A38H6euilIiqBcE9LzP+3
         v3cd9W1Ag==
X-HalOne-Cookie: 97e8025a86500fcb8587d22aeeebba46565afd88
X-HalOne-ID: fe1b27f0-e8fb-11ec-a912-d0431ea8a290
Received: from mailproxy3.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id fe1b27f0-e8fb-11ec-a912-d0431ea8a290;
        Fri, 10 Jun 2022 20:29:14 +0000 (UTC)
Date:   Fri, 10 Jun 2022 22:29:12 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Helge Deller <deller@gmx.de>,
        Paul Mackerras <paulus@samba.org>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/7] fbdev: aty128fb: Use backlight helper
Message-ID: <YqOpmKlLl909F/Ib@ravnborg.org>
References: <20220607192335.1137249-1-steve@sk2.org>
 <20220607192335.1137249-2-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607192335.1137249-2-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stepehen,

On Tue, Jun 07, 2022 at 09:23:29PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org

This and the other 6 patches in this series are all:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I did not receive the cover letter, which is why I reply to this mail.

	Sam
