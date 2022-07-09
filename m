Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2851956C688
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 06:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiGIEHz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Jul 2022 00:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGIEHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 00:07:53 -0400
Received: from relay3.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0B17AB1A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 21:07:52 -0700 (PDT)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 4FF7520BAB;
        Sat,  9 Jul 2022 04:07:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 103611A;
        Sat,  9 Jul 2022 04:07:44 +0000 (UTC)
Message-ID: <2c1717b23896bc95a9ba9de79c9dbf112aa35460.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: vt6655: Use loop in
 vt6655_mac_write_bssid_addr
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Fri, 08 Jul 2022 21:07:43 -0700
In-Reply-To: <YsgjOPUDDtD48tMO@kroah.com>
References: <cover.1657134099.git.philipp.g.hortmann@gmail.com>
         <b3b93ae7ce41562565e9007eb4580b9c47a2881f.1657134099.git.philipp.g.hortmann@gmail.com>
         <YsgjOPUDDtD48tMO@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 103611A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: wenfhm9tjf4dikq1umz4o1so58g5p685
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/lD4hqYXWTqy60ADw9GyoRDemBIZFqbuQ=
X-HE-Tag: 1657339664-43791
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 14:29 +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 06, 2022 at 09:19:01PM +0200, Philipp Hortmann wrote:
> > Use loop in vt6655_mac_write_bssid_addr to avoid multiple
> > similar statements.
[]
> > diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
[]
> > @@ -192,12 +192,8 @@ device_set_options(struct vnt_private *priv)
> >  static void vt6655_mac_write_bssid_addr(void __iomem *iobase, const u8 *mac_addr)
[]
> > +	for (int i = 0; i < 6; i++)
> 
> Taking advantage of the new compiler level I see, nice :)

Not sure this is altogether a great idea as it may
make backporting a bit difficult, but it's already
in the kernel in a few places.


