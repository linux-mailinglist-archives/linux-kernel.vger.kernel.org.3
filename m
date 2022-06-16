Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9783D54EBA9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378545AbiFPU4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiFPU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:56:07 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3955FF0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:56:06 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 6CD26C01E; Thu, 16 Jun 2022 22:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655412965; bh=ycjiY+aq2cDehp0fZ6aEcwNIfgJBez5urLaS1XAJP1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huiTsXlReqJ4KWvkpGoI4XylqLGpI3ZCm6DOMZZh6qYsPLom45xR4HVv9zHkdbRxc
         IfENjelJhYPd/0XgzlwzSFIB0/rijOl5XEu/lJyhtPBEvkn0JPHaelq+YAMZuyF3Kb
         tEpUNKMMyc77pV2QH6UNUoq6z3cqLyMltOnCp5TBK6yPpex13b5Hnx8aPKIrbeJE9k
         TJLwzN6kvmTtFLK68HhgAWJwwJ1K/+NTLdCLHTN5vp66/HNStpyFKDAkUzB7+fq/UC
         /eVfcBNUztNy524OV9QmuQczsGNIdnBrd+7R172jbkmvMm5CUkxAFjkhOPkkV544Ve
         kidv60nJ+z+fA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 1F1A9C009;
        Thu, 16 Jun 2022 22:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1655412964; bh=ycjiY+aq2cDehp0fZ6aEcwNIfgJBez5urLaS1XAJP1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QBGfGSCplw9XBFJutpJGRZkkdcQlpfMD++RNijHy+wwVQC4R0M4KW5W+OoxOoMLe8
         P9wgfm1dX/QhEXhlzzP44nYCzkH6aJfamS85KkvNYJD3gXJihdUPWZX1T9ahVY+9V5
         TNsE8WNEAJ1/QogWrKwygqf7t/3O+tmBJefHnCrf5nNetjQ2VoviBHwffC7LokcDoe
         EwejCjpslJssw8zl9eQg8kOMdYPO9vzVuQtjiYl+IwOM62kG8qYyv3bpulnGL1/+OR
         qrksBawE0pNmO8dn+x9u/ttP5d8TbagoB0SiCcXzRCEglO59K226dXqS2ngOQM8Iww
         EDdnIR1XrAh0Q==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 15fca7e8;
        Thu, 16 Jun 2022 20:56:00 +0000 (UTC)
Date:   Fri, 17 Jun 2022 05:55:45 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] net/9p: show warning on Tread/Twrite if wrong file mode
Message-ID: <YquY0Ys1MiGoAvyU@codewreck.org>
References: <E1o1tHC-00039k-04@lizzy.crudebyte.com>
 <1692377.rnsbsUYrV6@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1692377.rnsbsUYrV6@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Thu, Jun 16, 2022 at 09:44:16PM +0200:
> Better postpone this patch for now: when I use cache=loose, everything looks
> fine. But when I use cache=mmap it starts with the following warnings on boot:

Noted, I guess that means we're misusing some fids somewhere...

Will have a look when able
--
Dominique
