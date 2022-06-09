Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BF5544C62
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiFIMoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343552AbiFIMoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:44:16 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7AA4925F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=W2pDJyYht7VOnF3QgO48EKFIgXumd2pCO0LJ2y8eqgA=; b=XwsV5kVPYRzw8zsik48ZXpsC7h
        uDwZnQpMlIxxjUheod91CQGw864EqMlZVWZq09/Mxscjowvp+hI1riI0px/ZDhl565V/TO6vVRtNx
        jlypaJo+m0C2Nml78GnSuwbLj7ltbP0bvS/hxwQ73dKzvwIr8BvEz0yItvmcrWm0XPRcVBAQW3voy
        gImgVviuU2LwSIf9TG9G/FYsLKvnNH7EUgkcysLtrvXZCvWmvAUKG/2i5/noqXURujrSPYw4VhyzW
        eo5Fk7lhbJC9C1FdTQd/H4tzIXC4wCqoWGswEfe2Lealfbs1yskeMg1AgTv5eo6KFC+SnQddzg28M
        hYXyPM6+R/vKmDbOZ/BpHYlNvHyugj9zk7IlobMnEe+k/swj+hxMCRFJMIWkqX9ip8zIAwPGYlY1y
        Xmqu+p1OZ2NfgpAB3edEsE4aYQl2AUBx7LXvHdZSlI9aKjAxClCxVUEtVkAF4H1yM66o4YqDpM3g5
        uaF2nvE2kQyUMvg7ufHN3roO+Fhi0vgn5jjHyE8M63qgOBrD8dXKyq4AxZF42nAMkdHY3T4DouP0I
        6AW/Yy897JCJUD0tfe9O2uJ+QTBGaAFy3Tdze9z5k3vDvOXALMP2pG12q6wc2sGKt7l5kmZ3mRIEw
        SgGmlyMq6DK6kIgvpoOYhgMUw534Qo6BBwPQK5wqU=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Jianyong Wu <jianyong.wu@arm.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] 9p: Fix refcounting during full path walks for fid lookups
Date:   Thu, 09 Jun 2022 14:44:04 +0200
Message-ID: <7291261.iO0hoOTYzs@silver>
In-Reply-To: <20220607034110.GA7401@sequoia>
References: <20220527000003.355812-1-tyhicks@linux.microsoft.com>
 <1849605.JvGbLJQp6r@silver> <20220607034110.GA7401@sequoia>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 7. Juni 2022 05:41:10 CEST Tyler Hicks wrote:
> On 2022-06-01 16:28:49, Christian Schoenebeck wrote:
> > On Dienstag, 31. Mai 2022 16:28:29 CEST Tyler Hicks wrote:
> > > On 2022-05-30 19:14:43, Christian Schoenebeck wrote:
> > > > On Freitag, 27. Mai 2022 01:59:59 CEST Tyler Hicks wrote:
> > > > > Decrement the refcount of the parent dentry's fid after walking
> > > > > each path component during a full path walk for a lookup. Failure to
> > > > > do
> > > > > so can lead to fids that are not clunked until the filesystem is
> > > > > 
> > > > > unmounted, as indicated by this warning:
> > > > >  9pnet: found fid 3 not clunked
> > > > 
> > > > That explains why I saw so many fids not being clunked with recent
> > > > Linux
> > > > kernel versions while doing some 9p protocol debugging with QEMU
> > > > recently.
[...]
> 9p maintainers, is there anything else that I can help with to get this
> bug fix reviewed/merged? Thanks!

Dominique is the only active 9p maintainer for a while and barely has time for 
9p anymore (hint: implied call for volunteers hidden in this sentence).

Dominique, do you have a time slice for this issue? I agree that it makes 
sense to bring this issue forward.

Best regards,
Christian Schoenebeck


