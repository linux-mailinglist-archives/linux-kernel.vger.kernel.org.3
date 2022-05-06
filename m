Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C54351D0B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389188AbiEFFeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382385AbiEFFeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:34:01 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A42262C1;
        Thu,  5 May 2022 22:30:18 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D0FDF560D71;
        Fri,  6 May 2022 05:30:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a243.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 275C15608D3;
        Fri,  6 May 2022 05:30:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651815017; a=rsa-sha256;
        cv=none;
        b=kfCDl5RbpTt7rP1hGCIe4GZj++v9M4lEZ23DVfnmpR2crAgJsCkp+VaFroL3WomIexGDtk
        ercZUd1BFYtBwSWgvF9UpgbJdnEGrw4yHnSYPT6yQU7z1EmzdjOTG4qy6vVZkyCCitRK06
        OjP71CvXYO+IpsDot6357Qser7IJQ+ShKmQcgnnRw7L17g1IJb4vLmS7W7Le4QA8BYYxDM
        WPeI54kl4HtpfagmrhY0OA8PXV+ttxd8MRnXAd0BYKCIki5dlUcvZNN/qz/v9N9M9gGQZn
        qlkV1oFrm9A7GA6+eNOfDyGFvL3eexZEnkE/N/f/K5TbZ5r6BKZudX/E+1iB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651815017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=EVkr9CmxaYXCctU93BalOMVfkfCCgbUETz9MHNKsnlw=;
        b=o/Rr+9JgaZsxLlwgZpQ2Kntifve8C7TDJTTj3dt2ZvaOtcvlIs0AV7srvcvN727N5psjli
        hD69qn+hDZGQ2+BMJ0voKc0WMLFP0i5kUjIpOqb1Yw0ORc46uVITHTnSPGJ1jXpTpfxwFp
        8/wESprHOCRgusN4snhaD/wVUJ0mVP51CesuuLHd/P+CNLFdjec7tSIkaOMn5Z/WfYkYnI
        5WyF8a8d5tLJ6KclSzPa7KZPSlnkZxvxuLqfDwbmqbIX3Q2NCScWMDfaAkwQYA11Lfl6tH
        rkx0uYJVBK2HmDSSHMxj3GeHmp0eWJDIqeaWavz2z/+04ayerwW2/yBzcA1BGQ==
ARC-Authentication-Results: i=1;
        rspamd-847dd8955c-cpsmn;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Cure-Shrill: 6b76dc7a0e7105ae_1651815017690_445065697
X-MC-Loop-Signature: 1651815017690:1202526960
X-MC-Ingress-Time: 1651815017689
Received: from pdx1-sub0-mail-a243.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.123.55 (trex/6.7.1);
        Fri, 06 May 2022 05:30:17 +0000
Received: from fedora (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a243.dreamhost.com (Postfix) with ESMTPSA id 4KvfKL0w4qz2M;
        Thu,  5 May 2022 22:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1651815014;
        bh=EVkr9CmxaYXCctU93BalOMVfkfCCgbUETz9MHNKsnlw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=YuPu14i4PP4uV68df3aQmHwWCPiNeJcK816rvUa4cBW60kor8hdrREsSTu5BXXthB
         pf8WPHDY9KGd4PfzwtQB/jHSjiaSdki86oZFaxDEpx+cUGebxSkzEDsOhZWzLUYOcz
         9jYonuD3ahADRP4RjJ3Ve8E8CtGnxnyldJO2OOkIKkEKYe9bYglocuNQm5RqVjeI3w
         pMQF/iIXwfLTrQGtgiaFe6itL/RlMEHYJgPq7zEryFpPgPjaxeqFQ6rshnGgm7ezUJ
         BB+UqjXopCTtRF84HHSUMed/S4BxcNdmLadDcSdWlT5knSvP7uFkHwttdIkbFBbIki
         E7RxdS9hAZumg==
Date:   Fri, 6 May 2022 01:30:12 -0400
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 4/4] staging: media: zoran: replace dprintk with new
 debugging macros
Message-ID: <YnSyZEF8n7luVvHM@fedora>
References: <20220425144110.133316-1-ian@linux.cowan.aero>
 <3270dd49-0d68-5b60-d766-940b39aa463e@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3270dd49-0d68-5b60-d766-940b39aa463e@xs4all.nl>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 10:15:03AM +0200, Hans Verkuil wrote:
> Hi Ian,
> 
> When I compiled this patch series with smatch I got these warnings:
> 
> zoran/videocodec.c:45 videocodec_attach() warn: variable dereferenced before check 'master' (see line 40)
> zoran/videocodec.c:115 videocodec_detach() warn: variable dereferenced before check 'codec' (see line 111)
> zoran/videocodec.c:168 videocodec_register() warn: variable dereferenced before check 'codec' (see line 166)
> zoran/videocodec.c:200 videocodec_unregister() warn: variable dereferenced before check 'codec' (see line 198)
> 
> And I also got this warning when checking the kerneldoc:
> 
> zoran/zoran.h:307: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Can you fix this and post a v3?
> 
> Thanks!
> 
> 	Hans

I just resubmitted v3.

What did you use to see these issues? When I ran the checkpatch script
and compiled, I did not see any of this.

Thanks!
Ian
